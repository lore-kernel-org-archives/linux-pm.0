From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: ACPI_WMI: worst config description of all times
Date: Thu, 7 Feb 2008 23:51:31 +0000
Message-ID: <200802072351.32521.carlos@strangeworlds.co.uk>
References: <20080207214715.GA15211@elf.ucw.cz> <200802072318.28313.carlos@strangeworlds.co.uk> <2c0942db0802071533l5c3b98fel90946b73f8a9586b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2c0942db0802071533l5c3b98fel90946b73f8a9586b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Ray Lee <ray-lk@madrabbit.org>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday 07 February 2008 23:33:54 Ray Lee wrote:
> Do you have list of hardware/platforms that require this feature to
> get the hardware to work? (acer abc123, tcm1100 xyz)

I have a very long list of Acer laptops that are supported - which is far too 
long, and changes on far too much of a regular basis to put in there.

Perhaps adding something like "This driver is also a required dependency to 
build the firmware specific drivers needed for many laptops, including Acer 
and HP machines"?

(There's currently another ACPI-WMI based driver in development related to 
more HP laptops, and acer-wmi also supports a handful of non-Acer laptops).

I don't think explaining what WMI is, and how ACPI-WMI is related to it is 
that useful in Kconfig here; so I agree that further elaborating on the 'why' 
this should be enabled is definitely worth doing.

> Better, if there are kernel drivers that require this (and currently
> only those drivers), then have those kernel drivers enable ACPI WMI,

Wouldn't that require 'select' though, and I'm led to believe that's seriously 
frowned upon these days?

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
