From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v6 07/11] arm: dts: msm8974: Add thermal zones, tsens and
 qfprom nodes
Date: Fri, 1 Jul 2016 18:19:35 -0700
Message-ID: <20160702011933.GA9035@localhost.localdomain>
References: <1462438309-11196-1-git-send-email-rnayak@codeaurora.org>
 <1462438309-11196-8-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1462438309-11196-8-git-send-email-rnayak@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, punit.agrawal@arm.com, sboyd@codeaurora.org, lina.iyer@linaro.org, nrajan@codeaurora.org, Andy Gross <agross@codeaurora.org>, andy.gross@linaro.org, rui.zhang@intel.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, May 05, 2016 at 02:21:45PM +0530, Rajendra Nayak wrote:
> Add thermal zones, tsens and qfprom nodes
> 
> Cc: Andy Gross <agross@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 103 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index 8193139..3a7a63b 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -126,6 +126,88 @@
>  		};
>  	};
>  
> +	thermal-zones {
> +		cpu-thermal0 {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 5>;
> +
> +			trips {
> +				cpu_alert0: trip@0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};

You have passive trip points, but not cooling devices.

The  cooling-maps property is mandatory, as you can see
in the documentation
(Documentation/devicetree/bindings/thermal/thermal.txt)

Please add it, for all your zones.

> +				cpu_crit0: trip@1 {
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu-thermal1 {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 6>;
> +
> +			trips {
> +				cpu_alert1: trip@0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				cpu_crit1: trip@1 {
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu-thermal2 {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 7>;
> +
> +			trips {
> +				cpu_alert2: trip@0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				cpu_crit2: trip@1 {
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu-thermal3 {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 8>;
> +
> +			trips {
> +				cpu_alert3: trip@0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				cpu_crit3: trip@1 {
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +
>  	cpu-pmu {
>  		compatible = "qcom,krait-pmu";
>  		interrupts = <1 7 0xf04>;
> @@ -249,6 +331,27 @@
>  			reg = <0xf9011000 0x1000>;
>  		};
>  
> +		qfprom: qfprom@fc4bc000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "qcom,qfprom";
> +			reg = <0xfc4bc000 0x1000>;
> +			tsens_calib: calib@d0 {
> +				reg = <0xd0 0x18>;
> +			};
> +			tsens_backup: backup@440 {
> +				reg = <0x440 0x10>;
> +			};
> +		};
> +
> +		tsens: thermal-sensor@fc4a8000 {
> +			compatible = "qcom,msm8974-tsens";
> +			reg = <0xfc4a8000 0x2000>;
> +			nvmem-cells = <&tsens_calib>, <&tsens_backup>;
> +			nvmem-cell-names = "calib", "calib_backup";
> +			#thermal-sensor-cells = <1>;
> +		};
> +
>  		timer@f9020000 {
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
