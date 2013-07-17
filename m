From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v5 6/7] cpufreq:boost:Kconfig: Enable software managed
 BOOST support at Kconfig
Date: Wed, 17 Jul 2013 10:12:51 +0200
Message-ID: <20130717101251.164fbad8@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1372927830-2949-1-git-send-email-l.majewski@samsung.com>
 <1372927830-2949-7-git-send-email-l.majewski@samsung.com>
 <CAKohpokR=jrcLQQ7VAD+vr7GWgSFBfuqbOhWHwA3FCgk__EJ3Q@mail.gmail.com>
 <20130716135022.64a102f8@amdc308.digital.local>
 <CAKohpo=XbUtYBVQ_y4_R18wpag_HAVvXrxfSfmaNSqq=wLpciQ@mail.gmail.com>
 <20130717091706.69b77c2f@amdc308.digital.local>
 <CAKohpona8E-JgLxyLnc_QuS9LAuJ7FBbsSGPZawQtOd8kRd4JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:57910 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200Ab3GQINX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2013 04:13:23 -0400
In-reply-to: <CAKohpona8E-JgLxyLnc_QuS9LAuJ7FBbsSGPZawQtOd8kRd4JA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, l.majewski@majess.pl, linux-kernel <linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>

On Wed, 17 Jul 2013 13:22:20 +0530 Viresh Kumar viresh.kumar@linaro.org
wrote,
> On 17 July 2013 12:47, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > On Wed, 17 Jul 2013 10:54:55 +0530 Viresh Kumar
> > viresh.kumar@linaro.org wrote,
> >> On 16 July 2013 17:20, Lukasz Majewski <l.majewski@samsung.com>
> >> wrote:
> >> > On Tue, 16 Jul 2013 15:28:40 +0530 Viresh Kumar
> >> > viresh.kumar@linaro.org wrote,
> >> >> On 4 July 2013 14:20, Lukasz Majewski <l.majewski@samsung.com>
> >> >> wrote:
> >> >> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> >> >>
> >> >> > +config CPU_FREQ_BOOST_SW
> >> >> > +       bool "CPU frequency overclocking (BOOST)"
> >> >>
> >> >> Name it "CPU Frequency Overclocking - Software"
> >> >
> >> > Thanks, I had a puzzle to came up with a good short name :-).
> >> >
> >> >>
> >> >> > +       depends on ARM_EXYNOS_CPUFREQ && EXYNOS_THERMAL
> >> >                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ [*]
> >> >>
> >> >> Remote Exynos from here. If you want to enable it for your
> >> >> platform by default, then select it from EXYNOS.
> >
> > I can change ARM_EXYNOS_CPUFREQ -> CPUFREQ at [*]
> 
> We are in cpufreq Kconfig and so dependency is automatically
> there on cpufreq.

So then, it can be removed.

> 
> >>
> >> I misread it a bit. I wanted to say make it dependent only on
> >> THERMAL and not on Exynos.
> >
> > The cpufreq boost feature is possible to be enabled only when those
> > [*] dependencies are met. Moreover, it is disabled by default.
> >
> > This means that not only THERMAL generic code must be supported, but
> > also EXYNOS specific one - like per SoC trip points [**].
> >
> > With thermal it is possible (and correct) to only define THERMAL,
> > with no platform (in this case Exynos) specific definitions. To
> > force potential user to define [**], I think, that EXYNOS_THERMAL
> > is required.
> >
> >>
> >> > The purpose of the condition [*] here is to prevent from enabling
> >> > boost when thermal for Exynos is not supported.
> >>
> >> Why? Can't others use it? Its not exynos specific :)
> >
> > No it is not exynos specific.
> > For other platform one need to define:
> >
> > depends on CPUFREQ && (EXYNOS_THERMAL ||
> > <PLATFORM_SUPPORTED>_THERMAL)
> 
> Exactly. I don't want this kind of mess to be present here.
> 
> People selecting this feature must know what it does and
> dependency on a coolant is enough.
> 
> For other drivers, selecting this doesn't matter as they don't
> support boost.

Then it should be enough to only write:

depends on THERMAL

(since CPUFREQ is already enabled for entering this menu).




-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
