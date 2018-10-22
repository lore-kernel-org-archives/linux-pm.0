From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC PATCH v2 09/17] ARM: dts: tegra20: harmony: Setup voltage
 regulators for DVFS
Date: Mon, 22 Oct 2018 09:33:23 -0600
Message-ID: <a1b4cd27-858c-de53-8ae2-b1aee689475f@wwwdotorg.org>
References: <20181021205501.23943-1-digetx@gmail.com>
 <20181021205501.23943-10-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021205501.23943-10-digetx@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/21/18 2:54 PM, Dmitry Osipenko wrote:
> Set min/max regulators voltage and add CPU node that hooks up CPU with
> voltage regulators.

> diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts

> -				sm0 {
> +				core_vdd_reg: sm0 {
>   					regulator-name = "vdd_sm0,vdd_core";
> -					regulator-min-microvolt = <1200000>;
> -					regulator-max-microvolt = <1200000>;
> +					regulator-min-microvolt = <1000000>;
> +					regulator-max-microvolt = <1300000>;
> +					regulator-coupled-with = <&rtc_vdd_reg>;
> +					regulator-coupled-max-spread = <150000>;
>   					regulator-always-on;
>   				};

How do you know for sure that these increased ranges are safe (high end) 
and stable (low end) for this particular board? IIRC the safe/legal 
range depends on the chip SKU, and to be honest I have no idea which SKU 
is present on Harmony... For public boards like Colibri I imagine 
there's enough information out there to tell what will work, but maybe 
not our internal boards like Harmony, unless you checked our ancient 
downstream kernels?
