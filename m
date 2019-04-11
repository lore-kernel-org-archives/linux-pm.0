Return-Path: <SRS0=4kRr=SN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C801AC10F14
	for <linux-pm@archiver.kernel.org>; Thu, 11 Apr 2019 19:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94102217F4
	for <linux-pm@archiver.kernel.org>; Thu, 11 Apr 2019 19:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BDjeyhYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfDKTOt (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:14:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35991 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDKTOs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Apr 2019 15:14:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so8025434wml.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2019 12:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sjgv+GTqzYYYEeYktG8EM218JZ1lIdpdQ+xHnyDK8sQ=;
        b=BDjeyhYEB9/73Pt/L8UtgjqBXTkhti+6OPdAQGKZu/wUJWX5fuYRSvHxtFPoNYK8G0
         HS3Hgs6n4kBOqjSegpS4EKjAjqsmjRVatypIIwAtMdm4kkB0zmlShvUyFN77ewv3FbBT
         rGqWgQvGoHAkUIIV3WGFY4LAFJTen8glHdNSUJpyOF/wZAlHP0RLOLTf+C85iZuioFkb
         qnGHzlWKh8LYbuDrfNZK7OMUMfVjIrR1YJYu1Aal1znh/y9hKNG10oFNS9raShVu4ZV0
         lBG55psPKyUEDnxFlzjxelogInrLIs4xD0zHwcl07yVQV0szQmwS9hv4HECUY5vv5E5L
         d2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sjgv+GTqzYYYEeYktG8EM218JZ1lIdpdQ+xHnyDK8sQ=;
        b=sNsbqmjtJ+V4vF4PjY41JFGvXnCClP8pIJKZcu0VgH4qUxgEKttCQ+lVMwIbKFW2Gr
         Arv8TIU2gInwSr9ectHeq0GjZZqj+EvbiXF+P4iJuIWPuejR3NBe+ls/85Zey794apR3
         O+1oQW61IVaMNS5k+mU3JYlMXqTgLq8xtCz1uxxhCFnCLVRbm57vVsA2GxZvdwGbvr+v
         c3o/PONLcM6m0tIRsuVZoRWQhb4RipJKpGWqFzS6TaJSBKRVKR7LNuTpW8JxW67h0kPS
         EtPeUFG7NLsVxQwmaUuVsoQr2azNvwj3sGvuW/q2+EM7R/nk3Ik0wD6WV7BKDzJWK962
         Tqig==
X-Gm-Message-State: APjAAAVjaUbhu9LPwsTb1szbIzGENKc6C3UIlbxiK9ls7dBp0e2N3pXR
        dPaUU6sIHmjr0KqR5PV42Z/bRg==
X-Google-Smtp-Source: APXvYqxkQKdnZ0L8z5xBYB7bt/ExshN7qriHIvv/xfy/O8OPzXsc/EKVrJqrllzjmWn2KC1PUo2xjA==
X-Received: by 2002:a1c:5f42:: with SMTP id t63mr7525678wmb.94.1555010086734;
        Thu, 11 Apr 2019 12:14:46 -0700 (PDT)
Received: from [192.168.8.100] (195.118.130.77.rev.sfr.net. [77.130.118.195])
        by smtp.googlemail.com with ESMTPSA id o2sm31400238wrs.89.2019.04.11.12.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 12:14:46 -0700 (PDT)
Subject: Re: [PATCH v5] arm64: dts: ls1088a: add one more thermal zone node
To:     Yuantian Tang <andy.tang@nxp.com>, shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, edubezval@gmail.com
References: <20190411083236.9377-1-andy.tang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <915c86d8-d00e-f1e1-e7f5-24bc225c8e42@linaro.org>
Date:   Thu, 11 Apr 2019 21:14:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411083236.9377-1-andy.tang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190411191444.vrzogUT-3kRBB1ioXR0p5bzoJ7EV7OOuZm38I71Pvwc@z>

On 11/04/2019 10:32, Yuantian Tang wrote:
> Ls1088a has 2 thermal sensors, core cluster and SoC platform. Core cluster
> sensor is used to monitor the temperature of core and SoC platform is for
> platform. The current dts only support the first sensor.
> This patch adds the second sensor node to dts to enable it.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---
> v5:
> 	- update the thermal zone name due to the length limitation
> 	- remove cooling map in platform zone
> v4:
> 	- use hyphen instead of underscore in node name
> v3:
> 	- use more descriptive name for each zone
> v2:
> 	- Add more information about sensors to description
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |   28 ++++++++++++++++++++---
>  1 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index de93b42..de39672 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -129,19 +129,19 @@
>  	};
>  
>  	thermal-zones {
> -		cpu_thermal: cpu-thermal {
> +		core-cluster {
>  			polling-delay-passive = <1000>;
>  			polling-delay = <5000>;
>  			thermal-sensors = <&tmu 0>;
>  
>  			trips {
> -				cpu_alert: cpu-alert {
> +				core_cluster_alert: core-cluster-alert {
>  					temperature = <85000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu_crit: cpu-crit {
> +				core_cluster_crit: core-cluster-crit {
>  					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "critical";
> @@ -150,7 +150,7 @@
>  
>  			cooling-maps {
>  				map0 {
> -					trip = <&cpu_alert>;
> +					trip = <&core_cluster_alert>;
>  					cooling-device =
>  						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>  						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> @@ -163,6 +163,26 @@
>  				};
>  			};
>  		};
> +
> +		platform {
> +			polling-delay-passive = <1000>;
> +			polling-delay = <5000>;
> +			thermal-sensors = <&tmu 1>;
> +
> +			trips {
> +				platform-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				platform-crit {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};


Unfortunately, the documentation says the thermal zone node must contain
a "cooling-maps" entry.

It makes sense as if there is no cooling device, there is no action to
be taken thus polling the temperature just add noise to the system.



>  	};
>  
>  	timer {
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

