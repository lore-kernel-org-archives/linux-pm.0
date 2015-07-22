From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 1/8] Documentation: add DT binding for ARM System Control
 and Power Interface(SCPI) protocol
Date: Wed, 22 Jul 2015 16:56:20 +0100
Message-ID: <55AFBD24.8020903@arm.com>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com> <1433760002-24120-2-git-send-email-sudeep.holla@arm.com> <20150722095501.GA15809@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150722095501.GA15809@leverpostej>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, "Jon Medhurst (Tixy)" <tixy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Mark,

On 22/07/15 10:55, Mark Rutland wrote:
> Hi,
>
> This generally looks fine, but I believe you've misunderstood the usage
> of clock-indices, and I think that your usage of clock-specifiers is
> somewhat confusing.
>

Thanks for the review.

> More on that below.
>
> On Mon, Jun 08, 2015 at 11:39:55AM +0100, Sudeep Holla wrote:
>> This patch adds devicetree binding for System Control and Power
>> Interface (SCPI) Message Protocol used between the Application Cores(AP)
>> and the System Control Processor(SCP). The MHU peripheral provides a
>> mechanism for inter-processor communication between SCP's M3 processor
>> and AP.
>>
>> SCP offers control and management of the core/cluster power states,
>> various power domain DVFS including the core/cluster, certain system
>> clocks configuration, thermal sensors and many others.
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
>> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
>> CC: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Cc: Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
>> Cc: Jon Medhurst (Tixy) <tixy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> ---
>>   Documentation/devicetree/bindings/arm/arm,scpi.txt | 156 +++++++++++++++++++++
>>   1 file changed, 156 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/arm,scpi.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Documentation/devicetree/bindings/arm/arm,scpi.txt
>> new file mode 100644
>> index 000000000000..f5f9684e23b3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
>> @@ -0,0 +1,156 @@
>> +System Control and Power Interface (SCPI) Message Protocol
>> +----------------------------------------------------------
>> +
>> +Firmware implementing the SCPI described in ARM document number ARM DUI 0922B
>> +("ARM Compute Subsystem SCP: Message Interface Protocols")[0] can be used
>> +by Linux to initiate various system control and power operations.
>> +
>> +Required properties:
>> +
>> +- compatible : should be "arm,scpi"
>> +- mboxes: List of phandle and mailbox channel specifiers
>> +	  All the channels reserved by remote SCP firmware for use by
>> +	  SCPI message protocol should be specified in any order
>> +- shmem : List of phandle pointing to the shared memory(SHM) area between the
>> +	  processors using these mailboxes for IPC, one for each mailbox
>> +	  SHM can be any memory reserved for the purpose of this communication
>> +	  between the processors.
>> +
>> +See Documentation/devicetree/bindings/mailbox/mailbox.txt
>> +for more details about the generic mailbox controller and
>> +client driver bindings.
>> +
>> +Clock bindings for the clocks based on SCPI Message Protocol
>> +------------------------------------------------------------
>> +
>> +This binding uses the common clock binding[1].
>> +
>> +Container Node
>> +==============
>> +Required properties:
>> +- compatible : should be "arm,scpi-clocks"
>> +	       All the clocks provided by SCP firmware via SCPI message
>> +	       protocol much be listed as sub-nodes under this node.
>> +
>> +Sub-nodes
>> +=========
>> +Required properties:
>> +- compatible : shall include one of the following
>> +	"arm,scpi-dvfs-clocks" - all the clocks that are variable and index based.
>> +		These clocks don't provide the full range between the limits
>> +		but only discrete points within the range. The firmware
>> +		provides the mapping for each such operating frequency and the
>> +		index associated with it. The firmware also manages the
>> +		voltage scaling appropriately with the clock scaling.
>> +	"arm,scpi-variable-clocks" - all the clocks that are variable and provide full
>> +		range within the specified range. The firmware provides the
>> +		supported range for each clock.
>> +
>> +Other required properties for all clocks(all from common clock binding):
>> +- #clock-cells : should be set to 1 as each of the SCPI clocks have multiple
>> +	outputs. The clock specifier will be the index to an entry in the list
>> +	of output clocks.
>
> Huh? That's somewhat a circular definition.
>
> What does that number correspond to in the HW? If it's just the number
> that the FW expects, that's a reasonable definition.
>

Not exactly. The clock specifier are used by the consumers and they just
indicate the index into the list of clock outputs provided by the clock
provider. The consumers need not know the exact identifier used by the
provider to identify the clock(either via H/W or F/W)

Also since we are using standard definition and method 
(of_clk_src_onecell_get) to decode the clock specifier, it's fine IMO.

>> +- clock-output-names : shall be the corresponding names of the outputs.
>
> This is mandatory? What is it used for?
>

Yes it is used while registering the clocks. I can make it optional and
register the clock name may be using compatible and index. I thought it
would be good to mandate meaning full names.

>> +- clock-indices: The identifyng number for the clocks(clock_id) in the node as
>
> s/identifyng/identifying/
>
>> +	expected by the firmware. It can be non linear and hence provide the
>> +	mapping	of identifiers into the clock-output-names array.
>> +
>> +SRAM and Shared Memory for SCPI
>> +-------------------------------
>> +
>> +A small area of SRAM is reserved for SCPI communication between application
>> +processors and SCP.
>> +
>> +Required properties:
>> +- compatible : should be "arm,juno-sram-ns" for Non-secure SRAM on Juno
>> +
>> +The rest of the properties should follow the generic mmio-sram discription
>> +found in ../../misc/sysram.txt
>> +
>> +Each sub-node represents the reserved area for SCPI.
>> +
>> +Required sub-node properties:
>> +- reg : The base offset and size of the reserved area with the SRAM
>> +- compatible : should be "arm,juno-scp-shmem" for Non-secure SRAM based
>> +	       shared memory on Juno platforms
>> +
>> +[0] http://community.arm.com/servlet/JiveServlet/download/8401-45-18326/DUI0922B_scp_message_interface.pdf
>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +
>> +Example:
>> +
>> +sram: sram@50000000 {
>> +	compatible = "arm,juno-sram-ns", "mmio-sram";
>> +	reg = <0x0 0x50000000 0x0 0x10000>;
>> +
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +	ranges = <0 0x0 0x50000000 0x10000>;
>> +
>> +	cpu_scp_lpri: scp-shmem@0 {
>> +		compatible = "arm,juno-scp-shmem";
>> +		reg = <0x0 0x200>;
>> +	};
>> +
>> +	cpu_scp_hpri: scp-shmem@200 {
>> +		compatible = "arm,juno-scp-shmem";
>> +		reg = <0x200 0x200>;
>> +	};
>> +};
>> +
>> +mailbox: mailbox0@40000000 {
>> +	....
>> +	#mbox-cells = <1>;
>> +};
>> +
>> +scpi_protocol: scpi@2e000000 {
>> +	compatible = "arm,scpi";
>> +	mboxes = <&mailbox 0 &mailbox 1>;
>> +	shmem = <&cpu_scp_lpri &cpu_scp_hpri>;
>> +
>> +	clocks {
>> +		compatible = "arm,scpi-clocks";
>> +
>> +		scpi_dvfs: scpi_clocks@0 {
>> +			compatible = "arm,scpi-dvfs-clocks";
>> +			#clock-cells = <1>;
>> +			clock-indices = <0>, <1>, <2>;
>> +			clock-output-names = "vbig", "vlittle", "vgpu";
>> +		};
>> +		scpi_clk: scpi_clocks@3 {
>> +			compatible = "arm,scpi-variable-clocks";
>> +			#clock-cells = <1>;
>> +			clock-indices = <3>, <4>;
>> +			clock-output-names = "pxlclk0", "pxlclk1";
>> +		};
>> +	};
>> +};
>> +
>> +cpu@0 {
>> +	...
>> +	reg = <0 0>;
>> +	clocks = <&scpi_dvfs 0>;
>> +	clock-names = "vbig";
>> +};
>> +
>> +hdlcd@7ff60000 {
>> +	...
>> +	reg = <0 0x7ff60000 0 0x1000>;
>> +	clocks = <&scpi_clk 1>;
>> +	clock-names = "pxlclk";
>> +};
>> +
>> +In the above example, the #clock-cells is set to 1 as required.
>> +scpi_dvfs has 3 output clocks namely: vbig, vlittle and vgpu with 0, 1
>> +and 2 as clock-indices. scpi_clk has 2 output clocks namely: pxlclk0 and
>> +pxlclk1 with 3 and 4 as clock-indices.
>> +
>> +The first consumer in the example is cpu@0 and it has vbig as input clock.
>> +The index '0' in the clock specifier here points to the first entry in the
>> +output clocks of scpi_dvfs for which clock_id asrequired by the firmware
>> +is 0.
>> +
>> +Similarly the second example is hdlcd@7ff60000 and it has pxlclk0 as input
>> +clock. The index '1' in the clock specifier here points to the second entry
>> +in the output clocks of scpi_clocks for which clock_id as required by the
>> +firmware is 4.
>
> To the best of my knowledge, this is wrong. Per the example in
> Documentation/devicetree/bindings/clock/clock-bindings.txt, the
> clock-indices apply to the logical value in the clock-specifier.
>
> So <&scpi_clk 3>, <&scpi_clk 4> exist, (and are named "pxlclk0",
> "pxlclk1" respectively), but <&scpi_clk 0>, <&scpi_clk 1> do not (or at
> least don't have names).
>

That depends, if your clock provider provides a callback for decoding
clock and does this translation, then they can exist. Since SCPI is
using standard/default callback(of_clk_src_onecell_get), only
<&scpi_clk 0>, <&scpi_clk 1> in above example. For any value >=2,
of_clk_src_onecell_get will bail out as we have only 2 clocks registered
from that provider.

Regards,
Sudeep

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
