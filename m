Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1C533ADBA;
	Wed, 22 Jul 2026 07:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784703989; cv=none; b=fJtoK/aoxpHxSLFtD2+uJiMgl+qSCHZJjXqQ/3icb5InAhVikvk67xIp8mtbqRTxveouNudXKfnj4ulDoVpNdheYzg+1SiVWnqjbfBUCifZ5UzjcvmE3BC99KJ5+svTAPQvk0Alxyp60+sclSlcSwUOpj4GqgPAISlHAKU6EvGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784703989; c=relaxed/simple;
	bh=3ybV1jLsAfcefajhEJKJ2FeLoU5ZminLK+AwMHaSjNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+wkTEgf6E4y2CbAIiG/x0KOj1bSlVTNVqqPY3XFiCEVQ9jw6iJExrtmUeUqrv+knADIszKtROCC618Kl1CfNZZtapcFRTwdk3p1/JUgChkx05txdBCSYz2glYEkN2zxufJxfjQ/yNkSYA0Ze9SVBPooViMDR+nWP4WADdMNkJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KU1+ux9E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KU1+ux9E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6501F00A3A;
	Wed, 22 Jul 2026 07:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784703988;
	bh=mPrKJwtyc94vlPXCTsdOzTfpaNygSvDWA1DD/pRBXtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KU1+ux9ENMRdMjF4W5boalCx0W1oQbcV/jOcR6dWuby1Ca9BlLWVtaB4uFZQth71C
	 E+blIVAtlcIyTKI5grEVq8SJGzxMUBjzNFtoVNNiJ06riWd4IsmcdeiJTDFu2hKRU8
	 kq1jLSU4PBS+RAFnIR2ZdO3CC9U9WSl2Dukt+HIe2wjGmvv6Se+IrE7oXHG/EoIMGI
	 6wQyRyV26lM8VYoBrwdX1BErhu/Fb/+AQDomeJJARG1V7YgqRon7lTkuYAaavOb/FD
	 QqDvy7MoOzkBULCjTScl/qxKGMe2kmiYTjsup9sSqBupvKDe5giF6lI4En+4lrzW9W
	 TIFuHuC4RFTBQ==
Date: Wed, 22 Jul 2026 09:06:25 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, Amit Kucheria <amit.kucheria@oss.qualcomm.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
Subject: Re: [PATCH v5 1/9] dt-bindings: remoteproc: qcom,pas: add
 #cooling-cells property
Message-ID: <20260722-active-kangaroo-of-order-ebb28f@quoll>
References: <20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com>
 <20260721-b4-qmi-tmd-v5-1-99620e07f505@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260721-b4-qmi-tmd-v5-1-99620e07f505@oss.qualcomm.com>

On Tue, Jul 21, 2026 at 11:58:58AM +0530, Gaurav Kohli wrote:
> Document the optional #cooling-cells property for Qualcomm PAS
> remoteproc nodes so they can be used as thermal cooling devices via
> the QMI Thermal Mitigation Device (TMD) interface.
> 
> Qualcomm remote processors expose TMD endpoints that support thermal
> throttling through firmware. The cooling-device specifier uses 3 cells:
> 
>   <&phandle device_id min_state max_state>
> 
> where device_id selects the TMD endpoint (for example PA, modem, or
> CDSP software mitigation), with constants defined in:
> include/dt-bindings/thermal/qcom,qmi-tmd.h
> 
> Example usage in a thermal zone:
> 
>   cooling-maps {
>       map0 {
>           trip = <&cpu_alert>;
>           cooling-device = <&remoteproc_cdsp
>                            QCOM_TMD_CDSP_SW
>                            0 THERMAL_NO_LIMIT>;
>       };
>   };
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  .../bindings/remoteproc/qcom,pas-common.yaml         |  9 +++++++++
>  MAINTAINERS                                          |  1 +
>  include/dt-bindings/thermal/qcom,qmi-tmd.h           | 20 ++++++++++++++++++++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> index 11faf655f530..39e79a1c1079 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> @@ -77,6 +77,15 @@ properties:
>        channels and devices related to the ADSP.
>      unevaluatedProperties: false
>  
> +  '#cooling-cells':
> +    description: |
> +      Cooling device with three cells:
> +        Cell 0: Cooling device id as defined in
> +                include/dt-bindings/thermal/qcom,qmi-tmd.h
> +        Cell 1: Minimum cooling state
> +        Cell 2: Maximum cooling state
> +    const: 3
> +
>    glink-edge:
>      $ref: /schemas/remoteproc/qcom,glink-edge.yaml#
>      description:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dcffe9fc54f6..2d4d19201aec 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3423,6 +3423,7 @@ F:	drivers/watchdog/gunyah_wdt.c
>  F:	include/dt-bindings/arm/qcom,ids.h
>  F:	include/dt-bindings/firmware/qcom,scm.h
>  F:	include/dt-bindings/soc/qcom*
> +F:	include/dt-bindings/thermal/qcom,qmi-tmd.h
>  F:	include/linux/firmware/qcom
>  F:	include/linux/soc/qcom/
>  F:	include/soc/qcom/
> diff --git a/include/dt-bindings/thermal/qcom,qmi-tmd.h b/include/dt-bindings/thermal/qcom,qmi-tmd.h

Filename must match compatible. There are no qcom,qmi-tmd or qcom,.*tmd
or qcom,.*qmi compatibles.

Which device is providing this ABI? PAS?

Best regards,
Krzysztof

