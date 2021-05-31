Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB88BC47082
	for <linux-pm@archiver.kernel.org>; Mon, 31 May 2021 05:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8634D61248
	for <linux-pm@archiver.kernel.org>; Mon, 31 May 2021 05:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhEaFpW (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 31 May 2021 01:45:22 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3475 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhEaFpV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 01:45:21 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ftkfd4fnpzYqxK;
        Mon, 31 May 2021 13:40:57 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 13:43:40 +0800
Received: from [10.67.77.175] (10.67.77.175) by dggpeml500023.china.huawei.com
 (7.185.36.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 31 May
 2021 13:43:40 +0800
Subject: Re: [PATCH] cpufreq: stats: Remove redundant initialization of local
 variable
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <1622282079-52196-1-git-send-email-zhangshaokun@hisilicon.com>
 <20210531051643.xvjqb4rog6hmpyjm@vireshk-i7>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <4e0e7a0f-ff3a-f0b6-d1c0-38420c82ac6c@hisilicon.com>
Date:   Mon, 31 May 2021 13:43:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210531051643.xvjqb4rog6hmpyjm@vireshk-i7>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.77.175]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On 2021/5/31 13:16, Viresh Kumar wrote:
> On 29-05-21, 17:54, Shaokun Zhang wrote:
>> Local variable 'count' and 'ret' will be initialized, so remove the
>> redundant initialization.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> ---
>>  drivers/cpufreq/cpufreq_stats.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
>> index da717f7cd9a9..2af6c5b43c43 100644
>> --- a/drivers/cpufreq/cpufreq_stats.c
>> +++ b/drivers/cpufreq/cpufreq_stats.c
>> @@ -211,7 +211,7 @@ void cpufreq_stats_free_table(struct cpufreq_policy *policy)
>>  
>>  void cpufreq_stats_create_table(struct cpufreq_policy *policy)
>>  {
>> -	unsigned int i = 0, count = 0, ret = -ENOMEM;
>> +	unsigned int i = 0, count, ret;
> 
> ret isn't really required at all, can you get rid of it and update the only user
> to something like this ?

Will follow it in next version.

Thanks,
Shaokun

> 
> 	if (!sysfs_create_group(&policy->kobj, &stats_attr_group))
>                 return;
> 
