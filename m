From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 25/32] cpufreq: delete __cpuinit usage from all cpufreq
 files
Date: Mon, 24 Jun 2013 21:15:24 -0700
Message-ID: <1372133724.1245.38.camel@joe-AO722>
References: <1372102237-8757-1-git-send-email-paul.gortmaker@windriver.com>
	 <1372102237-8757-26-git-send-email-paul.gortmaker@windriver.com>
	 <CAKohponpsJBqbj_8u8MUiu7sCEpeg5bcztWJAZdn9uxL5taVZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohponpsJBqbj_8u8MUiu7sCEpeg5bcztWJAZdn9uxL5taVZQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2013-06-25 at 09:01 +0530, Viresh Kumar wrote:
> On 25 June 2013 01:00, Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
[]
> > -static int __cpuinit cpufreq_cpu_callback(struct notifier_block *nfb,
> > -                                       unsigned long action, void *hcpu)
> > +static int cpufreq_cpu_callback(struct notifier_block *nfb,
> > +                               unsigned long action, void *hcpu)
> 
> You were not required to change second line here and also don't
> change its indentation level. Check this everywhere.

Paul, yes, thanks for doing that here,
but please, do it everywhere...

;)

> > diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
[]
> > @@ -306,7 +306,7 @@ static int cpufreq_stat_notifier_policy(struct notifier_block *nb,
> >  }
> >
> >  static int cpufreq_stat_notifier_trans(struct notifier_block *nb,
> > -               unsigned long val, void *data)
> > +                                      unsigned long val, void *data)
> 
> See.. unnecessary change.

Or from another perspective, ideal change.

> > -static int __cpuinit cpufreq_stat_cpu_callback(struct notifier_block *nfb,
> > +static int cpufreq_stat_cpu_callback(struct notifier_block *nfb,
> >                                                unsigned long action,
> >                                                void *hcpu)

Hey Paul, you missed some too.

Viresh, there's no absolute "right" way to do this.


