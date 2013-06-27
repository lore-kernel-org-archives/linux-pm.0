From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 2/7] cpufreq: Add boost frequency support in core
Date: Thu, 27 Jun 2013 14:32:57 +0530
Message-ID: <CAKohpo==702FnSwhrPi6L1VzLbxO5LT3VDQCru9cwKjgmbppxA@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<1371661969-7660-1-git-send-email-l.majewski@samsung.com>
	<1371661969-7660-3-git-send-email-l.majewski@samsung.com>
	<CAKohpon7GLGvrkFQdWpco5f9P7S8L-2-ETMu2-3dFEDwOgL1RQ@mail.gmail.com>
	<20130626145412.1e9bfa63@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130626145412.1e9bfa63@amdc308.digital.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, t.figa@samsung.com
List-Id: linux-pm@vger.kernel.org

On 26 June 2013 18:24, Lukasz Majewski <l.majewski@samsung.com> wrote:
> On Wed, 26 Jun 2013 16:24:32 +0530, Viresh Kumar wrote:
>> On 19 June 2013 22:42, Lukasz Majewski <l.majewski@samsung.com> wrote:

>> > +static ssize_t store_boost(struct kobject *kobj, struct attribute
>> > *attr,
>> > +                                 const char *buf, size_t count)
>> > +{
>> > +       int ret, enable;
>> > +
>> > +       ret = sscanf(buf, "%d", &enable);
>> > +       if (ret != 1 || enable < 0 || enable > 1)
>> > +               return -EINVAL;
>> > +
>> > +       if (cpufreq_boost_trigger_state(enable)) {
>> > +               pr_err("%s: Cannot enable boost!\n", __func__);
>> > +               return -EINVAL;
>> > +       }
>>
>> Probably do boost_enabled = true here.
>
> I would prefer to set boot_enabled at
> cpufreq_boost_trigger_state() method. It is closer to the
> cpufreq_driver->enable_boost and cpufreq_boost_trigger_state_sw();
> functions, which do change the freq.

I said that as this will be more inclined towards the purpose of
this routine. This routine should store boost as show_boost()
is returning it. So, what would be better is if you just return
0 or err from cpufreq_boost_trigger_state() and then set boost
here. This will also solve your problem where you revert back
to older boost value for failure cases.

>> > +                       ret = cpufreq_driver->enable_boost(state);
>                                                   ^^^^^^^^^^^^^
>                                         I would prefer to change this
>                                         name to enable_boost_hw
> It is more informative, since it is tailored to hw based boost (Intel).

Ok

>> > +               else
>> > +                       ret = cpufreq_boost_trigger_state_sw();

then why not enable_boost_sw() here? that would be more
relevant.

> I will rewrite it as follow:
>
> if (ret)
>         boost_enabled = 0;
>
> write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> pr_debug("%s: cpufreq BOOST %s\n", __func__,
>                  state ? "enabled" : "disabled");

So, you will not print error but current state? Probably
printing error is better.
