From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: axp20x-i2c: Add i2c-ids to fix module auto-loading
Date: Wed, 26 Oct 2016 15:01:52 +0100
Message-ID: <20161026140152.GF13127@dell>
References: <20161005155112.13774-1-hdegoede@redhat.com>
 <20161005155112.13774-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35597 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753294AbcJZN7U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2016 09:59:20 -0400
Received: by mail-wm0-f44.google.com with SMTP id e69so32513663wmg.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2016 06:59:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20161005155112.13774-2-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dennis Gilmore <dennis@ausil.us>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 05 Oct 2016, Hans de Goede wrote:

> The i2c subsys does not load modules by compatible, only by
> i2c-id, with e.g. a modalias of: "i2c:axp209".
> 
> Populate the axp20x_i2c_id[] table with supported ids, so that
> module auto-loading will work.
> 
> Reported-by: Dennis Gilmore <dennis@ausil.us>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/axp20x-i2c.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied (for now), thanks.

> diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
> index b1b8658..d35a5fe 100644
> --- a/drivers/mfd/axp20x-i2c.c
> +++ b/drivers/mfd/axp20x-i2c.c
> @@ -69,10 +69,11 @@ static const struct of_device_id axp20x_i2c_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, axp20x_i2c_of_match);
>  
> -/*
> - * This is useless for OF-enabled devices, but it is needed by I2C subsystem
> - */
>  static const struct i2c_device_id axp20x_i2c_id[] = {
> +	{ "axp152", 0 },
> +	{ "axp202", 0 },
> +	{ "axp209", 0 },
> +	{ "axp221", 0 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
