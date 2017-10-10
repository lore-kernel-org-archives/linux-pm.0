From: Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH V2] thermal/drivers/hisi: Switch to interrupt mode
Date: Tue, 10 Oct 2017 18:01:34 +0100
Message-ID: <ff47cc88-dc44-60cd-e4bf-1da5ec19e066@arm.com>
References: <1bfd974e-3dc1-e99b-d0dd-50102cee762d@ti.com>
 <1506575625-20388-1-git-send-email-daniel.lezcano@linaro.org>
 <4ce2e445-d846-e032-5677-36dcbce7bed4@arm.com>
 <313949ce-e0d6-da66-7809-a963f704f75f@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47654 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755436AbdJJRBg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Oct 2017 13:01:36 -0400
In-Reply-To: <313949ce-e0d6-da66-7809-a963f704f75f@linaro.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, ionela.voinescu@arm.com, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>

On 10/10/2017 05:51 PM, Daniel Lezcano wrote:
> Ok, so apparently there are multiple alarms level in the driver for the
> hikey960 [1]. So I prefer to drop this patch for now and take the
> hikey960 thermal support first and we can sort out the issue later.
>
> For my information, can you show me the DT snippet you have for the
> thermal zones?

Sure thing:

     thermal-zones {

             cls0: cls0 {
                 polling-delay = <1000>;
                 polling-delay-passive = <100>;
                 sustainable-power = <4500>;

                 /* sensor ID */
                 thermal-sensors = <&tsensor 1>;

                 trips {
                     threshold: trip-point@0 {
                         temperature = <65000>;
                         hysteresis = <1000>;
                         type = "passive";
                     };

                     target: trip-point@1 {
                         temperature = <75000>;
                         hysteresis = <1000>;
                         type = "passive";
                     };
                 };

                 cooling-maps {
                     map0 {
                         trip = <&target>;
                         contribution = <1024>;
                         cooling-device = <&cpu0 THERMAL_NO_LIMIT 
THERMAL_NO_LIMIT>;
                     };
                     map1 {
                         trip = <&target>;
                         contribution = <512>;
                         cooling-device = <&cpu4 THERMAL_NO_LIMIT 
THERMAL_NO_LIMIT>;
                     };
                     map2 {
                         trip = <&target>;
                         contribution = <1024>;
                         cooling-device = <&gpu THERMAL_NO_LIMIT 
THERMAL_NO_LIMIT>;
                     };
                 };
             };
         };

It's exactly what is on the Android 4.9 kernel 
(https://android.googlesource.com/kernel/hikey-linaro/+/android-hikey-linaro-4.9/arch/arm64/boot/dts/hisilicon/hi3660.dtsi#1272), 
with the tsensor index changed from 4 to 1 to work with Kevin's patches.

>
>    -- Daniel
>
> [1] https://patchwork.kernel.org/patch/9965743/
>
>
