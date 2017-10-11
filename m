From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: FW: RE: [PATCH v3 1/8] PM / devfreq: Set min/max_freq when adding
 the devfreq device
Date: Wed, 11 Oct 2017 11:22:18 +0000
Message-ID: <20171011112218epcms1p44a92995d11f8bed42199eab623b4a2d1@epcms1p4>
References: <20171011110952epcms1p2f1c04c3cc0b078c07b55e7031cd175ac@epcms1p2>
        <1507691364-3899-2-git-send-email-cw00.choi@samsung.com>
        <1507691364-3899-1-git-send-email-cw00.choi@samsung.com>
        <CGME20171011030946epcas1p156d133af4c065453eb8afde9e0e6869d@epcms1p4>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:23578 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756515AbdJKLWV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2017 07:22:21 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20171011112219epoutp04af96d5cedc4bdb0d322cc22df1638e70~sgDTNdUcF2824228242epoutp04Z
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2017 11:22:19 +0000 (GMT)
In-Reply-To: <20171011110952epcms1p2f1c04c3cc0b078c07b55e7031cd175ac@epcms1p2>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "chanwoo@kernel.org" <chanwoo@kernel.org>, Inki Dae <inki.dae@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

> > Prior to that, the min/max_freq of the devfreq device are always zero
> > before the user changes the min/max_freq through sysfs entries.
> > It might make the confusion for the min/max_freq.
> > 
> > This patch initializes the available min/max_freq by using the OPP
> > during adding the devfreq device.
> > 
> > Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> > ---
> >  drivers/devfreq/devfreq.c | 43 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> > 
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index a1c4ee818614..ae8717a6eee1 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index a1c4ee818614..ae8717a6eee1 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -69,6 +69,34 @@ static struct devfreq *find_device_devfreq(struct device *dev)
> >  	return ERR_PTR(-ENODEV);
> >  }
> >  
> > +static unsigned long find_available_min_freq(struct devfreq *devfreq)
> > +{
> > +	struct dev_pm_opp *opp;
> > +	unsigned long min_freq = 0;
> > +
> > +	opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &min_freq);
> 
> When min_freq is 0, dev_pm_opp_find_freq_ceil will return ERR_PTR(-EINVAL);
> 
> --- from drivers/base/power/opp/core.c ------ 
> struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
>                                              unsigned long *freq)
> {
>         struct opp_table *opp_table;
>         struct dev_pm_opp *opp;
> 
>         if (!dev || !freq) {
>                 dev_err(dev, "%s: Invalid argument freq=%p\n", __func__, freq);
>                 return ERR_PTR(-EINVAL);
>         }
> ---------------------------------------------

Sorry, please never mind. My Bad. Your code had no such issues.

So, I'm adding:
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

> 
> Cheers,
> MyungJoo
> 
