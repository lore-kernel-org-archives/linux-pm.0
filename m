From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH 2/9] cpufreq: qcom: Re-organise kryo cpufreq to use
 it for other nvmem based qcom socs
Date: Sat, 06 Apr 2019 01:07:23 -0500
Message-ID: <5ca8421e.1c69fb81.42211.e57b@mx.google.com>
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
 <20190404050931.9812-3-niklas.cassel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190404050931.9812-3-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Niklas Cassel <niklas.cassel@linaro.org>
Cc: Ilia Lin <ilia.lin@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org, Sricharan R <sricharan@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 04, 2019 at 07:09:23AM +0200, Niklas Cassel wrote:
> From: Sricharan R <sricharan@codeaurora.org>
> 
> The kryo cpufreq driver reads the nvmem cell and uses that data to
> populate the opps. There are other qcom cpufreq socs like krait which
> does similar thing. Except for the interpretation of the read data,
> rest of the driver is same for both the cases. So pull the common things
> out for reuse.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  ...ryo-cpufreq.txt => qcom-nvmem-cpufreq.txt} |  16 +--

Please make DT bindings a separate patch.

>  drivers/cpufreq/Kconfig.arm                   |   4 +-
>  drivers/cpufreq/Makefile                      |   2 +-
>  ...om-cpufreq-kryo.c => qcom-cpufreq-nvmem.c} | 124 +++++++++++-------
>  4 files changed, 85 insertions(+), 61 deletions(-)
>  rename Documentation/devicetree/bindings/opp/{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt} (97%)
>  rename drivers/cpufreq/{qcom-cpufreq-kryo.c => qcom-cpufreq-nvmem.c} (69%)
> 
> diff --git a/Documentation/devicetree/bindings/opp/kryo-cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> similarity index 97%
> rename from Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
> rename to Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> index c2127b96805a..f4a7123730c3 100644
> --- a/Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
> +++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> @@ -1,13 +1,13 @@
> -Qualcomm Technologies, Inc. KRYO CPUFreq and OPP bindings
> +Qualcomm Technologies, Inc. NVMEM CPUFreq and OPP bindings
>  ===================================
>  
> -In Certain Qualcomm Technologies, Inc. SoCs like apq8096 and msm8996
> -that have KRYO processors, the CPU ferequencies subset and voltage value
> -of each OPP varies based on the silicon variant in use.
> +In Certain Qualcomm Technologies, Inc. SoCs like apq8096 and msm8996,
> +the CPU frequencies subset and voltage value of each OPP varies based on
> +the silicon variant in use.
>  Qualcomm Technologies, Inc. Process Voltage Scaling Tables
>  defines the voltage and frequency value based on the msm-id in SMEM
>  and speedbin blown in the efuse combination.
> -The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
> +The qcom-cpufreq-nvmem driver reads the msm-id and efuse value from the SoC
>  to provide the OPP framework with required information (existing HW bitmap).
>  This is used to determine the voltage and frequency value for each OPP of
>  operating-points-v2 table when it is parsed by the OPP framework.
> @@ -19,7 +19,7 @@ In 'cpus' nodes:
>  
>  In 'operating-points-v2' table:
>  - compatible: Should be
> -	- 'operating-points-v2-kryo-cpu' for apq8096 and msm8996.
> +	- 'operating-points-v2-qcom-cpu' for apq8096 and msm8996.

You can't just change this. In any case, it's just a string. Use it even 
if it applies to more than just kryo cpus.

>  - nvmem-cells: A phandle pointing to a nvmem-cells node representing the
>  		efuse registers that has information about the
>  		speedbin that is used to select the right frequency/voltage
> @@ -127,7 +127,7 @@ Example 1:
>  	};
>  
>  	cluster0_opp: opp_table0 {
> -		compatible = "operating-points-v2-kryo-cpu";
> +		compatible = "operating-points-v2-qcom-cpu";
>  		nvmem-cells = <&speedbin_efuse>;
>  		opp-shared;
>  
> @@ -338,7 +338,7 @@ Example 1:
>  	};
>  
>  	cluster1_opp: opp_table1 {
> -		compatible = "operating-points-v2-kryo-cpu";
> +		compatible = "operating-points-v2-qcom-cpu";
>  		nvmem-cells = <&speedbin_efuse>;
>  		opp-shared;
>  
