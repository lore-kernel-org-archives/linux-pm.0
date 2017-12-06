From: Meelis Roos <mroos@linux.ee>
Subject: Re: [PATCH] cpufreq: longhaul: Set transition_delay_us to 20 ms
Date: Wed, 6 Dec 2017 20:21:34 +0200 (EET)
Message-ID: <alpine.LRH.2.21.1712062020200.11844@math.ut.ee>
References: <alpine.LRH.2.21.1711241741080.10361@math.ut.ee> <ed89c17b60d7183144ab4ac4b125fbed373fe670.1511838689.git.viresh.kumar@linaro.org> <alpine.LRH.2.21.1712051017060.2774@math.ut.ee> <alpine.LRH.2.21.1712051054170.2774@math.ut.ee>
 <CAJZ5v0henViynygKTRqpYWr6mfm_LJALH6wurNhxM_AXLU4Kzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0henViynygKTRqpYWr6mfm_LJALH6wurNhxM_AXLU4Kzg@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, "4 . 14+" <stable@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> >> > diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
> >> > index c46a12df40dd..56eafcb07859 100644
> >> > --- a/drivers/cpufreq/longhaul.c
> >> > +++ b/drivers/cpufreq/longhaul.c
> >> > @@ -894,7 +894,7 @@ static int longhaul_cpu_init(struct cpufreq_policy *policy)
> >> >     if ((longhaul_version != TYPE_LONGHAUL_V1) && (scale_voltage != 0))
> >> >             longhaul_setup_voltagescaling();
> >> >
> >> > -   policy->cpuinfo.transition_latency = 200000;    /* nsec */
> >> > +   policy->transition_delay_us = 20000;    /* usec */
> >> >
> >> >     return cpufreq_table_validate_and_show(policy, longhaul_table);
> >> >  }
> >>
> >> This patch also works on my EPIA-M board - tested 10+ times.
> >
> > An on the last try just after sending the mail, it hung again in the
> > same way as before - so maybe 20 is on the edge of being good.
> 
> OK, so can you please try to modify the patch to set
> transition_delay_us to 30000, say, and see if that's reliable?

30000 was not reliable.

I created root cron job
@reboot sleep 120; /sbin/reboot

and by the evening it was dead again.

Will try 50000 tomorrow.

-- 
Meelis Roos (mroos@linux.ee
