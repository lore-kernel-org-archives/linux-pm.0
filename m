From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 2/2] PM / devfreq: exynos-nocp: Remove redundant code to
 reset load_count/total_count
Date: Tue, 20 Sep 2016 18:43:48 +0900
Message-ID: <57E104D4.5070604@samsung.com>
References: <1474361863-2319-1-git-send-email-axel.lin@ingics.com>
 <CGME20160920085825epcas1p1cf03ec303d8cd04b8443e58d12a3f502@epcas1p1.samsung.com>
 <1474361863-2319-2-git-send-email-axel.lin@ingics.com>
 <57E102A4.9050805@samsung.com>
 <CAFRkauDTy2Nnv-wihOVNKaBSHy7H9EiXXKXGHuWfCLQU08xJeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:59737 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752145AbcITJnv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Sep 2016 05:43:51 -0400
In-reply-to: <CAFRkauDTy2Nnv-wihOVNKaBSHy7H9EiXXKXGHuWfCLQU08xJeg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

On 2016년 09월 20일 18:38, Axel Lin wrote:
> 2016-09-20 17:34 GMT+08:00 Chanwoo Choi <cw00.choi@samsung.com>:
>> Hi,
>>
>> On 2016년 09월 20일 17:57, Axel Lin wrote:
>>> This is done by devfreq_event_get_event() so remove the redundant code in
>>> exynos_nocp_get_event().
>>>
>>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>>> ---
>>>  drivers/devfreq/event/exynos-nocp.c | 3 ---
>>>  1 file changed, 3 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
>>> index a584140..49e712a 100644
>>> --- a/drivers/devfreq/event/exynos-nocp.c
>>> +++ b/drivers/devfreq/event/exynos-nocp.c
>>> @@ -176,9 +176,6 @@ static int exynos_nocp_get_event(struct devfreq_event_dev *edev,
>>>       return 0;
>>>
>>>  out:
>>> -     edata->load_count = 0;
>>> -     edata->total_count = 0;
>>> -
>>>       dev_err(nocp->dev, "Failed to read the counter of NoC probe device\n");
>>>
>>>       return ret;
>>>
>>
>> As you said, devfreq_event_get_event() initializes both load_count and total_count
>> before calling edev->desc->ops->get_event(). Looks good to me.
> 
> Actually, the point is if edev->desc->ops->get_event() fails,
> the code in devfreq_event_get_event() will reset
> edata->total_count and edata->load_count to 0.

You're right. devfreq_event_get_event() initializes the data
when before calling edev->desc->ops->get_event() or fail happen.

-- 
Best Regards,
Chanwoo Choi
