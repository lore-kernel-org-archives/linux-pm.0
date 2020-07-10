Return-Path: <SRS0=akx2=AV=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F71C433E1
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jul 2020 08:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3970207BC
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jul 2020 08:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgGJIev (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:34:51 -0400
Received: from foss.arm.com ([217.140.110.172]:59648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbgGJIeu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Jul 2020 04:34:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0CDB31B;
        Fri, 10 Jul 2020 01:34:49 -0700 (PDT)
Received: from [10.37.12.58] (unknown [10.37.12.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA9263F9AB;
        Fri, 10 Jul 2020 01:34:46 -0700 (PDT)
Subject: Re: [PATCH 1/2] memory: samsung: exynos5422-dmc: Adjust polling
 interval and uptreshold
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     willy.mh.wolff.ml@gmail.com, k.konieczny@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        s.nawrocki@samsung.com, kgene@kernel.org
References: <20200708153420.29484-1-lukasz.luba@arm.com>
 <CGME20200708153448epcas1p438fae2327ac69fcc1a78d9c73cfda501@epcas1p4.samsung.com>
 <20200708153420.29484-2-lukasz.luba@arm.com>
 <fa3f651a-3c2b-188b-e2dc-4fd05ce4a1b7@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <a676fc18-6f1f-8502-e8d5-5ad1ccf0eec6@arm.com>
Date:   Fri, 10 Jul 2020 09:34:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <fa3f651a-3c2b-188b-e2dc-4fd05ce4a1b7@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 7/9/20 5:08 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 7/9/20 12:34 AM, Lukasz Luba wrote:
>> In order to react faster and make better decisions under some workloads,
>> benchmarking the memory subsystem behavior, adjust the polling interval
>> and upthreshold value used by the simple_ondemand governor.
>>
>> Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/memory/samsung/exynos5422-dmc.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
>> index 93e9c2429c0d..e03ee35f0ab5 100644
>> --- a/drivers/memory/samsung/exynos5422-dmc.c
>> +++ b/drivers/memory/samsung/exynos5422-dmc.c
>> @@ -1466,10 +1466,10 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
>>   		 * Setup default thresholds for the devfreq governor.
>>   		 * The values are chosen based on experiments.
>>   		 */
>> -		dmc->gov_data.upthreshold = 30;
>> +		dmc->gov_data.upthreshold = 10;
>>   		dmc->gov_data.downdifferential = 5;
>>   
>> -		exynos5_dmc_df_profile.polling_ms = 500;
>> +		exynos5_dmc_df_profile.polling_ms = 100;
>>   	}
>>   
>>   
>>
> 
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> 

Thank you for the review. Do you think this patch could go through
your tree together with your patches?

I don't know Krzysztof's opinion about the patch 2/2, but
I would expect, assuming the patch itself is correct, he would
like to take it into his next/dt branch.

Regards,
Lukasz
