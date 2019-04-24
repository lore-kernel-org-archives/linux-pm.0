From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: opp: Introduce bandwidth-MBps
 bindings
Date: Wed, 24 Apr 2019 12:16:43 +0530
Message-ID: <e35223d0-80ac-5236-2b8d-7f46cd3a1581@codeaurora.org>
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
 <20190423132823.7915-2-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423132823.7915-2-georgi.djakov@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>, vireshk@kernel.org, sboyd@kernel.org, nm@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net
Cc: jcrouse@codeaurora.org, vincent.guittot@linaro.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, sibis@codeaurora.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 4/23/2019 6:58 PM, Georgi Djakov wrote:
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
>   Documentation/devicetree/bindings/opp/opp.txt | 38 +++++++++++++++++++
>   .../devicetree/bindings/property-units.txt    |  4 ++
>   2 files changed, 42 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 76b6c79604a5..830f0206aea7 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -132,6 +132,9 @@ Optional properties:
>   - opp-level: A value representing the performance level of the device,
>     expressed as a 32-bit integer.
>   
> +- bandwidth-MBps: The interconnect bandwidth is specified with an array containing
> +  the two integer values for average and peak bandwidth in megabytes per second.
> +
>   - clock-latency-ns: Specifies the maximum possible transition latency (in
>     nanoseconds) for switching to this OPP from any other OPP.
>   
> @@ -546,3 +549,38 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>:
>   		};
>   	};
>   };
> +
> +Example 7: bandwidth-MBps:
> +Average and peak bandwidth values for the interconnects between CPU and DDR
> +memory and also between CPU and L3 are defined per each OPP. Bandwidth of both
> +interconnects is scaled together with CPU frequency.
> +
> +/ {
> +	cpus {
> +		CPU0: cpu@0 {
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			...
> +			operating-points-v2 = <&cpu_opp_table>;
> +			/* path between CPU and DDR memory and CPU and L3 */
> +			interconnects = <&noc MASTER_CPU &noc SLAVE_DDR>,
> +					<&noc MASTER_CPU &noc SLAVE_L3>;
> +		};
> +	};
> +
> +	cpu_opp_table: cpu_opp_table {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-200000000 {
> +			opp-hz = /bits/ 64 <200000000>;
> +			/* CPU<->DDR bandwidth: 457 MB/s average, 1525 MB/s peak */
> +			 * CPU<->L3 bandwidth: 914 MB/s average, 3050 MB/s peak */
> +			bandwidth-MBps = <457 1525>, <914 3050>;

Should this also have a bandwidth-MBps-name perhaps? Without that I guess we assume
the order in which we specify the interconnects is the same as the order here?
  
> +		};
> +		opp-400000000 {
> +			opp-hz = /bits/ 64 <400000000>;
> +			/* CPU<->DDR bandwidth: 915 MB/s average, 3051 MB/s peak */
> +			 * CPU<->L3 bandwidth: 1828 MB/s average, 6102 MB/s peak */
> +			bandwidth-MBps = <915 3051>, <1828 6102>;
> +		};
> +	};
> diff --git a/Documentation/devicetree/bindings/property-units.txt b/Documentation/devicetree/bindings/property-units.txt
> index bfd33734faca..9c3dbefcdae8 100644
> --- a/Documentation/devicetree/bindings/property-units.txt
> +++ b/Documentation/devicetree/bindings/property-units.txt
> @@ -41,3 +41,7 @@ Temperature
>   Pressure
>   ----------------------------------------
>   -kpascal	: kiloPascal
> +
> +Throughput
> +----------------------------------------
> +-MBps		: megabytes per second
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
