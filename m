From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v3 1/3] cpufreq: Add boost frequency support in core
Date: Mon, 17 Jun 2013 15:51:56 +0200
Message-ID: <20130617155156.4c729b5a@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1371195540-2991-1-git-send-email-l.majewski@samsung.com>
 <1371195540-2991-2-git-send-email-l.majewski@samsung.com>
 <CAKohpokQAsuAqWi7rNx9RaFz8KVRNXVkBD22KC5_Qh05k66qqA@mail.gmail.com>
 <20130617091549.398b865f@amdc308.digital.local>
 <CAKohpo=nfuqwCoQJRczmNRNXCOTL5FSJQEzjKpVdXU+wu-KJ1g@mail.gmail.com>
 <20130617110811.1e1805d2@amdc308.digital.local>
 <CAKohpo=oy3SQXgvNvOydggZ5NZu9yyVtKrdFQjNOGVmzhSaQUw@mail.gmail.com>
 <20130617115809.5206c42c@amdc308.digital.local>
 <CAKohpo=yPcH0FW7T38cd3E1xOpzC0AhJ5mtyVaQyuj_S8iLovw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAKohpo=yPcH0FW7T38cd3E1xOpzC0AhJ5mtyVaQyuj_S8iLovw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 17 Jun 2013 18:40:50 +0530, Viresh Kumar wrote:
> On 17 June 2013 15:28, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > Yes. But I don't want to hardcode anything. Especially starting CPU
> > number.
> 
> There is nothing wrong with it. for_each_online_cpu() is good enough
> on these cases.

I've already changed this code to use list of policies.

I will send this at v4.

> 
> >> > How one can control the boost? I'm now (on my setup) using
> >> > thermal subsystem. I set proper trip points and when one of them
> >> > is met, then boost is disabled. Moreover the thermal governor
> >> > (stepwise) also reduces frequency.
> >> >
> >> > It works stable with v3.10 (with 3.8 there were some bugs - now
> >> > they are fixed).
> >> >
> >> >
> >> > The core acpi-cpufreq.c code hadn't been changed by me, so I
> >> > assume that it will work as before.
> >>
> >> That should adapt your patch in your patchset.

Could you explain what do you mean? 


> 
> ??
> 
> >> From sysfs?? I thought we are going to have some automatic control
> >> of this stuff from inside kernel.
> >
> > From sysfs I just enable the boost. I do not order from userpace the
> > cpufreq to run with a particular (boosted) frequency.
> >
> > When I enable boost - I ask (politely) the cpufreq core to
> > reevaluate policies and when applicable increase policy->max.
> >
> > Then governor can use this new frequencies for normal operation.
> 
> So, with your current patchset in, ondemand or conservative governors
> will start using boost frequencies. Which might burn your chip.

Two scenarios:
1. Thermal framework is compiled in and enabled (for exynos/other SoC)
-> trip point is reached -> boost is disabled -> frequency is reduced ->
SoC is cooled down.

I think, that thermal framework is a good "safe valve" here.


2. Thermal framework is disabled and user has enabled boost and used
ondemand / conservative governor. 
Then execute gzip < /dev/urandom > /dev/null & (on all cores).

Then yes, chip will hang/burn due to crossing operating point (or burn).


What other means of control (despite of thermal) would you consider
applicable? 

What comes to my mind is modifying governor logic to count how long the
CPU run with boost enabled and then disable it. 

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
