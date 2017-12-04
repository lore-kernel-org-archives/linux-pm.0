From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: longhaul: Set transition_delay_us to 20 ms
Date: Mon, 04 Dec 2017 16:03:41 +0100
Message-ID: <1936974.loJEzqH07r@aspire.rjw.lan>
References: <alpine.LRH.2.21.1711241741080.10361@math.ut.ee> <CAJZ5v0gTk_XpszbnvifxiaySMXomDSxpcr_yG2MPpLvX6L4CFA@mail.gmail.com> <alpine.LRH.2.21.1711290859010.803@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <alpine.LRH.2.21.1711290859010.803@math.ut.ee>
Sender: stable-owner@vger.kernel.org
To: Meelis Roos <mroos@linux.ee>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, "4 . 14+" <stable@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, November 29, 2017 7:59:27 AM CET Meelis Roos wrote:
> > > diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
> > > index c46a12df40dd..56eafcb07859 100644
> > > --- a/drivers/cpufreq/longhaul.c
> > > +++ b/drivers/cpufreq/longhaul.c
> > > @@ -894,7 +894,7 @@ static int longhaul_cpu_init(struct cpufreq_policy *policy)
> > >         if ((longhaul_version != TYPE_LONGHAUL_V1) && (scale_voltage != 0))
> > >                 longhaul_setup_voltagescaling();
> > >
> > > -       policy->cpuinfo.transition_latency = 200000;    /* nsec */
> > > +       policy->transition_delay_us = 20000;    /* usec */
> > >
> > >         return cpufreq_table_validate_and_show(policy, longhaul_table);
> > >  }
> > > --
> > 
> > Meelis, please check if this fixes the shutdown issue you have
> > reported recently.
> 
> Yes, but not today - hopefully tomorrow.

Any news?

I'd like to push the fix for 4.15 shortly if it works for you (I don't
see why it wouldn't work, but still I'd prefer it to be actually tested).

Thanks,
Rafael
