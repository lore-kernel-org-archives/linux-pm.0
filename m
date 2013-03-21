From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 06/16] thermal: mvebu: Convert to devm_ioremap_resource()
Date: Thu, 21 Mar 2013 06:43:26 -0300
Message-ID: <20130321094325.GB2469@localhost>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1363818997-23137-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130321061024.GH21478@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:52145 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756228Ab3CUJnf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Mar 2013 05:43:35 -0400
Content-Disposition: inline
In-Reply-To: <20130321061024.GH21478@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Jason Cooper <jason@lakedaemon.net>, Florian Fainelli <florian@openwrt.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>

On Thu, Mar 21, 2013 at 07:10:24AM +0100, Andrew Lunn wrote:
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
> > -	}
>=20
>=20
> It would be better to return priv->sensor, not a fixed error code.
>=20

Good catch! I missed that.

Thanks,
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
