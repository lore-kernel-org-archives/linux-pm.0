From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 6/8] cpufreq:exynos:Extend Exynos cpufreq driver to
 support boost framework
Date: Mon, 29 Jul 2013 12:31:30 +0530
Message-ID: <CAKohpom0U1S9nAJO2yAYSJ2_SW-xdFYaY3OYhgLHJC06y_ROXA@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<1374770011-22171-1-git-send-email-l.majewski@samsung.com>
	<1374770011-22171-7-git-send-email-l.majewski@samsung.com>
	<CAKohponC=S=3=mrTpWvPvejqSeqfndVOwb2GDkQ0jKxXXa0TOQ@mail.gmail.com>
	<20130726132617.567f2cbf@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:46206 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab3G2HBa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2013 03:01:30 -0400
Received: by mail-ob0-f171.google.com with SMTP id tb18so8496253obb.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2013 00:01:30 -0700 (PDT)
In-Reply-To: <20130726132617.567f2cbf@amdc308.digital.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, durgadoss.r@intel.com

On 26 July 2013 16:56, Lukasz Majewski <l.majewski@samsung.com> wrote:
> On Fri, 26 Jul 2013 15:56:53 +0530 Viresh Kumar wrote,
>> On 25 July 2013 22:03, Lukasz Majewski <l.majewski@samsung.com> wrote:
>>
>> > diff --git a/drivers/cpufreq/exynos-cpufreq.c
>> > b/drivers/cpufreq/exynos-cpufreq.c index 9ae1871..175172d9 100644
>> > --- a/drivers/cpufreq/exynos-cpufreq.c
>> > +++ b/drivers/cpufreq/exynos-cpufreq.c
>> > @@ -270,6 +270,9 @@ static int exynos_cpufreq_cpu_exit(struct
>> > cpufreq_policy *policy)
>> >
>> >  static struct freq_attr *exynos_cpufreq_attr[] = {
>> >         &cpufreq_freq_attr_scaling_available_freqs,
>> > +#ifdef CONFIG_CPU_FREQ_BOOST_SW
>             ^^^^^^^^^^^^^^^^^^^^^^^^^ [*]
>>
>> Use ARM_EXYNOS_CPU_FREQ_BOOST_SW instead.
>
> For the reasons explained at [PATCH v6 5/8] I would prefer to leave [*]
> here.

I don't see how that reasoning fit here.

This is exynos code and you must use exynos specific boost Kconfig
option here.. Otherwise It might be enabled without Exynos specific option,
if somebody else has selected CONFIG_CPU_FREQ_BOOST_SW in
a multi platform kernel,
