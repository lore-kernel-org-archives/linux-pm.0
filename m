From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 1/2] power: supply: bq24190_charger: Use new
 extcon_register_notifier_all()
Date: Fri, 14 Apr 2017 01:35:26 +0200
Message-ID: <20170413233526.ebtytz54d3ux2oze@earth>
References: <20170413120412.12773-1-hdegoede@redhat.com>
 <20170413120412.12773-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lj7wpymxwatwkeve"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752365AbdDMXfb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Apr 2017 19:35:31 -0400
Content-Disposition: inline
In-Reply-To: <20170413120412.12773-2-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org


--lj7wpymxwatwkeve
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 13, 2017 at 02:04:11PM +0200, Hans de Goede wrote:
> When I submitted the extcon handling I had a patch pending for the
> extcon sub-system for extcon_register_notifier to take -1 as cable id
> for listening for all type cable events on an extcon with a single
> notifier.
>=20
> In the end it was decided to instead add a new
> extcon_register_notifier_all function for this, switch to using this.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Liam Breck <kernel@networkimprov.net>

With extcon_register_notifier_all() being new and not available
in my tree I can't simply queue this patch. Also it can't simply
go through the extcon subsystem, since it depends on changes in
the power-supply subsystem and results in non-trivial merge conflict.
I see three merge solutions:

 1. Defer to 4.13 (since we are already quite near the merge window)
 2. I need a immutable branch with extcon_register_notifier_all()
    from the extcon subsystem
 3. It may count as Fix and could be queued during the 4.12-rc
    phase based von 4.12-rc1

-- Sebastian

> ---
> Changes in v4:
> -This is a new patch in v4 of this patch-set
> Changes in v5;
> -Add Liam's Acked-by
> ---
>  drivers/power/supply/bq24190_charger.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index 7c893c0..bd9e5c3 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1502,8 +1502,8 @@ static int bq24190_probe(struct i2c_client *client,
>  	if (bdi->extcon) {
>  		INIT_DELAYED_WORK(&bdi->extcon_work, bq24190_extcon_work);
>  		bdi->extcon_nb.notifier_call =3D bq24190_extcon_event;
> -		ret =3D devm_extcon_register_notifier(dev, bdi->extcon, -1,
> -						    &bdi->extcon_nb);
> +		ret =3D devm_extcon_register_notifier_all(dev, bdi->extcon,
> +							&bdi->extcon_nb);
>  		if (ret) {
>  			dev_err(dev, "Can't register extcon\n");
>  			goto out_sysfs;
> --=20
> 2.9.3
>=20

--lj7wpymxwatwkeve
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljwCzwACgkQ2O7X88g7
+po5nQ//cjDc6lgc9LqdogMX5vtFBsDWq4Sb1e+IwD8REFF+76rM1rCV1OC2AaCG
pEXViwMsd129uYLrkefzuWRwew+b+NGd3Bqw9/KqVvdHjG8muvJCEJs9un+UG30g
bQHdUeRLFKjiCYo4QgHKgMPQARk26VzIz2YvlvaS8RTqqvgAfhI0HX2vnlaiwlg7
ep7CxFGbJftRkFBCajsv+Qz53Nsg3BHY2rsTyuN2toNKxIzjBUDbA1s5tzSoNlnZ
dlkUsCAYI83X0EH9H4AJd++UeN1Gl/z6lZYOUsVKjCzhp2Fb9a/rqzgvbJhOUunW
d85gSC9Uo9PfahvBZNa06PrlQkKbonGe3lu3621nx38U2kCUFCu2SFvQ5UAr0Gki
DbRMJ3P72DSvCfbMR3I37oDrOh4tUGD1eEA30NAVPLNDjyAhw71wg9yiV3EWzEmE
CRsI/B1HyaNux+87gDrmG9E97E9InNO/EqHd64zWsygUkUCcA8W8LaDD3STzesMI
Cdg/muSTeEpchZR8uPBqtQkwv8U6XIpj8zTF5T3fvhYvLwXK++oBSnB965Mco060
df8v8yik2glt4aR3AS4ff5ibsrmRMxAAcBGTb4q3RWdMDAZfzXgLEq+Oj3Yssyzy
Da2GhUmlnncj0AzYicY8oe1/W5iBcSbBL1UamjFnsQui0qlOjwY=
=JfQL
-----END PGP SIGNATURE-----

--lj7wpymxwatwkeve--
