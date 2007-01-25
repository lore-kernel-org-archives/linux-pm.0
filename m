From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [PATCH 0/6] [-mm]: ACPI: duplicate ACPI procfs	functions in sysfs
Date: Thu, 25 Jan 2007 05:15:57 -0800
Message-ID: <200701250515.57979.david-b@pacbell.net>
References: <1168083306.5619.34.camel@localhost.localdomain> <200701242128.14047.lenb@kernel.org> <20070125120813.GD23343@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070125120813.GD23343@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@lists.osdl.org
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Thursday 25 January 2007 4:08 am, Pavel Machek wrote:
> On Wed 2007-01-24 21:28:13, Len Brown wrote:
> > On Monday 08 January 2007 08:13, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > This patch set is against acpi-test sysfs branch which already converts
> > > > ACPI to follow driver model. Now the ACPI procfs functions are
> > > > duplicated in sysfs step by step. And I want the ACPI interface in sysfs
> > > > works exactly the same way as in procfs.
> > > 
> > > No, you can't port same broken interface into sysfs. Some /proc
> > > interfaces are horrible, and we do not want to create _exactly same_
> > > horrible interfaces in /sys.
> > 
> > Please be specific.
> 
> /proc/acpi/alarm is horrible mess, as was detailed in another email

ditto /proc/acpi/wakeup, and all those empty /proc/acpi directories 
