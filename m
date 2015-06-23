From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/8] ARM: STi: STiH407: Provide a node for CPUFreq
Date: Tue, 23 Jun 2015 07:46:22 +0530
Message-ID: <20150623021622.GA16776@linux>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-5-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434987837-24212-5-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, rob.herring-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ajitpal.singh-qxv4g6HH51o@public.gmane.org
List-Id: linux-pm@vger.kernel.org

[Ccing Rob]

On 22-06-15, 16:43, Lee Jones wrote:
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  arch/arm/boot/dts/stih407-family.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index f48767e..f57fd83 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -98,6 +98,11 @@
>  		ranges;
>  		compatible = "simple-bus";
>  
> +		cpufreq {
> +			compatible = "st,stih407-cpufreq";
> +			st,syscfg = <&syscfg_core 0x8e0>;
> +		};

These virtual nodes aren't allowed in DT and you have added them
before the bindings patch :).

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
