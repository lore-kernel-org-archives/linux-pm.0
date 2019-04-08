From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: Add Qualcomm QCS404 DT
 bindings
Date: Mon, 8 Apr 2019 15:38:17 -0700
Message-ID: <20190408223817.GS1843@tuxbook-pro>
References: <20190405035446.31886-1-georgi.djakov@linaro.org>
 <20190405035446.31886-2-georgi.djakov@linaro.org>
 <20190405143254.GM1843@tuxbook-pro>
 <9ee2c9b2-f201-abfb-be60-180befa9dc6d@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9ee2c9b2-f201-abfb-be60-180befa9dc6d@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: robh+dt@kernel.org, vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri 05 Apr 08:46 PDT 2019, Georgi Djakov wrote:

> Hi Bjorn,
> 
> On 4/5/19 21:32, Bjorn Andersson wrote:
> > On Fri 05 Apr 10:54 +07 2019, Georgi Djakov wrote:
> > 
> >> The Qualcomm QCS404 platform has several buses that could be controlled
> >> and tuned according to the bandwidth demand.
> >>
> >> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> >> ---
> >>  .../bindings/interconnect/qcom,qcs404.txt     | 45 +++++++++++++++++++
> >>  1 file changed, 45 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> >> new file mode 100644
> >> index 000000000000..2ea63ea827d7
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> >> @@ -0,0 +1,45 @@
> >> +Qualcomm QCS404 Network-On-Chip interconnect driver binding
> >> +-----------------------------------------------------------
> >> +
> >> +Required properties :
> >> +- compatible : shall contain only one of the following:
> >> +			"qcom,qcs404-bimc"
> > 
> > As this is a hardware block available in mmio register space I think you
> > better represent this on the mmio (soc) bus - and then represent the
> > link to rpm as a child node of the rpm.
> 
> The mmio register space is not used for expressing bandwidth needs, but
> contains mostly QoS related stuff. We do not support QoS for now and
> that's why i haven't included it. When we decide to support QoS, we can
> add the nodes for the QoS registers and then reference them with some DT
> property like qcom,qos = <&bimc_qos>;
> 

The fact that QoS support is not implemented today is an implementation
detail, it does not relate to how we're describing the hardware in
DeviceTree. Adding three new nodes under soc{} and referencing these
(and potentially duplicating the clocks properties in the two sets of
nodes?) in the future, rather than just describing the hardware
appropriately today seems odd to me.

Further more, as I shared a while back the aggregation code related to
the RPM would better be shared between 404, 410, 820 and 835. So to me
it makes sense to even on the implementation side split this is NoC part
and RPM part, from the beginning.

Regards,
Bjorn

> Thanks,
> Georgi
> 
> > 
> > Apart from that this looks good.
> > 
> > Regards,
> > Bjorn
> > 
> >> +			"qcom,qcs404-pcnoc"
> >> +			"qcom,qcs404-snoc"
> >> +- #interconnect-cells : should contain 1
> >> +
> >> +Optional properties :
> >> +clocks : list of phandles and specifiers to all interconnect bus clocks
> >> +clock-names : clock names should include both "bus_clk" and "bus_a_clk"
> >> +
> >> +Example:
> >> +
> >> +rpm-glink {
> >> +	...
> >> +	rpm_requests: glink-channel {
> >> +		...
> >> +		bimc: interconnect@0 {
> >> +			compatible = "qcom,qcs404-bimc";
> >> +			#interconnect-cells = <1>;
> >> +			clock-names = "bus_clk", "bus_a_clk";
> >> +			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> >> +				<&rpmcc RPM_SMD_BIMC_A_CLK>;
> >> +		};
> >> +
> >> +		pnoc: interconnect@1 {
> >> +			compatible = "qcom,qcs404-pcnoc";
> >> +			#interconnect-cells = <1>;
> >> +			clock-names = "bus_clk", "bus_a_clk";
> >> +			clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
> >> +				<&rpmcc RPM_SMD_PNOC_A_CLK>;
> >> +		};
> >> +
> >> +		snoc: interconnect@2 {
> >> +			compatible = "qcom,qcs404-snoc";
> >> +			#interconnect-cells = <1>;
> >> +			clock-names = "bus_clk", "bus_a_clk";
> >> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> >> +				<&rpmcc RPM_SMD_SNOC_A_CLK>;
> >> +		};
> >> +	};
> >> +};
