From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 07/10] ARM: dts: gemini: Remove "cooling-{min|max}-level"
 for gpio-fan node
Date: Mon, 12 Mar 2018 10:05:33 +0530
Message-ID: <20180312043533.GU6842@vireshk-i7>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <01ddf0ac8962feb63e8871a2c2c3498c763f649b.1518166039.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <01ddf0ac8962feb63e8871a2c2c3498c763f649b.1518166039.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09-02-18, 14:28, Viresh Kumar wrote:
> The "cooling-min-level" and "cooling-max-level" properties are not
> parsed by any part of the kernel currently and the max cooling state of
> gpio-fan cooling device is found by referring to the
> "gpio-fan,speed-map" instead.
> 
> Remove the unused properties from the gpio-fan node.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/boot/dts/gemini-dlink-dns-313.dts | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/gemini-dlink-dns-313.dts b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
> index 08568ce24d06..727d16eb02d9 100644
> --- a/arch/arm/boot/dts/gemini-dlink-dns-313.dts
> +++ b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
> @@ -78,8 +78,6 @@
>  		gpios = <&gpio0 11 GPIO_ACTIVE_HIGH>,
>  			<&gpio0 12 GPIO_ACTIVE_HIGH>;
>  		gpio-fan,speed-map = <0 0>, <3000 1>, <6000 2>;
> -		cooling-min-level = <0>;
> -		cooling-max-level = <2>;
>  		#cooling-cells = <2>;
>  	};
>  

@Linus: Can you please pick this one for 4.17 ?

-- 
viresh
