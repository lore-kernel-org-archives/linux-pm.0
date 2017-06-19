From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 03/10] i2c: i2c-smbus: Use threaded irq for smbalert
Date: Mon, 19 Jun 2017 17:27:18 +0200
Message-ID: <20170619152718.3xjksam7ns4ms6xk@ninjato>
References: <1497535178-12001-1-git-send-email-preid@electromag.com.au>
 <1497535178-12001-4-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5bk4ef74avjgooz6"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:53695 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752609AbdFSP1V (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Jun 2017 11:27:21 -0400
Content-Disposition: inline
In-Reply-To: <1497535178-12001-4-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org


--5bk4ef74avjgooz6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2017 at 09:59:31PM +0800, Phil Reid wrote:
> Prior to this commit the smbalert_irq was handling in the hard irq
> context. This change switch to using a thread irq which avoids the need
> for the work thread. Using threaded irq also removes the need for the
> edge_triggered flag as the enabling / disabling of the hard irq for level
> triggered interrupts will be handled by the irq core.
>=20
> Without this change have an irq connected to something like an i2c gpio
> resulted in a null ptr deferences. Specifically handle_nested_irq calls
> the threaded irq handler.
>=20
> There are currently 3 in tree drivers affected by this change.
>=20
> i2c-parport driver calls i2c_handle_smbus_alert in a hard irq context.
> This driver use edge trigger interrupts which skip the enable / disable
> calls. But it still need to handle the smbus transaction on a thread. So
> the work thread is kept for this driver.
>=20
> i2c-parport-light & i2c-thunderx-pcidrv provide the irq number in the
> setup which will result in the thread irq being used.
>=20
> i2c-parport-light is edge trigger so the enable / disable call was
> skipped as well.
>=20
> i2c-thunderx-pcidrv is getting the edge / level trigger setting from of
> data and was setting the flag as required. However the irq core should
> handle this automatically.
>=20
> Signed-off-by: Phil Reid <preid@electromag.com.au>

CCing Benjamin for smbus changes (like last time). Please CC him in the
future in case we need another revision of this series.

> ---
>  drivers/i2c/busses/i2c-parport-light.c   |  1 -
>  drivers/i2c/busses/i2c-parport.c         |  1 -
>  drivers/i2c/busses/i2c-thunderx-pcidrv.c |  6 -----
>  drivers/i2c/i2c-smbus.c                  | 41 +++++++++++++-------------=
------
>  include/linux/i2c-smbus.h                |  1 -
>  5 files changed, 17 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-parport-light.c b/drivers/i2c/busses/=
i2c-parport-light.c
> index 1bcdd10..e6e22b8 100644
> --- a/drivers/i2c/busses/i2c-parport-light.c
> +++ b/drivers/i2c/busses/i2c-parport-light.c
> @@ -123,7 +123,6 @@ static int parport_getsda(void *data)
> =20
>  /* SMBus alert support */
>  static struct i2c_smbus_alert_setup alert_data =3D {
> -	.alert_edge_triggered	=3D 1,
>  };
>  static struct i2c_client *ara;
>  static struct lineop parport_ctrl_irq =3D {
> diff --git a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-pa=
rport.c
> index a8e54df..319209a 100644
> --- a/drivers/i2c/busses/i2c-parport.c
> +++ b/drivers/i2c/busses/i2c-parport.c
> @@ -237,7 +237,6 @@ static void i2c_parport_attach(struct parport *port)
> =20
>  	/* Setup SMBus alert if supported */
>  	if (adapter_parm[type].smbus_alert) {
> -		adapter->alert_data.alert_edge_triggered =3D 1;
>  		adapter->ara =3D i2c_setup_smbus_alert(&adapter->adapter,
>  						     &adapter->alert_data);
>  		if (adapter->ara)
> diff --git a/drivers/i2c/busses/i2c-thunderx-pcidrv.c b/drivers/i2c/busse=
s/i2c-thunderx-pcidrv.c
> index 1d4c2be..c27a50f 100644
> --- a/drivers/i2c/busses/i2c-thunderx-pcidrv.c
> +++ b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
> @@ -112,8 +112,6 @@ static void thunder_i2c_clock_disable(struct device *=
dev, struct clk *clk)
>  static int thunder_i2c_smbus_setup_of(struct octeon_i2c *i2c,
>  				      struct device_node *node)
>  {
> -	u32 type;
> -
>  	if (!node)
>  		return -EINVAL;
> =20
> @@ -121,10 +119,6 @@ static int thunder_i2c_smbus_setup_of(struct octeon_=
i2c *i2c,
>  	if (!i2c->alert_data.irq)
>  		return -EINVAL;
> =20
> -	type =3D irqd_get_trigger_type(irq_get_irq_data(i2c->alert_data.irq));
> -	i2c->alert_data.alert_edge_triggered =3D
> -		(type & IRQ_TYPE_LEVEL_MASK) ? 1 : 0;
> -
>  	i2c->ara =3D i2c_setup_smbus_alert(&i2c->adap, &i2c->alert_data);
>  	if (!i2c->ara)
>  		return -ENODEV;
> diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
> index f9271c7..d4af270 100644
> --- a/drivers/i2c/i2c-smbus.c
> +++ b/drivers/i2c/i2c-smbus.c
> @@ -25,8 +25,6 @@
>  #include <linux/workqueue.h>
> =20
>  struct i2c_smbus_alert {
> -	unsigned int		alert_edge_triggered:1;
> -	int			irq;
>  	struct work_struct	alert;
>  	struct i2c_client	*ara;		/* Alert response address */
>  };
> @@ -72,13 +70,12 @@ static int smbus_do_alert(struct device *dev, void *a=
ddrp)
>   * The alert IRQ handler needs to hand work off to a task which can issue
>   * SMBus calls, because those sleeping calls can't be made in IRQ contex=
t.
>   */
> -static void smbus_alert(struct work_struct *work)
> +static irqreturn_t smbus_alert(int irq, void *d)
>  {
> -	struct i2c_smbus_alert *alert;
> +	struct i2c_smbus_alert *alert =3D d;
>  	struct i2c_client *ara;
>  	unsigned short prev_addr =3D 0;	/* Not a valid address */
> =20
> -	alert =3D container_of(work, struct i2c_smbus_alert, alert);
>  	ara =3D alert->ara;
> =20
>  	for (;;) {
> @@ -115,21 +112,17 @@ static void smbus_alert(struct work_struct *work)
>  		prev_addr =3D data.addr;
>  	}
> =20
> -	/* We handled all alerts; re-enable level-triggered IRQs */
> -	if (!alert->alert_edge_triggered)
> -		enable_irq(alert->irq);
> +	return IRQ_HANDLED;
>  }
> =20
> -static irqreturn_t smbalert_irq(int irq, void *d)
> +static void smbalert_work(struct work_struct *work)
>  {
> -	struct i2c_smbus_alert *alert =3D d;
> +	struct i2c_smbus_alert *alert;
> +
> +	alert =3D container_of(work, struct i2c_smbus_alert, alert);
> =20
> -	/* Disable level-triggered IRQs until we handle them */
> -	if (!alert->alert_edge_triggered)
> -		disable_irq_nosync(irq);
> +	smbus_alert(0, alert);
> =20
> -	schedule_work(&alert->alert);
> -	return IRQ_HANDLED;
>  }
> =20
>  /* Setup SMBALERT# infrastructure */
> @@ -139,28 +132,28 @@ static int smbalert_probe(struct i2c_client *ara,
>  	struct i2c_smbus_alert_setup *setup =3D dev_get_platdata(&ara->dev);
>  	struct i2c_smbus_alert *alert;
>  	struct i2c_adapter *adapter =3D ara->adapter;
> -	int res;
> +	int res, irq;
> =20
>  	alert =3D devm_kzalloc(&ara->dev, sizeof(struct i2c_smbus_alert),
>  			     GFP_KERNEL);
>  	if (!alert)
>  		return -ENOMEM;
> =20
> -	alert->alert_edge_triggered =3D setup->alert_edge_triggered;
> -	alert->irq =3D setup->irq;
> -	INIT_WORK(&alert->alert, smbus_alert);
> +	irq =3D setup->irq;
> +	INIT_WORK(&alert->alert, smbalert_work);
>  	alert->ara =3D ara;
> =20
> -	if (setup->irq > 0) {
> -		res =3D devm_request_irq(&ara->dev, setup->irq, smbalert_irq,
> -				       0, "smbus_alert", alert);
> +	if (irq > 0) {
> +		res =3D devm_request_threaded_irq(&ara->dev, irq,
> +						NULL, smbus_alert,
> +						IRQF_SHARED | IRQF_ONESHOT,
> +						"smbus_alert", alert);
>  		if (res)
>  			return res;
>  	}
> =20
>  	i2c_set_clientdata(ara, alert);
> -	dev_info(&adapter->dev, "supports SMBALERT#, %s trigger\n",
> -		 setup->alert_edge_triggered ? "edge" : "level");
> +	dev_info(&adapter->dev, "supports SMBALERT#\n");
> =20
>  	return 0;
>  }
> diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
> index a138502..19efbd1 100644
> --- a/include/linux/i2c-smbus.h
> +++ b/include/linux/i2c-smbus.h
> @@ -42,7 +42,6 @@
>   * properly set.
>   */
>  struct i2c_smbus_alert_setup {
> -	unsigned int		alert_edge_triggered:1;
>  	int			irq;
>  };
> =20
> --=20
> 1.8.3.1
>=20

--5bk4ef74avjgooz6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllH7VIACgkQFA3kzBSg
KbZpww//f47D+w0oW4aTQB5X76POla81SsHOBkw2MFZxTI+sSj/wXdg8izkR1+fV
iRU9T1e0LKQrY0DVkt5f4oL4xV0iV293PwSwsPAjiLpr54NHnmdkykqrJ/Qf+mXd
llvalVkdtlDZ3qLqqDLultLK3/G2tQRX2Hm4W0gBZGmLcifsSGxE7alJJnA90fSH
bRUcUxWvvIDrIqZ/LBjc6fburehaLVkUR/+dc7f0hxb3g4VpnfhnKbKqNEhDciPW
VGEP7UL942PXvunvs2ITwxfZQQfzHfTFUqQQ/VY7MrCfPHU5qAnUjkyIzGmOsHQH
pQl2reP68E+xUPgG2Wfasjxa1PCXodVkoyq1urofcY+nwiSpMv6/xkF4ru13k8v9
nqp1SpnPu4RUX5aEHY4OlPoXmQArPElU58vjucEnp9RlIAyGvwtyK5sVHNqzXK2y
z7yIKlgLg91dvb41b6r9NSFj570ibuJIlTwEjht2f5MM25Euipw6sEbXMXMKDj/x
1dgSEHgauCguPh4Mn5bDw7l7Ihp4DF9mkanvReP8kSI2V2nLwktqDwZ8oze4ajOI
e1nHRuSu9lKTAdsydn19NoWFKPJpUG2/nOLE2ZVUyK4UGvsGrP2/3tSs7bIrfVho
rBV++eVost3zs/Jt7F/+nW1rCyB7hZ2TkY2ap47z3mrkz3obWmI=
=R7ES
-----END PGP SIGNATURE-----

--5bk4ef74avjgooz6--
