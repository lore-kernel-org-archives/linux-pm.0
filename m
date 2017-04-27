From: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v1] spi: mxs: implement runtime pm
Date: Thu, 27 Apr 2017 10:49:09 +0200
Message-ID: <1493282949.13947.8.camel@pengutronix.de>
References: <20170426201028.19217-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170426201028.19217-1-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Uwe,

Am Mittwoch, den 26.04.2017, 22:10 +0200 schrieb Uwe Kleine-König:
> This is a straight forward addition of runtime and system sleep pm operations
> that handle clk and pinctrl (for runtime pm) and spi_master_{suspend,resume}
> (for system sleep).
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  drivers/spi/spi-mxs.c | 129 ++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 119 insertions(+), 10 deletions(-)
> 
> Hello,
> 
> this is my first patch since several years that has to do with PM stuff.
> So I'm sure you can find something I got wrong ;-)
> 
> Best regards
> Uwe
> 
[...]

> +static const struct dev_pm_ops mxs_spi_pm = {
> +	SET_RUNTIME_PM_OPS(mxs_spi_runtime_suspend,
> +			   mxs_spi_runtime_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(mxs_spi_suspend, mxs_spi_resume)
> +};

This would be UNIVERSAL_DEV_PM_OPS, but it bears the question if your
suspend callback is really prepared to be used a system suspend
callback. See the comment above the definition of the
UNIVERSAL_DEV_PM_OPS macro.

Regards,
Lucas

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
