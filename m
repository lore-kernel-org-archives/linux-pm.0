From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Fri, 19 Feb 2016 08:21:32 +0100
Message-ID: <20160219072132.GM3939@pengutronix.de>
References: <1448883753-19068-3-git-send-email-s.hauer@pengutronix.de>
 <20151217193332.GB7999@localhost.localdomain>
 <20160104141940.GI13058@pengutronix.de>
 <20160119072917.GA13237@pengutronix.de>
 <1454295246.22151.6.camel@mtksdaap41>
 <CAGS+omD9U8tKmb02d_gMMAGX18MJZhz0RrugpBK2EuqgZrBy6g@mail.gmail.com>
 <CAGS+omArr0_-ziBXWjEcKS0bqnruNzZc2aq2s3zkghUC7_HfGw@mail.gmail.com>
 <56C4A875.6080908@gmail.com>
 <20160218105603.GE3939@pengutronix.de>
 <20160218151552.GA1852@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33544 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752043AbcBSHVf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Feb 2016 02:21:35 -0500
Content-Disposition: inline
In-Reply-To: <20160218151552.GA1852@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Eddie Huang <eddie.huang@mediatek.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Feb 18, 2016 at 07:15:54AM -0800, Eduardo Valentin wrote:
> Folks,
> 
> > > I think the problem is, that Eduardo wants to see the hierachical thermal
> > > zones being used. But there is still a discussion ongoing [1].
> > 
> > It seems the original Author lost interest in the hierarchical thermal
> > zones. I am not convinced that we need hierarchical thermal zones for
> > the Mediatek driver since from the five sensors we only need the maximum
> > temperature (If this ever changes we could still rework it).
> > 
> > Given the current speed of communication I am not willing to add
> > another, possibly controversal, dependency to an otherwise simple
> > driver. I am even less willing when concerns like these come after *v12*
> > of this series.
> > 
> > Eduardo, it would really help to get a word from you.
> 
> Apologize for the long delays here. In fact I want the hierarchical
> support on this driver. But given that it is not really a strong
> dependency and the hierarchical support is still an ongoing development,
> I don't see why we should not merge this driver.
> 
> I also have had the chance to try it out in a board, and seams to work
> for me. I am adding to my tree.

Thanks for applying :)

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
