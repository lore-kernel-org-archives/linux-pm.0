Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9610E348C6C;
	Fri,  3 Jul 2026 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065090; cv=none; b=dWhTOsPzH3lqox7neoBfhYFAaZ076QZUQXjuT2v0WZnn21m308cQATNr0DurqVpMHc3O2wIKx42rig9IYtJv5xjAy8oFN6VWZ47tGyRbkFwHBSzW1laIDcyEKfZNgU/fwojEJf1IVCDpRYEWXetUzNTlqu3enJ/DgGBPTErmV50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065090; c=relaxed/simple;
	bh=2Y5jXaeI/31mD+p1BKRkDMD1hfuzZMrsQC1GPqe3gT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEtnPM5ARu6ERUOYCsoIbPahwtH3dYwMIl5m0TtwMIenLR6r/jlYpUq1+U8/QhiAQZ2lHCPHvASNvHfKfAfuesreYl/NKu+fDUVQwaKTwAzmFoDSnxsCjLbdNEqjvudxv/yOdDg/W7AvxCGPhpHllHWc66wpJpY/IozHunKgabE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AE3jj0Uj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AE3jj0Uj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACDA1F00A3A;
	Fri,  3 Jul 2026 07:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783065089;
	bh=zewJsOV4rEZ2zt3nWqFUqLGSFwEgdtzPGBXUM2osF7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AE3jj0UjfIMqa0Mq7gGPN+G59VbkpvUpug0qEJO4KZyWkMQIFmVPmMxjNnJUuvNAn
	 wDUCI0YUwVQme3VixPl5K7ZTRUv9ApX+kotmzNk+YHZ4q+i0VyLso66P+UxpOJY3G7
	 qkHELE0mv7v3SCKrf2TdIM1fQHVdkqxBg8INwl5oOTr3MXCz1c5wutfSd4EotJ1bOs
	 1fDNvWk9qY5ig9nxkhYMJrwKRQZXUCW6+ElYsywAP1/5Lj4bC1GAEKvWwMcRUfB+wd
	 LdULiGODkrgKT99RGj+F8rXkeyPBTg4iLtzM+4PA7FtG2uD3tcFyHMoAucwG2uyK1Z
	 fvMAMrKxzc9xQ==
Date: Fri, 3 Jul 2026 09:51:25 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, Amit Kucheria <amit.kucheria@oss.qualcomm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, 
	Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Subject: Re: [PATCH v4 06/10] arm64: dts: qcom: kodiak: Enable CDSP & Modem
 cooling
Message-ID: <20260703-deft-goshawk-of-brotherhood-c92ebd@quoll>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
 <20260703-qmi-tmd-v4-6-3882189c1f83@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260703-qmi-tmd-v4-6-3882189c1f83@oss.qualcomm.com>

On Fri, Jul 03, 2026 at 10:33:09AM +0530, Gaurav Kohli wrote:
> Unlike the CPU, the CDSP/Modem does not throttle its speed automatically
> when it reaches high temperatures in kodiak.
>=20
> Set up CDSP cooling by throttling the cdsp when it reaches 100=C2=B0C and
> for modem when it reaches to 95=C2=B0C.
>=20
> Since the remoteproc_mpss node doesn't exist on non modem boards, the
> cooling-maps that reference it cause DT compilation errors. To fix that
> remove inherited mdmss cooling-map nodes.
>=20
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kodiak.dtsi               | 134 +++++++++++++++=
+++++-
>  .../boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     |  17 +++
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |  17 +++
>  .../dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts  |  17 +++
>  .../boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts |  17 +++
>  .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi    |  17 +++
>  .../boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi   |  16 +++
>  7 files changed, 231 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/q=
com/kodiak.dtsi
> index fa540d8c2615..d6fbafae6d3e 100644
> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> @@ -14,6 +14,7 @@
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/clock/qcom,videocc-sc7280.h>
>  #include <dt-bindings/dma/qcom-gpi.h>
> +#include <dt-bindings/firmware/qcom,qmi-tmd.h>
>  #include <dt-bindings/firmware/qcom,scm.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interconnect/qcom,icc.h>
> @@ -3427,6 +3428,8 @@ remoteproc_mpss: remoteproc@4080000 {
>  			qcom,smem-states =3D <&modem_smp2p_out 0>;
>  			qcom,smem-state-names =3D "stop";
> =20
> +			#cooling-cells =3D <3>;
> +
>  			status =3D "disabled";
> =20
>  			glink-edge {
> @@ -4787,6 +4790,8 @@ remoteproc_cdsp: remoteproc@a300000 {
>  			qcom,smem-states =3D <&cdsp_smp2p_out 0>;
>  			qcom,smem-state-names =3D "stop";
> =20
> +			#cooling-cells =3D <3>;
> +
>  			status =3D "disabled";
> =20
>  			glink-edge {
> @@ -4906,6 +4911,7 @@ compute-cb@14 {
>  					};
>  				};
>  			};
> +

Please cleanup the patch from irrelevant changes.

Best regards,
Krzysztof

