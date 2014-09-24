From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v6 1/5] qcom: spm: Add Subsystem Power Manager driver
Date: Wed, 24 Sep 2014 11:33:00 -0500
Message-ID: <F743E5F0-28C1-4A9D-A27D-73EA70A01B46@codeaurora.org>
References: <1411516281-58328-1-git-send-email-lina.iyer@linaro.org> <1411516281-58328-2-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1411516281-58328-2-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: sboyd@codeaurora.org, daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@linaro.org, msivasub@codeaurora.org, lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On Sep 23, 2014, at 6:51 PM, Lina Iyer <lina.iyer@linaro.org> wrote:

> Based on work by many authors, available at codeaurora.org
>=20
> SPM is a hardware block that controls the peripheral logic surroundin=
g
> the application cores (cpu/l$). When the core executes WFI instructio=
n,
> the SPM takes over the putting the core in low power state as
> configured. The wake up for the SPM is an interrupt at the GIC, which
> then completes the rest of low power mode sequence and brings the cor=
e
> out of low power mode.
>=20
> The SPM has a set of control registers that configure the SPMs
> individually based on the type of the core and the runtime conditions=
=2E
> SPM is a finite state machine block to which a sequence is provided a=
nd
> it interprets the bytes  and executes them in sequence. Each low powe=
r
> mode that the core can enter into is provided to the SPM as a sequenc=
e.
>=20
> Configure the SPM to set the core (cpu or L2) into its low power mode=
,
> the index of the first command in the sequence is set in the SPM_CTL
> register. When the core executes ARM wfi instruction, it triggers the
> SPM state machine to start executing from that index. The SPM state
> machine waits until the interrupt occurs and starts executing the res=
t
> of the sequence until it hits the end of the sequence. The end of the
> sequence jumps the core out of its low power mode.
>=20
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> [lina: simplify the driver for initial submission, clean up and updat=
e
> commit text]
> ---
> Documentation/devicetree/bindings/arm/msm/spm.txt |  43 +++
> drivers/soc/qcom/Kconfig                          |   8 +
> drivers/soc/qcom/Makefile                         |   1 +
> drivers/soc/qcom/spm.c                            | 388 +++++++++++++=
+++++++++
> include/soc/qcom/spm.h                            |  38 +++
> 5 files changed, 478 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/arm/msm/spm.txt
> create mode 100644 drivers/soc/qcom/spm.c
> create mode 100644 include/soc/qcom/spm.h
>=20
> diff --git a/Documentation/devicetree/bindings/arm/msm/spm.txt b/Docu=
mentation/devicetree/bindings/arm/msm/spm.txt
> new file mode 100644
> index 0000000..2ff2454
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/spm.txt
> @@ -0,0 +1,43 @@
> +* Subsystem Power Manager (SPM)
> +
> +Qualcomm Snapdragons have SPM hardware blocks to control the Applica=
tion
> +Processor Sub-System power. These SPM blocks run individual state ma=
chine
> +to determine what the core (L2 or Krait/Scorpion) would do when the =
WFI
> +instruction is executed by the core.
> +
> +The devicetree representation of the SPM block should be:
> +
> +Required properties
> +
> +- compatible: Must be -
> +		 "qcom,spm-v2.1"
> +- reg: The physical address and the size of the SPM's memory mapped =
registers
> +- qcom,cpu: phandle for the CPU that the SPM block is attached to.
> +	This field is required on only for SPMs that control the CPU.

Let=92s make this just cpu-handle instead of qcom,cpu.  The concept of =
a handle to a cpu is pretty generic.

> +- qcom,saw2-clk-div: SAW2 configuration register to program the SPM =
runtime
> +	clocks. The register for this property is MSM_SPM_REG_SAW2_CFG.

(add details on how this is used to compute timer tick.  Is it timer ti=
ck =3D saw_clk/saw2-clk-div?  What is valid range of values)

> +- qcom,saw2-delays: The SPM delay values that SPM sequences would re=
fer to.
> +	The register for this property is MSM_SPM_REG_SAW2_SPM_DLY.

Didn=92t Stephen asked about splitting this up? Or at least treating it=
 as an array of 3 values?

> +- qcom,saw2-enable: The SPM control register to enable/disable the s=
leep state
> +	machine. The register for this property is MSM_SPM_REG_SAW2_SPM_CTL=
=2E

Can this just be a boolean (exist or not), if so, probably change it to=
 qcom,saw2-disable (so lack of property means enable)?

> +
> +Optional properties
> +
> +- qcom,saw2-spm-cmd-wfi: The WFI command sequence

probably add something like: =93array of bytes =85=94 (want to convey t=
he data type somehow, is there a max length?)

> +- qcom,saw2-spm-cmd-spc: The Standalone PC command sequence

probably add something like: =93array of bytes =85=94 (want to convey t=
he data type somehow, is there a max length?)

> +
> +Example:
> +	spm@f9089000 {
> +		compatible =3D "qcom,spm-v2.1";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		reg =3D <0xf9089000 0x1000>;
> +		qcom,cpu =3D <&CPU0>;
> +		qcom,saw2-clk-div =3D <0x1>;
> +		qcom,saw2-delays =3D <0x20000400>;
> +		qcom,saw2-enable =3D <0x1>;
> +		qcom,saw2-spm-cmd-wfi =3D [03 0b 0f];
> +		qcom,saw2-spm-cmd-spc =3D [00 20 50 80 60 70 10 92
> +				a0 b0 03 68 70 3b 92 a0 b0
> +				82 2b 50 10 30 02 22 30 0f];
> +	};

- k


--=20
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, host=
ed by The Linux Foundation
