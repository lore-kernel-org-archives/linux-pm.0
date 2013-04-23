From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/2] Thermal: exynos: Add clk_{un}prepare APIs
Date: Tue, 23 Apr 2013 09:08:39 +0530
Message-ID: <CAK9yfHxs1E5aJtkWcS+DHY0J8REv8Mju=7LsYme0xxjzLYGmBg@mail.gmail.com>
References: <1366285079-10395-1-git-send-email-sachin.kamat@linaro.org>
	<5175807C.4090005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:41413 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191Ab3DWDim (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Apr 2013 23:38:42 -0400
Received: by mail-ob0-f173.google.com with SMTP id xn12so147676obc.32
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2013 20:38:39 -0700 (PDT)
In-Reply-To: <5175807C.4090005@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, kgene.kim@samsung.com, patches@linaro.org, Amit Daniel Kachhap <amit.daniel@samsung.com>

On 22 April 2013 23:55, Eduardo Valentin <eduardo.valentin@ti.com> wrote:
> On 18-04-2013 07:37, Sachin Kamat wrote:
>>
>> clk_{un}prepare APIs are required to migrate to common
>> clock framework. While at it convert to use devm_clk_get as
>> it removes some cleanup code.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> ---
>>   drivers/thermal/exynos_thermal.c |   10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/exynos_thermal.c
>> b/drivers/thermal/exynos_thermal.c
>> index e34d842..9df96e5 100644
>> --- a/drivers/thermal/exynos_thermal.c
>> +++ b/drivers/thermal/exynos_thermal.c
>> @@ -937,12 +937,16 @@ static int exynos_tmu_probe(struct platform_device
>> *pdev)
>>                 return ret;
>>         }
>>
>> -       data->clk = clk_get(NULL, "tmu_apbif");
>> +       data->clk = devm_clk_get(&pdev->dev, "tmu_apbif");
>
>
> Here you are also changing the sequence from clk_get(NULL, ...) to
> clk_get(&pdev->dev, ...). Is your platform code ready to match to your
> device node?

Yes. This has been tested on Exynos4 and 5 DT enabled boards (Origen
4210, 4412 and Arndale).

-- 
With warm regards,
Sachin
