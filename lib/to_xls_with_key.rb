require 'spreadsheet'

class Array

  def to_xls( options = {} )
    return '' if self.empty?
    
    kclass = self.first.class
    xls_report = StringIO.new
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet

    fields = options[:fields]
    
    return '' if fields.empty?
    
    sheet.row(0).concat(ColumnName.provide_head_name(kclass.name,fields))
    sheet.row(0).height = 15
    format = Spreadsheet::Format.new :size => 13
    sheet.row(0).default_format = format
    
    self.each_with_index do |obj, index|
      sheet.row(index + 1).replace(
          obj.provide_value(fields)
      )
    end
    
    book.write(xls_report)
    
    xls_report.string
  end
  
end
