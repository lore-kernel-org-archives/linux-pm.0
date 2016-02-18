From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Thu, 18 Feb 2016 14:28:34 +0000
Message-ID: <20160218142833.GB2943@e104805>
References: <1448883753-19068-1-git-send-email-s.hauer@pengutronix.de>
 <1448883753-19068-3-git-send-email-s.hauer@pengutronix.de>
 <20151217193332.GB7999@localhost.localdomain>
 <20160104141940.GI13058@pengutronix.de>
 <20160119072917.GA13237@pengutronix.de>
 <1454295246.22151.6.camel@mtksdaap41>
 <CAGS+omD9U8tKmb02d_gMMAGX18MJZhz0RrugpBK2EuqgZrBy6g@mail.gmail.com>
 <CAGS+omArr0_-ziBXWjEcKS0bqnruNzZc2aq2s3zkghUC7_HfGw@mail.gmail.com>
 <56C4A875.6080908@gmail.com>
 <20160218105603.GE3939@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39557 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425404AbcBRO2i (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 18 Feb 2016 09:28:38 -0500
Content-Disposition: inline
In-Reply-To: <20160218105603.GE3939@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Daniel Kurtz <djkurtz@chromium.org>, Eduardo Valentin <edubezval@gmail.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eddie Huang <eddie.huang@mediatek.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Sascha,

On Thu, Feb 18, 2016 at 11:56:03AM +0100, Sascha Hauer wrote:
> On Wed, Feb 17, 2016 at 06:05:57PM +0100, Matthias Brugger wrote:
> > On 15/02/16 03:14, Daniel Kurtz wrote:
> > >On Mon, Feb 15, 2016 at 10:11 AM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> > >>Hi Eduardo, Sascha,
> > >>
> > >>>>Any input on this? I really like to get this driver upstream as it is
> > >>>>currently blocking other Mediatek drivers.
> > >>>>
> > >>>
> > >>>Hi Eduardo,
> > >>>
> > >>>Do you have any comment about Sascha's response ? We really hope get
> > >>>your comment since Mediatek thermal driver already reviewed in public
> > >>>over half years, and we have other patches [0] [1] depend on thermal
> > >>>driver.
> > >>>
> > >>>[0]:
> > >>>http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/394084.html
> > >>>[1]:
> > >>>http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/401055.html
> > >>
> > >>Friendly ping on the Mediatek thermal driver.
> > >>The "EFUSE" dependency has now landed in v4.5-rc4.
> > >
> > >Actually, it landed in char-misc-next, not v4.5-rc4.
> > >
> > >>So, AFAICT, the only thing left that may be blocking landing Mediatek
> > >>thermal driver is resolution of this discussion about thermal zones.
> > >>Can we kindly resolve this soon so we have a chance to land it in v4.6.
> > >>
> > 
> > 
> > I think the problem is, that Eduardo wants to see the hierachical thermal
> > zones being used. But there is still a discussion ongoing [1].
> 
> It seems the original Author lost interest in the hierarchical thermal
> zones. I am not convinced that we need hierarchical thermal zones for
> the Mediatek driver since from the five sensors we only need the maximum
> temperature (If this ever changes we could still rework it).

I guess that "the original Author" refers to me.  I haven't lost
interest in the hierarchical thermal zones, I just don't have time to
work on it currently.  I'd like to address your review at some point
in the future and continue working on it.
 
> Given the current speed of communication I am not willing to add
> another, possibly controversal, dependency to an otherwise simple
> driver. I am even less willing when concerns like these come after *v12*
> of this series.

I agree.  I don't think we should make this driver depend on the
hierarchical thermal zones series.  When hierarchical thermal zones
get merged we can consider to change the driver to use them but
there's no point in waiting for that to happen.

Cheers,
Javi


