From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH 4/6] [-mm]: ACPI: duplicate ACPI sleep "wakeup" attribute	in sysfs
Date: Sun, 7 Jan 2007 11:21:51 +0000
Message-ID: <20070107112150.GC4792@ucw.cz>
References: <1168083326.5619.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1168083326.5619.38.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> From: Zhang Rui <rui.zhang@intel.com>
> 
> Add "sleep_state" and "wakeup" attributes for devices that can wakeup a sleep system.
> They are located under sysfs device tree, i.e. /sys/device/acpi_system/.../xxx/.
> "sleep_state" indicates the lowest power system sleeping state that can be entered while still providing wake functionality.
> #echo 1 or 0 >/sys/devices/acpi_system/.../xxx/wakeup can be used to enable/disable the device's ability to wake a sleeping system.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/scan.c         |   12 +++++
>  drivers/acpi/sleep/proc.c   |   90 ++++++++++++++++++++++++++++++++++++++++++--
>  include/acpi/acpi_drivers.h |    6 ++
>  3 files changed, 105 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6.20-rc2-mm1/drivers/acpi/sleep/proc.c
> ===================================================================
> --- linux-2.6.20-rc2-mm1.orig/drivers/acpi/sleep/proc.c	2007-01-06 18:17:53.000000000 +0800
> +++ linux-2.6.20-rc2-mm1/drivers/acpi/sleep/proc.c	2007-01-06 18:18:01.000000000 +0800
> @@ -296,6 +296,93 @@ static int alarm_add_sysfs(void)
>  	return sysfs_create_file(&power_subsys.kset.kobj, &alarm_attr.attr);
>  }
>  
> +/*
> + * "sleep_state" and "wakeup" attributes are created when device is registered
> + */
> +extern struct list_head acpi_wakeup_device_list;
> +extern spinlock_t acpi_device_lock;
> +
> +static ssize_t
> +acpi_sleep_state_show(struct device *dev, struct device_attribute *attr, char* buf){
> +	struct acpi_device *acpi_dev = to_acpi_device(dev);

CodingStyle.

> +	return sprintf(buf, "%2d\n", (u32) acpi_dev->wakeup.sleep_state);

This exports ACPI Sx states as integers; but those make no sense on
non-acpi systems. Exporting /sys/power/state -like things might be
berrer?

							Pavel
-- 
Thanks for all the (sleeping) penguins.
