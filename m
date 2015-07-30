From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH 3/4] power: Add Qualcomm SMBB driver
Date: Thu, 30 Jul 2015 10:17:05 -0700
Message-ID: <20150730171705.GF6519@usrtlx11787.corpusers.net>
References: <1434662025-9485-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1434662025-9485-4-git-send-email-bjorn.andersson@sonymobile.com>
 <20150725154159.GA17373@earth>
 <20150726010414.GK4753@usrtlx11787.corpusers.net>
 <20150727140622.GB12993@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([37.139.156.2]:7201 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754460AbbG3RRL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2015 13:17:11 -0400
Content-Disposition: inline
In-Reply-To: <20150727140622.GB12993@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "Cavin, Courtney" <Courtney.Cavin@sonymobile.com>

On Mon 27 Jul 07:06 PDT 2015, Sebastian Reichel wrote:

> Hi,
> 
> On Sat, Jul 25, 2015 at 06:04:14PM -0700, Bjorn Andersson wrote:
> > On Sat 25 Jul 08:42 PDT 2015, Sebastian Reichel wrote:
> > >  * battery-charge-control-limit
> > > 
> > > It's unclear, what this property is used for. Is the limit only
> > > for "normal" charging or also for fast charging?
> > > 
> > 
> > This is described as the current limit during fast charging. However,
> > "fast charging" is the normal state.
> > 
> > I think the most consistent (regards documentation and other properties)
> > would be:
> > 
> >  qcom,fast-charge-current-limit

I spoke with Courtney about this and he pointed out that it really is
the limit of the current flowing into the battery, hence his original
naming.

> 
> So what's the difference to "fast-charge-safe-current"?
> 

The "safe" values are write-once values that should be set once during
boot to protect the hardware. The fast-charge-current-limit can be
modified in runtime by e.g. userspace or a thermal mitigation solution -
but will never be allowed to go above the safe limit.

Regards,
Bjorn
