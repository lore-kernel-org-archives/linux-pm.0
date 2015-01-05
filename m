From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 05/14] cpufreq: stats: get rid of per-cpu cpufreq_stats_table
Date: Tue, 06 Jan 2015 00:38:33 +0100
Message-ID: <4032433.AHjvo9fo3u@vostro.rjw.lan>
References: <cover.1420177186.git.viresh.kumar@linaro.org> <2035066.1nOVW1Pe1d@vostro.rjw.lan> <CAKohponaosUYjBXp9YVdKkmZLpKKTeOfPnqJD1vMqazR_TTAfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61786 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753885AbbAEXQR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jan 2015 18:16:17 -0500
In-Reply-To: <CAKohponaosUYjBXp9YVdKkmZLpKKTeOfPnqJD1vMqazR_TTAfQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>

On Monday, January 05, 2015 09:53:45 AM Viresh Kumar wrote:
> On 4 January 2015 at 03:50, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> 
> All comments accepted before this ..
> 
> >> @@ -293,15 +281,19 @@ static int cpufreq_stat_notifier_trans(struct notifier_block *nb,
> >>               unsigned long val, void *data)
> >>  {
> >>       struct cpufreq_freqs *freq = data;
> >> +     struct cpufreq_policy *policy = cpufreq_cpu_get(freq->cpu);
> >>       struct cpufreq_stats *stat;
> >>       int old_index, new_index;
> >>
> >>       if (val != CPUFREQ_POSTCHANGE)
> >>               return 0;
> >>
> >> -     stat = per_cpu(cpufreq_stats_table, freq->cpu);
> >> -     if (!stat)
> >> -             return 0;
> >> +     if (!policy) {
> >> +             pr_err("%s: No policy found\n", __func__);
> >
> > Do we need the extra message here?  If so, can it be pr_debug()?
> 
> Because we are in the POSTCHANGE stage right now, the policy
> isn't allowed to be NULL. And so this is an error and I used pr_err.
> 
> >> +             return -ENODEV;
> >> +     }
> >
> > This changes the behavior in a subtle way.  Instead of returning 0 when stats
> > are not present, we'll now return an error code for a missing policy.  Are you
> > sure that this isn't going to break anything?
> 
> Something I didn't looked at earlier. This *can* break things a bit.
> If I understand it clearly now, the notifiers aren't allowed to return these
> errors. They should return:
> 
> NOTIFY_DONE or NOTIFY_OK or NOTIFY_BAD
> 
> And this is what the notifier chain does to the return value:
> 
>     if ((ret & NOTIFY_STOP_MASK) == NOTIFY_STOP_MASK)
>             break;
> 
> So, if the return error has its 15th bit set, then we will break the loop.
> (NOTIFY_STOP_MASK 0x8000).
> 
> It wouldn't happen in this case, but probably we should just return
> NOTIFY_DONE (0)..
> 
> Right ?

Looks correct to me.

> >> +
> >> +     stat = policy->stats_data;
> >
> > Is stat guaraneed to be a valid pointer at this point?
> 
> We better check it as well for some corner cases where we failed
> to create a table.

Exactly. :-)


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
