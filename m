From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/2] power: reset: at91: add sama5d3 reset function
Date: Fri, 10 Jul 2015 08:54:40 +0200
Message-ID: <20150710065440.GY28632@lukather>
References: <1436436947-11210-1-git-send-email-josh.wu@atmel.com>
 <20150709120335.GW28632@lukather>
 <559F36CC.7020203@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WTO+dqXoBrlfXqg9"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:40550 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752064AbbGJGzH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2015 02:55:07 -0400
Content-Disposition: inline
In-Reply-To: <559F36CC.7020203@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josh Wu <josh.wu@atmel.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Fabian Frederick <fabf@skynet.be>, linux-pm@vger.kernel.org


--WTO+dqXoBrlfXqg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2015 at 11:06:52AM +0800, Josh Wu wrote:
> Hi, Maxime
>=20
> On 7/9/2015 8:03 PM, Maxime Ripard wrote:
> >Hi,
> >
> >On Thu, Jul 09, 2015 at 06:15:46PM +0800, Josh Wu wrote:
> >>As since sama5d3, to reset the chip, we don't need to shutdown the ddr
> >>controller.
> >>
> >>So add a new compatible string and new restart function for sama5d3 and
> >>later chips. As we don't use sama5d3 ddr controller, so remove it as
> >>well.
> >>
> >>Signed-off-by: Josh Wu <josh.wu@atmel.com>
> >>Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> >>---
> >>
> >>  drivers/power/reset/at91-reset.c | 30 +++++++++++++++++++++---------
> >>  1 file changed, 21 insertions(+), 9 deletions(-)
> >>
> >>diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at9=
1-reset.c
> >>index 36dc52f..8944b63 100644
> >>--- a/drivers/power/reset/at91-reset.c
> >>+++ b/drivers/power/reset/at91-reset.c
> >>@@ -123,6 +123,14 @@ static int at91sam9g45_restart(struct notifier_blo=
ck *this, unsigned long mode,
> >>  	return NOTIFY_DONE;
> >>  }
> >>+static int sama5d3_restart(struct notifier_block *this, unsigned long =
mode,
> >>+			void *cmd)
> >>+{
> >>+	writel(cpu_to_le32(AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCR=
ST),
> >>+				at91_rstc_base);
> >>+	return NOTIFY_DONE;
> >>+}
> >>+
> >>  static void __init at91_reset_status(struct platform_device *pdev)
> >>  {
> >>  	u32 reg =3D readl(at91_rstc_base + AT91_RSTC_SR);
> >>@@ -155,13 +163,13 @@ static void __init at91_reset_status(struct platf=
orm_device *pdev)
> >>  static const struct of_device_id at91_ramc_of_match[] =3D {
> >>  	{ .compatible =3D "atmel,at91sam9260-sdramc", },
> >>  	{ .compatible =3D "atmel,at91sam9g45-ddramc", },
> >>-	{ .compatible =3D "atmel,sama5d3-ddramc", },
> >>  	{ /* sentinel */ }
> >>  };
> >>  static const struct of_device_id at91_reset_of_match[] =3D {
> >>  	{ .compatible =3D "atmel,at91sam9260-rstc", .data =3D at91sam9260_re=
start },
> >>  	{ .compatible =3D "atmel,at91sam9g45-rstc", .data =3D at91sam9g45_re=
start },
> >>+	{ .compatible =3D "atmel,sama5d3-rstc", .data =3D sama5d3_restart },
> >>  	{ /* sentinel */ }
> >>  };
> >>@@ -181,17 +189,21 @@ static int at91_reset_of_probe(struct platform_de=
vice *pdev)
> >>  		return -ENODEV;
> >>  	}
> >>-	for_each_matching_node(np, at91_ramc_of_match) {
> >>-		at91_ramc_base[idx] =3D of_iomap(np, 0);
> >>-		if (!at91_ramc_base[idx]) {
> >>-			dev_err(&pdev->dev, "Could not map ram controller address\n");
> >>-			return -ENODEV;
> >>+	match =3D of_match_node(at91_reset_of_match, pdev->dev.of_node);
> >>+	at91_restart_nb.notifier_call =3D match->data;
> >>+
> >>+	if (match->data !=3D sama5d3_restart) {
> >Using of_device_is_compatible seems more appropriate.
> >
> >Also, why are you changing the order of this loop and the notifier
> >registration?
>=20
> I moved this order because I use the match->data to compare whether is
> sama5d3_restart. So I need to move this function (of_match_node) up.

Ah right, my bad.

Still, testing against the kernel pointer is not that great.

It would be great to use something explicit instead, like
of_device_is_compatible.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--WTO+dqXoBrlfXqg9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVn2wwAAoJEBx+YmzsjxAgo4MP/A6uX0Y6iYJFrmVsJUtiIncz
91OTJ0A/TVYi1qzg6VZmDQ1EwhU29rXqOajoXHYT/3SkewNzFEprhxZsbWCMitN5
nXzho5JcWWo/FSF1+RAIdk8Lo3NCbDp+k3bmo65A16eERwTKOhJ4Y9ouRALEDnM5
QR/sQMDSL13ajDoFgYOvA8dr4wZBuK+BbsHQQZea54WuCXic2e6XfJFIUluAtcM9
yHj9N9H5gHXSE8Owfl+A2pmmobDPe6nKP04ccTj4CHczVB86eD5jDLSGqMahNJ6m
+DH1cYMaDaq4jVRA3hEopU/JDSRYdGy4nbPd0krG8LDpd8i2gVoLkJnj0hAV9wlH
db6z/18IQ9kfL/ktitSSELmtSQlghkaCT1mxa8/EZxomQWG4rYtTs69zYFSS0H33
e+fBOdI/n5fDYRAQacvsNZSrKP4MhvfKMAq0ehZtBtE5q9JbAQfmLqV3lQdgKlPx
sZyl7lP8n7kUmJnnc1lMPMbi6BLUD7CsK4d3CZCj8rIAZNNBdDBoXV/B3OD916yC
K1YKrpR5mP2u3rpdu0Vw1JFro+JdsdwsJhkDrsX+oOPi8+Y3eCDTH9Im3+oSL4h3
LJ4XNZkclfN6WwYruIz8ASqEJqP9oojF8T1WqMFJ9f/Vx3J6SCe+3vdQO8qObWaB
3VwbiI0/WNozNLzvB0xa
=T7Uq
-----END PGP SIGNATURE-----

--WTO+dqXoBrlfXqg9--
