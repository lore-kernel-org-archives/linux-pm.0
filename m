Return-Path: <SRS0=YTwn=65=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D7AC433DF
	for <linux-pm@archiver.kernel.org>; Fri, 15 May 2020 01:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3CC0206B6
	for <linux-pm@archiver.kernel.org>; Fri, 15 May 2020 01:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgEOB2g (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 14 May 2020 21:28:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4842 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbgEOB2g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 May 2020 21:28:36 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0515F29578E8C6EBAE43;
        Fri, 15 May 2020 09:28:33 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.101) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 15 May 2020
 09:28:23 +0800
Subject: Re: [RFC PATCH 1/3] cpufreq: fix the return value in
 'cpufreq_boost_set_sw()'
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <viresh.kumar@linaro.org>, <Souvik.Chakravarty@arm.com>,
        <Thanu.Rangarajan@arm.com>, <Sudeep.Holla@arm.com>,
        <guohanjun@huawei.com>, <john.garry@huawei.com>,
        <jonathan.cameron@huawei.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1588929064-30270-1-git-send-email-wangxiongfeng2@huawei.com>
 <1588929064-30270-2-git-send-email-wangxiongfeng2@huawei.com>
 <28914151.3vfbF0e6KZ@kreacher>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <881629ba-17fb-114c-858f-43b62e32b421@huawei.com>
Date:   Fri, 15 May 2020 09:28:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <28914151.3vfbF0e6KZ@kreacher>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.101]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

Thanks for your reply !

On 2020/5/14 21:54, Rafael J. Wysocki wrote:
> On Friday, May 8, 2020 11:11:02 AM CEST Xiongfeng Wang wrote:
>> When I try to add SW BOOST support for CPPC, I got the following error:
>> cpufreq: cpufreq_boost_trigger_state: Cannot enable BOOST
>> cpufreq: store_boost: Cannot enable BOOST!
>>
>> It is because return value 1 of 'freq_qos_update_request()' means the
>> effective constraint value has changed, not a error code on failures.
>> But for 'cpufreq_driver.set_boost()', a nonzero return value means
>> failure. So change 'ret' to zero when 'freq_qos_update_request()'
>> returns a positive value.
>>
>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>> ---
>>  drivers/cpufreq/cpufreq.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 4adac3a..475fb1b 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -2522,6 +2522,8 @@ static int cpufreq_boost_set_sw(int state)
>>  		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
>>  		if (ret < 0)
>>  			break;
>> +		else
>> +			ret = 0;
>>  	}
>>  
>>  	return ret;
>>
> 
> I would change cpufreq_boost_trigger_state() to take the 1 into account properly
> instead.

Thanks for your suggestion. I will change it in the next version.

Thanks,
Xiongfeng

> 
> Thanks!
> 
> 
> 
> 
> .
> 

