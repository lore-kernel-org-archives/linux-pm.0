From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v6 1/8] cpufreq: Store cpufreq policies in a list
Date: Fri, 26 Jul 2013 14:46:12 +0200
Message-ID: <20130726144612.5939419c@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1374770011-22171-1-git-send-email-l.majewski@samsung.com>
 <1374770011-22171-2-git-send-email-l.majewski@samsung.com>
 <CAKohpoktwZUvs2ap7wk1tudVsiKjbhFkoM5=+AaFZP=+73fEyg@mail.gmail.com>
 <20130726125827.72f9ef18@amdc308.digital.local>
 <CAKohpokqHsHZP0AkPBbmGP=ekLPQrnLCc5j6BsfM6KY01uzG1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohpokqHsHZP0AkPBbmGP=ekLPQrnLCc5j6BsfM6KY01uzG1w@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, durgadoss.r@intel.com
List-Id: linux-pm@vger.kernel.org

On Fri, 26 Jul 2013 16:32:34 +0530 Viresh Kumar viresh.kumar@linaro.org
wrote,
> On 26 July 2013 16:28, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > On Fri, 26 Jul 2013 15:44:29 +0530 Viresh Kumar
> > viresh.kumar@linaro.org wrote,
> >> On 25 July 2013 22:03, Lukasz Majewski <l.majewski@samsung.com>
> >> wrote:
> 
> >> Looks good but would have been better if you could have moved
> >> existing code to use this infrastructure..
> >>
> >> For example, this code in __cpufreq_add_dev()
> >>
> >> #ifdef CONFIG_HOTPLUG_CPU
> >>       /* Check if this cpu was hot-unplugged earlier and has
> >> siblings */ read_lock_irqsave(&cpufreq_driver_lock, flags);
> >>       for_each_online_cpu(sibling) {
> >>
> >>          ---
> >>
> >>       }
> >>       read_unlock_irqrestore(&cpufreq_driver_lock, flags);
> >> #endif
> >
> > Do you mean to write something like:
> >
> > #ifdef CONFIG_CPU_FREQ_BOOST_SW
> >         write_lock_irqsave(&cpufreq_driver_lock, flags);
> >         list_add(&policy->policy_list, &cpufreq_policy_list);
> >         write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> > #endif
> >
> > Or Am I missing something?
> 
> I can't imaging how you though I am saying this :)
>

:-)
 
> The code I mentioned actually requires to iterate through the
> list of available policies but was iterating over all online cpus..
> 
> And so your new infrastructure or this list can be used instead
> of looping for all cpus.

So instead of reading policies from per_cpu variables for all online
cpus, you think of using the list explicitly.

Good idea, but can we first finish the boost patches? Such change can
be applied on top of boost patch series as well.

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
