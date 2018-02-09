From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 06/10] ARM64: dts: meson: Remove "cooling-{min|max}-level"
 for CPU nodes
Date: Fri, 9 Feb 2018 10:03:57 +0100
Message-ID: <303e6c56-8076-e590-c778-81cb8c0181ed@baylibre.com>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <6c91ebfecf86da98a7682c6d262ff1218a1d7343.1518166039.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42139 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbeBIJEA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Feb 2018 04:04:00 -0500
Received: by mail-wr0-f195.google.com with SMTP id 41so7415794wrc.9
        for <linux-pm@vger.kernel.org>; Fri, 09 Feb 2018 01:04:00 -0800 (PST)
In-Reply-To: <6c91ebfecf86da98a7682c6d262ff1218a1d7343.1518166039.git.viresh.kumar@linaro.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-amlogic@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org

On 09/02/2018 09:58, Viresh Kumar wrote:
> The "cooling-min-level" and "cooling-max-level" properties are not
> parsed by any part of the kernel currently and the max cooling state of
> a CPU cooling device is found by referring to the cpufreq table instead.
> 
> Remove the unused properties from the CPU nodes.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> index 1448c3dba08e..658215c9822c 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> @@ -209,14 +209,10 @@
>  };
>  
>  &cpu0 {
> -	cooling-min-level = <0>;
> -	cooling-max-level = <6>;
>  	#cooling-cells = <2>;
>  };
>  
>  &cpu4 {
> -	cooling-min-level = <0>;
> -	cooling-max-level = <4>;
>  	#cooling-cells = <2>;
>  };
>  
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
