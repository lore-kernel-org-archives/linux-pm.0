From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] power: supply: axp288_charger: Only wait for INT3496
 device if present
Date: Mon, 20 Mar 2017 10:19:12 +0100
Message-ID: <20170320091912.rcbet4prgtq6vj6c@earth>
References: <20170316161736.339-1-hdegoede@redhat.com>
 <20170316161736.339-3-hdegoede@redhat.com>
 <20170320013039.vyi3zd5cc5ujqd5o@earth>
 <CAGb2v67VFa-Pu3j0rUUsFRKe4nndrbuPWN34j1F=R4uhB6papw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ao5qk5gitwd2r3f6"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753084AbdCTJ0u (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Mar 2017 05:26:50 -0400
Content-Disposition: inline
In-Reply-To: <CAGb2v67VFa-Pu3j0rUUsFRKe4nndrbuPWN34j1F=R4uhB6papw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, "open list:THERMAL" <linux-pm@vger.kernel.org>


--ao5qk5gitwd2r3f6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 20, 2017 at 04:56:18PM +0800, Chen-Yu Tsai wrote:
> On Mon, Mar 20, 2017 at 9:30 AM, Sebastian Reichel <sre@kernel.org> wrote:
> > On Thu, Mar 16, 2017 at 05:17:36PM +0100, Hans de Goede wrote:
> >> On some devices with an axp288 pmic setting vbus path based on the
> >> id-pin is handled by an ACPI _AIE interrupt on the gpio and the
> >> INT3496 device is disabled.
> >>
> >> Instead of returning -EPROBE_DEFER on these devices waiting for the
> >> never to show up INT3496 device, check for its presence and only
> >> request and monitor the matching extcon if the device is there,
> >> otherwise let the firmware handle the vbus path control.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >>  drivers/power/supply/axp288_charger.c | 24 +++++++++++++++---------
> >>  1 file changed, 15 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/sup=
ply/axp288_charger.c
> >> index d3bf4b2..6c4ad66 100644
> >> --- a/drivers/power/supply/axp288_charger.c
> >> +++ b/drivers/power/supply/axp288_charger.c
> >> @@ -14,6 +14,7 @@
> >>   * GNU General Public License for more details.
> >>   */
> >>
> >> +#include <linux/acpi.h>
> >>  #include <linux/module.h>
> >>  #include <linux/device.h>
> >>  #include <linux/regmap.h>
> >> @@ -114,7 +115,8 @@
> >>  #define ILIM_3000MA                  3000    /* 3000mA */
> >>
> >>  #define AXP288_EXTCON_DEV_NAME               "axp288_extcon"
> >> -#define USB_HOST_EXTCON_DEV_NAME     "INT3496:00"
> >> +#define USB_HOST_EXTCON_HID          "INT3496"
> >> +#define USB_HOST_EXTCON_NAME         "INT3496:00"
> >>
> >>  static const unsigned int cable_ids[] =3D
> >>       { EXTCON_CHG_USB_SDP, EXTCON_CHG_USB_CDP, EXTCON_CHG_USB_DCP };
> >> @@ -808,10 +810,12 @@ static int axp288_charger_probe(struct platform_=
device *pdev)
> >>               return -EPROBE_DEFER;
> >>       }
> >>
> >> -     info->otg.cable =3D extcon_get_extcon_dev(USB_HOST_EXTCON_DEV_NA=
ME);
> >> -     if (info->otg.cable =3D=3D NULL) {
> >> -             dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferr=
ed\n");
> >> -             return -EPROBE_DEFER;
> >> +     if (acpi_dev_present(USB_HOST_EXTCON_HID)) {
> >
> > I may have missed something, but as far as I can see axp288 also
> > supports DT based init, so that should be handled here.
>=20
> I doubt that will happen. AXP288 was designed specifically for Intel
> Bay Trail platforms, which AFAIK use ACPI. For the other AXP series
> PMIC we have another battery driver for them coming in.
>=20
> If you look in drivers/mfd/axp20x.c and drivers/mfd/axp20x-i2c.c,
> you'll see that AXP288 is only instantiated from ACPI, and all
> the axp288 named drivers are only instantiated for the AXP288
> mfd device.

Ok. I just looked briefly at drivers/mfd/axp20x.c and saw, that it
contained of_compatible entries. On a closer look axp288 does not
have them, so:

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--ao5qk5gitwd2r3f6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljPno0ACgkQ2O7X88g7
+pqeAhAAo6ZqL63v3T08ZbRxtKYU7kbxZeYTBuHtLwf7JP9ixnOlJ9ug/kniPmzZ
ebd1m9QeuO5mmnW3xaGeHmBUrM0iSZCreJRK2+rwHa0mzEnoBPuxjsF62O8rSPmS
485fq48fDOj8EvAwjJp9kp3PVSRDktX1f520qPtKe8nOD4YI4+fOrl2ihBegVS+E
Q5LjB0AVbsR5ZLjnWXUuoTPoUUSScgWW9upX+Bx24dKwAZZs/Og7gVi6gxqJZtJ3
hBABsDiEU+tcqRU/hdOsbDQpHPkWwh8ZUWX2Shp2B2JrCdWNhsE9IUEGY5yXkTUn
lNndOBN3WLufqngzmAJXLCTVEWxV0wRwA2TrNu57w+9SWwH44UrBSHgfbyJa5STv
lElFetIO2qKUPzXBsJsNzJ8+IGeM76VBED0xUxUw9nX6e8m2/DW5fwzlpOH4aTYK
DGqLRlrKE2IUWXbqTYmenp+drjey9Id2AVlTH6Qvj3JC6UmqbQjWimuzDgIqij2X
4ip3of7TSEc2iKHpBT0LrLGwq9ap7Cus4oW8IfSS+eQNgZ5Nz2+UC1mOPkqpodAD
CWBYdJSfVjM6yZXyS05T+C9sR2IZ7fgF3TvRLbpCQpgIvdCTibDo7A+ypt657C1m
h4T9Rx72UdqIDrTvX4cXCRSBGAxTl+/z0OwXfI/tu14GOI4uDSY=
=SS2E
-----END PGP SIGNATURE-----

--ao5qk5gitwd2r3f6--
