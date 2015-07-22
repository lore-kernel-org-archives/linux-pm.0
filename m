From: Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 1/8] Documentation: add DT binding for ARM System
 Control and Power Interface(SCPI) protocol
Date: Wed, 22 Jul 2015 09:43:12 +0100
Message-ID: <20150722084312.GB14923@e106497-lin.cambridge.arm.com>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
 <1433760002-24120-2-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1433760002-24120-2-git-send-email-sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Content-Disposition: inline
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, "Jon Medhurst (Tixy)" <tixy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Sudeep,

Minor spelling/phrasing corrections:

On Mon, Jun 08, 2015 at 11:39:55AM +0100, Sudeep Holla wrote:
> This patch adds devicetree binding for System Control and Power
> Interface (SCPI) Message Protocol used between the Application Cores(=
AP)
> and the System Control Processor(SCP). The MHU peripheral provides a
> mechanism for inter-processor communication between SCP's M3 processo=
r
> and AP.
>=20
> SCP offers control and management of the core/cluster power states,
> various power domain DVFS including the core/cluster, certain system
> clocks configuration, thermal sensors and many others.
>=20
> Signed-off-by: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> CC: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
> Cc: Jon Medhurst (Tixy) <tixy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
>  Documentation/devicetree/bindings/arm/arm,scpi.txt | 156 +++++++++++=
++++++++++
>  1 file changed, 156 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,scpi.tx=
t
>=20
> diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Doc=
umentation/devicetree/bindings/arm/arm,scpi.txt
> new file mode 100644
> index 000000000000..f5f9684e23b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
> @@ -0,0 +1,156 @@
> +System Control and Power Interface (SCPI) Message Protocol
> +----------------------------------------------------------
> +
> +Firmware implementing the SCPI described in ARM document number ARM =
DUI 0922B
> +("ARM Compute Subsystem SCP: Message Interface Protocols")[0] can be=
 used
> +by Linux to initiate various system control and power operations.
> +
> +Required properties:
> +
> +- compatible : should be "arm,scpi"
> +- mboxes: List of phandle and mailbox channel specifiers
> +	  All the channels reserved by remote SCP firmware for use by
> +	  SCPI message protocol should be specified in any order
> +- shmem : List of phandle pointing to the shared memory(SHM) area be=
tween the
> +	  processors using these mailboxes for IPC, one for each mailbox
> +	  SHM can be any memory reserved for the purpose of this communicat=
ion
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
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Required properties:
> +- compatible : should be "arm,scpi-clocks"
> +	       All the clocks provided by SCP firmware via SCPI message
> +	       protocol much be listed as sub-nodes under this node.
> +
> +Sub-nodes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Required properties:
> +- compatible : shall include one of the following
> +	"arm,scpi-dvfs-clocks" - all the clocks that are variable and index=
 based.
> +		These clocks don't provide the full range between the limits
=2E.. don't provide an entire range of values between the limits
> +		but only discrete points within the range. The firmware
> +		provides the mapping for each such operating frequency and the
> +		index associated with it. The firmware also manages the
> +		voltage scaling appropriately with the clock scaling.
> +	"arm,scpi-variable-clocks" - all the clocks that are variable and p=
rovide full
> +		range within the specified range. The firmware provides the
		range of values within a specified range. .....
> +		supported range for each clock.
> +
> +Other required properties for all clocks(all from common clock bindi=
ng):
> +- #clock-cells : should be set to 1 as each of the SCPI clocks have =
multiple
> +	outputs. The clock specifier will be the index to an entry in the l=
ist
> +	of output clocks.
> +- clock-output-names : shall be the corresponding names of the outpu=
ts.
> +- clock-indices: The identifyng number for the clocks(clock_id) in t=
he node as

s/identifyng/identifying/=20

> +	expected by the firmware. It can be non linear and hence provide th=
e
> +	mapping	of identifiers into the clock-output-names array.
> +
> +SRAM and Shared Memory for SCPI
> +-------------------------------
> +
> +A small area of SRAM is reserved for SCPI communication between appl=
ication
> +processors and SCP.
> +
> +Required properties:
> +- compatible : should be "arm,juno-sram-ns" for Non-secure SRAM on J=
uno
> +
> +The rest of the properties should follow the generic mmio-sram discr=
iption

s/discription/description/

> +found in ../../misc/sysram.txt
> +
> +Each sub-node represents the reserved area for SCPI.
> +
> +Required sub-node properties:
> +- reg : The base offset and size of the reserved area with the SRAM
> +- compatible : should be "arm,juno-scp-shmem" for Non-secure SRAM ba=
sed
> +	       shared memory on Juno platforms
> +
> +[0] http://community.arm.com/servlet/JiveServlet/download/8401-45-18=
326/DUI0922B_scp_message_interface.pdf
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Example:
> +
> +sram: sram@50000000 {
> +	compatible =3D "arm,juno-sram-ns", "mmio-sram";
> +	reg =3D <0x0 0x50000000 0x0 0x10000>;
> +
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +	ranges =3D <0 0x0 0x50000000 0x10000>;
> +
> +	cpu_scp_lpri: scp-shmem@0 {
> +		compatible =3D "arm,juno-scp-shmem";
> +		reg =3D <0x0 0x200>;
> +	};
> +
> +	cpu_scp_hpri: scp-shmem@200 {
> +		compatible =3D "arm,juno-scp-shmem";
> +		reg =3D <0x200 0x200>;
> +	};
> +};
> +
> +mailbox: mailbox0@40000000 {
> +	....
> +	#mbox-cells =3D <1>;
> +};
> +
> +scpi_protocol: scpi@2e000000 {
> +	compatible =3D "arm,scpi";
> +	mboxes =3D <&mailbox 0 &mailbox 1>;
> +	shmem =3D <&cpu_scp_lpri &cpu_scp_hpri>;
> +
> +	clocks {
> +		compatible =3D "arm,scpi-clocks";
> +
> +		scpi_dvfs: scpi_clocks@0 {
> +			compatible =3D "arm,scpi-dvfs-clocks";
> +			#clock-cells =3D <1>;
> +			clock-indices =3D <0>, <1>, <2>;
> +			clock-output-names =3D "vbig", "vlittle", "vgpu";
> +		};
> +		scpi_clk: scpi_clocks@3 {
> +			compatible =3D "arm,scpi-variable-clocks";
> +			#clock-cells =3D <1>;
> +			clock-indices =3D <3>, <4>;
> +			clock-output-names =3D "pxlclk0", "pxlclk1";
> +		};
> +	};
> +};
> +
> +cpu@0 {
> +	...
> +	reg =3D <0 0>;
> +	clocks =3D <&scpi_dvfs 0>;
> +	clock-names =3D "vbig";
> +};
> +
> +hdlcd@7ff60000 {
> +	...
> +	reg =3D <0 0x7ff60000 0 0x1000>;
> +	clocks =3D <&scpi_clk 1>;
> +	clock-names =3D "pxlclk";
> +};
> +
> +In the above example, the #clock-cells is set to 1 as required.
> +scpi_dvfs has 3 output clocks namely: vbig, vlittle and vgpu with 0,=
 1
> +and 2 as clock-indices. scpi_clk has 2 output clocks namely: pxlclk0=
 and
> +pxlclk1 with 3 and 4 as clock-indices.
> +
> +The first consumer in the example is cpu@0 and it has vbig as input =
clock.
> +The index '0' in the clock specifier here points to the first entry =
in the
> +output clocks of scpi_dvfs for which clock_id asrequired by the firm=
ware

s/asrequired/as required/

> +is 0.
> +
> +Similarly the second example is hdlcd@7ff60000 and it has pxlclk0 as=
 input
> +clock. The index '1' in the clock specifier here points to the secon=
d entry
> +in the output clocks of scpi_clocks for which clock_id as required b=
y the
> +firmware is 4.

This paragraph doesn't match the example. pxlclk0 is index '0'.

Best regards,
Liviu

> --=20
> 1.9.1
>=20

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    =C2=AF\_(=E3=83=84)_/=C2=AF

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
