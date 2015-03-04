From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 2/2] twl4030_charger: find associated phy by more
 reliable means.
Date: Wed, 4 Mar 2015 20:14:31 +1100
Message-ID: <20150304201431.0fc6c108@notabene.brown>
References: <20150224035809.32252.4180.stgit@notabene.brown>
	<20150224040129.32252.59874.stgit@notabene.brown>
	<20150225211351.GH13695@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/gEm57q3prhNdkBCiy9+wi4e"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150225211351.GH13695@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Felipe Balbi <balbi@ti.com>, GTA04 owners <gta04-owner@goldelico.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--Sig_/gEm57q3prhNdkBCiy9+wi4e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Feb 2015 22:13:51 +0100 Sebastian Reichel <sre@kernel.org> wrote:

> Hi Neil,
>=20
> On Tue, Feb 24, 2015 at 03:01:29PM +1100, NeilBrown wrote:
> > twl4030_charger currently finds the associated phy
> > using usb_get_phy() which will return the first USB2 phy.
> > If your platform has multiple such phys (as mine does),
> > this is not reliable (and reliably fails on the GTA04).
> >=20
> > Change to use devm_usb_get_phy_by_node(), having found the
> > node by looking for an appropriately named sibling in
> > device-tree.
> >=20
> > This makes usb-charging dependent on correct device-tree
> > configuration.
>=20
> The patch looks ok to me, but you should update the DT documentation
> in Documentation/devicetree/bindings/power/twl-charger.txt regarding
> the sibling dependency.
>=20
> Apart from that DT binding maintainers should be CC'd.
>=20
> -- Sebastian

Thanks.
I've added the following.  I've also changed the code to use
of_find_compatible_node() and find the USB phy based on 'compatible' rather
than on the node name.

I'll Cc DT maintainers when I resubmit.

Thanks,
NeilBrown

diff --git a/Documentation/devicetree/bindings/power/twl-charger.txt b/Docu=
mentation/devicetree/bindings/power/twl-charger.txt
index d5c706216df5..3b4ea1b73b38 100644
--- a/Documentation/devicetree/bindings/power/twl-charger.txt
+++ b/Documentation/devicetree/bindings/power/twl-charger.txt
@@ -1,5 +1,15 @@
 TWL BCI (Battery Charger Interface)
=20
+The battery charger needs to interact with the USB phy in order
+to know when charging is permissible, and when there is a connection
+or disconnection.
+
+The choice of phy cannot be configured at a hardware level, so there
+is no value in explicit configuration in device-tree.  Rather
+if there is a sibling of the BCI node which is compatible with
+"ti,twl4030-usb", then that is used to determine when and how
+use USB power for charging.
+
 Required properties:
 - compatible:
   - "ti,twl4030-bci"
diff --git a/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt b/Docume=
ntation/devicetree/bindings/usb/twlxxxx-usb.txt
index 0aee0ad3f035..17327a296110 100644
--- a/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
+++ b/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
@@ -30,6 +30,9 @@ TWL4030 USB PHY AND COMPARATOR
  - usb_mode : The mode used by the phy to connect to the controller. "1"
    specifies "ULPI" mode and "2" specifies "CEA2011_3PIN" mode.
=20
+If a sibling node is compatible "ti,twl4030-bci", then it will find
+this device and query it for USB power status.
+
 twl4030-usb {
 	compatible =3D "ti,twl4030-usb";
 	interrupts =3D < 10 4 >;

--Sig_/gEm57q3prhNdkBCiy9+wi4e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVPbM9znsnt1WYoG5AQIx6BAAutL1z9YG+YulciZsil0zdHOEesu9PAsm
/uQIsYTxLGKcJc5AjjJeAbkdVyJwO8cxOILJSQbAMYjmv2N3t6xM3UuRwAK8Xfsq
x+qWa6Uy/Y2UBH5eeJppt+CH66BoyktG1CyLXsHJYMZUlHlLY0O9Y3WJuNtUkbt4
t1z0IXgC+zyU8w+IWuCMLx7kpqdxZRcked/0LIgHSVLOBo9wqoKl4jUGoOcKQ4em
gzfVlDxmwCpxr9TT6kep93DZQhiFGBlusFZzOCogAdFYiMU87ZyDOfgebAJvJMx1
agl3R05SLMsAFFMaHDs+s7hnWXwpvOWQUmdogU+U9DNE+5CR74bn/F9G1/ZeUsjb
k5mooTJbkQ78VL7jjPurj7GeoDfNuxYUj8QLyiy7iTCiei07HSbHP4FQFHYpq34b
3IbyX/D6u/NkmjORQ9KojX7gPQjzuCSJPtvsXoLuib+JQomKatUtTPtz+FAsuvcj
zVfwKdKzlA9qrmdz82n4/CjMo7qmOapX/zpZFKL4lKwDGgMFcpaQf+8HtQeWzozn
nPpHairaIPAxggRBlRHLMO0r2jiMns2xZKzYUG/xZaYS4m/rSn4HPNxyvlMZoyIh
dyXkyRphJbjtQpdH3w6qVgehLC7k/OOHqOMp1+sKJJ7ZkcKqfY0DHcXZEj1oO/q2
G2+730xy0Ag=
=N+fp
-----END PGP SIGNATURE-----

--Sig_/gEm57q3prhNdkBCiy9+wi4e--
