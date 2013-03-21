From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 06/16] thermal: mvebu: Convert to devm_ioremap_resource()
Date: Thu, 21 Mar 2013 11:08:52 +0100
Message-ID: <20130321100852.GA5627@lunn.ch>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1363818997-23137-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130321061024.GH21478@lunn.ch>
 <20130321094325.GB2469@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:50046 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753140Ab3CUKJM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 Mar 2013 06:09:12 -0400
Content-Disposition: inline
In-Reply-To: <20130321094325.GB2469@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Jason Cooper <jason@lakedaemon.net>, Florian Fainelli <florian@openwrt.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>

On Thu, Mar 21, 2013 at 06:43:26AM -0300, Ezequiel Garcia wrote:
> On Thu, Mar 21, 2013 at 07:10:24AM +0100, Andrew Lunn wrote:
> > On Wed, Mar 20, 2013 at 07:36:27PM -0300, Ezequiel Garcia wrote:
> > > Convert devm_request_and_ioremap() to the newly introduced
> > > devm_ioremap_resource() which provides more consistent error handling.
> > > 
> > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > ---
> > >  drivers/thermal/mvebu_thermal.c |    6 ++----
> > >  1 files changed, 2 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
> > > index ef04e4e..089b43d 100644
> > > --- a/drivers/thermal/mvebu_thermal.c
> > > +++ b/drivers/thermal/mvebu_thermal.c
> > > @@ -86,11 +86,9 @@ static int mvebu_thermal_probe(struct platform_device *pdev)
> > >  	if (!priv)
> > >  		return -ENOMEM;
> > >  
> > > -	priv->sensor = devm_request_and_ioremap(&pdev->dev, res);
> > > -	if (!priv->sensor) {
> > > -		dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
> > > +	priv->sensor = devm_ioremap_resource(&pdev->dev, res);
> > > +	if (!priv->sensor)
> > >  		return -EADDRNOTAVAIL;
> > > -	}
> > 
> > 
> > It would be better to return priv->sensor, not a fixed error code.
> > 
> 
> Good catch! I missed that.

And the same where the priv->control is introduced.

    Andrew
