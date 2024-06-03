// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.ALProject4;

using Microsoft.Sales.Customer;
using Microsoft.Foundation.Reporting;

pageextension 50100 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage();
    var
        reporlayoutselection: Record "Report Layout Selection";
    begin
        reporlayoutselection.SetTempLayoutSelectedName('layout1');
        Report.Run(50100, false, false);

    end;
}