From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] power: max14577: Remove SYSFS dependency from Kconfig
Date: Fri, 28 Nov 2014 14:35:10 +0100
Message-ID: <1417181710.18249.28.camel@AMDC1943>
References: <1417180982-15127-1-git-send-email-k.wrona@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1417180982-15127-1-git-send-email-k.wrona@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Karol Wrona <k.wrona@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

On pi=C4=85, 2014-11-28 at 14:23 +0100, Karol Wrona wrote:
> This is only a small clean-up. The driver can be built without SYSFS
> as there exist stubs for used functions.
>=20
> Signed-off-by: Karol Wrona <k.wrona@samsung.com>
> ---
>  drivers/power/Kconfig |    1 -
>  1 file changed, 1 deletion(-)

Seems fine to me.
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

>=20
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 0108c2a..69fa8a9 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -327,7 +327,6 @@ config CHARGER_MANAGER
>  config CHARGER_MAX14577
>  	tristate "Maxim MAX14577/77836 battery charger driver"
>  	depends on MFD_MAX14577
> -	depends on SYSFS
>  	help
>  	  Say Y to enable support for the battery charger control sysfs and
>  	  platform data of MAX14577/77836 MUICs.
