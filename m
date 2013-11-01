From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: ondemand: Remove redundant return statement
Date: Fri, 01 Nov 2013 01:18 +0100
Message-ID: <7457887.jzoQrnelyS@vostro.rjw.lan>
References: <5272A118.1090908@semaphore.gr> <CAKohponQ+oRYpdYrpKV3=GMh6ACQr+E+WygLHk0mdC+ivjeP_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohponQ+oRYpdYrpKV3=GMh6ACQr+E+WygLHk0mdC+ivjeP_Q@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stratos Karafotis <stratosk@semaphore.gr>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Henrik Nilsson <Karl.Henrik.Nilsson@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Friday, November 01, 2013 12:09:16 AM Viresh Kumar wrote:
> On 31 October 2013 23:57, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> > After commit dfa5bb622555d9da0df21b50f46ebdeef390041b
> > "cpufreq: ondemand: Change the calculation of target frequency",
> > this return statement is no longer needed.
> >
> > Reported-by: Henrik Nilsson <Karl.Henrik.Nilsson@gmail.com>
> > Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> > ---
> >  drivers/cpufreq/cpufreq_ondemand.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> > index 32f26f6..18d4091 100644
> > --- a/drivers/cpufreq/cpufreq_ondemand.c
> > +++ b/drivers/cpufreq/cpufreq_ondemand.c
> > @@ -168,7 +168,6 @@ static void od_check_cpu(int cpu, unsigned int load)
> >                         dbs_info->rate_mult =
> >                                 od_tuners->sampling_down_factor;
> >                 dbs_freq_increase(policy, policy->max);
> > -               return;
> >         } else {
> >                 /* Calculate the next frequency proportional to load */
> >                 unsigned int freq_next;
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Queued up for 3.13, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
