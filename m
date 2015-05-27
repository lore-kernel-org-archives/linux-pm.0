From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 1/5] Documentation: add DT binding for ARM System
 Control and Power Interface(SCPI) protocol
Date: Wed, 27 May 2015 14:37:00 +0100
Message-ID: <20150527133700.GK8439@leverpostej>
References: <1432720398-5701-1-git-send-email-sudeep.holla@arm.com>
 <1432720398-5701-2-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52363 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322AbbE0NhJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 27 May 2015 09:37:09 -0400
Content-Disposition: inline
In-Reply-To: <1432720398-5701-2-git-send-email-sudeep.holla@arm.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <Sudeep.Holla@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wed, May 27, 2015 at 10:53:14AM +0100, Sudeep Holla wrote:
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
>  Documentation/devicetree/bindings/arm/arm,scpi.txt | 121 +++++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,scpi.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Documentation/devicetree/bindings/arm/arm,scpi.txt
> new file mode 100644
> index 000000000000..5db235f69e54
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
> @@ -0,0 +1,121 @@
> +System Control and Power Interface (SCPI) Message Protocol
> +----------------------------------------------------------

Could we refer to the documentation for SCPI similarly to what we do
in the PSCI binding (i.e. give the document number and title so people
can search for it)?

> +
> +Required properties:
> +
> +- compatible : should be "arm,scpi"
> +- mboxes: List of phandle and mailbox channel specifiers

How many, in which order, and what are they used for?

> +- shmem : List of phandle pointing to the shared memory(SHM) area between the
> +	  processors using these mailboxes for IPC, one for each mailbox

When you say "shared memory", what exactly are we referring to? It looks
like we refer to SRAM areas?

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
> +Required properties:
> +- compatible : shall be one of the following:

Nit: s/be/include/

> +	"arm,scpi-clocks" - for the container node with all the clocks
> +		based on the SCPI protocol

Please separate this from the description of its sub-nodes (e.g. have a
sub-nodes heading under "arm,scpi-clocks").

Is there any reason to have this container if we're only going to place
the two clock controllers described below within it? Can't we just place
them directly under the SCPI node?

> +	"arm,scpi-dvfs" - all the clocks that are variable and index based.
> +		These clocks don't provide the full range between the limits
> +		but only discrete points within the range. The firmware
> +		provides the mapping for each such operating frequency and the
> +		index associated with it. The firmware also manages the
> +		voltage scaling appropriately with the clock scaling.

Could this be "arm,scpi-dvfs-clocks"?

> +	"arm,scpi-clk" - all the clocks that are variable and provide full
> +		range within the specified range. The firmware provides the
> +		supported range for each clock.

Likewise "arm,scpi-variable-clocks"?

Using "arm,scpi-clk" makes it sound like there's a single clock output.

> +
> +Required properties for all clocks(all from common clock binding):
> +- #clock-cells : should be set to 1 as each of the SCPI clocks have multiple
> +	outputs. The clock specifier will be the index to an entry in the list
> +	of output clocks.
> +- clock-output-names : shall be the corresponding names of the outputs.
> +- clock-indices: The identifyng number for the clocks(clock_id) in the node as
> +	expected by the firmware. It can be non linear and hence provide the
> +	mapping	of identifiers into the clock-output-names array.
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Example:
> +
> +sram: sram@50000000 {
> +	compatible = "arm,juno-sram-ns", "mmio-sram";

Nit: undocumented compatible string.

> +	reg = <0x0 0x50000000 0x0 0x10000>;
> +
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	ranges = <0 0x0 0x50000000 0x10000>;
> +
> +	cpu_scp_lpri: scp-shmem@0 {
> +		compatible = "arm,juno-scp-shmem";

Nit: undocumented compatible string.

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
> +			compatible = "arm,scpi-dvfs";
> +			#clock-cells = <1>;
> +			clock-indices = <0>, <1>, <2>;
> +			clock-output-names = "vbig", "vlittle", "vgpu";
> +		};
> +		scpi_clk: scpi_clocks@3 {
> +			compatible = "arm,scpi-clk";
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
> +	clock-names = "big";

This isn't documented anywhere, and I can't see any code in this series
using it. The Juno dts doesn't seem to have CPU clocks, and nothing in
this series adds them -- have I missed a series?

Also, I'm not keen on using software-defined names (e.g. "big") for CPU
clocks, as it doesn't stictly relate to the hardware. That said, the set
of clocks, their names, and how they related to CPUs is
implementation-specific, which is somewhat painful. I'm not sure how
we cater for that with generic software.

Thanks,
Mark.
