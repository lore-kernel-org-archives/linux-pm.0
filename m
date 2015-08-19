From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] thermal: cpu_cooling: Remove usage of devm functions
Date: Wed, 19 Aug 2015 17:32:09 +0530
Message-ID: <20150819120209.GC14544@linux>
References: <20150819062219.GA10032@localhost>
 <CAOh2x==kSnXWZMhrEcRyiVc-5iixecQki5-7ZC-ajes-D48-sA@mail.gmail.com>
 <CAK-LDbKdORz5-3oBd7p4BcU+t3w9=u=aQv6LKQthiZPL-qi9bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34708 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbbHSMCO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2015 08:02:14 -0400
Received: by paccq16 with SMTP id cq16so1913341pac.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2015 05:02:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAK-LDbKdORz5-3oBd7p4BcU+t3w9=u=aQv6LKQthiZPL-qi9bQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 19-08-15, 17:27, Vaishali Thakkar wrote:
> > I will rather ask you to do this:
> >
> > diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> > index 620dcd405ff6..a04055ea5d94 100644
> > --- a/drivers/thermal/cpu_cooling.c
> > +++ b/drivers/thermal/cpu_cooling.c
> > @@ -584,8 +584,8 @@ static int cpufreq_get_requested_power(struct
> > thermal_cooling_device *cdev,
> >         if (trace_thermal_power_cpu_get_power_enabled()) {
> >                 u32 ncpus = cpumask_weight(&cpufreq_device->allowed_cpus);
> >
> > -               load_cpu = devm_kcalloc(&cdev->device, ncpus, sizeof(*load_cpu),
> > -                                       GFP_KERNEL);
> > +               load_cpu = kcalloc(&cdev->device, ncpus, sizeof(*load_cpu),
> > +                                  GFP_KERNEL);
> >         }
> 
> Sorry. I forgot to ask you one more thing. devm_kcalloc takes one more
> argument then
> kcalloc. So, the change I did is correct I guess.

Right, there is an extra argument in my code.

-- 
viresh
