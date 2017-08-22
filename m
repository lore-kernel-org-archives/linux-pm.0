From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal/drivers/hisi: Remove confusing error message
Date: Tue, 22 Aug 2017 10:25:07 +0200
Message-ID: <12e90c78-d8dc-5184-17aa-281cd0ad5417@linaro.org>
References: <1499439833-32531-1-git-send-email-daniel.lezcano@linaro.org>
 <1502178956.4296.7.camel@intel.com>
 <46604862-fbb8-8ed1-8b0d-7a51543b3398@linaro.org>
 <1502196531.4296.41.camel@intel.com>
 <20170808132955.GB32732@leoy-ThinkPad-T440>
 <8f58bd6d-0561-7383-6be4-04ee3704099a@linaro.org>
 <20170822080427.GB13910@leoy-ThinkPad-T440>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:36840 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932077AbdHVIZL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Aug 2017 04:25:11 -0400
Received: by mail-wr0-f180.google.com with SMTP id f8so82359434wrf.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Aug 2017 01:25:10 -0700 (PDT)
In-Reply-To: <20170822080427.GB13910@leoy-ThinkPad-T440>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, edubezval@gmail.com, "open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, kong.kongxinwei@hisilicon.com

On 22/08/2017 10:04, Leo Yan wrote:
> Hi Daniel,
> 
> On Mon, Aug 21, 2017 at 12:06:17PM +0200, Daniel Lezcano wrote:
> 
> [...]
> 
>> Hi Leo,
>>
>> a cleanest solution would be either:
>>
>>  - add the 3 missing thermal sensors in the DT and default to the id 2
> 
> Yeah, so do you think below change works for you?

Isn't it possible to set the delay also ? so we don't have to send
another patch if we want to use one of those instead of 2.


> ---8<---
> 
>     ARM64: dts: hisilicon: add missed thermal sensors for Hi6220
> 
>     The thermal driver tries to register four sensors but the DT only binds
>     one sensor (sensor ID 2) with thermal zone, as result the thermal driver
>     reports failure for missed thermal sensor binding.
> 
>     This patch adds missed thermal sensor for Hi6220, so can dismiss the
>     booting failure log.
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index eacbe0d..44c2bc7 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -833,6 +833,18 @@
>  
>                 thermal-zones {
>  
> +                       local: local {
> +                               polling-delay = <0>;
> +                               polling-delay-passive = <0>;
> +                               thermal-sensors = <&tsensor 0>;
> +                       };
> +
> +                       cls1: cls1 {
> +                               polling-delay = <0>;
> +                               polling-delay-passive = <0>;
> +                               thermal-sensors = <&tsensor 1>;
> +                       };
> +
>                         cls0: cls0 {
>                                 polling-delay = <1000>;
>                                 polling-delay-passive = <100>;
> @@ -862,6 +874,12 @@
>                                         };
>                                 };
>                         };
> +
> +                       gpu: gpu {
> +                               polling-delay = <0>;
> +                               polling-delay-passive = <0>;
> +                               thermal-sensors = <&tsensor 3>;
> +                       };
>                 };
>  
> 
>> or
>>
>>  - remove all the code assuming 4 sensors and deal with the one unique
>> sensor
> 
> I personally prefer to avoid doing this, if only register one unique
> sensor this will let us have no flexiblity for trying multiple sensors
> on this platform.

Ok, I will on the other side give a cleanup in the driver to optimize
the sensors lookup.

Thanks
  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
