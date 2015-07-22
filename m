From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 1/8] Documentation: add DT binding for ARM System
 Control and Power Interface(SCPI) protocol
Date: Wed, 22 Jul 2015 10:55:01 +0100
Message-ID: <20150722095501.GA15809@leverpostej>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
 <1433760002-24120-2-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35190 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932429AbbGVJzq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 22 Jul 2015 05:55:46 -0400
Content-Disposition: inline
In-Reply-To: <1433760002-24120-2-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi,

This generally looks fine, but I believe you've misunderstood the usage
of clock-indices, and I think that your usage of clock-specifiers is
somewhat confusing.

More on that below.

On Mon, Jun 08, 2015 at 11:39:55AM +0100, Sudeep Holla wrote:
> This patch adds devicetree binding for System Control and Power
> Interface (SCPI) Message Protocol used between the Application Cores(AP)
> and the System Control Processor(SCP). The MHU peripheral provides a
> mechanism for inter-processor communication between SCP's M3 processor
> and AP.
> 
> SCP offers control and management of the core/cluster power states,
> various power domain DVFS including the core/cluster, certain system
> clocks configuration, thermal sensors and many others.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> CC: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Liviu Dudau <Liviu.Dudau@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Jon Medhurst (Tixy) <tixy@linaro.org>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/arm/arm,scpi.txt | 156 +++++++++++++++++++++
>  1 file changed, 156 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,scpi.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Documentation/devicetree/bindings/arm/arm,scpi.txt
> new file mode 100644
> index 000000000000..f5f9684e23b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
> @@ -0,0 +1,156 @@
> +System Control and Power Interface (SCPI) Message Protocol
> +----------------------------------------------------------
> +
> +Firmware implementing the SCPI described in ARM document number ARM DUI 0922B
> +("ARM Compute Subsystem SCP: Message Interface Protocols")[0] can be used
> +by Linux to initiate various system control and power operations.
> +
> +Required properties:
> +
> +- compatible : should be "arm,scpi"
> +- mboxes: List of phandle and mailbox channel specifiers
> +	  All the channels reserved by remote SCP firmware for use by
> +	  SCPI message protocol should be specified in any order
> +- shmem : List of phandle pointing to the shared memory(SHM) area between the
> +	  processors using these mailboxes for IPC, one for each mailbox
> +	  SHM can be any memory reserved for the purpose of this communication
> +	  between the processors.
> +
> +See Documentation/devicetree/bindings/mailbox/mailbox.txt
> +for more details about the generic mailbox controller and
> +client driver bindings.
> +
> +Clock bindings for the clocks based on SCPI Message Protocol
> +------------------------------------------------------------
> +
> +This binding uses the common clock binding[1].
> +
> +Container Node
> +==============
> +Required properties:
> +- compatible : should be "arm,scpi-clocks"
> +	       All the clocks provided by SCP firmware via SCPI message
> +	       protocol much be listed as sub-nodes under this node.
> +
> +Sub-nodes
> +=========
> +Required properties:
> +- compatible : shall include one of the following
> +	"arm,scpi-dvfs-clocks" - all the clocks that are variable and index based.
> +		These clocks don't provide the full range between the limits
> +		but only discrete points within the range. The firmware
> +		provides the mapping for each such operating frequency and the
> +		index associated with it. The firmware also manages the
> +		voltage scaling appropriately with the clock scaling.
> +	"arm,scpi-variable-clocks" - all the clocks that are variable and provide full
> +		range within the specified range. The firmware provides the
> +		supported range for each clock.
> +
> +Other required properties for all clocks(all from common clock binding):
> +- #clock-cells : should be set to 1 as each of the SCPI clocks have multiple
> +	outputs. The clock specifier will be the index to an entry in the list
> +	of output clocks.

Huh? That's somewhat a circular definition.

What does that number correspond to in the HW? If it's just the number
that the FW expects, that's a reasonable definition.

> +- clock-output-names : shall be the corresponding names of the outputs.

This is mandatory? What is it used for?

> +- clock-indices: The identifyng number for the clocks(clock_id) in the node as

s/identifyng/identifying/

> +	expected by the firmware. It can be non linear and hence provide the
> +	mapping	of identifiers into the clock-output-names array.
> +
> +SRAM and Shared Memory for SCPI
> +-------------------------------
> +
> +A small area of SRAM is reserved for SCPI communication between application
> +processors and SCP.
> +
> +Required properties:
> +- compatible : should be "arm,juno-sram-ns" for Non-secure SRAM on Juno
> +
> +The rest of the properties should follow the generic mmio-sram discription
> +found in ../../misc/sysram.txt
> +
> +Each sub-node represents the reserved area for SCPI.
> +
> +Required sub-node properties:
> +- reg : The base offset and size of the reserved area with the SRAM
> +- compatible : should be "arm,juno-scp-shmem" for Non-secure SRAM based
> +	       shared memory on Juno platforms
> +
> +[0] http://community.arm.com/servlet/JiveServlet/download/8401-45-18326/DUI0922B_scp_message_interface.pdf
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Example:
> +
> +sram: sram@50000000 {
> +	compatible = "arm,juno-sram-ns", "mmio-sram";
> +	reg = <0x0 0x50000000 0x0 0x10000>;
> +
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	ranges = <0 0x0 0x50000000 0x10000>;
> +
> +	cpu_scp_lpri: scp-shmem@0 {
> +		compatible = "arm,juno-scp-shmem";
> +		reg = <0x0 0x200>;
> +	};
> +
> +	cpu_scp_hpri: scp-shmem@200 {
> +		compatible = "arm,juno-scp-shmem";
> +		reg = <0x200 0x200>;
> +	};
> +};
> +
> +mailbox: mailbox0@40000000 {
> +	....
> +	#mbox-cells = <1>;
> +};
> +
> +scpi_protocol: scpi@2e000000 {
> +	compatible = "arm,scpi";
> +	mboxes = <&mailbox 0 &mailbox 1>;
> +	shmem = <&cpu_scp_lpri &cpu_scp_hpri>;
> +
> +	clocks {
> +		compatible = "arm,scpi-clocks";
> +
> +		scpi_dvfs: scpi_clocks@0 {
> +			compatible = "arm,scpi-dvfs-clocks";
> +			#clock-cells = <1>;
> +			clock-indices = <0>, <1>, <2>;
> +			clock-output-names = "vbig", "vlittle", "vgpu";
> +		};
> +		scpi_clk: scpi_clocks@3 {
> +			compatible = "arm,scpi-variable-clocks";
> +			#clock-cells = <1>;
> +			clock-indices = <3>, <4>;
> +			clock-output-names = "pxlclk0", "pxlclk1";
> +		};
> +	};
> +};
> +
> +cpu@0 {
> +	...
> +	reg = <0 0>;
> +	clocks = <&scpi_dvfs 0>;
> +	clock-names = "vbig";
> +};
> +
> +hdlcd@7ff60000 {
> +	...
> +	reg = <0 0x7ff60000 0 0x1000>;
> +	clocks = <&scpi_clk 1>;
> +	clock-names = "pxlclk";
> +};
> +
> +In the above example, the #clock-cells is set to 1 as required.
> +scpi_dvfs has 3 output clocks namely: vbig, vlittle and vgpu with 0, 1
> +and 2 as clock-indices. scpi_clk has 2 output clocks namely: pxlclk0 and
> +pxlclk1 with 3 and 4 as clock-indices.
> +
> +The first consumer in the example is cpu@0 and it has vbig as input clock.
> +The index '0' in the clock specifier here points to the first entry in the
> +output clocks of scpi_dvfs for which clock_id asrequired by the firmware
> +is 0.
> +
> +Similarly the second example is hdlcd@7ff60000 and it has pxlclk0 as input
> +clock. The index '1' in the clock specifier here points to the second entry
> +in the output clocks of scpi_clocks for which clock_id as required by the
> +firmware is 4.

To the best of my knowledge, this is wrong. Per the example in
Documentation/devicetree/bindings/clock/clock-bindings.txt, the
clock-indices apply to the logical value in the clock-specifier.

So <&scpi_clk 3>, <&scpi_clk 4> exist, (and are named "pxlclk0",
"pxlclk1" respectively), but <&scpi_clk 0>, <&scpi_clk 1> do not (or at
least don't have names).

Thanks,
Mark.
