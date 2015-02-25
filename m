From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] twl4030_charger: find associated phy by more
 reliable means.
Date: Wed, 25 Feb 2015 22:13:51 +0100
Message-ID: <20150225211351.GH13695@earth>
References: <20150224035809.32252.4180.stgit@notabene.brown>
 <20150224040129.32252.59874.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y9PDtDHaFrXNoMPU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150224040129.32252.59874.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Felipe Balbi <balbi@ti.com>, GTA04 owners <gta04-owner@goldelico.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--y9PDtDHaFrXNoMPU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Neil,

On Tue, Feb 24, 2015 at 03:01:29PM +1100, NeilBrown wrote:
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

The patch looks ok to me, but you should update the DT documentation
in Documentation/devicetree/bindings/power/twl-charger.txt regarding
the sibling dependency.

Apart from that DT binding maintainers should be CC'd.

-- Sebastian

--y9PDtDHaFrXNoMPU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU7jsMAAoJENju1/PIO/qawYEP/1w6Pt3PJ+5mY5q7styNl0T2
FxUPBy8zCn2llSs4tz4914V6reloTFg1E1N+ELUlTTorfkAAP3uNLMuyDVJi/YDx
eRy1VbXteUe3/jymvZ9YsB96YKltNPDn6gJ3dZWWrP2ibKCiYBgX+hcmpyTR+tvn
bTkv9b82hxmi1MLLwE5mAGPVZcnNdnORqSgPs+/ds66bYHth7cavQjdIZ22WxpfM
/SazRQS0mCMVhUB1wcdBFj74UU5eKJwgKg7lx+OBWKvWFyKtmZETyIiET+KsCI7c
+Xl6Ai82FtCvMnj9S5pAxWN3pFWoEW3bDo68Y8WXInaxhvR7wghMrPJYljBx8kJ/
PaT317R/1UC1rNLDs+rc5MXS8sx0MO6Iiox0zZJ3f7qPlQe/G1DlynFqZU+KzL+S
DVMJvwqiXtivcj0O0vHSyOosrzp/AGTm0oor5rW/Ly4rtlC+cgO8BSKc7L4Z0jdW
FCzsuH4rtTRfW/Fl1nBtK6ba4cZsZFgQ0WpD0OshIpP7wwn1KTNLOgi5J8wTbaph
Yc5obgVPa1Lv5sFS+P3sCFIwCgLrdiqgJD+yjAC8LpNhUGVSGHJWhduooq5uSOXR
j237q74BR9q1CEKdoe1XRRm0tlatOSLO9z9hQtqqBOQCz8oS0T5HrU0RdGcMgmSl
w7LWxJQAklsiDkdo44Qp
=cpSK
-----END PGP SIGNATURE-----

--y9PDtDHaFrXNoMPU--
