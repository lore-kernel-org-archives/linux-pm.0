From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] cpufreq: Add ARM_MT8173_CPUFREQ dependencyon THERMAL
Date: Fri, 4 Sep 2015 12:01:40 -0700
Message-ID: <CAOesGMgcSjNdRCe6i994F=unLLXG3-JJeiV-mLBnOHfbUd0DDw@mail.gmail.com>
References: <1441293658-18199-1-git-send-email-linux@roeck-us.net>
	<20150903155029.GB5332@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:33103 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933073AbbIDTBl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2015 15:01:41 -0400
Received: by ykei199 with SMTP id i199so30059421yke.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2015 12:01:40 -0700 (PDT)
In-Reply-To: <20150903155029.GB5332@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Sep 3, 2015 at 8:50 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 03-09-15, 08:20, Guenter Roeck wrote:
>> If ARM_MT8173_CPUFREQ is configured, and THERMAL is configured as module,
>> the following build error is seen for arm:allmodconfig and
>> arm64:allmodconfig.
>>
>> drivers/built-in.o: In function `mtk_cpufreq_ready':
>> :(.text+0x32a20c): undefined reference to `of_cpufreq_cooling_register'
>> drivers/built-in.o: In function `mtk_cpufreq_exit':
>> :(.text+0x32a420): undefined reference to `cpufreq_cooling_unregister'
>>
>> The fix is similar to CPUFREQ_DT, but more restrictive since
>> ARM_MT8173_CPUFREQ can not be built as module.
>>
>> Fixes: 1453863fb02a ("cpufreq: mediatek: Add MT8173 cpufreq driver")
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> It might also make sense to declare ARM_MT8173_CPUFREQ as tristate
>> and relax the conditions, but I don't know if that is feasible.
>>
>>  drivers/cpufreq/Kconfig.arm | 1 +
>>  1 file changed, 1 insertion(+)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Who's applying and sending this up to avoid extended period of build breakage?


-Olof
