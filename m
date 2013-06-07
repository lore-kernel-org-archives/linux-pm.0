From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 2/5] cpufreq:boost: Add support for software based CPU
 frequency boost
Date: Fri, 07 Jun 2013 16:34:26 +0200
Message-ID: <20130607163426.61e405aa@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1370502472-7249-3-git-send-email-l.majewski@samsung.com>
 <CAKohpok3KTfSWDU6PdDd4_VW4Pp+6J80yn5cLrYr5RuBNH-agA@mail.gmail.com>
 <20130606134903.5f69b8fb@amdc308.digital.local>
 <CAKohpo=jCuLwhB+3pC0NLRBDmfPpGr=hRgxTT4rXzSwM4BndaQ@mail.gmail.com>
 <20130607152718.4b458087@amdc308.digital.local>
 <CAKohpok=+UiDQR+i3sJAKLc26f41=uexj1R7=OBUnjyvabAxhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:31789 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432Ab3FGOee (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2013 10:34:34 -0400
In-reply-to: <CAKohpok=+UiDQR+i3sJAKLc26f41=uexj1R7=OBUnjyvabAxhg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>

Hi Viresh,

> Hi Lukasz,
> 
> On 7 June 2013 18:57, Lukasz Majewski <l.majewski@samsung.com> wrote:
> 
> I hope you agreed to all the other comments I gave as I don't see an
> explicit reply below each of these. I have seen people missing these
> in past, so what would be better to do is:
> - either reply below each one of them and say yes or no..
> - Or write once below many comments and say: All above comments
> are accepted.
> 
> So, that Reviewer is assured that you haven't missed anything.
> 

Thanks for reminding :-).

I've read through all the comments. I'm redesigning now the driver to
remove redundant code.


> > I would prefer to have following fields in the cpufreq_boost
> > structure: struct cpufreq_boost {
> >         unsigned int    max_boost_freq; /*boost max freq*/
> >         unsigned int    max_normal_freq; /*max normal freq
> >         int (*low_level_boost) (int state);
> >         bool boost_en;  /* indicate if boost is enabled */
> > }
> >
> > The max_{boost|normal}_freq fields will be filed at
> > ret = cpufreq_driver->init(policy);
> >
> > Thanks to them I will avoid calling many times routine, which
> > extracts from freq_table maximal boost and normal frequencies.
> >
> > I could define those variables in the exynos-cpufreq.c driver, but I
> > think, that they are more suitable to be embedded at cpufreq_boost
> > structure.
> 
> I understand that you need these variables (I will still look how you
> are using them in next version). But they are per policy and driver
> isn't responsible for maintaining them. If they are required then
> cpufreq core must find them out and keep in struct cpufreq_policy (as
> they are policy dependent)..
> 
> So, remove this structure from cpufreq_driver and embed variables
> directly.

After refactoring the code. I admit, that we shall embed the struct
cpu_boost fields directly to the coufreq_driver. There is no point to
create structure with 2 fields.

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
