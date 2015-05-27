From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 1/5] Documentation: add DT binding for ARM System Control
 and Power Interface(SCPI) protocol
Date: Wed, 27 May 2015 15:52:37 +0100
Message-ID: <5565DA35.8030902@arm.com>
References: <1432720398-5701-1-git-send-email-sudeep.holla@arm.com> <1432720398-5701-2-git-send-email-sudeep.holla@arm.com> <20150527133700.GK8439@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150527133700.GK8439@leverpostej>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, "Jon Medhurst (Tixy)" <tixy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Mark,

Thanks for the review.

On 27/05/15 14:37, Mark Rutland wrote:
> On Wed, May 27, 2015 at 10:53:14AM +0100, Sudeep Holla wrote:
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
>>   Documentation/devicetree/bindings/arm/arm,scpi.txt | 121 +++++++++++++++++++++
>>   1 file changed, 121 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/arm,scpi.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Documentation/devicetree/bindings/arm/arm,scpi.txt
>> new file mode 100644
>> index 000000000000..5db235f69e54
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
>> @@ -0,0 +1,121 @@
>> +System Control and Power Interface (SCPI) Message Protocol
>> +----------------------------------------------------------
>
> Could we refer to the documentation for SCPI similarly to what we do
> in the PSCI binding (i.e. give the document number and title so people
> can search for it)?
>

Yes that's the plan but was waiting for a stable URL(currently it's not
in ARM Infocenter and simple google search for document/title doesn't
seem to work). For now I will include the URL too and may be remove or
fix it in future.

>> +
>> +Required properties:
>> +
>> +- compatible : should be "arm,scpi"
>> +- mboxes: List of phandle and mailbox channel specifiers
>
> How many, in which order, and what are they used for?
>

Ok will update.

>> +- shmem : List of phandle pointing to the shared memory(SHM) area between the
>> +	  processors using these mailboxes for IPC, one for each mailbox
>
> When you say "shared memory", what exactly are we referring to? It looks
> like we refer to SRAM areas?
>

It can be any memory reserved for the purpose of this communication via
MHU between the Application Processors and the remote System Control
Processor. On most platforms with MHU it happens to be SRAM like in Juno
and Fijitsu MB86S7X

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
>> +Required properties:
>> +- compatible : shall be one of the following:
>
> Nit: s/be/include/
>
>> +	"arm,scpi-clocks" - for the container node with all the clocks
>> +		based on the SCPI protocol
>
> Please separate this from the description of its sub-nodes (e.g. have a
> sub-nodes heading under "arm,scpi-clocks").
>

OK, I will update.

> Is there any reason to have this container if we're only going to place
> the two clock controllers described below within it? Can't we just place
> them directly under the SCPI node?
>

SCP also supports power domains, sensors and other misc features. I
wanted to avoid parsing through all the nodes in the clock driver once
they are added. Is that not recommended ?

>> +	"arm,scpi-dvfs" - all the clocks that are variable and index based.
>> +		These clocks don't provide the full range between the limits
>> +		but only discrete points within the range. The firmware
>> +		provides the mapping for each such operating frequency and the
>> +		index associated with it. The firmware also manages the
>> +		voltage scaling appropriately with the clock scaling.
>
> Could this be "arm,scpi-dvfs-clocks"?
>
>> +	"arm,scpi-clk" - all the clocks that are variable and provide full
>> +		range within the specified range. The firmware provides the
>> +		supported range for each clock.
>
> Likewise "arm,scpi-variable-clocks"?
>
> Using "arm,scpi-clk" makes it sound like there's a single clock output.
>
>> +
>> +Required properties for all clocks(all from common clock binding):
>> +- #clock-cells : should be set to 1 as each of the SCPI clocks have multiple
>> +	outputs. The clock specifier will be the index to an entry in the list
>> +	of output clocks.
>> +- clock-output-names : shall be the corresponding names of the outputs.
>> +- clock-indices: The identifyng number for the clocks(clock_id) in the node as
>> +	expected by the firmware. It can be non linear and hence provide the
>> +	mapping	of identifiers into the clock-output-names array.
>> +
>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +
>> +Example:
>> +
>> +sram: sram@50000000 {
>> +	compatible = "arm,juno-sram-ns", "mmio-sram";
>
> Nit: undocumented compatible string.
>
>> +	reg = <0x0 0x50000000 0x0 0x10000>;
>> +
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +	ranges = <0 0x0 0x50000000 0x10000>;
>> +
>> +	cpu_scp_lpri: scp-shmem@0 {
>> +		compatible = "arm,juno-scp-shmem";
>
> Nit: undocumented compatible string.
>

Will fix all the above compatible strings and add missing document.

[...]

>> +cpu@0 {
>> +	...
>> +	reg = <0 0>;
>> +	clocks = <&scpi_dvfs 0>;
>> +	clock-names = "big";
>
> This isn't documented anywhere, and I can't see any code in this series
> using it. The Juno dts doesn't seem to have CPU clocks, and nothing in
> this series adds them -- have I missed a series?
>

No, you didn't miss anything, I didn't post the DTS changes to avoid
churn when the binding is still under discussion, will post in the next
version.

> Also, I'm not keen on using software-defined names (e.g. "big") for CPU
> clocks, as it doesn't stictly relate to the hardware. That said, the set
> of clocks, their names, and how they related to CPUs is
> implementation-specific, which is somewhat painful. I'm not sure how
> we cater for that with generic software.
>

Sorry for the confusion, it should be "vbig" in the above example. These
names are derived from the SCPI document and yes it may vary with platforms.

Regards,
Sudeep
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
