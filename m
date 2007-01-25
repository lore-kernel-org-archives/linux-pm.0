From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH 0/6] [-mm]: ACPI: duplicate ACPI procfs	functions in sysfs
Date: Thu, 25 Jan 2007 13:08:13 +0100
Message-ID: <20070125120813.GD23343@elf.ucw.cz>
References: <1168083306.5619.34.camel@localhost.localdomain> <1168256428.5754.98.camel@localhost.localdomain> <20070108131318.GC25933@elf.ucw.cz> <200701242128.14047.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200701242128.14047.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.osdl.org, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@osdl.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed 2007-01-24 21:28:13, Len Brown wrote:
> On Monday 08 January 2007 08:13, Pavel Machek wrote:
> > Hi!
> > 
> > > This patch set is against acpi-test sysfs branch which already converts
> > > ACPI to follow driver model. Now the ACPI procfs functions are
> > > duplicated in sysfs step by step. And I want the ACPI interface in sysfs
> > > works exactly the same way as in procfs.
> > 
> > No, you can't port same broken interface into sysfs. Some /proc
> > interfaces are horrible, and we do not want to create _exactly same_
> > horrible interfaces in /sys.
> 
> Please be specific.

/proc/acpi/alarm is horrible mess, as was detailed in another email
from David.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
