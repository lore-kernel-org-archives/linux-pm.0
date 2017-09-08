From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2] thermal/drivers/step_wise: Fix temperature regulation
 misbehavior
Date: Fri, 8 Sep 2017 15:59:07 +0200
Message-ID: <535fbdfe-6e6b-84b1-90b8-592aed46c6b2@linaro.org>
References: <20170908030513.GC2755@localhost.localdomain>
 <1504861502-4093-1-git-send-email-daniel.lezcano@linaro.org>
 <2ed0c54f-4e86-308e-92c8-19b8a852286d@ti.com>
 <620ae07f-fd37-d97b-ad0c-5d11a3022084@linaro.org>
 <d2fc01f9-c9d9-4247-2baf-6e544e5ef172@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:38353 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbdIHN7K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Sep 2017 09:59:10 -0400
Received: by mail-wr0-f171.google.com with SMTP id 108so4842349wra.5
        for <linux-pm@vger.kernel.org>; Fri, 08 Sep 2017 06:59:09 -0700 (PDT)
In-Reply-To: <d2fc01f9-c9d9-4247-2baf-6e544e5ef172@ti.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, john.stultz@linaro.org, leo.yan@linaro.org

On 08/09/2017 14:25, Keerthy wrote:
> 
[ ... ]

> This definitely is an issue i have seen on dra7 and if step_wise by
> design can accommodate this change, It will fix the issue!

Ah, ok. I understood you thought we should not do the change and use the
DT crit trip instead.

> Then you should be updating the documentation as well.
> 
> /*
>  * If the temperature is higher than a trip point,
>  *    a. if the trend is THERMAL_TREND_RAISING, use higher cooling
>  *       state for this trip point
>  *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
>  *       state for this trip point
> 
> Now with your patch applied the point b. will change to:
> 
> b. if the trend is THERMAL_TREND_DROPPING, Maintain the same cooling
> level till the temperature drops below trip point.

Ok, I will change accordingly.

Thanks.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
