From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/3] CPUFreq Fixes for 3.10-rc2
Date: Fri, 17 May 2013 14:16:23 +0200
Message-ID: <10164364.7LZaY8si4T@vostro.rjw.lan>
References: <cover.1368679353.git.viresh.kumar@linaro.org> <4482296.g7Mb85DDVP@vostro.rjw.lan> <CAKohpomOzeHsv=ZDBJGQKAiFWHDczweWF1wZuQDMRZE-0U3=2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpomOzeHsv=ZDBJGQKAiFWHDczweWF1wZuQDMRZE-0U3=2A@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com
List-Id: linux-pm@vger.kernel.org

On Friday, May 17, 2013 10:13:37 AM Viresh Kumar wrote:
> On 17 May 2013 02:21, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > While I kind of understand why you want [3/3] to go into 3.10, I'm wondering
> > about the other two patches.  Why exactly are they needed now?
> 
> First one:
> 
>   cpufreq: Add EXPORT_SYMBOL_GPL for have_governor_per_policy
> 
> is required so that governors can be compiled as module. Otherwise they
> may break.. I haven't tried that but I believe that is the case.

Did you try to build them as modules?

> For second one:
> 
>   cpufreq: governors: Move get_governor_parent_kobj() to cpufreq.c
> 
> I was actually working on Android's Interactive governor (Where I enabled
> same per-policy-instance of governor support), And i required this patch
> for its working. Then I thought other platform specific governors present
> in mainline might also use this routine and so must be pushed to cpufreq.c.
> 
> Now, because this patch is around due to something which got
> added in 3.10-rc1, its better to fix it in rcs only rather than fixing
> it in 3.11.

OK, thanks for the explanation.

> I will trust your judgement here, push it for 3.10-rc if it looks okay to you.
> 
> > And speaking of patch [3/3], if you paste kernel logs into changelogs, please
> > remove the time stamps (unless they are relevant to the problem being fixed).
> 
> Okay.. Will keep that in mind.

Thanks!

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
