From: Meelis Roos <mroos@linux.ee>
Subject: Re: [PATCH] cpufreq: longhaul: Set transition_delay_us to 20 ms
Date: Wed, 29 Nov 2017 08:59:27 +0200 (EET)
Message-ID: <alpine.LRH.2.21.1711290859010.803@math.ut.ee>
References: <alpine.LRH.2.21.1711241741080.10361@math.ut.ee> <ed89c17b60d7183144ab4ac4b125fbed373fe670.1511838689.git.viresh.kumar@linaro.org> <CAJZ5v0gTk_XpszbnvifxiaySMXomDSxpcr_yG2MPpLvX6L4CFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:48666 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752014AbdK2G7c (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Nov 2017 01:59:32 -0500
In-Reply-To: <CAJZ5v0gTk_XpszbnvifxiaySMXomDSxpcr_yG2MPpLvX6L4CFA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, "4 . 14+" <stable@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

> > diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
> > index c46a12df40dd..56eafcb07859 100644
> > --- a/drivers/cpufreq/longhaul.c
> > +++ b/drivers/cpufreq/longhaul.c
> > @@ -894,7 +894,7 @@ static int longhaul_cpu_init(struct cpufreq_policy *policy)
> >         if ((longhaul_version != TYPE_LONGHAUL_V1) && (scale_voltage != 0))
> >                 longhaul_setup_voltagescaling();
> >
> > -       policy->cpuinfo.transition_latency = 200000;    /* nsec */
> > +       policy->transition_delay_us = 20000;    /* usec */
> >
> >         return cpufreq_table_validate_and_show(policy, longhaul_table);
> >  }
> > --
> 
> Meelis, please check if this fixes the shutdown issue you have
> reported recently.

Yes, but not today - hopefully tomorrow.

-- 
Meelis Roos (mroos@linux.ee)
