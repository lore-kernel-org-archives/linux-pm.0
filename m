From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / Fan: Use bus id for INT3404 Fan
Date: Tue, 09 Dec 2014 22:43:16 +0100
Message-ID: <5893682.k1Yk2RLk90@vostro.rjw.lan>
References: <1418158385-5070-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53335 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751853AbaLIVVn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Dec 2014 16:21:43 -0500
In-Reply-To: <1418158385-5070-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org

On Tuesday, December 09, 2014 12:53:05 PM Srinivas Pandruvada wrote:
> The ART table refers to actual bus id name for specifying relationship.
> Naming "Fan" is not enough as name in the ART table can change on every
> platform.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/acpi/fan.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
> index caf9b76..c9213bc 100644
> --- a/drivers/acpi/fan.c
> +++ b/drivers/acpi/fan.c
> @@ -325,6 +325,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
>  	struct thermal_cooling_device *cdev;
>  	struct acpi_fan *fan;
>  	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> +	char *name;
>  
>  	fan = devm_kzalloc(&pdev->dev, sizeof(*fan), GFP_KERNEL);
>  	if (!fan) {
> @@ -346,7 +347,12 @@ static int acpi_fan_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	cdev = thermal_cooling_device_register("Fan", device,
> +	if (!strncmp(pdev->name, "INT3404", strlen("INT3404")))

strcmp() should be sufficient here (we need to have a match to get to this point
anyway).

That said I'd compare with "PNP0C0B" and then use "Fan" if that's matching
or the device ID otherwise.

> +		name = acpi_device_bid(device);
> +	else
> +		name = "Fan";
> +
> +	cdev = thermal_cooling_device_register(name, device,
>  						&fan_cooling_ops);
>  	if (IS_ERR(cdev)) {
>  		result = PTR_ERR(cdev);
> 

And please CC ACPI patches to linux-acpi.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
