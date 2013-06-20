From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/3] cpufreq: Add boost frequency support in core
Date: Thu, 20 Jun 2013 10:41:41 +0530
Message-ID: <CAKohponTEb_XQnGTpDVC78jknCuwumnckCKZk6cObq45RmWpFA@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<20130617155156.4c729b5a@amdc308.digital.local>
	<CAKohpo=_=u35wTb-ZUXrR2hNno+ryAqq4gSC3EiJr=-bmgb9JQ@mail.gmail.com>
	<3258927.Qds4G9CTyG@vostro.rjw.lan>
	<20130618154456.56d99e18@amdc308.digital.local>
	<20130619091612.60e4d69d@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:59823 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064Ab3FTFLl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jun 2013 01:11:41 -0400
Received: by mail-oa0-f41.google.com with SMTP id n10so7429006oag.28
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2013 22:11:41 -0700 (PDT)
In-Reply-To: <20130619091612.60e4d69d@amdc308.digital.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>

On 19 June 2013 12:46, Lukasz Majewski <l.majewski@samsung.com> wrote:
> I would like to clarify the above issue.
>
> When I've discussed with Viresh previous version of this patch, we have
> agreed, that "boost" sysfs attribute [*]:
> /sys/devices/system/cpu/cpufreq/boost
>
> would be only visible when boost_supported flag is set at cpufreq
> driver.

Yes.

> When acpi-cpufreq driver doesn't support boost, the attribute [*]
> won't be exported at all. This contradicts the documentation and legacy
> acpi-cpufreq behaviour.

No they aren't contradictory. What the documentation meant was:
acpi-cpufreq driver is used by lots of different x86 processors. Now
all processors might not support boost inside x86 also. And for them
we will keep 'boost' file readonly. This is done by following statement

	if (boot_cpu_has(X86_FEATURE_CPB) || boot_cpu_has(X86_FEATURE_IDA)) {
		boost_supported = true;
                ....
	} else
		global_boost.attr.mode = 0444;

Documentation file doesn't talk about any other cpufreq driver, for
them there is no concept like boost.

You need to preserve this functionality.

> Since I'm affraid to break API (with all its consequences :-) ), I would
> like to be sure that this is OK, and thereof I'm allowed to rewrite
> documentation accordingly.
>
> I simply need explicit permission from both maintainers :-).

For me its okay to rewrite documentation.
