From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: max8925: mark expected switch fall-through
Date: Sun, 21 Oct 2018 21:34:13 +0200
Message-ID: <20181021193413.6w7x4rvx4xkyeyaw@earth.universe>
References: <20181004135636.GA15157@embeddedor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5why2j2ejhabe252"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181004135636.GA15157@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--5why2j2ejhabe252
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 04, 2018 at 03:56:36PM +0200, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>=20
> Addresses-Coverity-ID: 201510 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/max8925_power.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/supply/max8925_power.c b/drivers/power/supply/=
max8925_power.c
> index 3b94620..39b4d5b 100644
> --- a/drivers/power/supply/max8925_power.c
> +++ b/drivers/power/supply/max8925_power.c
> @@ -124,6 +124,7 @@ static irqreturn_t max8925_charger_handler(int irq, v=
oid *data)
>  	case MAX8925_IRQ_VCHG_THM_OK_F:
>  		/* Battery is not ready yet */
>  		dev_dbg(chip->dev, "Battery temperature is out of range\n");
> +		/* Fall through */
>  	case MAX8925_IRQ_VCHG_DC_OVP:
>  		dev_dbg(chip->dev, "Error detection\n");
>  		__set_charger(info, 0);
> --=20
> 2.7.4
>=20

--5why2j2ejhabe252
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvM1LUACgkQ2O7X88g7
+pqg5Q//ecxAFxAcMfEjXPAUNEyfetJvuk22LHz3gu9SsPbweu7k3/bF/eErlEAe
458haowS+dg7GNiymqIVH+Qe7n5sAV+x/GxCN8w6J8q35lR+Z8Q0iVc3nssfnIqG
3AEyUHgWmgZpZacrGIjoluGceu3mfaSC+eGYNnvIO0biWmukWEvde9AnuZBC2N3j
/0YSpdDOclVYk9+3eeAxQC/D2RE6rczbEaYGyyncixohlcFcGKv72/SRNRFj3NOY
v5rFjmt1ABilVQyf8o2xv4LOMHcq/+9Rk7O8HE3CNa2XP6zdlcVPmc6B4l3aO0Dv
6CrDbiO9k8l6jUbN9wPLQYAtaImoGL/bhVW84URU4CCWLfIBvzlAofIqzOpv4ICP
YQrgwgvAzPo7xK/NXL17gYq59es0bT2n/UYtmitA6Q/Yv69ZaZhKHvRIvg7gOAtF
kmt1PMiA7neU3gqIBfXMZ2+Fe9LrdkulxeJIqPtAYDD9D651/6hcfD/Ml4u/eQ8i
50ehgX2ASHfTKZkaDcCFLrztUuAsTkQSpb5vIFVm3A787Fa0NtqgbSqxovt0gYBx
1tQdkTQC2vhPKKkGv9aoqMnU/VuwqBIcRuVUzpegp00tAHEAviEIYPO3iFf+DuUp
VT95IPWnTs5uqgMrjaZ4UQ5OXkDpd/wCi7pPHx9zugqiUs53c0M=
=oRPN
-----END PGP SIGNATURE-----

--5why2j2ejhabe252--
