From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v4 2/7] cpufreq: Add boost frequency support in core
Date: Fri, 28 Jun 2013 08:49:39 +0200
Message-ID: <20130628084939.1921a717@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-3-git-send-email-l.majewski@samsung.com>
 <CAKohpon7GLGvrkFQdWpco5f9P7S8L-2-ETMu2-3dFEDwOgL1RQ@mail.gmail.com>
 <20130627175546.677d9f9b@amdc308.digital.local>
 <CAKohpomuGHQ53SohgN9UyF0ODJVq3TgiyTk6TaWFSotTEZm_9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAKohpomuGHQ53SohgN9UyF0ODJVq3TgiyTk6TaWFSotTEZm_9w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 28 Jun 2013 09:10:53 +0530, Viresh Kumar wrote:
> On 27 June 2013 21:25, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > On Wed, 26 Jun 2013 16:24:32 +0530, Viresh Kumar wrote:
> >> > +       if (boost_enabled != state) {
> >> > +               write_lock_irqsave(&cpufreq_driver_lock, flags);
> >> > +               boost_enabled = state;
> >> > +               if (cpufreq_driver->enable_boost)
> >> > +                       ret =
> >> > cpufreq_driver->enable_boost(state);
> >> > +               else
> >> > +                       ret = cpufreq_boost_trigger_state_sw();
> >
> > I will use only one call to cpufreq_driver->enable_boost(state) [*]
> > with either cpufreq_boost_enable_sw() (function with SW boost
> > handling) or the one provided by cpufreq driver.
> >
> > Only when cpufreq driver doesn't provide [*], it will be filled with
> > "default" cpufreq_boost_enable_sw().
> 
> I didn't get it completely. You are saying you will send a function
> pointer now?

No, I will use:

if (boost_enabled != state) {
	write_lock_irqsave(&cpufreq_driver_lock, flags);
	boost_enabled = state;

	ret = cpufreq_driver->enable_boost(state);
	^^^^^^^^^^^^^^^^^^^^ only one callback call
	if (ret)
		boost_enabled = 0;

	write_unlock_irqrestore(&cpufreq_driver_lock, flags);

	if (ret)
		pr_err("%s: BOOST cannot enable (%d)\n",
		       __func__, ret);
}

and @ cpufreq_register_driver() I will add following line:

if (!cpufreq_driver->enable_boost)
	cpufreq_driver->enable_boost = &cpufreq_boost_enable_sw;

When cpufreq driver doesn't define callback for enable_boost it will be
filled with default SW cpufreq_boost_enable_sw callback.



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
