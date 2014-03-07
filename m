From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] x86_pkg_temp_thermal: Fix the thermal zone type
Date: Fri, 7 Mar 2014 09:03:58 +0100
Message-ID: <20140307090358.71157133@endymion.delvare>
References: <20140302150549.45f6df2a@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42360 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905AbaCGIEB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 7 Mar 2014 03:04:01 -0500
In-Reply-To: <20140302150549.45f6df2a@endymion.delvare>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Rui, Eduardo,

We start getting more complaints from libsensors users, for example:
http://lists.lm-sensors.org/pipermail/lm-sensors/2014-March/041486.html

So it would be great to have this fix (and the following one) upstream
quickly.

Thanks,
Jean

On Sun, 2 Mar 2014 15:05:49 +0100, Jean Delvare wrote:
> The thermal zone type should not include an instance number. Otherwise
> each zone is considered a different type and the thermal-to-hwmon
> bridge fails to group them all in a single hwmon device.
> 
> I also changed the type to "x86_pkg_temp", because "pkg" was too
> generic, and other thermal drivers use an underscore, not a dash, as
> a separator. Or maybe "cpu_pkg_temp" would be better?
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
> Candidate for stable trees?
> 
>  drivers/thermal/x86_pkg_temp_thermal.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> --- linux-3.14-rc4.orig/drivers/thermal/x86_pkg_temp_thermal.c	2014-02-09 16:53:05.464687235 +0100
> +++ linux-3.14-rc4/drivers/thermal/x86_pkg_temp_thermal.c	2014-03-02 15:02:15.950089266 +0100
> @@ -394,7 +394,6 @@ static int pkg_temp_thermal_device_add(u
>  	int err;
>  	u32 tj_max;
>  	struct phy_dev_entry *phy_dev_entry;
> -	char buffer[30];
>  	int thres_count;
>  	u32 eax, ebx, ecx, edx;
>  	u8 *temp;
> @@ -440,9 +439,7 @@ static int pkg_temp_thermal_device_add(u
>  	phy_dev_entry->first_cpu = cpu;
>  	phy_dev_entry->tj_max = tj_max;
>  	phy_dev_entry->ref_cnt = 1;
> -	snprintf(buffer, sizeof(buffer), "pkg-temp-%d\n",
> -					phy_dev_entry->phys_proc_id);
> -	phy_dev_entry->tzone = thermal_zone_device_register(buffer,
> +	phy_dev_entry->tzone = thermal_zone_device_register("x86_pkg_temp",
>  			thres_count,
>  			(thres_count == MAX_NUMBER_OF_TRIPS) ?
>  				0x03 : 0x01,
> 
> 
