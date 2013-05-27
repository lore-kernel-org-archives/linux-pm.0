From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [RFC v2 0/3][TESTS] LAB: Support for Legacy Application Booster
 governor - tests results
Date: Mon, 27 May 2013 09:34:55 +0200
Message-ID: <20130527093455.04de38b1@amdc308.digital.local>
References: <1367590072-10496-1-git-send-email-jonghwa3.lee@samsung.com>
 <CAKohpokXNUmMbk0KOh58-0=sAs7yzD=cQe24eaoArpRSwM__Gg@mail.gmail.com>
 <20130522122700.104ca5cd@amdc308.digital.local>
 <CAKohpo=9dRXb1jjauvhzuje9rOgH82k-3DeL2zqiwHDHOwSo4g@mail.gmail.com>
 <20130522164453.29cd3a7d@amdc308.digital.local>
 <20130524075640.0a5b80ff@amdc308.digital.local>
 <CAKohpoksymD76rDvg_+PwU7r3JXp1oydHBbJE4-y6TBHOomZHg@mail.gmail.com>
 <20130524103007.7bb206ee@amdc308.digital.local>
 <CAKohponbX7u_k9ZYQ7KyBeyKh93Qu+niGZj60t9c1n+AmaA6pg@mail.gmail.com>
 <20130524132036.7e7d5ffe@amdc308.digital.local>
 <CAKohpo=Kw4RsDJL8BdH1uE7Aj-X=K5A7af5NRqJXyjRUNvv5ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAKohpo=Kw4RsDJL8BdH1uE7Aj-X=K5A7af5NRqJXyjRUNvv5ag@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jonghwa Lee <jonghwa3.lee@samsung.com>, "Rafael J. Wysocky" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Vicent Guittot <vincent.guittot@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

> On 24 May 2013 16:50, Lukasz Majewski <l.majewski@samsung.com> wrote:
> >> On 24 May 2013 14:00, Lukasz Majewski <l.majewski@samsung.com>
> >> wrote:
> 
> > This is not safe IMHO to add permanently overclocked frequency to
> > the freq table. Since, for example, thermal framework also asks for
> > reference to this table.
> 
> Yes, its wrong. Even adding it permanently this way would be a problem
> if governor is changed to performance. :)
> 
> > The idea beneath overclocking is to add "dangerous" frequency to the
> > frequency table only when necessary (and remove it when not needed).
> 
> Hmm.. probably the idea beneath is to use dangerous frequency only
> when we are assured that we will not break system.. 

Exactly, this is the idea.

> It doesn't have
> anything to do with cpufreq table entries :)
> 
> > In this way, the thermal framework (as it is done at our platform)
> > will decrease the frequency (according to thermal governor :-) ) to
> > safe level.
> >
> > Overclocking is disabled in 2 ways (at our setup):
> > - thermal framework is here to help us
> > - lab governor disables the overclocking when favorable conditions
> > are gone.
> 
> I don't want to discuss OR think about LAB for now.. Want to get
> overclocking feature in first.
> 
> > One more remark - enabling tb_en_over_clk at sysfs (echo 1
> >> /sys/devices/system/cpu/cpu0/cpufreq/tb_en_over_clk)
> > adds overclock frequency to frequency table and updates policy.
> 
> What if it is enabled and governor is changed to performance
> without disabling it... Who will take care of disabling dangerous
> frequencies?

So we could disable overclocking by default when policy is changed, or
when we remove governor (at cpufreq_unregister_governor()).

> 
> One thing I am certain about is to make overclocking a generic and
> core feature, rather than platform specific...

Ok, I see your point. I will prepare appropriate patches to rewrite
overclocking as a generic framework.

> 
> What about adding overdrive frequencies in freq table permanently
> but with .index field as: CPUFREQ_ENTRY_OVERDRIVE ??
> 
> This way we will use frequencies marked with
> CPUFREQ_ENTRY_OVERDRIVE only when we have overclocking
> enabled. And not at other times?

It seems to be a good idea. In this way we could solve some other
problems as well (like specifying not single overclocked frequency,
make sysfs entries read only).

As I've stated above, I will prepare only overclocking patches, with
new generic approach.



-- 
Best regards,

Lukasz Majewski

Samsung R&D Poland (SRPOL) | Linux Platform Group
