From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] pcc-cpufreq driver update default value of cpuinfo_transition_latency
Date: Tue, 15 Dec 2015 00:57:23 +0100
Message-ID: <2921381.QHnJOSZSZC@vostro.rjw.lan>
References: <1447946941-14923-1-git-send-email-jtanenba@redhat.com> <20151120015820.GK3737@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50355 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932667AbbLNX1R (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2015 18:27:17 -0500
In-Reply-To: <20151120015820.GK3737@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Jacob Tanenbaum <jtanenba@redhat.com>
Cc: linux-pm@vger.kernel.org, corbet@lwn.net, prarit@redhat.com

On Friday, November 20, 2015 07:28:20 AM Viresh Kumar wrote:
> On 19-11-15, 10:29, Jacob Tanenbaum wrote:
> > The cpufreq documentation specifies
> > 
> > policy->cpuinfo.transition_latency   the time it takes on this CPU to
> >                                 switch between two frequencies in
> >                                 nanoseconds (if appropriate, else
> >                                 specify CPUFREQ_ETERNAL)
> > 
> > currently pcc-cpufreq does not expose the value and sets it to zero. I
> > changed the pcc-cpufreq driver and it's documentation to conform to the
> > default value specified in Documentation/cpu-freq/cpu-drivers.txt
> > 
> > Signed-off-by: Jacob Tanenbaum <jtanenba@redhat.com>
> > ---
> >  Documentation/cpu-freq/pcc-cpufreq.txt | 4 ++--
> >  drivers/cpufreq/pcc-cpufreq.c          | 2 ++
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/cpu-freq/pcc-cpufreq.txt b/Documentation/cpu-freq/pcc-cpufreq.txt
> > index 9e3c3b3..0a94224 100644
> > --- a/Documentation/cpu-freq/pcc-cpufreq.txt
> > +++ b/Documentation/cpu-freq/pcc-cpufreq.txt
> > @@ -159,8 +159,8 @@ to be strictly associated with a P-state.
> >  
> >  2.2 cpuinfo_transition_latency:
> >  -------------------------------
> > -The cpuinfo_transition_latency field is 0. The PCC specification does
> > -not include a field to expose this value currently.
> > +The cpuinfo_transition_latency field is CPUFREQ_ETERNAL. The PCC specification
> > +does not include a field to expose this value currently.
> >  
> >  2.3 cpuinfo_cur_freq:
> >  ---------------------
> > diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
> > index 2a0d589..808a320 100644
> > --- a/drivers/cpufreq/pcc-cpufreq.c
> > +++ b/drivers/cpufreq/pcc-cpufreq.c
> > @@ -555,6 +555,8 @@ static int pcc_cpufreq_cpu_init(struct cpufreq_policy *policy)
> >  	policy->min = policy->cpuinfo.min_freq =
> >  		ioread32(&pcch_hdr->minimum_frequency) * 1000;
> >  
> > +	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
> > +
> >  	pr_debug("init: policy->max is %d, policy->min is %d\n",
> >  		policy->max, policy->min);
> >  out:
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

Rafael

