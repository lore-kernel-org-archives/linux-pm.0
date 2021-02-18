Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29940C433DB
	for <linux-pm@archiver.kernel.org>; Thu, 18 Feb 2021 13:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFEFE64EAE
	for <linux-pm@archiver.kernel.org>; Thu, 18 Feb 2021 13:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhBRNP7 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 18 Feb 2021 08:15:59 -0500
Received: from foss.arm.com ([217.140.110.172]:50966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233189AbhBRM7D (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Feb 2021 07:59:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C85BE1FB;
        Thu, 18 Feb 2021 04:58:11 -0800 (PST)
Received: from [10.57.43.160] (unknown [10.57.43.160])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 203DD3F73B;
        Thu, 18 Feb 2021 04:58:09 -0800 (PST)
Subject: Re: [PATCH v7 1/3] scmi-cpufreq: Remove deferred probe
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        vireshk@kernel.org, cristian.marussi@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        ionela.voinescu@arm.com
References: <20210215075139.30772-1-nicola.mazzucato@arm.com>
 <20210215075139.30772-2-nicola.mazzucato@arm.com>
 <20210218103539.zkxhqxaivhifmjwj@vireshk-i7>
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
Message-ID: <2b8f34cc-5317-f839-5f51-f83c10f571c6@arm.com>
Date:   Thu, 18 Feb 2021 13:01:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20210218103539.zkxhqxaivhifmjwj@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,


On 2/18/21 10:35 AM, Viresh Kumar wrote:
> On 15-02-21, 07:51, Nicola Mazzucato wrote:
>> The current implementation of the scmi_cpufreq_init() function returns
>> -EPROBE_DEFER when the OPP table is not populated. In practice the
>> cpufreq core cannot handle this error code.
>> Therefore, fix the return value and clarify the error message.
>>
>> Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
>> Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
>> ---
>>  drivers/cpufreq/scmi-cpufreq.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
>> index 491a0a24fb1e..34bf2eb8d465 100644
>> --- a/drivers/cpufreq/scmi-cpufreq.c
>> +++ b/drivers/cpufreq/scmi-cpufreq.c
>> @@ -155,9 +155,11 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>  
>>  	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
>>  	if (nr_opp <= 0) {
>> -		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
>> -		ret = -EPROBE_DEFER;
>> -		goto out_free_opp;
> 
> Why change goto label as well ?

oops! thanks for spotting this :)

> 
>> +		dev_err(cpu_dev, "%s: No OPPs for this device: %d\n",
>> +			__func__, ret);
>> +
>> +		ret = -ENODEV;
>> +		goto out_free_priv;
>>  	}
>>  
>>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>> -- 
>> 2.27.0
> 
