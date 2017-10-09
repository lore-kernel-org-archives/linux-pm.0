From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] cpufreq: dt-platdev: drop socionext,uniphier-ld6b from whitelist
Date: Mon, 9 Oct 2017 21:15:55 +0900
Message-ID: <CAK7LNARoPk+NZ0z3rbaUr3NGHQnMZmymH-YMCaq50t1tYpajPw@mail.gmail.com>
References: <1504021023-12459-1-git-send-email-yamada.masahiro@socionext.com> <20170914212655.GD11836@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from conssluserg-03.nifty.com ([210.131.2.82]:19524 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbdJIMQo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Oct 2017 08:16:44 -0400
In-Reply-To: <20170914212655.GD11836@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Rafael,


2017-09-15 6:26 GMT+09:00 Viresh Kumar <viresh.kumar@linaro.org>:
> On 30-08-17, 00:37, Masahiro Yamada wrote:
>> As you see arch/arm/boot/dts/uniphier-ld6b.dtsi, it includes
>> uniphier-pxs2.dtsi, which uses "operating-points-v2" property
>> and whose cpufreq device is automatically created.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
>> index a020da7940d6..c344fc1c4eb8 100644
>> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
>> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
>> @@ -83,8 +83,6 @@ static const struct of_device_id whitelist[] __initconst = {
>>       { .compatible = "rockchip,rk3368", },
>>       { .compatible = "rockchip,rk3399", },
>>
>> -     { .compatible = "socionext,uniphier-ld6b", },
>> -
>>       { .compatible = "st-ericsson,u8500", },
>>       { .compatible = "st-ericsson,u8540", },
>>       { .compatible = "st-ericsson,u9500", },
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>


Viresh issued Ack.

Could you apply this for v4.15?  (or perhaps v4.14?)



-- 
Best Regards
Masahiro Yamada
