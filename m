From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [linux-pm] [PATCH 3/6] [-mm]: ACPI: duplicate ACPI sleep
	"alarm" attribute in	sysfs
Date: Mon, 08 Jan 2007 18:13:54 +0800
Message-ID: <1168251234.5754.38.camel@localhost.localdomain>
References: <1168083318.5619.37.camel@localhost.localdomain>
	 <200701061442.22340.david-b@pacbell.net>
	 <20070107055757.GB24853@srcf.ucam.org>
	 <200701071831.18186.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200701071831.18186.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Thanks for your attention.

On Sun, 2007-01-07 at 18:31 -0800, David Brownell wrote:
> On Saturday 06 January 2007 9:57 pm, Matthew Garrett wrote:
> > On Sat, Jan 06, 2007 at 02:42:22PM -0800, David Brownell wrote:
> > > On Saturday 06 January 2007 3:35 am, Zhang Rui wrote:
> > > > 
> > > > Create /sys/power/alarm.
> > > 
> > > Urg.  This doesn't work with the RTC framework, which accepts the reality
> > > that some systems have multiple RTCs ... /sys/class/rtc/rtcN/alarm is a
> > > much more appropriate location for that RTC's alarm.
> > 
Errr, I never met this multiple RTCs situation before and it's true
that /sys/power/alarm can not handle multiple RTCs.
I don't know why they are needed, maybe for the embedded system?
Could you provide me more details about this multiple RTCs please?
Thanks.
> > Especially since /proc/acpi/alarm is just banging on the RTC registers 
> > - the only ACPI thing about it is that the FADT can expose whether or 
> > not the extended registers exist, and then making sure that the GPE is 
> > enabled.
> 
> The FADT also exposes whether the RTC can wake from S4.  You may have
> noticed that my rtc-cmos patch #3 exported the relevant FADT info
> to the RTC device using platform_data, but the S4 wake capability flag
> isn't useful for anything on today's Linux.
> Not speaking as an ACPI expert, I do see the ACPI spec says (right
> under fig 4-11 in my version) that RTC events don't require GPEs.
> 
Enabling the GPE for RTC is needed. According to the ACPI spec 3.0,
which is the latest version, "If the RTC wake event status and enable
bits are implemented in fixed hardware, the platform are able to
indicate an RTC wake source without consuming a GPE bit, as would be
required if RTC wake was not implemented using the fixed hardware RTC
feature". You can get it in 4.7.2.4.

Thanks,
Rui
