From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [PATCH 3/6] [-mm]: ACPI: duplicate ACPI sleep "alarm" attribute in	sysfs
Date: Sun, 7 Jan 2007 18:31:17 -0800
Message-ID: <200701071831.18186.david-b@pacbell.net>
References: <1168083318.5619.37.camel@localhost.localdomain> <200701061442.22340.david-b@pacbell.net> <20070107055757.GB24853@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070107055757.GB24853@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@lists.osdl.org, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

On Saturday 06 January 2007 9:57 pm, Matthew Garrett wrote:
> On Sat, Jan 06, 2007 at 02:42:22PM -0800, David Brownell wrote:
> > On Saturday 06 January 2007 3:35 am, Zhang Rui wrote:
> > > 
> > > Create /sys/power/alarm.
> > 
> > Urg.  This doesn't work with the RTC framework, which accepts the reality
> > that some systems have multiple RTCs ... /sys/class/rtc/rtcN/alarm is a
> > much more appropriate location for that RTC's alarm.
> 
> Especially since /proc/acpi/alarm is just banging on the RTC registers 
> - the only ACPI thing about it is that the FADT can expose whether or 
> not the extended registers exist, and then making sure that the GPE is 
> enabled.

The FADT also exposes whether the RTC can wake from S4.  You may have
noticed that my rtc-cmos patch #3 exported the relevant FADT info
to the RTC device using platform_data, but the S4 wake capability flag
isn't useful for anything on today's Linux.

Not speaking as an ACPI expert, I do see the ACPI spec says (right
under fig 4-11 in my version) that RTC events don't require GPEs.

Conceptually, one would expect that enable_irq_wake(RTC_IRQ) would
set PM1.RTC_EN, and disable_irq_wake(RTC_IRQ) would clear it, on
ACPI systems.  It doesn't do that, though.

But I did notice there was a lot of event infrastructure behind the
/proc/acpi/alarm thing ... which I never observed to fire.  Maybe it
would be needed on systems with different RTC implementations...

- Dave
