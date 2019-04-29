From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: interconnect: Add Qualcomm QCS404 DT
 bindings
Date: Mon, 29 Apr 2019 17:16:56 -0500
Message-ID: <20190429221656.GA1843@bogus>
References: <20190415104357.5305-1-georgi.djakov@linaro.org>
 <20190415104357.5305-2-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190415104357.5305-2-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: bjorn.andersson@linaro.org, vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 15, 2019 at 01:43:54PM +0300, Georgi Djakov wrote:
> The Qualcomm QCS404 platform has several buses that could be controlled
> and tuned according to the bandwidth demand.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> 
> v2:
> - No changes.
> 
>  .../bindings/interconnect/qcom,qcs404.txt     | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> new file mode 100644
> index 000000000000..9befcd14a5b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> @@ -0,0 +1,45 @@
> +Qualcomm QCS404 Network-On-Chip interconnect driver binding
> +-----------------------------------------------------------
> +
> +Required properties :
> +- compatible : shall contain only one of the following:
> +			"qcom,qcs404-bimc"
> +			"qcom,qcs404-pcnoc"
> +			"qcom,qcs404-snoc"
> +- #interconnect-cells : should contain 1
> +
> +Optional properties :
> +clocks : list of phandles and specifiers to all interconnect bus clocks
> +clock-names : clock names should include both "bus_clk" and "bus_a_clk"
> +
> +Example:
> +
> +rpm-glink {
> +	...
> +	rpm_requests: glink-channel {
> +		...
> +		bimc: interconnect@0 {

Unit-address needs a 'reg' property. dtc should give you a warning 
(maybe W=1 is still needed).

> +			compatible = "qcom,qcs404-bimc";
> +			#interconnect-cells = <1>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> +				<&rpmcc RPM_SMD_BIMC_A_CLK>;
> +		};
> +
> +		pnoc: interconnect@1 {
> +			compatible = "qcom,qcs404-pcnoc";
> +			#interconnect-cells = <1>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
> +				<&rpmcc RPM_SMD_PNOC_A_CLK>;
> +		};
> +
> +		snoc: interconnect@2 {
> +			compatible = "qcom,qcs404-snoc";
> +			#interconnect-cells = <1>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> +				<&rpmcc RPM_SMD_SNOC_A_CLK>;
> +		};
> +	};
> +};
