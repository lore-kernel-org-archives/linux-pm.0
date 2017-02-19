From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: mt8173: minor mtk_thermal.c cleanups
Date: Sat, 18 Feb 2017 17:23:07 -0800
Message-ID: <20170219012306.GA28525@localhost.localdomain>
References: <1486531862-31945-1-git-send-email-dawei.chien@mediatek.com>
 <ebdf54af-6290-9654-c475-53dd580582a0@gmail.com>
 <1486976518.24087.7.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35371 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbdBSBXM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Feb 2017 20:23:12 -0500
Content-Disposition: inline
In-Reply-To: <1486976518.24087.7.camel@mtksdaap41>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dawei Chien <dawei.chien@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@armlinux.org.uk>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Fan Chen <fan.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Erin Lo <erin.lo@mediatek.com>

On Mon, Feb 13, 2017 at 05:01:58PM +0800, Dawei Chien wrote:
> Hi, Matthias,
> 
> On Thu, 2017-02-09 at 22:25 +0100, Matthias Brugger wrote:
> > 
> > On 02/08/2017 06:31 AM, Dawei Chien wrote:
> > > Thermal driver should read TEMP_MSR3 if thermal bank with 4 sensors.
> > > However, Currently thermal driver don't need read TEMP_MSR3 since
> > > thermal controller only use 3 sensors for each thermal bank.
> > >
> > > Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> > > ---
> > 
> > Actually the commit message should state:
> > Fixes: b7cf0053738c ("thermal: Add Mediatek thermal driver for mt2701.")
> > 
> > ...and get backported to v4.9 and v4.10.
> > 
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > 
> > Regards,
> > Matthias
> 
> Thank you for your review. I would add below commit message on next
> version. However, currently 8173 thermal driver would not read TEMP_MSR3
> since thermal driver only use 3 sensors on each bank, this patch would
> not effect temperature.
> Only if thermal driver use 4 sensors on any thermal bank, would read
> third sensor two times, and lose fourth sensor of vale.
> Fixes: b7cf0053738c ("thermal: Add Mediatek thermal driver for mt2701.")
> 

Please send a new version with the tag in the commit message.
