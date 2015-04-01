From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 1/3] power: max17042_battery: Use reg type instead of chip type
Date: Wed, 1 Apr 2015 10:18:53 +0200
Message-ID: <CAJKOXPdM1zt_y19Lv8Q6PPLzhOJSw3JaLRgi=ziaNsg0p=-ieg@mail.gmail.com>
References: <1427808574-19397-1-git-send-email-beomho.seo@samsung.com>
	<1427808574-19397-2-git-send-email-beomho.seo@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427808574-19397-2-git-send-email-beomho.seo@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: lee.jones@linaro.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, cw00.choi@samsung.com, sangbae90.lee@samsung.com, inki.dae@samsung.com, Kozik <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, myungjoo.ham@samsung.com, Sebastian Reichel <sre@kernel.org>, jonghwa3.lee@samsung.com
List-Id: linux-pm@vger.kernel.org

2015-03-31 15:29 GMT+02:00 Beomho Seo <beomho.seo@samsung.com>:
> Currently, max17042 battery driver choose register map by MAX17042_DevName
> register. But thid register is return IC specific firmware version. So other
> maxim chip hard to use this drvier. This patch choose reg_type by driver_data.

I don't quite get the concept of "reg_type" and why it replaces chip
type? It seems that you choose reg_type based on given chip type so
there is direct mapping chip_type->reg_type. If max17047 and max17050
are the same from the point of view of interface (registers) then they
should use the same compatible or the same device type. Something
like:

>  static const struct i2c_device_id max17042_id[] = {
> -       { "max17042", 0 },
> -       { "max17047", 1 },
> -       { "max17050", 2 },
> +       { "max17042", MAXIM_DEVICE_TYPE_MAX17042 },
> +       { "max17047", MAXIM_DEVICE_TYPE_MAX17047 },
> +       { "max17050", MAXIM_DEVICE_TYPE_MAX17047 }, /* Same as 17047 */
>         { }

So why you are adding the conversion from i2c_device_id -> reg_type?

Beside that, thanks for integrating this into existing driver! Much appreciated.

Best regards,
Krzysztof
