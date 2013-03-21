From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 06/16] thermal: mvebu: Convert to devm_ioremap_resource()
Date: Thu, 21 Mar 2013 17:21:33 -0300
Message-ID: <20130321202131.GA3358@localhost>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1363818997-23137-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130321191751.GP4977@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:56255 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589Ab3CUUVl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Mar 2013 16:21:41 -0400
Content-Disposition: inline
In-Reply-To: <20130321191751.GP4977@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-pm@vger.kernel.org, Lior Amsalem <alior@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, Florian Fainelli <florian@openwrt.org>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Thu, Mar 21, 2013 at 07:17:51PM +0000, Russell King - ARM Linux wrot=
e:
> On Wed, Mar 20, 2013 at 07:36:27PM -0300, Ezequiel Garcia wrote:
> > Convert devm_request_and_ioremap() to the newly introduced
> > devm_ioremap_resource() which provides more consistent error handli=
ng.
> >=20
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  drivers/thermal/mvebu_thermal.c |    6 ++----
> >  1 files changed, 2 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mveb=
u_thermal.c
> > index ef04e4e..089b43d 100644
> > --- a/drivers/thermal/mvebu_thermal.c
> > +++ b/drivers/thermal/mvebu_thermal.c
> > @@ -86,11 +86,9 @@ static int mvebu_thermal_probe(struct platform_d=
evice *pdev)
> >  	if (!priv)
> >  		return -ENOMEM;
> > =20
> > -	priv->sensor =3D devm_request_and_ioremap(&pdev->dev, res);
> > -	if (!priv->sensor) {
> > -		dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
> > +	priv->sensor =3D devm_ioremap_resource(&pdev->dev, res);
> > +	if (!priv->sensor)
> >  		return -EADDRNOTAVAIL;
>=20
> NAK.  It pays to understand the interface that you're using.  In this
> case, it *doesn't* return NULL on error, so you'll never reach
> -EADDRNOTAVAIL.  Please look this function up in lib/devres.c and
> understand its API.
>=20

Yes, you're right, I'll fix this on v2.

Thanks,
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
