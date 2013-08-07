From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: exynos5440: Fix to skip when new frequency same
 as current
Date: Wed, 7 Aug 2013 17:03:59 +0530
Message-ID: <CAKohpom0gPk9BXRP2eEuX_HBXDut=wynrZfvOH1tcEQY6CMLNQ@mail.gmail.com>
References: <1375874171-16951-1-git-send-email-amit.daniel@samsung.com>
	<CAKohpokp04HXau1fOA6w9K675LwRw6uCCZZKyFAJtF1_pkcC=Q@mail.gmail.com>
	<52022FC2.2010109@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52022FC2.2010109@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

On 7 August 2013 17:00, Sudeep KarkadaNagesha
<Sudeep.KarkadaNagesha@arm.com> wrote:
> Any particular reason we need this check in all drivers after your
> commit: 5a1c0228 "cpufreq: Avoid calling cpufreq driver's target()
> routine if target_freq == policy->cur"
>
> I think it can removed from all drivers, am I missing something ?

Yeah.. Just a bit though :)

So, cpufreq core checks this when we call target for any frequency.
Now, cpufreq driver actually does a cpufreq_frequency_table_target()
and so the frequency may vary than what is requested, in case
requested frequency isn't picked from the table.

In such cases we check it again to be sure that we aren't at this
frequency already..

Earlier I thought of calling cpufreq_frequency_table_target() in the
core before calling target but dropped the idea as I wasn't sure of
the side effects.

@Rafael: Do you see why we shouldn't/can't call
cpufreq_frequency_table_target() from the core itself and so drivers
never need to do it?
