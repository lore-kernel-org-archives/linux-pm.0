From: jonghwa3.lee@samsung.com
Subject: Re: [PATCH] max17042: Fix build errors caused by missing REGMAP_I2C
 config
Date: Mon, 25 Nov 2013 09:40:04 +0900
Message-ID: <52929C64.2090903@samsung.com>
References: <20131124214149.cf1b6444d6e43d637ea7e34b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20131124214149.cf1b6444d6e43d637ea7e34b@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Austin Boyle <boyle.austin@gmail.com>
Cc: Anton Vorontsov <anton@enomsg.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Myungjoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 2013=EB=85=84 11=EC=9B=94 24=EC=9D=BC 19:41, Austin Boyle wrote:

> max17042 now uses regmap interface but does not enable config option.=
 This patch fixes the following build errors:
>=20
> drivers/power/max17042_battery.c:661:15: error: variable =E2=80=98max=
17042_regmap_config=E2=80=99 has initializer but incomplete type
> drivers/power/max17042_battery.c:662:2: error: unknown field =E2=80=98=
reg_bits=E2=80=99 specified in initializer
> drivers/power/max17042_battery.c:662:2: warning: excess elements in s=
truct initializer
> drivers/power/max17042_battery.c:662:2: warning: (near initialization=
 for =E2=80=98max17042_regmap_config=E2=80=99)
> drivers/power/max17042_battery.c:663:2: error: unknown field =E2=80=98=
val_bits=E2=80=99 specified in initializer
> drivers/power/max17042_battery.c:663:2: warning: excess elements in s=
truct initializer
> drivers/power/max17042_battery.c:663:2: warning: (near initialization=
 for =E2=80=98max17042_regmap_config=E2=80=99)
> drivers/power/max17042_battery.c:664:2: error: unknown field =E2=80=98=
val_format_endian=E2=80=99 specified in initializer
> drivers/power/max17042_battery.c:664:23: error: =E2=80=98REGMAP_ENDIA=
N_NATIVE=E2=80=99 undeclared here (not in a function)
> drivers/power/max17042_battery.c:664:2: warning: excess elements in s=
truct initializer
> drivers/power/max17042_battery.c:664:2: warning: (near initialization=
 for =E2=80=98max17042_regmap_config=E2=80=99)
> drivers/power/max17042_battery.c: In function =E2=80=98max17042_probe=
=E2=80=99:
> drivers/power/max17042_battery.c:684:2: error: implicit declaration o=
f function =E2=80=98devm_regmap_init_i2c=E2=80=99
>=20
> Signed-off-by: Austin Boyle <boyle.austin@gmail.com>
> ---
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 5e2054a..85ad58c 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -196,6 +196,7 @@ config BATTERY_MAX17040
>  config BATTERY_MAX17042
>  	tristate "Maxim MAX17042/17047/17050/8997/8966 Fuel Gauge"
>  	depends on I2C
> +	select REGMAP_I2C
>  	help
>  	  MAX17042 is fuel-gauge systems for lithium-ion (Li+) batteries
>  	  in handheld and portable equipment. The MAX17042 is configured
>=20


Sorry, It's my fault. Thanks.

Acked-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
