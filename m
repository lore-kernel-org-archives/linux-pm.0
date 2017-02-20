From: Markus Mayer <code@mmayer.net>
Subject: Re: [PATCH v2] MAINTAINERS: cpufreq: add bmips-cpufreq.c
Date: Sun, 19 Feb 2017 20:10:12 -0800
Message-ID: <CANEuBv43mVEHrYUWBO4f2aHp4HyssHHbkYzo_Tvx4rm6Qt_9ow@mail.gmail.com>
References: <20170217202704.33596-1-code@mmayer.net> <20170220032911.GM21911@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34348 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751851AbdBTEKW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Feb 2017 23:10:22 -0500
Received: by mail-qt0-f196.google.com with SMTP id x35so2004967qtc.1
        for <linux-pm@vger.kernel.org>; Sun, 19 Feb 2017 20:10:14 -0800 (PST)
In-Reply-To: <20170220032911.GM21911@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Markus Mayer <code@mmayer.net>, Ralf Baechle <ralf@linux-mips.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Markus Mayer <mmayer@broadcom.com>, MIPS Linux Kernel List <linux-mips@linux-mips.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 19 February 2017 at 19:29, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 17-02-17, 12:27, Markus Mayer wrote:
>> From: Markus Mayer <mmayer@broadcom.com>
>>
>> Add maintainer information for bmips-cpufreq.c.
>>
>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>
>> This is based on PM's linux-next from today (February 17).
>>
>> This patch could be squashed into patch 3/4 of the original series if that
>> is acceptable (see [1]) or it can remain separate.
>>
>> [1] https://lkml.org/lkml/2017/2/7/775
>>
>> Changes in v2:
>>   - added bcm-kernel-feedback-list@broadcom.com
>>
>>  MAINTAINERS | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 107c10e..d4ac248 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2692,6 +2692,13 @@ F:     drivers/irqchip/irq-brcmstb*
>>  F:   include/linux/bcm963xx_nvram.h
>>  F:   include/linux/bcm963xx_tag.h
>>
>> +BROADCOM BMIPS CPUFREQ DRIVER
>> +M:   Markus Mayer <mmayer@broadcom.com>
>> +M:   bcm-kernel-feedback-list@broadcom.com
>
> Isn't this a list as well? Shouldn't this be L: ?

We used to do that, but then there was a discussion at some point in
the past (I don't have the link handy for it at this point), where it
was suggested that we use M: for the Broadcom list, because it is a
private, closed list (i.e. you can't just go and subscribe). It does
reach a bunch of folks at Broadcom, however, who work on upstreaming.
Therefore, the reasoning was that it fits the "maintainer" category
better than the "list" category (where people might expect to be able
to subscribe or find a public archive).

>> +L:   linux-pm@vger.kernel.org
>> +S:   Maintained
>> +F:   drivers/cpufreq/bmips-cpufreq.c
>> +
>>  BROADCOM TG3 GIGABIT ETHERNET DRIVER
>>  M:   Siva Reddy Kallam <siva.kallam@broadcom.com>
>>  M:   Prashant Sreedharan <prashant@broadcom.com>
>
> --
> viresh
