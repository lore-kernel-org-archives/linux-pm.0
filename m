From: Bastian Stender <bst@pengutronix.de>
Subject: Re: [PATCH] thermal: imx: remove cooling device
Date: Wed, 15 Nov 2017 10:05:57 +0100
Message-ID: <fc2237a1-d3ad-4922-fed2-4b795cf52f9f@pengutronix.de>
References: <20171114134829.1354-1-bst@pengutronix.de>
 <20171115045626.GF3257@vireshk-i7> <20171115050032.GH3257@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49479 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751189AbdKOJF6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 04:05:58 -0500
In-Reply-To: <20171115050032.GH3257@vireshk-i7>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: shawnguo@kernel.org, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, kernel@pengutronix.de, linux-pm@vger.kernel.org

On 11/15/2017 06:00 AM, Viresh Kumar wrote:
> On 15-11-17, 10:26, Viresh Kumar wrote:
>> + Shawn
>>
>> On 14-11-17, 14:48, Bastian Stender wrote:
>>> The cooling device should not be part of the i.MX thermal code but
>>> rather in the i.MX cpufreq driver. So remove it here.
>>>
>>> Signed-off-by: Bastian Stender <bst@pengutronix.de>
>>
>> Shouldn't the two patches you sent be part of a series? What if one gets applied
>> before the other? For example if the cpufreq patch gets applied before this one,
>> then the kernel would break somewhere as two drivers would be adding the
>> cpu-cooling device :)
> 
> Actually, we may really want to have a single patch for this. So I would suggest
> that we merge both the patches.

Okay, I will send a merged v2.

Regards,
Bastian

-- 
Pengutronix e.K.
Industrial Linux Solutions
http://www.pengutronix.de/
Peiner Str. 6-8, 31137 Hildesheim, Germany
Amtsgericht Hildesheim, HRA 2686
