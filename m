Return-Path: <SRS0=CzTI=6M=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2D0C83002
	for <linux-pm@archiver.kernel.org>; Tue, 28 Apr 2020 02:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33B64206E2
	for <linux-pm@archiver.kernel.org>; Tue, 28 Apr 2020 02:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgD1Cm1 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 27 Apr 2020 22:42:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47574 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726264AbgD1Cm1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Apr 2020 22:42:27 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 57B99998573B9A9E1C82;
        Tue, 28 Apr 2020 10:42:25 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.93) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Apr 2020
 10:42:22 +0800
Subject: Re: [RFC PATCH] cpuidle: Make cpuidle governor switchable to be the
 default behaviour
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <linux-pm@vger.kernel.org>
References: <1587982637-33618-1-git-send-email-guohanjun@huawei.com>
 <06ff344e-7abf-9eb6-9664-0e9f9d8d6bc7@linaro.org>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <7f503d07-8b55-e080-adf7-f8cc70c48d75@huawei.com>
Date:   Tue, 28 Apr 2020 10:42:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <06ff344e-7abf-9eb6-9664-0e9f9d8d6bc7@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.213.93]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020/4/27 21:36, Daniel Lezcano wrote:
> On 27/04/2020 12:17, Hanjun Guo wrote:
>> For now cpuidle governor can be switched via sysfs only when the
>> boot option "cpuidle_sysfs_switch" is passed, but it's important
>> to switch the governor to adapt to different workloads, especially
>> after TEO and haltpoll governor were introduced.
>>
>> Introduce a CONFIG option to make cpuidle governor switchable to be
>> the default behaviour, which will not break the boot option behaviour.
>>
>> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
>> ---
>>   drivers/cpuidle/Kconfig | 9 +++++++++
>>   drivers/cpuidle/sysfs.c | 2 +-
>>   2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
>> index c0aeedd..c40cb40 100644
>> --- a/drivers/cpuidle/Kconfig
>> +++ b/drivers/cpuidle/Kconfig
>> @@ -47,6 +47,15 @@ config CPU_IDLE_GOV_HALTPOLL
>>   config DT_IDLE_STATES
>>   	bool
>>   
>> +config CPU_IDLE_SWITCH_GOV_IN_DEFAULT
>> +	bool "Switch the CPU idle governor via sysfs at runtime in default behaviour"
>> +	help
>> +	  Make the CPU idle governor switchable at runtime, and make it as the
>> +	  default behaviour even the boot option "cpuidle_sysfs_switch" is not
>> +	  passed in cmdline.
>> +
>> +	  Say N if you unsure about this.
> 
> Well I wouldn't make this optional but just remove the sysfs_switch.

That's my first solution but I send this RFC patch as it's less
aggressive :), I'm happy to get your comments to remove the
sysfs_switch, I will prepare patches for this solution.

> 
> However, there is the '_ro' suffix when the option is not set. In order
> to not break the existing tools, may be let both files co-exist and add
> in the ABI/obselete the '_ro' file as candidate for removal ?

Agreed.

Thanks
Hanjun

