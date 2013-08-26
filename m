From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v7 3/7] thermal:boost: Automatic enable/disable of BOOST
 feature
Date: Mon, 26 Aug 2013 08:50:46 +0200
Message-ID: <20130826085046.797baf96@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1376388505-30233-1-git-send-email-l.majewski@samsung.com>
 <1376388505-30233-4-git-send-email-l.majewski@samsung.com>
 <CAKohpo=KSVOFr5PXcpTZTaSq3_fv7AZgSiHiY-kWYREj6JdUoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohpo=KSVOFr5PXcpTZTaSq3_fv7AZgSiHiY-kWYREj6JdUoA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, "R, Durgadoss" <durgadoss.r@intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 26 Aug 2013 11:03:51 +0530 Viresh Kumar viresh.kumar@linaro.org
wrote,
> On 13 August 2013 15:38, Lukasz Majewski <l.majewski@samsung.com>
> wrote:
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index b5defd4..ec19da9 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -408,10 +408,24 @@ int cpufreq_frequency_table_target(struct
> > cpufreq_policy *policy,
> >
> >  void cpufreq_frequency_table_update_policy_cpu(struct
> > cpufreq_policy *policy); ssize_t cpufreq_show_cpus(const struct
> > cpumask *mask, char *buf); +#ifdef CONFIG_CPU_FREQ
> >  int cpufreq_boost_trigger_state(int state);
> >  int cpufreq_boost_supported(void);
> >  int cpufreq_boost_enabled(void);
> > -
> > +#else
> > +static inline int cpufreq_boost_trigger_state(int state)
> > +{
> > +       return 0;
> > +}
> > +static inline int cpufreq_boost_supported(void)
> > +{
> > +       return 0;
> > +}
> > +static inline int cpufreq_boost_enabled(void)
> > +{
> > +       return 0;
> > +}
> > +#endif
> 
> I almost gave an Ack before I saw this :)
> This should be moved to the first patch I believe..

Ok, I will move it there.

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
