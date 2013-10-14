From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v2 0/2] cpufreq: exynos: Fixes for v3.12
Date: Mon, 14 Oct 2013 07:55:46 +0200
Message-ID: <20131014075546.72e0dc61@amdc308.digital.local>
References: <1380108138-30402-1-git-send-email-l.majewski@samsung.com>
 <1381320523-28183-1-git-send-email-l.majewski@samsung.com>
 <1457107.oQjJi4YKRz@vostro.rjw.lan> <2822925.9aRTDAMrLp@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <2822925.9aRTDAMrLp@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Yadwinder Singh Brar <yadi.brar01@gmail.com>, Tomasz Figa <t.figa@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

> On Friday, October 11, 2013 01:22:57 PM Rafael J. Wysocki wrote:
> > On Wednesday, October 09, 2013 02:08:41 PM Lukasz Majewski wrote:
> > > Attached commits provide cpufreq regression fixes for Trats and
> > > Trats2 Exynos4 boards.
> > > Since v3.12 Exynos4 uses common clock framework for clock
> > > manipulation. Those patches restore correct output for
> > > cpuinfo_cur_freq [1] sysfs attribute.
> > > Without them, the [1] provides default frequency (800 MHz) set at
> > > driver initialization.
> > > 
> > > 
> > > Lukasz Majewski (2):
> > >   cpufreq: exynos4x12: Use the common clock framework to set APLL
> > > clock rate
> > >   cpufreq: exynos4210: Use the common clock framework to set APLL
> > > clock rate
> > > 
> > >  drivers/cpufreq/exynos4210-cpufreq.c |   67
> > > ++++-----------------------------
> > > drivers/cpufreq/exynos4x12-cpufreq.c |   69
> > > ++++------------------------------ 2 files changed, 16
> > > insertions(+), 120 deletions(-)
> > 
> > Can you please resend [1/2], it got lost somewhere (at least I
> > can't see it now)?
> 
> Scratch this, it's there in patchwork.
> 

Rafael, do you need any more help with those fixes? 

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
