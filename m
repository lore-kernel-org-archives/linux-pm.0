From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v4 6/8] arm64: dts: add SRAM, MHU mailbox and SCPI
 support on Juno
Date: Wed, 22 Jul 2015 14:28:09 +0100
Message-ID: <20150722132809.GG14923@e106497-lin.cambridge.arm.com>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
 <1433760002-24120-7-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:65312 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756785AbbGVN2M convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 22 Jul 2015 09:28:12 -0400
In-Reply-To: <1433760002-24120-7-git-send-email-sudeep.holla@arm.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>

On Mon, Jun 08, 2015 at 11:40:00AM +0100, Sudeep Holla wrote:
> This patch adds support for the MHU mailbox peripheral used on Juno b=
y
> application processors to communicate with remote SCP handling most o=
f
> the CPU/system power management. It also adds the SRAM reserving the
> shared memory and SCPI message protocol using that shared memory.
>=20
> Cc: Liviu Dudau <Liviu.Dudau@arm.com>
> Cc: Jon Medhurst (Tixy) <tixy@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi   | 31 ++++++++++++++++++++++=
+++++++++
>  arch/arm64/boot/dts/arm/juno-clocks.dtsi | 23 ++++++++++++++++++++++=
+
>  2 files changed, 54 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot=
/dts/arm/juno-base.dtsi
> index e3ee96036eca..f8069a98da25 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -17,6 +17,18 @@
>  		};
>  	};
> =20
> +	mailbox: mhu@2b1f0000 {
> +		compatible =3D "arm,mhu", "arm,primecell";
> +		reg =3D <0x0 0x2b1f0000 0x0 0x1000>;
> +		interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names =3D "mhu_lpri_rx",
> +				  "mhu_hpri_rx";
> +		#mbox-cells =3D <1>;
> +		clocks =3D <&soc_refclk100mhz>;
> +		clock-names =3D "apb_pclk";
> +	};
> +
>  	gic: interrupt-controller@2c010000 {
>  		compatible =3D "arm,gic-400", "arm,cortex-a15-gic";
>  		reg =3D <0x0 0x2c010000 0 0x1000>,
> @@ -44,6 +56,25 @@
>  			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
>  	};
> =20
> +	sram: sram@2e000000 {
> +		compatible =3D "arm,juno-sram-ns", "mmio-sram";
> +		reg =3D <0x0 0x2e000000 0x0 0x8000>;
> +
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		ranges =3D <0 0x0 0x2e000000 0x8000>;
> +
> +		cpu_scp_lpri: scp-shmem@0 {
> +			compatible =3D "arm,juno-scp-shmem";
> +			reg =3D <0x0 0x200>;
> +		};
> +
> +		cpu_scp_hpri: scp-shmem@200 {
> +			compatible =3D "arm,juno-scp-shmem";
> +			reg =3D <0x200 0x200>;
> +		};
> +	};
> +
>  	/include/ "juno-clocks.dtsi"
> =20
>  	dma@7ff00000 {
> diff --git a/arch/arm64/boot/dts/arm/juno-clocks.dtsi b/arch/arm64/bo=
ot/dts/arm/juno-clocks.dtsi
> index 25352ed943e6..64af7370815a 100644
> --- a/arch/arm64/boot/dts/arm/juno-clocks.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-clocks.dtsi
> @@ -42,3 +42,26 @@
>  		clock-frequency =3D <400000000>;
>  		clock-output-names =3D "faxi_clk";
>  	};
> +
> +	scpi {
> +		compatible =3D "arm,scpi";
> +		mboxes =3D <&mailbox 1>;
> +		shmem =3D <&cpu_scp_hpri>;
> +
> +		clocks {
> +			compatible =3D "arm,scpi-clocks";
> +
> +			scpi_dvfs: scpi_clocks@0 {
> +				compatible =3D "arm,scpi-dvfs-clocks";
> +				#clock-cells =3D <1>;
> +				clock-indices =3D <0>, <1>, <2>;
> +				clock-output-names =3D "vbig", "vlittle", "vgpu";
> +			};
> +			scpi_clk: scpi_clocks@3 {
> +				compatible =3D "arm,scpi-variable-clocks";
> +				#clock-cells =3D <1>;
> +				clock-indices =3D <3>, <4>;

Subject to you addressing Mark's comments regarding the indices values =
(maybe choose
a different property to show the fact that the index is actually an SCP=
I index
rather than the clock's), you can add my

Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

Best regards,
Liviu


> +				clock-output-names =3D "pxlclk0", "pxlclk1";
> +			};
> +		};
> +	};
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

