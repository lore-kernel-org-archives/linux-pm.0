From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2] thermal/drivers/hisi: Switch to interrupt mode
Date: Tue, 5 Dec 2017 07:49:45 +0100
Message-ID: <e86982ed-aa3f-118d-0c57-25b0ec905b4d@linaro.org>
References: <1bfd974e-3dc1-e99b-d0dd-50102cee762d@ti.com>
 <1506575625-20388-1-git-send-email-daniel.lezcano@linaro.org>
 <20170928065752.GA31697@leoy-linaro> <20170928073220.GF2196@mai>
 <20171205020031.GA4949@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35884 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751325AbdLEGts (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Dec 2017 01:49:48 -0500
Received: by mail-wm0-f43.google.com with SMTP id b76so18410466wmg.1
        for <linux-pm@vger.kernel.org>; Mon, 04 Dec 2017 22:49:47 -0800 (PST)
In-Reply-To: <20171205020031.GA4949@localhost.localdomain>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Leo Yan <leo.yan@linaro.org>, rui.zhang@intel.com, jean.wangtao@linaro.org, Keerthy <j-keerthy@ti.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On 05/12/2017 03:00, Eduardo Valentin wrote:
> Hello,
> 
> On Thu, Sep 28, 2017 at 09:32:20AM +0200, Daniel Lezcano wrote:
>> On Thu, Sep 28, 2017 at 02:57:52PM +0800, Leo Yan wrote:
>>> Hi Daniel,
>>>
>>> On Thu, Sep 28, 2017 at 07:13:44AM +0200, Daniel Lezcano wrote:
>>>> At this moment, we have both the interrupt setup and the polling enabled. The
>>>> interrupt does nothing more than forcing an update while the temperature is
>>>> polled every second.
>>>>
>>>> We can do much better than that, threshold is set to 65C in the DT and the
>>>> passive cooling device enters in the dance when 75C is reached. We need to
>>>> sample the temperature at 65C in order to let the IPA gather enough values for
>>>> the PID computation. If the SoC is running at a temperature below 65C, we will
>>>> be constantly polling for nothing.
>>>>
>>>> This patch disables the sensor when the temperature is below 65C and enables it
>>>> when passing the threshold. It results the thermal sensor driver will have no
>>>> activity most of the time.
>>>>
>>>> Cc: Keerthy <j-keerthy@ti.com>
>>>> Cc: Leo Yang <leo.yan@linaro.org>
>>>
>>> s/Yang/Yan :) Have tested this patch on Hikey at my side:
>>
>> Oops sorry :)
>>
>>> Reviewed-by: Leo Yan <leo.yan@linaro.org>
>>> Tested-by: Leo Yan <leo.yan@linaro.org>
>>
> 
> Is this still needed after the latest rework done?

No longer needed.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
