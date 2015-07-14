From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [RFT/RFC] power_supply: bq2415x_charger: Initialize workqueue
 before scheduling it
Date: Tue, 14 Jul 2015 09:18:01 +0200
Message-ID: <20150714071801.GB12844@pali>
References: <1436834053-2084-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436834053-2084-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 14 July 2015 09:34:13 Krzysztof Kozlowski wrote:
> The driver during probe registers a power supply notifier
> (with bq2415x_notifier_call() callback) and calls it manually right
> after. The notifier callback function schedules driver's workqueue
> (bq->work).
>=20
> However the workqueue was initialized after these two events (after
> registering power supply notifier and calling manually the callback).
>=20
> When power supply core notified the driver (executing its
> bq2415x_notifier_call() callback) the scheduled workqueue could be
> still uninitialized.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reported-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>=20
> ---
>=20
> I don't have the hardware, please test. Additionally I could not find
> the commit which introduced the issue so I did not cc-stable.

Thanks for the patch! Please wait some time (about week) and I will tes=
t
it on real Nokia N900 hardware.

Because bq2415x depends on isp1704 on Nokia N900 and isp1704 is not
emulated by qemu, we cannot test any bq2415x changes in qemu :-(

> ---
>  drivers/power/bq2415x_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_=
charger.c
> index e98dcb661cc9..527ed0f18796 100644
> --- a/drivers/power/bq2415x_charger.c
> +++ b/drivers/power/bq2415x_charger.c
> @@ -1601,6 +1601,7 @@ static int bq2415x_probe(struct i2c_client *cli=
ent,
>  	bq->reported_mode =3D BQ2415X_MODE_OFF;
>  	bq->autotimer =3D 0;
>  	bq->automode =3D 0;
> +	INIT_DELAYED_WORK(&bq->work, bq2415x_timer_work);
> =20
>  	if (np || ACPI_HANDLE(bq->dev)) {
>  		ret =3D device_property_read_u32(bq->dev,
> @@ -1677,7 +1678,6 @@ static int bq2415x_probe(struct i2c_client *cli=
ent,
>  		dev_info(bq->dev, "automode not supported\n");
>  	}
> =20
> -	INIT_DELAYED_WORK(&bq->work, bq2415x_timer_work);
>  	bq2415x_set_autotimer(bq, 1);
> =20
>  	dev_info(bq->dev, "driver registered\n");

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
