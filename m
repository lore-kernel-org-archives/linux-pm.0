From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2] thermal/drivers/hisi: Switch to interrupt mode
Date: Tue, 10 Oct 2017 19:13:22 +0200
Message-ID: <464262af-206d-b8b8-2971-d894586d7edd@linaro.org>
References: <1bfd974e-3dc1-e99b-d0dd-50102cee762d@ti.com>
 <1506575625-20388-1-git-send-email-daniel.lezcano@linaro.org>
 <4ce2e445-d846-e032-5677-36dcbce7bed4@arm.com>
 <313949ce-e0d6-da66-7809-a963f704f75f@linaro.org>
 <ff47cc88-dc44-60cd-e4bf-1da5ec19e066@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:51341 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755436AbdJJRN0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2017 13:13:26 -0400
Received: by mail-wm0-f42.google.com with SMTP id f4so7347349wme.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2017 10:13:25 -0700 (PDT)
In-Reply-To: <ff47cc88-dc44-60cd-e4bf-1da5ec19e066@arm.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Valentin Schneider <valentin.schneider@arm.com>, linux-pm@vger.kernel.org, ionela.voinescu@arm.com, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>

On 10/10/2017 19:01, Valentin Schneider wrote:
> On 10/10/2017 05:51 PM, Daniel Lezcano wrote:
>> Ok, so apparently there are multiple alarms level in the driver for the
>> hikey960 [1]. So I prefer to drop this patch for now and take the
>> hikey960 thermal support first and we can sort out the issue later.
>>
>> For my information, can you show me the DT snippet you have for the
>> thermal zones?
> 
> Sure thing:
> 
>     thermal-zones {
> 
>             cls0: cls0 {
>                 polling-delay = <1000>;
>                 polling-delay-passive = <100>;
>                 sustainable-power = <4500>;
> 
>                 /* sensor ID */
>                 thermal-sensors = <&tsensor 1>;
> 
>                 trips {
>                     threshold: trip-point@0 {
>                         temperature = <65000>;
>                         hysteresis = <1000>;
>                         type = "passive";
>                     };
> 
>                     target: trip-point@1 {
>                         temperature = <75000>;
>                         hysteresis = <1000>;
>                         type = "passive";
>                     };
>                 };

That's strange, regarding your traces:

"
[  118.107357] hisi_thermal fff30000.tsensor: THERMAL ALARM: 70495 > 65000
[  119.182531] hisi_thermal fff30000.tsensor: THERMAL ALARM: 76235 > 65000
[  119.361964] hisi_thermal fff30000.tsensor: THERMAL ALARM: 70495 > 65000
[  119.907865] hisi_thermal fff30000.tsensor: THERMAL ALARM: 75620 > 65000
[  119.959076] hisi_thermal fff30000.tsensor: THERMAL ALARM: 70700 > 65000
"

I was expecting to see more trip points. Did you test the driver with a
70000 trip point?


[ ... ]


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
