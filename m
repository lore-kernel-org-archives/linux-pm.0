From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: ACPI_WMI: worst config description of all times
Date: Fri, 8 Feb 2008 00:27:53 +0000
Message-ID: <200802080027.54576.carlos@strangeworlds.co.uk>
References: <20080207214715.GA15211@elf.ucw.cz> <200802072351.32521.carlos@strangeworlds.co.uk> <2c0942db0802071612r1b32f996jc26ac3792b8c31fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2c0942db0802071612r1b32f996jc26ac3792b8c31fc@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Ray Lee <ray-lk@madrabbit.org>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 08 February 2008 00:12:24 Ray Lee wrote:
> While I'm not trying to set you up for a firing squad, if you can show
> that the only use this driver has is as underlying support for Acer/HP
> xyz drivers, 

Certainly at the moment, this is the only real use it has (and the only reason 
I spent any time working on a generic ACPI-WMI driver - probably one of the 
reasons Kconfig is somewhat neglected - ACPI-WMI is a means to an end for me 
(getting my laptop properly supported by another driver on top of it), not 
the end itself).

Although, given most of the other laptop drivers in drivers/misc use 'select' 
for various things, I don't see the harm here - unless anyone else has a 
great objection to acer-wmi and tc1100-wmi having 'select ACPI_WMI'?

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
