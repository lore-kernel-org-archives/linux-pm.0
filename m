From: Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH 2/2] cpufreq: dt: add support for rockchip rv1108
Date: Thu, 14 Sep 2017 08:52:42 +0800
Message-ID: <00893ba9-5d67-fd08-6a5a-945fd4fb6583@rock-chips.com>
References: <1503306404-28876-1-git-send-email-andy.yan@rock-chips.com>
 <1503306624-28937-1-git-send-email-andy.yan@rock-chips.com>
 <20170913191840.GB11836@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.132]:41764 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbdINAw7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Sep 2017 20:52:59 -0400
In-Reply-To: <20170913191840.GB11836@ubuntu>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, heiko@sntech.de

Hi Viresh:


On 2017年09月14日 03:18, Viresh Kumar wrote:
> On 21-08-17, 17:10, Andy Yan wrote:
>> Add the compatible string to support the generic device tree
>> cpufreq-dt driver on rockchip rv1108 soc.
>>
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>> ---
>>
>>   drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
>> index 1c26292..2d71c09 100644
>> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
>> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
>> @@ -69,6 +69,7 @@ static const struct of_device_id machines[] __initconst = {
>>   	{ .compatible = "renesas,r8a7794", },
>>   	{ .compatible = "renesas,sh73a0", },
>>   
>> +	{ .compatible = "rockchip,rv1108", },
>>   	{ .compatible = "rockchip,rk2928", },
>>   	{ .compatible = "rockchip,rk3036", },
>>   	{ .compatible = "rockchip,rk3066a", },
> You use operating-points-v2 or the V1 bindings for this SoC? The SoCs using
> operating-points-v2 don't need such changes anymore.

     Yes, I use operating-points-v2.
>
