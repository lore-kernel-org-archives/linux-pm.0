From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v2 1/2] PM / devfreq: exynos-nocp: Select REGMAP_MMIO
Date: Fri, 30 Sep 2016 22:46:04 +0900
Message-ID: <CAJ0PZbRCBeqbixQikCbc1F_AwGRHsCWEnh7MTYP3=zZ2LWEZBA@mail.gmail.com>
References: <1474805638-30407-1-git-send-email-axel.lin@ingics.com> <9785239.FWYofzirS3@vostro.rjw.lan>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:32924 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751645AbcI3NqV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Sep 2016 09:46:21 -0400
In-Reply-To: <9785239.FWYofzirS3@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Axel Lin <axel.lin@ingics.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>

On Thu, Sep 29, 2016 at 9:29 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Sunday, September 25, 2016 08:13:57 PM Axel Lin wrote:
>> This driver uses devm_regmap_init_mmio(), so select REGMAP_MMIO to avoid
>> build failure.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>> v2: fix typo in commit log and also add Chanwoo's Ack.
>> This one is a build fix, I think it should be for v4.8.
>>  drivers/devfreq/event/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/devfreq/event/Kconfig b/drivers/devfreq/event/Kconfig
>> index 0fdae86..cd94980 100644
>> --- a/drivers/devfreq/event/Kconfig
>> +++ b/drivers/devfreq/event/Kconfig
>> @@ -17,6 +17,7 @@ config DEVFREQ_EVENT_EXYNOS_NOCP
>>       tristate "EXYNOS NoC (Network On Chip) Probe DEVFREQ event Driver"
>>       depends on ARCH_EXYNOS || COMPILE_TEST
>>       select PM_OPP
>> +     select REGMAP_MMIO
>>       help
>>         This add the devfreq-event driver for Exynos SoC. It provides NoC
>>         (Network on Chip) Probe counters to measure the bandwidth of AXI bus.
>>
>
> MyungJoo, I can apply this one and the [2/2] directly.  Should I do that?
>
> Thanks,
> Rafael


Yes, sure. Those two fixes look good. Thanks.




Cheers,
MyungJoo

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
MyungJoo Ham, Ph.D.
Frontier CS Lab, S/W Center, Samsung Electronics
