From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V3 09/10] cpufreq: cpu0: rename driver and internals to
 'cpufreq_generic'
Date: Mon, 08 Sep 2014 16:18:11 -0700
Message-ID: <540E3933.8000904@codeaurora.org>
References: <cover.1409201048.git.viresh.kumar@linaro.org> <8d75112b27fa36c873838185e99f0dbe7f86cc05.1409201048.git.viresh.kumar@linaro.org> <1841344.yBggYEARvr@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1841344.yBggYEARvr@vostro.rjw.lan>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org, spk.linux@gmail.com, thomas.ab@samsung.com, t.figa@samsung.com, santosh.shilimkar@ti.com, thomas.petazzoni@free-electrons.com, pramod.gurav@smartplayin.com
List-Id: linux-pm@vger.kernel.org

On 09/08/14 16:34, Rafael J. Wysocki wrote:
> On Thursday, August 28, 2014 11:22:31 AM Viresh Kumar wrote:
>> The naming convention of this driver was always under the scanner, people
>> complained that it should have a more generic name than cpu0, as it manages all
>> CPUs that are sharing clock lines.
>>
>> Also, in future it will be modified to support any number of clusters with
>> separate clock/voltage lines.
>>
>> Lets rename it to 'cpufreq_generic' from 'cpufreq_cpu0'.
> I'm not a big fan of changes like this to be honest, because they kind of
> hide history.  For example, if you do a "git blame" on the new file, it will
> show your commit and nothing before it.

Sounds like a tooling problem. But git blame doesn't have that behavior
so there isn't actually any problem?

$ git blame -- drivers/cpufreq/cpufreq-generic.c | head -10
95ceafd46359d drivers/cpufreq/cpufreq-cpu0.c    (Shawn Guo               2012-09-06 07:09:11 +0000   1) /*
95ceafd46359d drivers/cpufreq/cpufreq-cpu0.c    (Shawn Guo               2012-09-06 07:09:11 +0000   2)  * Copyright (C) 2012 Freescale Semiconductor, Inc.
95ceafd46359d drivers/cpufreq/cpufreq-cpu0.c    (Shawn Guo               2012-09-06 07:09:11 +0000   3)  *
da1a765bf681c drivers/cpufreq/cpufreq-cpu0.c    (Viresh Kumar            2014-06-30 10:15:22 +0530   4)  * Copyright (C) 2014 Linaro.
da1a765bf681c drivers/cpufreq/cpufreq-cpu0.c    (Viresh Kumar            2014-06-30 10:15:22 +0530   5)  * Viresh Kumar <viresh.kumar@linaro.org>
da1a765bf681c drivers/cpufreq/cpufreq-cpu0.c    (Viresh Kumar            2014-06-30 10:15:22 +0530   6)  *
ac4f646b8a5f3 drivers/cpufreq/cpufreq-generic.c (Viresh Kumar            2014-06-27 10:58:51 +0530   7)  * The OPP code in function set_target() is reused from
95ceafd46359d drivers/cpufreq/cpufreq-cpu0.c    (Shawn Guo               2012-09-06 07:09:11 +0000   8)  * drivers/cpufreq/omap-cpufreq.c
95ceafd46359d drivers/cpufreq/cpufreq-cpu0.c    (Shawn Guo               2012-09-06 07:09:11 +0000   9)  *
95ceafd46359d drivers/cpufreq/cpufreq-cpu0.c    (Shawn Guo               2012-09-06 07:09:11 +0000  10)  * This program is free software; you can redistribute it and/or modify

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
