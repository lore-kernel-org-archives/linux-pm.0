From: Eddie Huang <eddie.huang@mediatek.com>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Mon, 1 Feb 2016 10:54:06 +0800
Message-ID: <1454295246.22151.6.camel@mtksdaap41>
References: <1448883753-19068-1-git-send-email-s.hauer@pengutronix.de>
	 <1448883753-19068-3-git-send-email-s.hauer@pengutronix.de>
	 <20151217193332.GB7999@localhost.localdomain>
	 <20160104141940.GI13058@pengutronix.de>
	 <20160119072917.GA13237@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:42971 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752338AbcBACyL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 31 Jan 2016 21:54:11 -0500
In-Reply-To: <20160119072917.GA13237@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, Zhang Rui <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, 2016-01-19 at 15:29 +0800, Sascha Hauer wrote:
> Eduardo,
> 
> On Mon, Jan 04, 2016 at 03:19:40PM +0100, Sascha Hauer wrote:
> > Hi Eduardo,
> > 
> > > 
> > > That should remove the policy of computing the maximum from this driver.
> > > Please have a look on the work being done [1] to add grouping and
> > > aggregation of thermal zones. With that in place, you should be a matter
> > > of configuring the grouping and selecting max as the aggregation function,
> > > from the thermal core, instead in the driver. Which should give the
> > > system engineer, more flexibility to compose whatever policy based on
> > > the exposed sensors.
> > 
> > I think the aggregation of thermal zones is quite useful when it comes
> > to putting different chips together to a system. I am not so sure how
> > useful it is to expose different thermal zones of a single SoC to the
> > device tree.
> > Currently the only control knob we have is the CPU frequency. When any
> > of the sensors on the SoC gets too hot then the only thing we can do is
> > to decrease the CPU frequency. This does not leave much space for
> > configuration in the device tree.
> > What I need to be able is to attach multiple sensors to one thermal
> > zone. The aggregation patch series only partly solves that and I think
> > is inconsistent, but I commented on the series directly.
> 
> Any input on this? I really like to get this driver upstream as it is
> currently blocking other Mediatek drivers.
> 

Hi Eduardo,

Do you have any comment about Sascha's response ? We really hope get
your comment since Mediatek thermal driver already reviewed in public
over half years, and we have other patches [0] [1] depend on thermal
driver.

[0]:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/394084.html
[1]:
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/401055.html

Regards,
Eddie






