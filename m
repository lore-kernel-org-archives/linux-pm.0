From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 06/16] thermal: mvebu: Convert to devm_ioremap_resource()
Date: Thu, 21 Mar 2013 12:17:37 -0300
Message-ID: <20130321151736.GB24246@localhost>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1363818997-23137-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <514B138A.7060203@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:53862 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656Ab3CUPRq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Mar 2013 11:17:46 -0400
Content-Disposition: inline
In-Reply-To: <514B138A.7060203@cogentembedded.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-pm@vger.kernel.org, Lior Amsalem <alior@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, Florian Fainelli <florian@openwrt.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Hi Sergei,

On Thu, Mar 21, 2013 at 06:04:58PM +0400, Sergei Shtylyov wrote:
> On 21-03-2013 2:36, Ezequiel Garcia wrote:
>=20
> > Convert devm_request_and_ioremap() to the newly introduced
> > devm_ioremap_resource() which provides more consistent error handli=
ng.
>=20
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >   drivers/thermal/mvebu_thermal.c |    6 ++----
> >   1 files changed, 2 insertions(+), 4 deletions(-)
>=20
> > diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mveb=
u_thermal.c
> > index ef04e4e..089b43d 100644
> > --- a/drivers/thermal/mvebu_thermal.c
> > +++ b/drivers/thermal/mvebu_thermal.c
> > @@ -86,11 +86,9 @@ static int mvebu_thermal_probe(struct platform_d=
evice *pdev)
> >   	if (!priv)
> >   		return -ENOMEM;
> >
> > -	priv->sensor =3D devm_request_and_ioremap(&pdev->dev, res);
> > -	if (!priv->sensor) {
> > -		dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
> > +	priv->sensor =3D devm_ioremap_resource(&pdev->dev, res);
> > +	if (!priv->sensor)
>=20
>     devm_ioremap_resource() returns error code, not NULL.
>=20

Yes, you're right. Andrew has already pointed this out
and I'll fix it in the next round.

Thanks for the review!
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
