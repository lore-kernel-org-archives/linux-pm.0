From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [linux-pm] [PATCH 0/6] [-mm]: ACPI: duplicate ACPI
	procfs	functions in sysfs
Date: Fri, 26 Jan 2007 09:36:56 +0800
Message-ID: <1169775416.25758.21.camel@localhost.localdomain>
References: <1168083306.5619.34.camel@localhost.localdomain>
	 <200701242128.14047.lenb@kernel.org> <20070125120813.GD23343@elf.ucw.cz>
	 <200701250515.57979.david-b@pacbell.net>
	 <20070125195136.GE23774@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070125195136.GE23774@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@osdl.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2007-01-25 at 20:51 +0100, Pavel Machek wrote:
> Hi!
> 
> > > > > > This patch set is against acpi-test sysfs branch which already converts
> > > > > > ACPI to follow driver model. Now the ACPI procfs functions are
> > > > > > duplicated in sysfs step by step. And I want the ACPI interface in sysfs
> > > > > > works exactly the same way as in procfs.
> > > > > 
> > > > > No, you can't port same broken interface into sysfs. Some /proc
> > > > > interfaces are horrible, and we do not want to create _exactly same_
> > > > > horrible interfaces in /sys.
> > > > 
> > > > Please be specific.
> > > 
> > > /proc/acpi/alarm is horrible mess, as was detailed in another email
> > 
> > ditto /proc/acpi/wakeup, and all those empty /proc/acpi directories 
> 
> Agreed, /proc/acpi/wakeup is unusable/strange/mess, too. I don't get
> that many empty /proc/acpi directories, but I surely hope I'll not see
> them in /sys.
Many /proc/acpi/(drivers)/ may be empty,
e.g. /proc/acpi/ac, /proc/acpi/battery...
This is because that driver entry in procfs is created after driver is
successfully registered. But the actual proc interface is added when a
device is binded to the driver. So when a driver is loaded but no
matchable device is found, we'll leave an empty directory
under /proc/acpi/.
Anyway, we won't have such problems in sysfs.

Thanks,
Rui
