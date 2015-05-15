From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] cpufreq: arm_big_little: check if the frequency is set correctly
Date: Fri, 15 May 2015 02:20:36 +0200
Message-ID: <1778706.Xlqg2QcRzz@vostro.rjw.lan>
References: <1430128266-15012-1-git-send-email-sudeep.holla@arm.com> <CAKohpomtkPCwHN1ivTSLOg9xj8nKGua=m8LerRG_djMfOr1DiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54921 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1423067AbbENXzX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2015 19:55:23 -0400
In-Reply-To: <CAKohpomtkPCwHN1ivTSLOg9xj8nKGua=m8LerRG_djMfOr1DiA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Monday, April 27, 2015 03:56:18 PM Viresh Kumar wrote:
> On 27 April 2015 at 15:21, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > The actual frequency is set through "clk_change_rate" which is void
> > function. If the underlying hardware fails and returns error, the error
> > is lost in the clk layer. In order to track such failures, we need to
> > read back the frequency(just the cached value as clk_recalc called after
> > clk->ops->set_rate gets the frequency)
> >
> > This patch adds check to see if the frequency is set correctly or if
> > they were any hardware failures and sends the appropriate errors to the
> > cpufreq core.
> >
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Reviewed-by: Michael Turquette <mike.turquette@linaro.org>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/cpufreq/arm_big_little.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
> > index e1a6ba66a7f5..f65e19f340d0 100644
> > --- a/drivers/cpufreq/arm_big_little.c
> > +++ b/drivers/cpufreq/arm_big_little.c
> > @@ -186,6 +186,15 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
> >                 mutex_unlock(&cluster_lock[old_cluster]);
> >         }
> >
> > +       /*
> > +        * FIXME: clk_set_rate has to handle the case where clk_change_rate
> > +        * can fail due to hardware or firmware issues. Until the clk core
> > +        * layer is fixed, we can check here. In most of the cases we will
> > +        * be reading only the cached value anyway. This needs to  be removed
> > +        * once clk core is fixed.
> > +        */
> > +       if (bL_cpufreq_get_rate(cpu) != new_rate)
> > +               return -EIO;
> >         return 0;
> >  }
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Both queued up for 4.2, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
