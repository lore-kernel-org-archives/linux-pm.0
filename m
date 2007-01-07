From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [linux-pm] [PATCH 3/6] [-mm]: ACPI: duplicate ACPI sleep "alarm" attribute in	sysfs
Date: Sun, 7 Jan 2007 05:57:57 +0000
Message-ID: <20070107055757.GB24853@srcf.ucam.org>
References: <1168083318.5619.37.camel@localhost.localdomain> <200701061442.22340.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200701061442.22340.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, Zhang Rui <rui.zhang@intel.com>, lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Sat, Jan 06, 2007 at 02:42:22PM -0800, David Brownell wrote:
> On Saturday 06 January 2007 3:35 am, Zhang Rui wrote:
> > 
> > Create /sys/power/alarm.
> 
> Urg.  This doesn't work with the RTC framework, which accepts the reality
> that some systems have multiple RTCs ... /sys/class/rtc/rtcN/alarm is a
> much more appropriate location for that RTC's alarm.

Especially since /proc/acpi/alarm is just banging on the RTC registers 
- the only ACPI thing about it is that the FADT can expose whether or 
not the extended registers exist, and then making sure that the GPE is 
enabled.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
