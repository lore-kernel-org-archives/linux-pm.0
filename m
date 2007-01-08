From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [PATCH 3/6] [-mm]: ACPI: duplicate ACPI sleep "alarm" attribute in	sysfs
Date: Mon, 8 Jan 2007 12:46:47 -0800
Message-ID: <200701081246.47811.david-b@pacbell.net>
References: <1168083318.5619.37.camel@localhost.localdomain> <200701071831.18186.david-b@pacbell.net> <1168251234.5754.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1168251234.5754.38.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Monday 08 January 2007 2:13 am, Zhang Rui wrote:
> Errr, I never met this multiple RTCs situation before and it's true
> that /sys/power/alarm can not handle multiple RTCs.
> I don't know why they are needed, maybe for the embedded system?

Yes.

> Could you provide me more details about this multiple RTCs please?

An example would be one board I have, with one highly functional RTC
integrated into a system-on-chip processor ... but without battery
backup, since the SOC doesn't have a separate power domain for that.

Systems that want to use that SOC with an RTC may accordingly need
a battery backed RTC, probably connected with I2C or SPI.  On this
board, that's a simple one that's used mostly when starting from a
power-off state, to initialize system clock and then the SOC's RTC.
The more functional integrated RTC (rtc0) is used for normal operation,
but the battery backed one (rtc1) sets the system clock at boot.


> > The FADT also exposes whether the RTC can wake from S4.  You may have
> > noticed that my rtc-cmos patch #3 exported the relevant FADT info
> > to the RTC device using platform_data, but the S4 wake capability flag
> > isn't useful for anything on today's Linux.
> >
> > Not speaking as an ACPI expert, I do see the ACPI spec says (right
> > under fig 4-11 in my version) that RTC events don't require GPEs.
>  
> Enabling the GPE for RTC is needed. According to the ACPI spec 3.0,
> which is the latest version, "If the RTC wake event status and enable
> bits are implemented in fixed hardware, the platform are able to
> indicate an RTC wake source without consuming a GPE bit, as would be
> required if RTC wake was not implemented using the fixed hardware RTC
> feature". You can get it in 4.7.2.4.

That doesn't disagree with what I said.  "Not consuming a GPE bit"
is clearly not requiring a GPE (bit).

I suspect what you mean to say is that the OS needs some hook into
ACPI so it behaves in both cases.  I'm not disagreeing with that.
It would be nice if that were {enable,disable}_irq_wake(RTC_IRQ),
which is what bare metal (non-ACPI) systems would normally use.

- Dave
