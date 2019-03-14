From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/4] dt-bindings: opp: Introduce opp-bw-MBs bindings
Date: Thu, 14 Mar 2019 11:53:12 +0530
Message-ID: <20190314062312.vwyu3ryeyc6iv55h@vireshk-i7>
References: <20190313090010.20534-1-georgi.djakov@linaro.org>
 <20190313090010.20534-2-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190313090010.20534-2-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: vireshk@kernel.org, sboyd@kernel.org, nm@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, jcrouse@codeaurora.org, vincent.guittot@linaro.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, sibis@codeaurora.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 13-03-19, 11:00, Georgi Djakov wrote:
> In addition to frequency and voltage, some devices may have bandwidth
> requirements for their interconnect throughput - for example a CPU
> or GPU may also need to increase or decrease their bandwidth to DDR
> memory based on the current operating performance point.
> 
> Extend the OPP tables with additional property to describe the bandwidth
> needs of a device. The average and peak bandwidth values depend on the
> hardware and its properties.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 76b6c79604a5..fa598264615f 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -129,6 +129,9 @@ Optional properties:
>  - opp-microamp-<name>: Named opp-microamp property. Similar to
>    opp-microvolt-<name> property, but for microamp instead.
>  
> +- opp-bw-MBs: The interconnect bandwidth is specified with an array containing
> +  the two integer values for average and peak bandwidth in megabytes per second.
> +
>  - opp-level: A value representing the performance level of the device,
>    expressed as a 32-bit integer.
>  
> @@ -546,3 +549,45 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>:
>  		};
>  	};
>  };
> +
> +Example 7: opp-bw-MBs:
> +(example: average and peak bandwidth values are defined for each OPP and the
> +interconnect between CPU and DDR memory is scaled together with CPU frequency)
> +
> +/ {
> +	cpus {
> +		CPU0: cpu@0 {
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			...
> +			operating-points-v2 = <&cpu_opp_table>;
> +			/* path between the CPU and DDR memory */
> +			interconnects = <&rpm_bimc MASTER_AMPSS_M0
> +					&rpm_bimc SLAVE_EBI_CH0>;

Can we have multiple paths for a device ?

> +		};
> +	};
> +
> +	cpu_opp_table: cpu_opp_table {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-200000000 {
> +			opp-hz = /bits/ 64 <200000000>;
> +			/* 457 MB/s average and 1525 MB/s peak bandwidth */
> +			opp-bw-MBs = <457 1525>;

In that case fixing this to just 2 entries in the array is incorrect
and we should take care of that in the bindings here.

> +		};
> +		opp-400000000 {
> +			opp-hz = /bits/ 64 <400000000>;
> +			/* 915 MB/s average and 3051 MB/s peak bandwidth */
> +			opp-bw-MBs = <915 3051>;
> +		};
> +		opp-800000000 {
> +			opp-hz = /bits/ 64 <800000000>;
> +			/* 1830 MB/s average and 6103 MB/s peak bandwidth */
> +			opp-bw-MBs = <1830 6103>;
> +		};
> +		opp-998400000 {
> +			opp-hz = /bits/ 64 <998400000>;
> +			/* 2282 MB/s average and 7614 MB/s peak bandwidth */
> +			opp-bw-MBs = <2284 7614>;
> +		};
> +	};

-- 
viresh
