From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 13/16] thermal: mvebu: Add support for Marvell Dove SoC
 family
Date: Thu, 21 Mar 2013 07:26:11 +0100
Message-ID: <20130321062611.GJ21478@lunn.ch>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1363818997-23137-14-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130321062307.GI21478@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:49830 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756089Ab3CUG0T (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 Mar 2013 02:26:19 -0400
Content-Disposition: inline
In-Reply-To: <20130321062307.GI21478@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Jason Cooper <jason@lakedaemon.net>, Florian Fainelli <florian@openwrt.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>

On Thu, Mar 21, 2013 at 07:23:07AM +0100, Andrew Lunn wrote:
> 
> 
> > -	priv->control = devm_request_and_ioremap(&pdev->dev, res);
> > -	if (!priv->control) {
> > -		dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
> > -		return -EADDRNOTAVAIL;
> > -	}
> 
> 
> Hi Ezequiel
> 
> I've not looked too hard, but i don't see the equivalent of the above
> in your new probe function.

Upps, Sorry, found it. Does exists.
