From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v3 1/3] PM / devfreq: cache the last call to
 get_dev_status()
Date: Mon, 3 Aug 2015 16:24:28 +0100
Message-ID: <20150803152428.GC2714@e104805>
References: <453349609.343761438579853672.JavaMail.weblogic@epmlwas06d>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:28798 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754065AbbHCPYe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2015 11:24:34 -0400
Content-Disposition: inline
In-Reply-To: <453349609.343761438579853672.JavaMail.weblogic@epmlwas06d>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, =?utf-8?B?7LWc7LCs7Jqw?= <cw00.choi@samsung.com>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>

On Mon, Aug 03, 2015 at 06:30:53AM +0100, MyungJoo Ham wrote:
> > The return value of get_dev_status() can be reused.  Cache it so that
> > other parts of the kernel can reuse it instead of having to call the
> > same function again.
> > 
> > Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > Signed-off-by: Javi Merino <javi.merino@arm.com>
> 
> Your patch introduces build errors if you try to compile governors as
> modules. Please fix it.

Ok, with your suggestion to make devfreq_update_stats() a static
inline function this will be solved.  Sorry for that.

> And..
> > +int devfreq_update_stats(struct devfreq *df)
> > +{
> > +	return df->profile->get_dev_status(df->dev.parent, &df->last_status);
> > +}
> This seems a good candidate for a macro or a static inline function.

I'll turn it into a static inline function in <linux/devfreq.h>

> Modifications in governor_simpleondemand.c looks good.

Ok, so you are happy with this only working for that governor?

> Please add some explanations at the definition of devfreq_update_stats()
> as well in devfreq.c

I'll add kerneldoc for it.  Cheers,
Javi
