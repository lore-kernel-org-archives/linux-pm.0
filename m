From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: Re: [PATCH] devfreq: do not ignore errors during store min, max
 frequency
Date: Thu, 27 Apr 2017 23:41:23 +0000
Message-ID: <20170427234123epcms1p42e47c19e54fbcc3e766ebd2594da6709@epcms1p4>
References: <f02c5605-be71-79da-a33d-75e2d041029b@arm.com>
        <1493281427-8671-1-git-send-email-lukasz.luba@arm.com>
        <20170427083057epcms1p5f916dda5e9fe0275a915963b96dc28d5@epcms1p5>
        <CGME20170427082416epcas3p3b9aeb23978707b164b4d4a46156d1216@epcms1p4>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:32151 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965022AbdD0Xl0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Apr 2017 19:41:26 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20170427234124epoutp0164e95f120a0c3914816fbddcd1008d7c~5ZZ7OVqZ12763527635epoutp01E
        for <linux-pm@vger.kernel.org>; Thu, 27 Apr 2017 23:41:24 +0000 (GMT)
In-Reply-To: <f02c5605-be71-79da-a33d-75e2d041029b@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Luba <lukasz.luba@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

> >
> > ...
> >
> >> +	ret = devfreq_get_freq_level(df, value);
> >> +	if (ret < 0) {
> >> +		dev_warn(dev, "Storing min freq failed with (%d) error\n", ret);
> >> +		goto unlock;
> >> +	}
> >> +
> >
> > This is not good.
> >
> > For a device that supports [ 100, 400, 800, 1000 ] MHz,
> > saying "min = 200 Mhz" or "max = 600 MHz" shouldn't be prohibited.
> >
> > Those functions are to express lower bound and upper bound, not to
> > designate the exact operating frequencies.
> 
> Would it be possible to convince you to store a
> 'posible/valid frequency' (from OPP) in that value?
> Governors (like simpleondemand) and drivers use it with the flags.
> It would be useful for thermal subsystem. It could have the max/min for 
> the devfreq device.
> 
> I could prepare a patch which sets the freq from OPP respecting
> rounding up/down based on 'devfreq_recommended_opp()'.
> 
> Regards,
> Lukasz

Before talking about implementation detail,
what's the benefit of what you are suggesting?

What's the scenario that you cannot do with the current system
while you can do with what you suggest?

Why do you need rounded (OPP-enabled) max/min values?
Why unrounded (lower/upper limits) max/min values cannot do what you want?


Cheers,
MyungJoo


ps. I'll be away from the network for about 10 days after few hours.
