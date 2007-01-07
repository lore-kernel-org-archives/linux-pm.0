From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH 0/6] [-mm]: ACPI: duplicate ACPI procfs functions in sysfs
Date: Sun, 7 Jan 2007 11:15:09 +0000
Message-ID: <20070107111509.GA4792@ucw.cz>
References: <1168083306.5619.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1168083306.5619.34.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> This patch set is against acpi-test sysfs branch, and will duplicate several ACPI procfs functions in sysfs.
> As struct subsystem power_subsys is referred and the interface under /sys/power/ is changed by this patch series,
> I wish to receive some comments from linux-pm too.

Thanks for doing the work.

> Patch 03-05:
> 	add ACPI sleep attributes in sysfs.
> 	/proc/acpi/sleep is already deprecated by /sys/power/state.

Does that mean we drop standby (S1) capability on PCs?

						Pavel
-- 
Thanks for all the (sleeping) penguins.
