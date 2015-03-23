From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v17 04/10] ARM: dts: qcom: Add power-controller device node for 8074 Krait CPUs
Date: Mon, 23 Mar 2015 15:05:22 -0700
Message-ID: <292C2E97-ED74-4F17-B592-B5EA7BDD1E8E@codeaurora.org>
References: <1426882877-33008-1-git-send-email-lina.iyer@linaro.org> <1426882877-33008-5-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45706 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbbCWWF0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2015 18:05:26 -0400
In-Reply-To: <1426882877-33008-5-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, agross@codeaurora.org


On Mar 20, 2015, at 1:21 PM, Lina Iyer <lina.iyer@linaro.org> wrote:

> Each Krait CPU in the QCOM 8074/8974 SoC has an SAW power controller =
to
> regulate the power to the cpu and aide the core in entering idle stat=
es.
> Reference the SAW instance and associate the instance with the CPU co=
re.
>=20
> Cc: Kumar Gala <galak@codeaurora.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> arch/arm/boot/dts/qcom-msm8974.dtsi | 26 +++++++++++++++++++++++++-
> 1 file changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/=
qcom-msm8974.dtsi
> index e265ec1..5a41f44 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -21,6 +21,7 @@
> 			reg =3D <0>;
> 			next-level-cache =3D <&L2>;
> 			qcom,acc =3D <&acc0>;
> +			qcom,saw =3D <&saw0>;
> 		};
>=20
> 		cpu@1 {
> @@ -30,6 +31,7 @@
> 			reg =3D <1>;
> 			next-level-cache =3D <&L2>;
> 			qcom,acc =3D <&acc1>;
> +			qcom,saw =3D <&saw1>;
> 		};
>=20
> 		cpu@2 {
> @@ -39,6 +41,7 @@
> 			reg =3D <2>;
> 			next-level-cache =3D <&L2>;
> 			qcom,acc =3D <&acc2>;
> +			qcom,saw =3D <&saw2>;
> 		};
>=20
> 		cpu@3 {
> @@ -48,6 +51,7 @@
> 			reg =3D <3>;
> 			next-level-cache =3D <&L2>;
> 			qcom,acc =3D <&acc3>;
> +			qcom,saw =3D <&saw3>;
> 		};
>=20
> 		L2: l2-cache {
> @@ -144,7 +148,27 @@
> 			};
> 		};
>=20
> -		saw_l2: regulator@f9012000 {
> +		saw0: power-controller@f9089000 {
> +			compatible =3D "qcom,msm8974-saw2-v2.1-cpu=94;

Should these include =93qcom,saw=94?

> +			reg =3D <0xf9089000 0x1000>, <0xf9009000 0x1000>;
> +		};
> +
> +		saw1: power-controller@f9099000 {
> +			compatible =3D "qcom,msm8974-saw2-v2.1-cpu";
> +			reg =3D <0xf9099000 0x1000>, <0xf9009000 0x1000>;
> +		};
> +
> +		saw2: power-controller@f90a9000 {
> +			compatible =3D "qcom,msm8974-saw2-v2.1-cpu";
> +			reg =3D <0xf90a9000 0x1000>, <0xf9009000 0x1000>;
> +		};
> +
> +		saw3: power-controller@f90b9000 {
> +			compatible =3D "qcom,msm8974-saw2-v2.1-cpu";
> +			reg =3D <0xf90b9000 0x1000>, <0xf9009000 0x1000>;
> +		};
> +
> +		saw_l2: power-controller@f9012000 {
> 			compatible =3D "qcom,saw2";
> 			reg =3D <0xf9012000 0x1000>;
> 			regulator;
> --=20
> 2.1.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-m=
sm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um,
a Linux Foundation Collaborative Project

