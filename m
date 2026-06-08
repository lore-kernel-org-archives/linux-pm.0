Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A32A32B9A9
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 03:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780888480; cv=none; b=ZNdzsi9mOTT6nxrHIrwv2/cb5xsE50X1M0Sg8NQkkyzC6Ab+qBlqaEgUh9W2Pdd6f/DECiWHctj1ya3/de31tL1Fd0dsz2IfIRUsu2GtB9mloD4RGMAKn/+ZMjRUvlTJ6CHS3DOhSwvlp0e5mDyMFlGPYMAwwLZ66Vg7PC2WhNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780888480; c=relaxed/simple;
	bh=J6GR7Si5iI6uBvrP/qs8cEY8iIjk49htdTwqbM/Ie0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqJDvoaXtcViwwsbcvcMqkwgrj0pcEY3LwwLXuFargQdlQCMhrx2aoE5hbPDwNfCtLf9rQ5BPwuL7LgL4b5ZZcNqLPNVmtcPsD09D2Q7B21NP9uUghDZ6JV5IGqhKjaHaC2HZqjLIOvDr1LJBDXdjemEkmnvTLCbN1tPQspgFHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TD1OsXAg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KyOmUviq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TD1OsXAg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KyOmUviq"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580ENYx1511230
	for <linux-pm@vger.kernel.org>; Mon, 8 Jun 2026 03:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j+AZEdKKpOwHfkzjxlDVyOlIJN1Ra392uAlGrjFZ7pw=; b=TD1OsXAgA4dm5Qjc
	ss91jopf0knnP/yc2cYeGQhCyyYcrWP9fLJMzWqp004iTgKFfRsVvGHWo1h/VXbd
	kPqjH59WOuftdgiY7pku3tB6DJCIsnIaK11J6nNEHiQHZHJeEFhlMuMbyVAx1lJD
	ANe+9G9oZ0L6gVY4Gis2qdDxL1Fz6WlB/HowEDENv5tbtjrazOXmoqax8zApyNEx
	wFGvoi/5tIRd/B8MqAzqL3aHqyq5FDgxD1Nv2N3VMocMInpftody5/7Vd3Tx4IJa
	boNtECO0Km2eVexEViMtc/aa/qyCZI7h6kJWJQa8VMfgadvtEtE41o9T8qF1tdya
	3uslDg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcadw9gb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 03:14:37 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6cfd65ab97aso5633868137.1
        for <linux-pm@vger.kernel.org>; Sun, 07 Jun 2026 20:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780888476; x=1781493276; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j+AZEdKKpOwHfkzjxlDVyOlIJN1Ra392uAlGrjFZ7pw=;
        b=KyOmUviqgvF4KJqVvIi9fF8ybi31HtOwrNNLhYhFG1KEDGrZAN0pUuid0sOaladwFq
         ZHY6/kIIBVHuXLNK+Na/38V9pz85kHgAIm+RJMw2dR2ORjGLVfbRtNmC/ddz5ZZWi8HZ
         +ZjYTa6iyKpx4vSGwHSigNGrr9ocNQhFXuQN8AcIvQfuRpD4K7GGOP+W7GN88A+Qa0nL
         0D82eLMV3d8PS7vD4/IDvL8bNyACKSeLiem0u5NiJBPg3y9qUsJbGo5ztFy8/cRxzG7s
         Mf6InW7dZOl+xqoqFI21xZthVMPhMKuS9eWQYjq82Gb5nM3hWZEM+rR6YomeRhiZJumG
         4T9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780888476; x=1781493276;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+AZEdKKpOwHfkzjxlDVyOlIJN1Ra392uAlGrjFZ7pw=;
        b=nUgha27wcigQXBQ1Tr9nJbYlRZDKktnJuiWj9677VdZUU8NvNkIZeBUBJ2QG0Q1cra
         kt3tVixFda+PKX2c6VKB0PlIKDsdRqkjAAVualZWBhdjPBVTn5LBbZ60IUG/UtAs2BCj
         Vu7zY2bDZA5F1p6bjdxWyJRLe3DlT1yn4VkqarMoYugKFicF3xxiuKbSlbcjaZFpRaxF
         m6Af6fdLxPTXK2fyX7uf2k8ke3AD3mMDQ9ysQT8Zv92F2rYkFhBasqygdbyAbLLAhbTp
         FG7jfvEz/lTxPHKviHBRdkhlgTQHsOqPMfLAqwKxvN7wYvXv+2otjb3oDWckn4aXtAKt
         OD1w==
X-Forwarded-Encrypted: i=1; AFNElJ/LMMp2JWDLhh7ovo3lqHohYfOOMMgcQ+VRNPIPYE9HQUiQNF3BFPPPUonPrMpkMoRPWcgExGxJRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQxQX1dsSFijna07jSZPiW71JojK0PCb0ViOCrsxjQrRC2SUmw
	Y2aQx4zLSJmCiLbHxu6tl7Sz7wSRLtFal2lkg1bgc37ljGcgEgGtQJnFV5enu+NppnlBhQAoFAo
	8tXoSj/HyIX9PURp5SfQ71S7FuoB/rAJDl9uTEqU46eSoxJj+vCigQJyvbE57Dw==
X-Gm-Gg: Acq92OGt9Gt+ugWJY216E02EEvaNbfyb0QZCiRRkgdeBy3FmAwqSqc5ToINX/zExRlM
	O7etoVsX1Wd/oZUU22wCdzsPNIwCnmgLS40PgJzCIWQ6bNTEJW3BxR7nMML4DXYjezpeU3G6Uv2
	Vro+4FElfLbbvXuF5LbPKijDliKJwz0/nynmah5la8ZJ7UUBoo81KjYkWno1Jj/xxNBrQIBeLhY
	vHmwzM9HPTAzyaT4RApqzZWQkYH3bD7ber+BYKKBQQPYuOPtu1dcLkhFju1+rS3NyfSiihx6PDD
	hd+E9t5UcckYwNCh/gyHEQd6TSmg2ZMWYD5eXYUOEKn43M5QbHwK5MWe+8pDK8c3GI4KIa93Aiz
	g6/Zt1sWnUs85lL8Lc79d6mHNMLB/kMIu7zBU28HXVcApNKmCy35A2zJXamx2P8L5CeCNLOyJIU
	aRUcNqT9ixwnVtKaYH2a63/tTVezW0Nj4D87zbILRsFTkWNA==
X-Received: by 2002:a05:6102:5694:b0:62a:1bba:64ee with SMTP id ada2fe7eead31-6feed1adc0amr6648310137.6.1780888476598;
        Sun, 07 Jun 2026 20:14:36 -0700 (PDT)
X-Received: by 2002:a05:6102:5694:b0:62a:1bba:64ee with SMTP id ada2fe7eead31-6feed1adc0amr6648300137.6.1780888476219;
        Sun, 07 Jun 2026 20:14:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b90421dsm3426125e87.30.2026.06.07.20.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 20:14:34 -0700 (PDT)
Date: Mon, 8 Jun 2026 06:14:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: Amit Kucheria <amitk@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/2] dt-bindings: thermal: qcom: add pm8901-temp-alarm
Message-ID: <t25hkdgberbqu6bolvvyhu4jqxbjfyjcwdc2af76z5dorhexvm@azczmhlkjgz4>
References: <cover.1780148149.git.github.com@herrie.org>
 <386f3cef9d50d61f588f99706d9f979c56f8bab8.1780148149.git.github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <386f3cef9d50d61f588f99706d9f979c56f8bab8.1780148149.git.github.com@herrie.org>
X-Authority-Analysis: v=2.4 cv=DIa/JSNb c=1 sm=1 tr=0 ts=6a26339d cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=gEfo2CItAAAA:8
 a=cTwmTnRGAAAA:8 a=O01ZJP_XdAIdQBp6JKkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=sptkURWiP4Gy88Gu7hUp:22 a=GUWCSGlMWfG-xDt5EnV5:22
X-Proofpoint-GUID: nkOJZk9NcUL7IO1VirExfz8XUvWIhyM0
X-Proofpoint-ORIG-GUID: nkOJZk9NcUL7IO1VirExfz8XUvWIhyM0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAyNiBTYWx0ZWRfX496/ajWmJEq+
 In59mMgMqnY94US7HpkDySEkk5zc9LPMs5P0Ub7DmS8Ow+DR+DERDP280+VoRCVjQNBXnn4RObH
 86oGb612UQtskr1a2jA6ZCkbzyM3etT1/GHycpIWjr1EN4CIAAy7M5yiSAySqS5GtUywcy4vXdx
 C3vuSs12/IQkgAnRnQNXA0zJo0lEsXWhFr12rFFdMGtpNZin5fBZV9W8UGLhn4gdk1qnKM4xNzQ
 fUt3PB6LcCOlEK/OLMYqSBTvnKyGDeN4UQXoaZ9LtUdO0vqP5tsyVqUVebVX+W/Py8quA54mTQ/
 fN/i9dEBxPv2QkBb0U5MXwC9GbLkvUk8n2rmstKq3AP91A2VICA1O7Zb6UQkf+D7xfvbyBZArXm
 PHBfzq5PubN5hu8Lq4CJkYZtT2myG6Sc4i3tl59yInDQ+r0xsevaIO1uylKw9dNhGQyhnRALtDl
 mM8G+HLAZjmYPZXzhCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080026

On Sat, May 30, 2026 at 04:00:39PM +0200, Herman van Hazendonk wrote:
> Add the binding for the temperature-alarm block inside the Qualcomm
> PM8901 PMIC (companion to the PM8058 on MSM8x60). The driver exposes
> the PM8901 die-temperature trip stages (105 / 125 / 145 C) to the
> thermal framework via a thermal-zone, with stage 3 wired as a
> critical trip so the kernel issues orderly_poweroff() when the part
> overheats.
> 
> The binding describes the SSBI sub-node address, the GIC interrupt
> the alarm raises on a stage transition, and the parent PMIC
> reference.
> 
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> ---
>  .../thermal/qcom,pm8901-temp-alarm.yaml       | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom,pm8901-temp-alarm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom,pm8901-temp-alarm.yaml b/Documentation/devicetree/bindings/thermal/qcom,pm8901-temp-alarm.yaml
> new file mode 100644
> index 000000000000..569943b4aedc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qcom,pm8901-temp-alarm.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/qcom,pm8901-temp-alarm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm PM8901 PMIC Temperature Alarm
> +
> +maintainers:
> +  - Herman van Hazendonk <github.com@herrie.org>
> +
> +description: |
> +  PM8901 is a secondary PMIC paired with PM8058 on MSM8x60 family
> +  (MSM8260/MSM8660/APQ8060) platforms. It exposes an over-temperature
> +  alarm block at SSBI offset
> +  0x23 (CTRL) / 0x24 (PWM) with four selectable thresholds and three
> +  escalating stages. Unlike PM8058, there is no raw die-temperature
> +  ADC channel — the driver decodes the stage + threshold pair into a
> +  representative millicelsius value.

Don't describe the driver in the bindings.

> +
> +  Two PMIC-internal interrupts are exposed: a stage-transition alarm
> +  (TEMP_ALARM, PM8901 IRQ block 6 bit 4 == 52) and a hi-temp alarm
> +  (TEMP_HI_ALARM, block 6 bit 5 == 53).

I think, register definitions are too verbose for the bindings.

> +
> +  The driver registers a thermal-of sensor; board DTs declare trip
> +  points and a critical-trip action against it.

The same.

> +
> +properties:
> +  compatible:
> +    const: qcom,pm8901-temp-alarm
> +
> +  reg:
> +    description: SSBI offset of the temp-alarm CTRL register.
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: Stage-transition alarm interrupt (TEMP_ALARM).
> +      - description: Hi-temperature alarm interrupt (TEMP_HI_ALARM).
> +
> +  interrupt-names:
> +    items:
> +      - const: alarm
> +      - const: hi-alarm
> +
> +  "#thermal-sensor-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - "#thermal-sensor-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    ssbi {
> +      pmic {
> +        compatible = "qcom,pm8901";
> +        #interrupt-cells = <2>;
> +        interrupt-controller;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pm8901_temp: temp-alarm@23 {
> +          compatible = "qcom,pm8901-temp-alarm";
> +          reg = <0x23>;
> +          interrupts = <52 IRQ_TYPE_EDGE_RISING>,
> +                       <53 IRQ_TYPE_EDGE_RISING>;
> +          interrupt-names = "alarm", "hi-alarm";
> +          #thermal-sensor-cells = <0>;
> +        };
> +      };
> +    };
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
