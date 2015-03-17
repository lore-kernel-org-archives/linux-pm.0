From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH 7/9] mmc: core: Attach PM domain prior probing of SDIO
 func driver
Date: Tue, 17 Mar 2015 13:04:33 +0800
Message-ID: <5507B5E1.6000208@intel.com>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org> <1426261429-31883-8-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61004 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754AbbCQFF6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 17 Mar 2015 01:05:58 -0400
In-Reply-To: <1426261429-31883-8-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel@lists.infradead.org

On 03/13/2015 11:43 PM, Ulf Hansson wrote:
> Align the behvaior to how other buses are handling attachment of PM
> domains. Additionally, let's add error handling.
> 
> Cc: Aaron Lu <aaron.lu@intel.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Aaron Lu <aaron.lu@intel.com>

> ---
> 
> For reference, this change has been discussed before.
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/294278.html
> 
> ---
>  drivers/mmc/core/sdio_bus.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index bee02e6..71357b8 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -315,13 +315,19 @@ int sdio_add_func(struct sdio_func *func)
>  
>  	sdio_set_of_node(func);
>  	sdio_acpi_set_handle(func);
> +
> +	ret = dev_pm_domain_attach(&func->dev, false);
> +	if (ret)
> +		return ret;
> +
>  	ret = device_add(&func->dev);
> -	if (ret == 0) {
> -		sdio_func_set_present(func);
> -		dev_pm_domain_attach(&func->dev, false);
> +	if (ret) {
> +		dev_pm_domain_detach(&func->dev, false);
> +		return ret;
>  	}
>  
> -	return ret;
> +	sdio_func_set_present(func);
> +	return 0;
>  }
>  
>  /*
> 

