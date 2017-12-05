From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal/drivers/hisi: disable multi alarm support for
 hi3660 SoC
Date: Tue, 5 Dec 2017 07:57:24 +0100
Message-ID: <74aafbca-f08b-0a27-5536-e8967bcffeb7@linaro.org>
References: <20171017043941.GE7954@localhost.localdomain>
 <1508318150-108444-1-git-send-email-kevin.wangtao@hisilicon.com>
 <9685721b-4593-029b-b8e8-d721526b7119@linaro.org>
 <6f39a5ed-0db6-4600-19d0-f9e9c5c43b1f@hisilicon.com>
 <20171205020212.GB4949@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40543 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbdLEG51 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Dec 2017 01:57:27 -0500
Received: by mail-wm0-f66.google.com with SMTP id f206so12143406wmf.5
        for <linux-pm@vger.kernel.org>; Mon, 04 Dec 2017 22:57:26 -0800 (PST)
In-Reply-To: <20171205020212.GB4949@localhost.localdomain>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, "Wangtao (Kevin, Kirin)" <kevin.wangtao@hisilicon.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, sunzhaosheng@hisilicon.com, gengyanping@hisilicon.com, Kevin Wangtao <kevin.wangtao@linaro.org>

On 05/12/2017 03:02, Eduardo Valentin wrote:
> Hello,
> 
> On Thu, Oct 19, 2017 at 09:31:24AM +0800, Wangtao (Kevin, Kirin) wrote:
>>
>>
>> 在 2017/10/18 23:54, Daniel Lezcano 写道:
>>> On 18/10/2017 11:15, Tao Wang wrote:
>>>> From: Kevin Wangtao <kevin.wangtao@linaro.org>
>>>>
>>>> multi alarm interrupt forced a re-trigger of power_allocator_throttle
>>>> which changes the PID's actual sampling rate, this isn't optimal for
>>>> IPA, it is best to disable multi alarm support now and sort out this
>>>> issue later.
>>>>
>>>> Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
>>>
>>> Did you test the series with this change?
>> Yes
> 
> Is this patch still valid with the latest linus master?

No, it was folded in the next iteration.

All patches for hisilicon are up-to-date.

Thanks.

 -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
