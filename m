From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v1] PM / devfreq: exynos-ppmu : Handle return value of
 clk_prepare_enable
Date: Wed, 24 May 2017 10:54:44 +0900
Message-ID: <5924E7E4.5020900@samsung.com>
References: <592403E7.8060906@samsung.com>
        <1495191364-16015-1-git-send-email-arvind.yadav.cs@gmail.com>
        <CGME20170519105745epcas5p29a5cbb259cd15138d7220f34e130e00a@epcms1p3>
        <20170524013036epcms1p3f5ced11e6ebe5664ce70718dedcf8de1@epcms1p3>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:58331 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbdEXByr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2017 21:54:47 -0400
In-reply-to: <20170524013036epcms1p3f5ced11e6ebe5664ce70718dedcf8de1@epcms1p3>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, Arvind Yadav <arvind.yadav.cs@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, "krzk@kernel.org" <krzk@kernel.org>, "kgene@kernel.org" <kgene@kernel.org>, "javier@osg.samsung.com" <javier@osg.samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 2017년 05월 24일 10:30, MyungJoo Ham wrote:
>> On 2017년 05월 19일 19:56, Arvind Yadav wrote:
>>> clk_prepare_enable() can fail here and we must check its return value.
>>>
>>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>>> ---
>>>  drivers/devfreq/event/exynos-ppmu.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
>>> index 9b73509..8f6537a 100644
>>> --- a/drivers/devfreq/event/exynos-ppmu.c
>>> +++ b/drivers/devfreq/event/exynos-ppmu.c
>>> @@ -648,7 +648,11 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
>>>  			dev_name(&pdev->dev), desc[i].name);
>>>  	}
>>>  
>>> -	clk_prepare_enable(info->ppmu.clk);
>>> +	ret = clk_prepare_enable(info->ppmu.clk);
>>> +	if (ret) {
>>> +		dev_err(&pdev->dev, "failed to prepare ppmu clock\n");
>>> +		return ret;
>>> +	}
>>
>> You're right. But, actually, some ppmu device-tree node doesn't include
>> the clock information because exynos clk driver don't support the
>> clock for some ppmu devices. Until now, the clock of ppmu devices
>> are default on state.
> 
> If it does not include the clock information, info->ppmu.clk is NULL,
> which makes ret == NULL, so this should be ok.
> (Line 593 of this file does that.)

Ah.. You're right. I'm missing this point.

Looks good to me.
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
