From: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
Subject: Re: [PATCH v4] power_supply: Add support for Richtek rt9455 battery charger
Date: Fri, 8 May 2015 21:09:27 +0900
Message-ID: <CAJKOXPdvOU3RtWaodXqJ3-6exZryyUiGZbdiKfpxd_JvDaih9g@mail.gmail.com>
References: <1431086300-5289-1-git-send-email-anda-maria.nicolae@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vn0-f43.google.com ([209.85.216.43]:38205 "EHLO
	mail-vn0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbbEHMJ3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 08:09:29 -0400
In-Reply-To: <1431086300-5289-1-git-send-email-anda-maria.nicolae@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
Cc: sre@kernel.org, dbaryshkov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

2015-05-08 20:58 GMT+09:00 Anda-Maria Nicolae <anda-maria.nicolae@intel.com>:
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 4091fb0..b2b230c 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -439,6 +439,13 @@ config BATTERY_RT5033
>           The fuelgauge calculates and determines the battery state of charge
>           according to battery open circuit voltage.
>
> +config CHARGER_RT9455
> +       tristate "Richtek RT9455 battery charger driver"
> +       depends on I2C && GPIOLIB
> +       depends on REGMAP_I2C

Like I said previously, I still think you need to select it, not
depend on it. This is not a user-selectable option, so depending on it
may hide your driver. If you are unsure in such case you can always:
$ git grep REGMAP_I2C

Rest looks fine to me, so with the change above (s/depends on/select/):
Reviewed-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Best regards,
Krzysztof
