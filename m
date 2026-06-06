Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2043286A4
	for <linux-pm@vger.kernel.org>; Sat,  6 Jun 2026 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752229; cv=none; b=CD99fTQlYrZe5T45OLOZtrD2j8PgM9BbtI6QfrsLp/Aoz1NKuQY2EhGGbwv/ePL9uGbdimV9EBlfnH3rtqEUKBBEdgxV+Ouc50ekKSiF3p95nZPrf6/lAbMuVoda4R/oZ/TrKRfgt6Si3htRgcRQot3PTekh35Kg8vX9MgIza7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752229; c=relaxed/simple;
	bh=ascq50Gto/BYzlD/1Iw9YsYIZvHWXVQK4s3uDyj5Nb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZMOVptTD33vIwH355gep5TZ6/w9Br7Tabg1pigFRTKgzxTmMO2kP/OWXg/1Bx0Rgb5bhhw+Au7vF01S/UI3yxHCrVij6XDAzVJPAiGnDU1TtlavfrDOJDmfRt2poxYCfuFjqNXpKvSYHTEEu8i86Ey945wubRNLkMhbViq6vDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o8oSnspX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bQ50NSd4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o8oSnspX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bQ50NSd4"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656BEYcR1328576
	for <linux-pm@vger.kernel.org>; Sat, 6 Jun 2026 13:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ksjiIivO5NlJD1LbbhDu0ri6
	r1Xvc7dbP55abanCnT8=; b=o8oSnspXna5nsUXSC+KfBSoGEJdK61nyM4vg9ygr
	3vgG4eO/s4iyr0+c/KuFA5I3N0rUSokBV4wuQaWUDtWyuhJQbYKzdOQNmwI73XP8
	rDJRx36feN3QhdKmFvX4BiV6OTZmUZ2ggr6QWIg2fo9cdCNvVjNARPkyE9wA0g8h
	LyP05vrvHNDwArQg1OX7pvzGV6bhSGkXh0yf7BtbiakWieBxVm7rs3mTnPcfnqJD
	YhM97MEmoXvIL4izG9iO+4I2fIwzX2T0lKfB58Eh3uRvfnnJTqbLzRw+DbUyMJpT
	200WcqPOPdgyc6b1994FbuJeJhdAe0iemgfsovZtwOIoTA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcu8rwn7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 06 Jun 2026 13:23:46 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-59eb3f8969aso2015552e0c.0
        for <linux-pm@vger.kernel.org>; Sat, 06 Jun 2026 06:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780752226; x=1781357026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ksjiIivO5NlJD1LbbhDu0ri6r1Xvc7dbP55abanCnT8=;
        b=bQ50NSd4q/B+GfNKHjPInDqJgHq0GIPHHkBwoMGUEpq/QJuhFPn3VXw4+ST25UkHOL
         PewJS0WtgIDRoPUm7hzVIK8+hZ9HmqDfoLeyJrZwbWHZEpRXGari2W7V4RcTOcmlA+Vg
         SLJ5WFekRYvQAyGLhn7RNIZ7izj2C6i4NdGd+z+tU23OiVvj3YtxpTb91ib9fLtd6HAU
         gEV7v4O/cyXomnIHx6mUwAAXYTYfJjvOWyAkT1t3oem2xX99DCykARpeUndUmrh6R6zG
         2rvvB3Amt9pWuAM1hBapaPL2VReiodu/DHVdTCikZPsVjfxoF/1Mcr413wWoc/fr4PTv
         MSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780752226; x=1781357026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksjiIivO5NlJD1LbbhDu0ri6r1Xvc7dbP55abanCnT8=;
        b=DpkZo7w0xv23pWtYshAElr8vSqJ+Z7X0nrJi0rFIld0VChR70sLzYE4EZ3PM7M9WuB
         /LPxfFRtwXlnvl9+1ERIMJGKkb97BcVmwdahbCdG2yG0V3BUm0zBYhBWNBp0AjS2fLIR
         KpInHILfdXfI9x8w7TeLetuKOkinkVjjopFDEqQD8OwOm/9/mS1ixgYdN4TnKe8hAGki
         g5K/HhId3dHowlkTfbohwgP0A7sHUPvb2bx1YTz8pzJqV0qENzXlwZVq9UtPWIlNxKEJ
         FfglqmIAnALh8amMFm+7H+KvpFnAIcKjpQQjrxh7L9x/5MtLbXHkj74bP5ZAVfbrGLrl
         k0eg==
X-Forwarded-Encrypted: i=1; AFNElJ/rZRU6zOKHWysRATEr6QJQhxBkQKWJGo0NpTPR5O5L6BmjT0opNyc0/9kKZ7w4H5RAotfLnn31cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHf8NYYVO701TGhXb1dCfhI6Le1PPCBhjZGc7ueT7UwYpWWj8k
	BHPlxrDhW3dAJ5DO/z257cpZvqnBCLZRKqPR544bZrkp3tdWH/jtzTmqzLlE06GEOPq/PyXTmq9
	QxjtyjDBV9PvEIfCxYxxYKmJNzv7BmBBtGNrSl87f7KOOoWnnJJtQTREfD80YKQ==
X-Gm-Gg: Acq92OHahQfJ/9QbZywkF0Uj6qld8avg82bmbkppRi0Z7DwKHb5S82jz04JxVUo+kWg
	ENlzJobyFQTY8pfmkApuISS2LI5xqD5Lx4UPc9ShbCJhDoz23swQkGGwTiLawzz6TNurKFq3WDD
	xUItxmexC0DEHLPbnlZwOPIFzcrkuXt34rwZrty3AtYAClj+qv42tqKv8+YUnzjvDvBu9SgSBl+
	dzbsQWiruA49fbVXHZxtAAEQwVwt6W0JkxKfnbdSn1K8m8ZTzbouwdKmKtaxGw62ZWy/KKVJI1G
	g9Tbq9En+YeClBXPyHgeIO0QpiyXjCmKDefFsfSYJQdkntnB8XI9MJkqzB+U353NXRbZbna2ujA
	rM5HNovNzWKO4CadvV/y3620julvZQ/imvLNe8XnV+B6lsjjGOXgxxSiH+jo8OmublLs6kUWsxz
	QFBH+5ovpnTdfTkG1HvkTkHMy73n1g6oL6ApJ+KEXcPSUxFQ==
X-Received: by 2002:a05:6102:4410:b0:631:44bc:c0fd with SMTP id ada2fe7eead31-6ff051aa733mr3964428137.8.1780752225835;
        Sat, 06 Jun 2026 06:23:45 -0700 (PDT)
X-Received: by 2002:a05:6102:4410:b0:631:44bc:c0fd with SMTP id ada2fe7eead31-6ff051aa733mr3964422137.8.1780752225368;
        Sat, 06 Jun 2026 06:23:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac2d6282sm31177541fa.30.2026.06.06.06.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 06:23:44 -0700 (PDT)
Date: Sat, 6 Jun 2026 16:23:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: qcom: add msm8660 NoC
Message-ID: <wypnu53w5pesj52zyrj3pydqzf2rbfrxa72uplz3mq64u447wf@gypyaug7iwkd>
References: <20260606-submit-interconnect-msm8660-v3-0-f9da0158cdf8@herrie.org>
 <20260606-submit-interconnect-msm8660-v3-1-f9da0158cdf8@herrie.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606-submit-interconnect-msm8660-v3-1-f9da0158cdf8@herrie.org>
X-Proofpoint-ORIG-GUID: DIspjfpi0TmqKAg0eFX88nOTP1NfgEea
X-Authority-Analysis: v=2.4 cv=deGwG3Xe c=1 sm=1 tr=0 ts=6a241f62 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=gEfo2CItAAAA:8
 a=cTwmTnRGAAAA:8 a=KCr-RzwM3x1iQMyl6jsA:9 a=CjuIK1q_8ugA:10
 a=XD7yVLdPMpWraOa8Un9W:22 a=sptkURWiP4Gy88Gu7hUp:22 a=GUWCSGlMWfG-xDt5EnV5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEzNSBTYWx0ZWRfX1BBth/bsb7yZ
 OvM9NhSTo34Cx15Kv8qdCXa3GY5MAT7jKOi1bRSuvTSKyCseeI/NKjExTfOhR0VSmB0b0Xee/ZR
 /1W6SoToaf67IfLzcqmO6IG67Pr6Joq2ZzmPBOrZ97+7oyOMggOMo1yRQEQHpN03/+cf0rcN7d7
 NEW/SAyTkvdVwbcN+5ZsxbyiknJNImzDp9vlc/WD5Poa9YU55mLEQmIr4W7YsSvTqSuKU6pqqq7
 9vSQ4dZDMlgxNWrr7MwbtpWVYz2dx49ReefcaQKGq5ymy+n9GXkH9kHkfACagSCBOvywhsfm1so
 DWax04PsSVL+gZxorn4mm0+ADJSQd8dEwMsWiqHGKFJ/4IKsrDO5uJQqUnGb+dCNflkirnXH/Md
 DbW63eS19yBNaUC+7vX9n8Eymc3o6IDK8l5ICW559AF5TdcEza4VQz6XVl9OxwIHXQXHSiR4SSv
 5aqRQSinZzRxmwnyF9g==
X-Proofpoint-GUID: DIspjfpi0TmqKAg0eFX88nOTP1NfgEea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060135

On Sat, Jun 06, 2026 at 02:34:50PM +0200, Herman van Hazendonk wrote:
> Add a dt-binding schema and an interconnect master/slave ID header for
> the MSM8x60 family (MSM8260/MSM8660/APQ8060) Network-on-Chip.  The
> chip exposes four NoC fabrics that the qnoc-msm8660 driver models:
> 
>   AFAB  - Applications fabric (Scorpion CPU + L2)
>   SFAB  - System fabric (DMA, SPS, security)
>   MMFAB - Multimedia fabric (MDP, GPU, camera, video, rotator)
>   DFAB  - Daytona fabric (SDC, ADM master/slave)
> 
> The schema covers all four compatible strings, per-fabric clock-name
> lists (bus / bus_a / ebi1 / ebi1_a for AFAB; bus / bus_a / smi /
> smi_a for MMFAB; bus / bus_a for SFAB and DFAB), the required
> qcom,rpm phandle through which the provider hands the arbitration
> buffer to RPM firmware, and #interconnect-cells = <1>.
> 
> The ID header lists per-fabric master / slave / gateway indices
> derived from the legacy vendor msm_bus_board_8660.c enums,
> normalised to the upstream interconnect-framework naming convention.
> 
> Assisted-by: Claude:claude-opus-4-7 Sashiko:claude-haiku-4-5
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> ---
>  .../bindings/interconnect/qcom,msm8660.yaml        | 166 +++++++++++++++++++++
>  include/dt-bindings/interconnect/qcom,msm8660.h    | 156 +++++++++++++++++++
>  2 files changed, 322 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8660.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8660.yaml
> new file mode 100644
> index 000000000000..ff28c7d46c32
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8660.yaml
> @@ -0,0 +1,166 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,msm8660.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm MSM8x60 family Network-On-Chip interconnect
> +
> +maintainers:
> +  - Herman van Hazendonk <github.com@herrie.org>
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmcc.h>
> +
> +    interconnect-afab {
> +        compatible = "qcom,msm8660-apps-fabric";
> +        clocks = <&rpmcc RPM_APPS_FABRIC_CLK>,
> +                 <&rpmcc RPM_APPS_FABRIC_A_CLK>,
> +                 <&rpmcc RPM_EBI1_CLK>,
> +                 <&rpmcc RPM_EBI1_A_CLK>;
> +        clock-names = "bus", "bus_a", "ebi1", "ebi1_a";
> +        qcom,rpm = <&rpm>;
> +        #interconnect-cells = <1>;
> +    };
> +
> +    interconnect-sfab {
> +        compatible = "qcom,msm8660-system-fabric";
> +        clocks = <&rpmcc RPM_SYS_FABRIC_CLK>,
> +                 <&rpmcc RPM_SYS_FABRIC_A_CLK>;
> +        clock-names = "bus", "bus_a";
> +        qcom,rpm = <&rpm>;
> +        #interconnect-cells = <1>;
> +    };
> +
> +    interconnect-mmfab {
> +        compatible = "qcom,msm8660-mmss-fabric";
> +        clocks = <&rpmcc RPM_MM_FABRIC_CLK>,
> +                 <&rpmcc RPM_MM_FABRIC_A_CLK>,
> +                 <&rpmcc RPM_SMI_CLK>,
> +                 <&rpmcc RPM_SMI_A_CLK>;
> +        clock-names = "bus", "bus_a", "smi", "smi_a";
> +        qcom,rpm = <&rpm>;
> +        #interconnect-cells = <1>;
> +    };
> +
> +    interconnect-dfab {
> +        compatible = "qcom,msm8660-daytona-fabric";
> +        clocks = <&rpmcc RPM_DAYTONA_FABRIC_CLK>,
> +                 <&rpmcc RPM_DAYTONA_FABRIC_A_CLK>;

Looking at it, I don't think those clocks sould be exposed here. Please
follow what Konrad did some time ago for smd-rpm interconnects: add
direct voting to the interconnect driver, them drop them from the clocks
driver. Ping me if you need help finding corresponding patch series (as
there were few more tricks.

> +        clock-names = "bus", "bus_a";
> +        qcom,rpm = <&rpm>;
> +        #interconnect-cells = <1>;
> +    };
> +...

-- 
With best wishes
Dmitry
