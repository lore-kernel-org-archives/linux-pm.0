From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v4 2/7] dt-bindings: Introduce interconnect provider
 bindings
Date: Sun, 18 Mar 2018 15:50:29 -0700
Message-ID: <20180318225029.GQ5626@tuxbook-pro>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-3-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180309210958.16672-3-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, davidai@quicinc.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri 09 Mar 13:09 PST 2018, Georgi Djakov wrote:
> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
[..]
> +Required properties:
> +- compatible : contains the interconnect provider vendor specific compatible
> +	       string
> +- reg : register space of the interconnect controller hardware

These properties doesn't relate to the interconnect provider, so there's
no need to describe them here.

> +
> +Examples:
> +
> +		snoc: snoc@580000 {

These nodes should be described in a qcom/msm8916 binding document.

> +			compatible = "qcom,msm8916-snoc";
> +			reg = <0x580000 0x14000>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>, <&rpmcc RPM_SMD_SNOC_A_CLK>;
> +			status = "okay";
> +		};

Regards,
Bjorn
