From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 08/10] ARM64: dts: meson: Remove "cooling-{min|max}-level"
 for gpio-fan node
Date: Fri, 9 Feb 2018 10:04:04 +0100
Message-ID: <3237154b-18a9-9e8b-1e5f-a7ce261fe3ae@baylibre.com>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <24b53440922491982c781a3eb032b04c167d733d.1518166039.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35228 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbeBIJEH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Feb 2018 04:04:07 -0500
Received: by mail-wr0-f194.google.com with SMTP id w50so7438969wrc.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Feb 2018 01:04:06 -0800 (PST)
In-Reply-To: <24b53440922491982c781a3eb032b04c167d733d.1518166039.git.viresh.kumar@linaro.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-amlogic@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org

On 09/02/2018 09:58, Viresh Kumar wrote:
> The "cooling-min-level" and "cooling-max-level" properties are not
> parsed by any part of the kernel currently and the max cooling state of
> gpio-fan cooling device is found by referring to the
> "gpio-fan,speed-map" instead.
> 
> Remove the unused properties from the gpio-fan node.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> index 658215c9822c..8ee4a693c438 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> @@ -59,8 +59,6 @@
>  				      1 1
>  				      2 2
>  				      3 3>;
> -		cooling-min-level = <0>;
> -		cooling-max-level = <3>;
>  		#cooling-cells = <2>;
>  	};
>  
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
