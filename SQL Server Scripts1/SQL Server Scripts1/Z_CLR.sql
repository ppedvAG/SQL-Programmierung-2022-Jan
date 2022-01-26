--Vstudio  --> DB Projekt --> Proc, Trigger, F(), Datentypen
--SQL Data Tools

--> DLL

--SQL CREATE ASSEMBLY


--WARUM? weil C# effektiver ist als TSQL

--Security: SAFE (lokaler Datenzugriff) , UNSAFE (alles möglich),
			--EXTERNAL ACCESS (lokalen Dateizugriff, Daten, Netzwerkzugriff, Registry)

			exec HelloCLR 'ttxt'


--IN VStiodio... DLL erstellen... --> Veröfffentlichen (genriert SQL Script, das auf dem SQL Server notwendig ist)
--hat man einen Connection, kann das aus VStudio heraus direkt gemacht werden..

--Beachte dll : SQL muss Zugriff haben.... Pfade , Rechte ...

-------------------------------------------
--C#

use SqlCLR;

sp_configure 'clr enabled', 1
go
RECONFIGURE
go
sp_configure 'clr enabled'
go

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

EXEC sp_configure 'clr strict security', 0;
RECONFIGURE;

CREATE ASSEMBLY SQLCLR from 'c:\_SQLDBS\SQLCLR.dll' WITH PERMISSION_SET = SAFE



CREATE PROCEDURE [dbo].[HelloCLR]
@text NVARCHAR (MAX) NULL OUTPUT
AS EXTERNAL NAME [SQLCLR].[StoredProcedures].[HelloCLR]

exec HelloCLR 'huhu' 


using System;  
using System.Data;  
using Microsoft.SqlServer.Server;  
using System.Data.SqlTypes;  
  
public class HelloWorldProc  
{  
    [Microsoft.SqlServer.Server.SqlProcedure]  
    public static void HelloWorld(out string text)  
    {  
        SqlContext.Pipe.Send("Hello world!" + Environment.NewLine);  
        text = "Hello world!";  
    }  
}

--Datei: Hello.cs

--Pfad .NET
-- C:\Windows\Microsoft.NET\Framework\

-- csc /target:library helloworld.cs



