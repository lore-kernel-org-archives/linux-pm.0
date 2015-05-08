From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] twl4030_charger: find associated phy by more
 reliable means.
Date: Fri, 8 May 2015 11:12:05 -0500
Message-ID: <20150508161205.GE16571@saruman.tx.rr.com>
References: <20150322225053.22311.45510.stgit@notabene.brown>
 <20150322225248.22311.50385.stgit@notabene.brown>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k3qmt+ucFURmlhDS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150322225248.22311.50385.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neil@brown.name>
Cc: Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Sebastian Reichel <sre@kernel.org>, Felipe Balbi <balbi@ti.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, NeilBrown <neilb@suse.de>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--k3qmt+ucFURmlhDS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2015 at 09:52:48AM +1100, NeilBrown wrote:
> From: NeilBrown <neilb@suse.de>
>=20
> twl4030_charger currently finds the associated phy
> using usb_get_phy() which will return the first USB2 phy.
> If your platform has multiple such phys (as mine does),
> this is not reliable (and reliably fails on the GTA04).
>=20
> Change to use devm_usb_get_phy_by_node(), having found the
> node by looking for an appropriately named sibling in
> device-tree.
>=20
> This makes usb-charging dependent on correct device-tree
> configuration.
>=20
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---

Sebastian, can I get your Acked-by here ?

>  .../devicetree/bindings/power/twl-charger.txt      |   10 ++++++++++
>  .../devicetree/bindings/usb/twlxxxx-usb.txt        |    3 +++
>  drivers/power/twl4030_charger.c                    |   21 +++++++++-----=
------
>  3 files changed, 22 insertions(+), 12 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/twl-charger.txt b/Do=
cumentation/devicetree/bindings/power/twl-charger.txt
> index d5c706216df5..3b4ea1b73b38 100644
> --- a/Documentation/devicetree/bindings/power/twl-charger.txt
> +++ b/Documentation/devicetree/bindings/power/twl-charger.txt
> @@ -1,5 +1,15 @@
>  TWL BCI (Battery Charger Interface)
> =20
> +The battery charger needs to interact with the USB phy in order
> +to know when charging is permissible, and when there is a connection
> +or disconnection.
> +
> +The choice of phy cannot be configured at a hardware level, so there
> +is no value in explicit configuration in device-tree.  Rather
> +if there is a sibling of the BCI node which is compatible with
> +"ti,twl4030-usb", then that is used to determine when and how
> +use USB power for charging.
> +
>  Required properties:
>  - compatible:
>    - "ti,twl4030-bci"
> diff --git a/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt b/Docu=
mentation/devicetree/bindings/usb/twlxxxx-usb.txt
> index 0aee0ad3f035..17327a296110 100644
> --- a/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
> @@ -30,6 +30,9 @@ TWL4030 USB PHY AND COMPARATOR
>   - usb_mode : The mode used by the phy to connect to the controller. "1"
>     specifies "ULPI" mode and "2" specifies "CEA2011_3PIN" mode.
> =20
> +If a sibling node is compatible "ti,twl4030-bci", then it will find
> +this device and query it for USB power status.
> +
>  twl4030-usb {
>  	compatible =3D "ti,twl4030-usb";
>  	interrupts =3D < 10 4 >;
> diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_char=
ger.c
> index d35b83e635b5..b07f4e2f2dde 100644
> --- a/drivers/power/twl4030_charger.c
> +++ b/drivers/power/twl4030_charger.c
> @@ -629,10 +629,15 @@ static int __init twl4030_bci_probe(struct platform=
_device *pdev)
> =20
>  	INIT_WORK(&bci->work, twl4030_bci_usb_work);
> =20
> -	bci->transceiver =3D usb_get_phy(USB_PHY_TYPE_USB2);
> -	if (!IS_ERR_OR_NULL(bci->transceiver)) {
> -		bci->usb_nb.notifier_call =3D twl4030_bci_usb_ncb;
> -		usb_register_notifier(bci->transceiver, &bci->usb_nb);
> +	bci->usb_nb.notifier_call =3D twl4030_bci_usb_ncb;
> +	if (bci->dev->of_node) {
> +		struct device_node *phynode;
> +
> +		phynode =3D of_find_compatible_node(bci->dev->of_node->parent,
> +						  NULL, "ti,twl4030-usb");
> +		if (phynode)
> +			bci->transceiver =3D devm_usb_get_phy_by_node(
> +				bci->dev, phynode, &bci->usb_nb);
>  	}
> =20
>  	/* Enable interrupts now. */
> @@ -662,10 +667,6 @@ static int __init twl4030_bci_probe(struct platform_=
device *pdev)
>  	return 0;
> =20
>  fail_unmask_interrupts:
> -	if (!IS_ERR_OR_NULL(bci->transceiver)) {
> -		usb_unregister_notifier(bci->transceiver, &bci->usb_nb);
> -		usb_put_phy(bci->transceiver);
> -	}
>  	free_irq(bci->irq_bci, bci);
>  fail_bci_irq:
>  	free_irq(bci->irq_chg, bci);
> @@ -694,10 +695,6 @@ static int __exit twl4030_bci_remove(struct platform=
_device *pdev)
>  	twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xff,
>  			 TWL4030_INTERRUPTS_BCIIMR2A);
> =20
> -	if (!IS_ERR_OR_NULL(bci->transceiver)) {
> -		usb_unregister_notifier(bci->transceiver, &bci->usb_nb);
> -		usb_put_phy(bci->transceiver);
> -	}
>  	free_irq(bci->irq_bci, bci);
>  	free_irq(bci->irq_chg, bci);
>  	power_supply_unregister(&bci->usb);
>=20
>=20

--=20
balbi

--k3qmt+ucFURmlhDS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVTOBVAAoJEIaOsuA1yqREl7cP/RXmHVHTaHHMHFgrQtcScvs4
0S9BvieH80pGRBO605j406tZwJuHVuRUmqcri1cU+ugroqtjtJs51aUficwz45xN
H/+bI7+0d1oKlXJtSL3hRCrlehLAkfVb2X3itVzi6NfsAh4wu64b7rNENKsb3e+W
KkCKfsyCqtD8SgODijuclyGI6eBn6c/BlDm59TahS8McZJWyhTkpFm6LPDzee0zT
n0MFYSdpBwvkAqLxeTRpQE0PJEPZkStTEzomr4t82xdMbAnk7tbJ7tQyEwnMfg3D
zTkAqEpnFoD7lsnELnh488xw0FbJleF3ywaIvrrZXYTnDNYfSrXL9mLjOj3QM9g1
9D6MVx1FUy9QcH4Nbl0Qku7FPUqrCNwTdRmqba3PU8XMv/hOE0ZR9fOntmcx+1oX
Kvo8lmNHLKrSx4cCHHlMNoB1EqcFmpP7CH9UBLgSBYjOEYKa2UnhulLZuzDeFGwu
YXP5t/o6GwtLXoygiS3OoUv90VwdiAzpmSSc0arGV8IZ2Aege6YhBqyPMNFVgO0h
ulmraNHJC/ruRlUqD8xQb3VCJZFPEuOYtmfauzBtqGPuLt23gNIFyFnhjehHiaoJ
arIfo5GWBgSUovrWEX44xTFA0+HBp7sBwEoLJa16TiukSbEw5dX0wgslmqQuykUd
UmeDolhYgYhs6dWnEl1L
=ob+K
-----END PGP SIGNATURE-----

--k3qmt+ucFURmlhDS--
