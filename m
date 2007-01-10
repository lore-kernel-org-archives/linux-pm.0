From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [PATCH 0/6] [-mm]: ACPI: duplicate ACPI procfs functions in sysfs
Date: Wed, 10 Jan 2007 12:53:27 -0800
Message-ID: <200701101253.28151.david-b@pacbell.net>
References: <1168083306.5619.34.camel@localhost.localdomain> <20070107055424.GA24853@srcf.ucam.org> <1168256428.5754.98.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1168256428.5754.98.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.osdl.org, lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Monday 08 January 2007 3:40 am, Zhang Rui wrote:
>
> if /sys/class/rtc/rtcN/alarm can provide the same function, it's great
> and I'll drop patch#03. I'll also mark /proc/acpi/alarm as deprecated if
> David's patches are merged. :)

One help there would be someone from the ACPI team signing off on
patch #3 of the series I sent, which teaches ACPI how to export the
extra registers to the rtc-cmos driver.

There will be another ACPI patch at some point, actually kicking
in hooks needed to handle system wakeup, but getting the PC into
the RTC class framework is an important first step.

Once there's a proper replacement for /proc/acpi/alarm it becomes
a candidate for removal.  Maybe sooner rather than later, unless
some users for that old file turn up...

- Dave

