From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 4/9] drivercore / platform: Convert to dev_pm_domain_attach|detach()
Date: Tue, 09 Sep 2014 15:46:28 +0200
Message-ID: <1504653.iqBBHr8Hq7@vostro.rjw.lan>
References: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org> <1410262570-22785-1-git-send-email-ulf.hansson@linaro.org> <1410262570-22785-5-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1410262570-22785-5-git-send-email-ulf.hansson@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On Tuesday, September 09, 2014 01:36:05 PM Ulf Hansson wrote:
> Previously only the ACPI PM domain was supported by the platform bus.
> 
> Let's convert to the common attach/detach functions for PM domains,
> which currently means we are extending the support to include the
> generic PM domain as well.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Kevin Hilman <khilman@linaro.org>

Greg, any objections here?

> ---
>  drivers/base/platform.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index ab4f4ce..904be3d 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -506,11 +506,12 @@ static int platform_drv_probe(struct device *_dev)
>  	if (ret < 0)
>  		return ret;
>  
> -	acpi_dev_pm_attach(_dev, true);
> -
> -	ret = drv->probe(dev);
> -	if (ret)
> -		acpi_dev_pm_detach(_dev, true);
> +	ret = dev_pm_domain_attach(_dev, true);
> +	if (ret != -EPROBE_DEFER) {
> +		ret = drv->probe(dev);
> +		if (ret)
> +			dev_pm_domain_detach(_dev, true);
> +	}
>  
>  	if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
>  		dev_warn(_dev, "probe deferral not supported\n");
> @@ -532,7 +533,7 @@ static int platform_drv_remove(struct device *_dev)
>  	int ret;
>  
>  	ret = drv->remove(dev);
> -	acpi_dev_pm_detach(_dev, true);
> +	dev_pm_domain_detach(_dev, true);
>  
>  	return ret;
>  }
> @@ -543,7 +544,7 @@ static void platform_drv_shutdown(struct device *_dev)
>  	struct platform_device *dev = to_platform_device(_dev);
>  
>  	drv->shutdown(dev);
> -	acpi_dev_pm_detach(_dev, true);
> +	dev_pm_domain_detach(_dev, true);
>  }
>  
>  /**
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
