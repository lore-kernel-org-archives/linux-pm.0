From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH 0/6] [-mm]: ACPI: duplicate ACPI procfs	functions in sysfs
Date: Mon, 8 Jan 2007 14:13:18 +0100
Message-ID: <20070108131318.GC25933@elf.ucw.cz>
References: <1168083306.5619.34.camel@localhost.localdomain> <200701061421.41342.david-b@pacbell.net> <20070107055424.GA24853@srcf.ucam.org> <1168256428.5754.98.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1168256428.5754.98.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, David Brownell <david-b@pacbell.net>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> This patch set is against acpi-test sysfs branch which already converts
> ACPI to follow driver model. Now the ACPI procfs functions are
> duplicated in sysfs step by step. And I want the ACPI interface in sysfs
> works exactly the same way as in procfs.

No, you can't port same broken interface into sysfs. Some /proc
interfaces are horrible, and we do not want to create _exactly same_
horrible interfaces in /sys.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
