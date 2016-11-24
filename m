From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/6] PM / devfreq: Fix the checkpatch warnings
Date: Fri, 25 Nov 2016 08:37:40 +0900
Message-ID: <583779C4.9070707@samsung.com>
References: <1479963668-22845-1-git-send-email-cw00.choi@samsung.com>
 <1479963668-22845-2-git-send-email-cw00.choi@samsung.com>
 <CGME20161124102049epcas4p3312e9a6cc4cb33b16dc1984922025c44@epcas4p3.samsung.com>
 <1479982838.19726.3.camel@perches.com> <5836C4F9.2010509@samsung.com>
 <1479984758.19726.7.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:42765 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbcKXXhm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Nov 2016 18:37:42 -0500
In-reply-to: <1479984758.19726.7.camel@perches.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rjw@rjwysocki.net, chanwoo@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 2016년 11월 24일 19:52, Joe Perches wrote:
> On Thu, 2016-11-24 at 19:46 +0900, Chanwoo Choi wrote:
>> On 2016년 11월 24일 19:20, Joe Perches wrote:
>>> On Thu, 2016-11-24 at 14:01 +0900, Chanwoo Choi wrote:
>>>> This patch just fixes the checkpatch warnings.
>>>
>>> unrelated trivia:
>>>
>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> []
>>>> @@ -576,11 +575,13 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>  		goto err_out;
>>>>  	}
>>>>  
>>>> -	devfreq->trans_table =	devm_kzalloc(&devfreq->dev, sizeof(unsigned int) *
>>>> +	devfreq->trans_table =	devm_kzalloc(&devfreq->dev,
>>>> +						sizeof(unsigned int) *
>>>>  						devfreq->profile->max_state *
>>>>  						devfreq->profile->max_state,
>>>>  						GFP_KERNEL);
>>>> -	devfreq->time_in_state = devm_kzalloc(&devfreq->dev, sizeof(unsigned long) *
>>>> +	devfreq->time_in_state = devm_kzalloc(&devfreq->dev,
>>>> +						sizeof(unsigned long) *
>>>>  						devfreq->profile->max_state,
>>>>  						GFP_KERNEL);
>>>
>>> Maybe these should be devm_kcalloc calls
>>
>> Why should devfreq use the devm_kcalloc?
> 
> Because these are allocating zeroed arrays of a specific size.

kzalloc is already set to zero.

[1]https://www.kernel.org/doc/htmldocs/kernel-api/API-kzalloc.html

