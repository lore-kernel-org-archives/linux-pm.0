From: Pavel Machek <pavel@ucw.cz>
Subject: Re: ACPI_WMI: worst config description of all times
Date: Fri, 8 Feb 2008 06:53:13 +0000
Message-ID: <20080208065312.GA4341@ucw.cz>
References: <20080207214715.GA15211@elf.ucw.cz> <200802072351.32521.carlos@strangeworlds.co.uk> <2c0942db0802071612r1b32f996jc26ac3792b8c31fc@mail.gmail.com> <200802080027.54576.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200802080027.54576.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Ray Lee <ray-lk@madrabbit.org>, Len Brown <lenb@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> On Friday 08 February 2008 00:12:24 Ray Lee wrote:
> > While I'm not trying to set you up for a firing squad, if you can show
> > that the only use this driver has is as underlying support for Acer/HP
> > xyz drivers, 
> 
> Certainly at the moment, this is the only real use it has (and the only reason 
> I spent any time working on a generic ACPI-WMI driver - probably one of the 
> reasons Kconfig is somewhat neglected - ACPI-WMI is a means to an end for me 
> (getting my laptop properly supported by another driver on top of it), not 
> the end itself).
> 
> Although, given most of the other laptop drivers in drivers/misc use 'select' 
> for various things, I don't see the harm here - unless anyone else has a 
> great objection to acer-wmi and tc1100-wmi having 'select ACPI_WMI'?

I believe selct is the way to go here. What do acer-wmi handle?
Additional buttons? Leds? Temperatures? Fan states?

The laptops will boot fine without it, right?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
