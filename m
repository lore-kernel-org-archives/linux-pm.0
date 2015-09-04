From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: Add ARM_MT8173_CPUFREQ dependencyon THERMAL
Date: Sat, 5 Sep 2015 00:27:42 +0200
Message-ID: <CAJZ5v0hzcbprjy_NHihbe-rbP7OxR1pmcU_Xxx_rTM2SQ5yL5A@mail.gmail.com>
References: <1441293658-18199-1-git-send-email-linux@roeck-us.net>
	<20150903155029.GB5332@linux>
	<CAOesGMgcSjNdRCe6i994F=unLLXG3-JJeiV-mLBnOHfbUd0DDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34789 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760159AbbIDW1o (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2015 18:27:44 -0400
In-Reply-To: <CAOesGMgcSjNdRCe6i994F=unLLXG3-JJeiV-mLBnOHfbUd0DDw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Guenter Roeck <linux@roeck-us.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

On Fri, Sep 4, 2015 at 9:01 PM, Olof Johansson <olof@lixom.net> wrote:
> On Thu, Sep 3, 2015 at 8:50 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> On 03-09-15, 08:20, Guenter Roeck wrote:
>>> If ARM_MT8173_CPUFREQ is configured, and THERMAL is configured as module,
>>> the following build error is seen for arm:allmodconfig and
>>> arm64:allmodconfig.
>>>
>>> drivers/built-in.o: In function `mtk_cpufreq_ready':
>>> :(.text+0x32a20c): undefined reference to `of_cpufreq_cooling_register'
>>> drivers/built-in.o: In function `mtk_cpufreq_exit':
>>> :(.text+0x32a420): undefined reference to `cpufreq_cooling_unregister'
>>>
>>> The fix is similar to CPUFREQ_DT, but more restrictive since
>>> ARM_MT8173_CPUFREQ can not be built as module.
>>>
>>> Fixes: 1453863fb02a ("cpufreq: mediatek: Add MT8173 cpufreq driver")
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>> It might also make sense to declare ARM_MT8173_CPUFREQ as tristate
>>> and relax the conditions, but I don't know if that is feasible.
>>>
>>>  drivers/cpufreq/Kconfig.arm | 1 +
>>>  1 file changed, 1 insertion(+)
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Who's applying and sending this up to avoid extended period of build breakage?

I'll queue up this particular one.

Thanks,
Rafael
