From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 4/7] drivers/cpufreq: Convert non-modular drivers to use builtin_driver_register
Date: Tue, 12 May 2015 23:17:30 -0400
Message-ID: <CAP=VYLqNnn1w8ss9to+NGOhwmq8O8wYY9scMg1vQ1+mQmf=Gyw@mail.gmail.com>
References: <1431287385-1526-1-git-send-email-paul.gortmaker@windriver.com>
 <1431287385-1526-5-git-send-email-paul.gortmaker@windriver.com> <20150512070444.GE32300@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:35556 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934004AbbEMDSD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2015 23:18:03 -0400
In-Reply-To: <20150512070444.GE32300@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, May 12, 2015 at 3:04 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 10-05-15, 15:49, Paul Gortmaker wrote:
>> These files depend on Kconfig options all of which are a bool, so
>> we use the appropriate registration function, which avoids us
>> relying on an implicit inclusion of <module.h> which we are
>> doing currently.
>>
>> While this currently works, we really don't want to be including
>> the module.h header in non-modular code, which we'd be forced
>> to do, pending some upcoming code relocation from init.h into
>> module.h.  So we fix it now by using the non-modular equivalent.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Cc: linux-pm@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> ---
>>  drivers/cpufreq/exynos-cpufreq.c  | 2 +-
>
> Exynos can be compiled as a module:
>
> drivers/cpufreq/Kconfig.arm:
>
> config ARM_EXYNOS_CPUFREQ
>         tristate "SAMSUNG EXYNOS CPUfreq Driver"
>         depends on CPU_EXYNOS4210 || SOC_EXYNOS4212 || SOC_EXYNOS4412 || SOC_EXYNOS5250

Sounds like things have changed since I did the original compile
testing ; thanks for the heads-up and I will follow up with the details,
once I can re-test.

Thanks,
Paul.
--

>
> --
> viresh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
