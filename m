From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 2/3] power: bq27xxx_battery: move irq handler to i2c
 section
Date: Fri, 16 Oct 2015 16:48:21 +0200
Message-ID: <20151016144821.GI28216@pali>
References: <1445003052-31373-1-git-send-email-sre@kernel.org>
 <1445003052-31373-3-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:32817 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbbJPOsY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2015 10:48:24 -0400
Content-Disposition: inline
In-Reply-To: <1445003052-31373-3-git-send-email-sre@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F . Davis" <afd@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 16 October 2015 15:44:11 Sebastian Reichel wrote:
> The IRQ handler is not used by the platform based
> code resulting in a 'defined but not used' warning,
> if CONFIG_BQ27XXX_I2C is not enabled.
>=20
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  drivers/power/bq27xxx_battery.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_=
battery.c
> index 69e6b371a51c..880233ce9343 100644
> --- a/drivers/power/bq27xxx_battery.c
> +++ b/drivers/power/bq27xxx_battery.c
> @@ -762,15 +762,6 @@ static void bq27xxx_battery_update(struct bq27xx=
x_device_info *di)
>  	di->last_update =3D jiffies;
>  }
> =20
> -static irqreturn_t bq27xxx_battery_irq_handler_thread(int irq, void =
*data)
> -{
> -	struct bq27xxx_device_info *di =3D data;
> -
> -	bq27xxx_battery_update(di);
> -
> -	return IRQ_HANDLED;
> -}
> -
>  static void bq27xxx_battery_poll(struct work_struct *work)
>  {
>  	struct bq27xxx_device_info *di =3D
> @@ -1061,6 +1052,15 @@ static void bq27xxx_powersupply_unregister(str=
uct bq27xxx_device_info *di)
>  static DEFINE_IDR(battery_id);
>  static DEFINE_MUTEX(battery_mutex);
> =20
> +static irqreturn_t bq27xxx_battery_irq_handler_thread(int irq, void =
*data)
> +{
> +	struct bq27xxx_device_info *di =3D data;
> +
> +	bq27xxx_battery_update(di);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, =
u8 reg,
>  				    bool single)
>  {

Acked-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
