From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v7 1/7] cpufreq: Add boost frequency support in core
Date: Mon, 26 Aug 2013 09:02:55 +0200
Message-ID: <20130826090255.01b1f299@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1376388505-30233-1-git-send-email-l.majewski@samsung.com>
 <1376388505-30233-2-git-send-email-l.majewski@samsung.com>
 <CAKohpo=m=smN-qk45dSdq8SOwAyqtE1xLV-Y85GaCbVhBDsmjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohpo=m=smN-qk45dSdq8SOwAyqtE1xLV-Y85GaCbVhBDsmjQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, "R, Durgadoss" <durgadoss.r@intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 26 Aug 2013 10:58:53 +0530 Viresh Kumar viresh.kumar@linaro.org
wrote,
> Some minor nitpicking, nothing much :)

Is there any chance to pull those corrected patches to v3.12?

> 
> On 13 August 2013 15:38, Lukasz Majewski <l.majewski@samsung.com>
> wrote:
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > +static int cpufreq_boost_set_sw(int state)
> > +{
> > +       struct cpufreq_frequency_table *freq_table;
> > +       struct cpufreq_policy *policy;
> > +       int ret = -EINVAL;
> > +
> > +       list_for_each_entry(policy, &cpufreq_policy_list,
> > policy_list) {
> > +               freq_table =
> > cpufreq_frequency_get_table(policy->cpu);
> > +               if (freq_table) {
> > +                       ret =
> > cpufreq_frequency_table_cpuinfo(policy,
> > +                                                       freq_table);
> > +                       if (!ret) {
> > +                               policy->user_policy.max =
> > policy->max;
> > +                               __cpufreq_governor(policy,
> > CPUFREQ_GOV_LIMITS);
> > +                       }
> 
> In case ret wasn't 0 (i.e. we failed), we should print an error
> message and break
> our loop ?

After your comments I think, that this code could be rewritten:


	list_for_each_entry(policy, &cpufreq_policy_list, policy_list) {
		freq_table = cpufreq_frequency_get_table(policy->cpu);
		if (freq_table) {
			ret = cpufreq_frequency_table_cpuinfo(policy,
							freq_table);
			if (ret) {
				pr_err("%s: Policy frequency update
				failed\n")
				break;
			}
			
			policy->user_policy.max = policy->max;
			__cpufreq_governor(policy,CPUFREQ_GOV_LIMITS);	
		}
	}

	return ret;
}


> 
> > +               }
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +int cpufreq_boost_trigger_state(int state)
> > +{
> > +       unsigned long flags;
> > +       int ret = 0;
> > +
> > +       if (cpufreq_driver->boost_enabled == state)
> > +               return 0;
> > +
> > +       write_lock_irqsave(&cpufreq_driver_lock, flags);
> > +       cpufreq_driver->boost_enabled = state;
> > +       write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> > +
> > +       ret = cpufreq_driver->set_boost(state);
> > +       if (ret) {
> > +               write_lock_irqsave(&cpufreq_driver_lock, flags);
> > +               cpufreq_driver->boost_enabled = !state;
> > +               write_unlock_irqrestore(&cpufreq_driver_lock,
> > flags); +
> > +               pr_err("%s: Cannot %s BOOST\n", __func__,
> > +                      state ? "enabled" : "disabled");
> 
> s/enabled/enable and s/disabled/disable

Ok.

> 
> > +       }
> > +
> > +       return ret;
> > +}
> > +



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
