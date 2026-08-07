Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A03E2E737C
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786137184; cv=none; b=k7Wd9l7PQMrOcDtzuniplslXyAi6SmuPUpQFfvnXrzVsc1A4RECUhAC+UnZN34CDkX1GmCC2bLqAO4xC1VNCXMcX9s5ll5AbPPwUMlvIKggZCR58/twxRyTHMnqqCMKHQGp96g7m1IbsihD6wCweFu5xAr8TIyUCKETsu8QQrVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786137184; c=relaxed/simple;
	bh=neRauKgu441YhW+fTyyRlK+KboCRKQPiTbWWaU+q99Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbcqtoKZxeR+jsbj9y9oua6pwC9SMLbvJ1tXNhnaQsmKEwtsoqz4TZtWP7WIKPCsnTceZgVbg1R4vYBtIm+aUQuq1XN45SEmxcFdur/Sm8sfpdU23yRYXVNxLlil3nW5bbSVhMn/m1yR6rQV+2cFgPbjHnUSgNrtKJ+AQQjB/Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AO66SMFG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AdEhuKqP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AO66SMFG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AdEhuKqP"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677ImqrU1819962
	for <linux-pm@vger.kernel.org>; Fri, 7 Aug 2026 21:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fQySiyd+1ZE4+fAXLmvA6DLU
	xl7gMfgC+U4FfxieAok=; b=AO66SMFGiSPxFSaGbUKJa/DNApeldVMz8OX6FJhA
	kLo8Cf6I2XD6xCtteidgCaVQDErrCydDYECYi3NnZ7BQD+oHI5hn2baBW1mSm7Qy
	hSDC3Fvj9dW7oolZOWKhTHJ9dnrLnVE8S959KOVykHithHpssGR8SqU2JPTFJpVk
	B/t2ZghacqwprMOJlaeyYRqkYFcaNZOieal/Oo+whzHU/3uQbwUFMY2YDKIG+RtI
	drmr+RlMrNZSYHIml2LbrJ/NNjWnD5ZoNmnRfc/BrrEVBrl233LpjBr1KtyxL02g
	hrnPxSHgEeUl/LTrJJ+P8NmvV4bfHZB1xoentew++vVA6w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwctpanhr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 21:13:01 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bff5c7035so70071cf.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 14:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786137181; x=1786741981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fQySiyd+1ZE4+fAXLmvA6DLUxl7gMfgC+U4FfxieAok=;
        b=AdEhuKqP9258VhWI3ZVFuAr+K6uPC17khlrHOmwapr05rkwyAET1QBOtHbAtd6JwxX
         5ff9mqExpO11W+BDW+C2aX/cm/rW/6893AVDjD9gV2AuPJj+FVyREsP1NOkCbCjR0eSM
         eW7KOlcndUz9v186cj0mTSCasVVMlHKqfSxicc3WBK0h+L/eq+OiTmTeZXryowz3jIUP
         jSHrd9aIkf1B0uaXHm+23hrnremjQmBPFVM8EAC5oYjbll4str2YXlIC/0mNcKPsVWY/
         sJezcufGYVuhFceaWzWBo/FSyu9osFL1hMz69UweHb4eksd1NgTxxiOUwlpDPve21xh1
         8O3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786137181; x=1786741981;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fQySiyd+1ZE4+fAXLmvA6DLUxl7gMfgC+U4FfxieAok=;
        b=Bon5alvBAl62/aJ9FMWxpLmeu2zU28PQQNQLaHxMFrGkKxDox3W093dq86VWbfr4e+
         D3JRO8jrve8SJ5jUKrufzo/f8dfzr/atSTZ1+5L/lFT6G1p1aDxHDTmwh4OQOzhN1X7n
         74fcRIQFf+CBBuztcb+zXHnsZzy4rbiiW5B8LwqAtizuggXoZqdmr89Kanq1MA+yB053
         siSzDWD3b9bAE2WlaMQeIrbDWnXIS5q7ghZaTtnhdfeQqGfg2uSwEtr8CbUu66RhYHii
         mhdWIPv6Mk395kJrYuWEL2LiV8plIRyiBYmySbY5JMxuLzB5abx379JkjTkIwlDKt5ku
         l1RQ==
X-Forwarded-Encrypted: i=1; AHgh+RqvKwdTsTGtHSwKGoxEexR9jQ7FNoqnRRnVa98J7uu1sn8ghBbiAJr+1CK8oJjnh3dcpMeG54snHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFqmyRPYyE0b3fJbJ2ep+450BefoQemt9cbRcPxZaBL49NbPHV
	iEYZEEmgovifht9aplCEEctdL/IHMxSVKY/jw92kmliVrn/ERH7Sbs9BsKKM9LoDs8FRtnSArBg
	ZWWbSlr2kp9rV71DfYt76/+p3kqpKaAzN2Zca055qNHdW3Oim343dcOFG6AcoxQ==
X-Gm-Gg: AR+sD11AU7Asxqvdek858a2PcXJcaiaiwOO5vgaoRD5lHtRascoRgZRcPs6wYTNDuqN
	Rapx0m6JYS6l2wdCD5Oky9NFgpPORjN4XwxZfKAzaxolnwT/09uBk79Iz43675Q+kQPfYYkNRLZ
	SoivjA+Yf88J36vn/JSaJR6ZgJ4Mlm7N2AV4fAHlHBE6khY5Ds03VUGBhYylXoUOfX8brrf6ckI
	KumEqqZv11xpmCmU3z7Fo7uqu1wv1UasnpJ1uJlL4/PGVgDXaHUNuu9NEFB1YlqaYcFioGY5Qyy
	hCEJVk5K5M1Evi9aZMhORbeQPegTHlu5Ec6BYtU08vjzC95jHX5o52U7ckjPzK2yvwkDIiFzhdT
	sIpnMUX7E6IbQyqxg1UL4QDDyRtaA8HEl+KpsRGFdHZs8yxEhqMsNdrIoN/D/1yQjL51AuoUf3/
	VIBf2PHnM1jdV7JA==
X-Received: by 2002:a05:622a:551b:b0:52c:dde9:5cd5 with SMTP id d75a77b69052e-52ce6113b93mr318509051cf.21.1786137180924;
        Fri, 07 Aug 2026 14:13:00 -0700 (PDT)
X-Received: by 2002:a05:622a:551b:b0:52c:dde9:5cd5 with SMTP id d75a77b69052e-52ce6113b93mr318508031cf.21.1786137180237;
        Fri, 07 Aug 2026 14:13:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39fe71fbc48sm1482661fa.38.2026.08.07.14.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 14:12:59 -0700 (PDT)
Date: Sat, 8 Aug 2026 00:12:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
Cc: djakov@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski@oss.qualcomm.com, odelu.kukatla@oss.qualcomm.com,
        raviteja.laggyshetty@oss.qualcomm.com, vivek.aknurwar@oss.qualcomm.com,
        quic_afilipov@quicinc.com, loic.poulain@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: interconnect: Add Qualcomm CAMNOC
 ICC binding
Message-ID: <2ssduce25rimjg7bry6dxzrf2d4f7msqqa2lvukwuxxacm36yc@lylvi42lwmm3>
References: <20260807114951.4164439-1-atanas.filipov@oss.qualcomm.com>
 <20260807114951.4164439-2-atanas.filipov@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807114951.4164439-2-atanas.filipov@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Fp01OWrq c=1 sm=1 tr=0 ts=6a764a5d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=MsFI18s26wfPVdcRVYAA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: RfoJITjVlkw0eV7gPTQt3egNFPXdfqm5
X-Proofpoint-ORIG-GUID: RfoJITjVlkw0eV7gPTQt3egNFPXdfqm5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE2NiBTYWx0ZWRfX4QuvjC0QOG5+
 w1YA/Q/j6OhN3U11RZncu6gVxQ8EbYV+5iWYwLMeDxFiKJind61ZWPXLaZisoa5ATjjXGVB22an
 4Yx5PDjn00zRaZPZeoOPfa7k9tT4JkadcdjczoI/CHrzy1wo+aCWvhpGY74VGkmPvdKfpGEtH+J
 5HBZXAheSg7OeyFS+fCGh6M6yCv/rXmgnDBAxAHmrJsWH3R3vxJ8GgX8iIVdGzDPihVD94+ZfCP
 h426udselYNwkeyqhavo8XSWXQpx9LbmTXiMkQYfO9QmiRpNrheXMwZlubPtAXas3UfuzomaWhS
 WnIp40W0Ub3fhhahs4wc1Pp0ENEQNZgN9blB3+PYN9f/oVfq7UJw0nWOPkm1B6rWcx7K/+xcRTO
 1HTNOBHC0C3xRTgSx84czUv6b6HT7HypUTz0QChIo9nzh0YqUFJt1FC/pTf+E8b/p04i6985LdN
 bln4xY6qso1rdODqBTA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE2NiBTYWx0ZWRfX7Obprude1tNr
 5Vc291wrVT/Oruf3TlpBa5PWtbeu5un4XtRw9wCHuB7B9lN6ULPMU54PBXlvIcZkGCvCn+F/JHc
 Qh1wzMPpErDt1HmdcrwfRIOKZY+e1qw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_04,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070166

On Fri, Aug 07, 2026 at 02:49:49PM +0300, Atanas Filipov wrote:
> Add a device tree binding for the Qualcomm Camera Network-on-Chip
> (CAMNOC) interconnect provider. CAMNOC is the internal AXI
> interconnect within the camera subsystem that arbitrates bandwidth
> between camera sub-devices and the external memory interconnect.
> 
> The CAMNOC ICC provider aggregates bandwidth requests from multiple
> independent consumers and scales the CAMNOC AXI clock accordingly,
> avoiding the race conditions that arise when each consumer calls
> clk_set_rate() directly on the shared clock.
> 
> Signed-off-by: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
> ---
>  .../bindings/interconnect/qcom,camnoc.yaml    | 98 +++++++++++++++++++
>  .../dt-bindings/interconnect/qcom,camnoc.h    | 12 +++
>  2 files changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,camnoc.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml b/Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml
> new file mode 100644
> index 000000000000..b2f5c140ff80
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,camnoc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Camera NOC (CAMNOC) Interconnect Provider
> +
> +maintainers:
> +  - Aleksandar Filipov <quic_afilipov@quicinc.com>
> +
> +description:
> +  The Camera Network-on-Chip (CAMNOC) is the internal AXI interconnect
> +  within the Qualcomm camera subsystem. It arbitrates AXI bandwidth
> +  between camera sub-devices (IFE, JPEG, BPS, etc.) and the external
> +  memory interconnect. Multiple consumers may independently request
> +  bandwidth; the CAMNOC ICC provider aggregates these requests and
> +  scales CAM_CC_CAMNOC_AXI_CLK accordingly.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sm8250-cam-virt
> +
> +  clocks:
> +    items:
> +      - description: CAMNOC AXI clock
> +
> +  clock-names:
> +    items:
> +      - const: camnoc_axi
> +
> +  '#interconnect-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - '#interconnect-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,camcc-sm8250.h>
> +    #include <dt-bindings/interconnect/qcom,camnoc.h>
> +
> +    camnoc_icc: interconnect {
> +        compatible = "qcom,sm8250-cam-virt";
> +        clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>;
> +        clock-names = "camnoc_axi";
> +        #interconnect-cells = <1>;
> +    };
> +
> +    /* Example camera sub-device consuming the CAMNOC provider above */
> +    camera-subsystem@ac53000 {
> +        reg = <0x0ac53000 0x1000>;
> +
> +        interconnects = <&camnoc_icc MASTER_CAMNOC_JPEG
> +                         &camnoc_icc SLAVE_CAMNOC_AXI>;
> +        interconnect-names = "camnoc";
> +
> +        /*
> +         * Optional: an operating-points-v2 table lets the consumer
> +         * drive its CAMNOC bandwidth vote from the same OPP that
> +         * selects its core clock rate and RPMh performance state.

Is this a table for the camera-subsystem or for the CAMNOC_AXI_CLK? In
the latter case, the OPP table should be a part of the camnoc device.

> +         */
> +        operating-points-v2 = <&camera_opp_table>;
> +
> +        camera_opp_table: opp-table {
> +            compatible = "operating-points-v2";
> +
> +            opp-100000000 {
> +                opp-hz = /bits/ 64 <100000000>;
> +                opp-peak-kBps = <22246>;
> +                required-opps = <&rpmhpd_opp_min_svs>;
> +            };
> +
> +            opp-200000000 {
> +                opp-hz = /bits/ 64 <200000000>;
> +                opp-peak-kBps = <44492>;
> +                required-opps = <&rpmhpd_opp_low_svs>;
> +            };
> +
> +            opp-400000000 {
> +                opp-hz = /bits/ 64 <400000000>;
> +                opp-peak-kBps = <88983>;
> +                required-opps = <&rpmhpd_opp_svs>;
> +            };
> +
> +            opp-480000000 {
> +                opp-hz = /bits/ 64 <480000000>;
> +                opp-peak-kBps = <106780>;
> +                required-opps = <&rpmhpd_opp_svs_l1>;
> +            };
> +        };
> +    };
> diff --git a/include/dt-bindings/interconnect/qcom,camnoc.h b/include/dt-bindings/interconnect/qcom,camnoc.h
> new file mode 100644
> index 000000000000..a03f5e3f6446
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom,camnoc.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_CAMNOC_H
> +#define __DT_BINDINGS_INTERCONNECT_QCOM_CAMNOC_H
> +
> +#define MASTER_CAMNOC_JPEG	0

I guess, there are other connection ports. Please describe them.

> +#define SLAVE_CAMNOC_AXI	1
> +
> +#endif /* __DT_BINDINGS_INTERCONNECT_QCOM_CAMNOC_H */
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
