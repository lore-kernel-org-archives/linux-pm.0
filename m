From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 5/7] cpufreq: governor: No need to manage state
 machine now
Date: Wed, 10 Feb 2016 11:06:37 +0530
Message-ID: <20160210053637.GP22111@vireshk>
References: <cover.1454988792.git.viresh.kumar@linaro.org>
 <9b7ac57013a525863d6c0c5e86419744d37879a4.1454988792.git.viresh.kumar@linaro.org>
 <CAJZ5v0gHk5L9vJ+BTnXdHAMzFZr7GX2RAD4gjSs+6L=NG3a0FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33189 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbcBJFgk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2016 00:36:40 -0500
Received: by mail-pa0-f52.google.com with SMTP id cy9so6274617pac.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Feb 2016 21:36:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gHk5L9vJ+BTnXdHAMzFZr7GX2RAD4gjSs+6L=NG3a0FQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 10-02-16, 01:36, Rafael J. Wysocki wrote:
> >  static int cpufreq_governor_stop(struct cpufreq_policy *policy)
> >  {
> > -       struct policy_dbs_info *policy_dbs = policy->governor_data;
> > -
> > -       /* State should be equivalent to START */
> > -       if (!policy_dbs->policy)
> > -               return -EBUSY;
> > -
> > -       gov_cancel_work(policy_dbs);
> > -       policy_dbs->policy = NULL;
> > +       gov_cancel_work(policy);
> >
> >         return 0;
> >  }
> 
> So maybe we can call gov_cancel_work(policy) from
> cpufreq_governor_dbs() directly and get rid of this wrapper too?

I thought about it, but left it for consistency. It wouldn't hurt, the
compiler will anyway make it inline I believe.

-- 
viresh
