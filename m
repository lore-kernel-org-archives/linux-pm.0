From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v4 5/7] cpufreq: Calculate number of busy CPUs
Date: Thu, 04 Jul 2013 07:43:07 +0200
Message-ID: <20130704074307.282a53dc@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-6-git-send-email-l.majewski@samsung.com>
 <CAKohpo=EwapTp8epok30=_ZYLPeCR8_LhpBF5H724dE=+SwMLg@mail.gmail.com>
 <20130627125819.5c90da30@amdc308.digital.local>
 <CAKohpo=JKg17YWjTrOh25hHW=sXn8-TW=D8rhrovonwZBDarBg@mail.gmail.com>
 <20130627164204.370dc4a6@amdc308.digital.local>
 <CAKohpomrPP9Lzk+fMn+Ba+J+2N740LR5NurVMomx8zww3AWLww@mail.gmail.com>
 <20130628085457.05d64878@amdc308.digital.local>
 <20130701101516.7945e387@amdc308.digital.local>
 <CAKohponiy3ebnt0_Cdaan5=DkAfA3U4g=m4NnYGLA-a+tPJJQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohponiy3ebnt0_Cdaan5=DkAfA3U4g=m4NnYGLA-a+tPJJQg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 04 Jul 2013 10:36:53 +0530, Viresh Kumar wrote:
> Hi Lukasz,
> 
> Sorry for being late. Actually I didn't had an answer to your mail
> and wanted to go through it with some fresh mind. This is my
> first mail this morning, lets see if I can bring something good
> into the discussion.
> 
> On 1 July 2013 13:45, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > Does anybody have any idea here? As written above, thermal is
> > suitable to disable boost.
> 
> See, one thing is very clear. User space applications aren't
> responsible for enabling boost again and again. There has to be a
> internal mechanism inside kernel for that.
> 
> > I'd like to bring those three options under discussion:
> >
> > 1. boost attr is always exported -> do not enable boost
> > automatically when disabled by thermal (as it was proposed at v4).
> 
> So, that's a problem. I see one more solution to that.
> - Create another Macro in cpufreq.c which would contain the time
> after which we will autoenable boost.
> - So, suppose thermal disabled it due to high temperature (Lets not
> change value of sysfs variable boost_enable, but create another
> variable like: skip_boost: which means skip boost temporarily).
> - Thermal would enable this variable skip_boost.
> - Then we will continue to get requests for next frequency and will
> check eveytime if we have exceeded time for autoenabling boost.
> - If yes, then we disable this variable and start boosting again..
> - Then thermal can disable it again later.
> 
> This variable (time for autoenable) looks to be more platform
> dependent for now, but lets don't make it like that unless somebody
> needs it.
> 
> > 2. boost attr is always exported -> find a way to enable boost after
> >    emergency disablement when thermal detects overheating (newest
> >    proposition).
> 
> My solution above probably.

This is a possible solution, but I've already modified thermal code a
bit and found a solution for the problem.

I use thermal workqueue (which is already in place anyway) to enable the
boost again.
Due to that I can provide behaviour similar to HW controlled boost.

Patches with this solution are already prepared. I will post them in a
few hours. Ok?

> 
> > 3. boost attr only exported at x86 (when supported)
> >    boost attr NOT exported via sysfs for SW controlled boost (e.g.
> >    Exynos ARM).
> >
> >    Then we only enable/disable boost at kernel and don't need to
> > take care of the user space interaction. This scenario is my use
> > case. I hadn't planned to expose boost to userspace and use it with
> > LAB as a kernel API.
> 
> Userspace must have control of this feature after kernel is built.
> That kernel image may run for ever without changing in a product.
> 
> @Rafael: How crazy do you think my solution is? :)


-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
