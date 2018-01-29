From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: introduce RPMH RSC bindings for
 Qualcomm SoCs
Date: Mon, 29 Jan 2018 13:33:44 -0600
Message-ID: <20180129193344.iovcnka27hmap2l4@rob-hp-laptop>
References: <20180119000157.7380-1-ilina@codeaurora.org>
 <20180119000157.7380-3-ilina@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:39488 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbeA2Tdq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jan 2018 14:33:46 -0500
Content-Disposition: inline
In-Reply-To: <20180119000157.7380-3-ilina@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org, sboyd@codeaurora.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

On Thu, Jan 18, 2018 at 05:01:55PM -0700, Lina Iyer wrote:
> Add device binding documentation for Qualcomm Technology Inc's RPMH RSC
> driver. The hardware block is used for communicating resource state
> requests for shared resources.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  .../devicetree/bindings/arm/msm/rpmh-rsc.txt       | 134 +++++++++++++++++++++

bindings/mailbox instead?

>  1 file changed, 134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/rpmh-rsc.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/msm/rpmh-rsc.txt b/Documentation/devicetree/bindings/arm/msm/rpmh-rsc.txt
> new file mode 100644
> index 000000000000..b0cd55caf916
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/rpmh-rsc.txt
> @@ -0,0 +1,134 @@
> +RPMH RSC:
> +------------
> +
> +RPMH is the mechanism for communicating with the hardened resource
> +accelerators. Requests to the resources can be written to the TCS mailbox
> +registers and using a (addr, val) pair and triggered. Messages in the TCS are
> +then sent in sequence over an internal bus.
> +
> +The hardware block (Direct Resource Voter or DRV) is a part of the h/w entity
> +(Resource State Coordinator a.k.a RSC) that can handle a multiple sleep and
> +active/wake resource requests. Multiple such DRVs can exist in a SoC and can
> +be written to from Linux. The structure of each DRV follows the same template
> +with a few variations that are captured by the properties here.
> +
> +Each DRV could have 'm' TCS instances. Each TCS could have 'n' slots. Each
> +slot has a header (u32), address (u32), data (u32), status (u32) and a
> +read-response (u32). A TCS when triggered will send all the enabled commands
> +of the 'n' commands in that slot in sequence.
> +
> +A TCS may be triggered from Linux or triggered by the F/W after all the CPUs
> +have powered off to faciliate idle power saving. TCS could be classified as -
> +
> +	SLEEP,  /* Triggered by F/W */
> +	WAKE,   /* Triggered by F/W */
> +	ACTIVE, /* Triggered by Linux */
> +	CONTROL /* Triggered by F/W */
> +
> +The order in which they are described in the DT, should match the hardware
> +configuration.
> +
> +Requests can be made for the state of a resource, when the subsystem is active
> +or idle. When all subsystems like Modem, GPU, CPU are idle, the resource state
> +will be an aggregeate of the sleep votes from each of those subsystem. Drivers
> +may request a sleep value for their shared resources in addition to the active
> +mode requests.
> +
> +Control requests are instance specific requests that may or may not reach an
> +accelerator. Only one platform device in Linux can request a control channel
> +on a DRV.
> +
> +CONTROLLER:
> +----------
> +
> +PROPERTIES:
> +
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: Should be "qcom,rpmh-rsc".
> +
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: the first element specifies the base address of the DRV,
> +	            the second element specifies the size of the region.
> +
> +- interrupts:
> +	Usage: required
> +	Value type: <prop-encoded-interrupt>
> +	Definition: the interrupt that trips when a message complete/response
> +	           is received for this DRV from the accelertors.
> +
> +- qcom,drv-id:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: the id of the DRV in the RSC block.
> +
> +- qcom, tcs-config:
          ^
space

> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: the tuple definining the configuration of TCS.
> +	            Must have 2 cells which describe each TCS type.
> +	            <type number_of_tcs>
> +	- Cell #1 (TCS Type): TCS types can be specified -
> +		SLEEP_TCS
> +		WAKE_TCS
> +		ACTIVE_TCS
> +		CONTROL_TCS

These defines belong in this patch.

> +	- Cell #2 (Number of TCS): <u32>

Is there some sort of range of numbers?

> +
> +- label:
> +	Usage: optional
> +	Value type: <string>
> +	Definition: Name for the RSC. The name would be used in trace logs.
> +
> +Clients the want to use the RSC to communicate with RPMH would specify their

Clients the want?

> +bindings as child of the corresponding RSC controllers.

Need to be specific here about what the child nodes are.

> +
> +EXAMPLE 1:
> +
> +For a TCS whose RSC base address is is 0x179C0000 and is at a DRV of 2, the
> +register offsets for DRV2 start at 0D00, the register calculations are like
> +this -
> +First tuple: 0x179C0000 + 0x10000 * 2 = 0x179E0000
> +Second tuple: 0x179E0000 + 0xD00  = 0x179E0D00
> +
> +	apps_rsc: rsc@179e000 {
> +		compatible = "qcom,rpmh-rsc";
> +		label = "apps_rsc";
> +		reg = <0x179e0000 0x10000>, <0x179e0d00 0x3000>;
> +		interrupts = <0 5 0>;
> +		qcom,drv-id = <2>;
> +		qcom,tcs-config = <SLEEP_TCS   3>,
> +				  <WAKE_TCS    3>,
> +				  <ACTIVE_TCS  2>,
> +				  <CONTROL_TCS 1>;
> +
> +		foo-clk {
> +			compatible = "foo-clk";
> +		};
> +	};
> +
> +EXAMPLE 2:
> +
> +For a TCS whose RSC base address is 0xAF20000 and is at DRV of 0, the register
> +offsets for DRV0 start at 01C00, the register calculations are like this -
> +First tuple: 0xAF20000
> +Second tuple: 0xAF20000 + 0x1C00
> +
> +	disp_rsc: rsc@af20000 {
> +		label = "disp_rsc";
> +		compatible = "qcom,rpmh-rsc";
> +		reg = <0xaf20000 0x10000>, <0xaf21c00 0x3000>;
> +		interrupts = <0 129 0>;
> +		qcom,drv-id = <0>;
> +		qcom,tcs-config = <SLEEP_TCS 1>,
> +				<WAKE_TCS    1>,
> +				<ACTIVE_TCS  0>,
> +				<CONTROL_TCS 1>;
> +
> +		foo-clk {
> +			compatible = "foo-clk";
> +		};
> +	};
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
