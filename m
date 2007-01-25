From: Len Brown <lenb@kernel.org>
Subject: Re: [linux-pm] [PATCH 0/6] [-mm]: ACPI: duplicate ACPI =?iso-8859-1?q?procfs=09functions_in?= sysfs
Date: Wed, 24 Jan 2007 21:28:13 -0500
Message-ID: <200701242128.14047.lenb@kernel.org>
References: <1168083306.5619.34.camel@localhost.localdomain> <1168256428.5754.98.camel@localhost.localdomain> <20070108131318.GC25933@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070108131318.GC25933@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@lists.osdl.org
Cc: Pavel Machek <pavel@ucw.cz>, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@osdl.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday 08 January 2007 08:13, Pavel Machek wrote:
> Hi!
> 
> > This patch set is against acpi-test sysfs branch which already converts
> > ACPI to follow driver model. Now the ACPI procfs functions are
> > duplicated in sysfs step by step. And I want the ACPI interface in sysfs
> > works exactly the same way as in procfs.
> 
> No, you can't port same broken interface into sysfs. Some /proc
> interfaces are horrible, and we do not want to create _exactly same_
> horrible interfaces in /sys.

Please be specific.

thanks,
-Len

