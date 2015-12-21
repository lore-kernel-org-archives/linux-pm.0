From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: processor thermal cooling device regression
Date: Mon, 21 Dec 2015 04:14:26 +0100
Message-ID: <4453191.9zmF0Mntv5@vostro.rjw.lan>
References: <1450326743-9460-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59412 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751284AbbLUCoL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 20 Dec 2015 21:44:11 -0500
In-Reply-To: <1450326743-9460-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, len.brown@intel.com, rui.zhang@intel.com, linux-pm@vger.kernel.org

On Wednesday, December 16, 2015 08:32:23 PM Srinivas Pandruvada wrote:
> The processor cooling device is no longer present for passive thermal
> control. The change
> commit 239708a3af44 ("ACPI: Split out ACPI PSS from ACPI Processor driver")
> moved the processing to a new function acpi_pss_perf_init, but
> missing "return 0" after successful creation. This causes the error
> handling functions to be called, which will delete the previously
> created processor cooling device.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

I'm adding this to my queue for 4.4-rc6, thanks!

BTW, if the commit that introduced the problem is known, please add a Fixes:
tag pointing to it to the patch changelog (I did that for this one).

> ---
>  drivers/acpi/processor_driver.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index f4e02ae..11154a3 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -200,7 +200,8 @@ static int acpi_pss_perf_init(struct acpi_processor *pr,
>  		goto err_remove_sysfs_thermal;
>  	}
>  
> -	sysfs_remove_link(&pr->cdev->device.kobj, "device");
> +	return 0;
> +
>   err_remove_sysfs_thermal:
>  	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
>   err_thermal_unregister:
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
