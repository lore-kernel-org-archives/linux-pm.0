Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5AE476CF6
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 10:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787308330; cv=none; b=svgNwDu0Agi27Pz7cle3/v8NEiWI1+1ce3Vs5xnFONGnFPNXqGZaQqqZYoDdZIWAMfLe40Cd3DY/PTqRdIds7JxAt0/leVZDgAReoOP8GNGFdXNHvmRwwoIryAOvat9TrDd8L3c1Rkr8nGGCHIBTYEynTxfuB1XLvjyWjFxNuN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787308330; c=relaxed/simple;
	bh=zosSe2E/ZqD40uYiqTnsIoI6CtU2hb2xgOwBPZusLho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INSvzg2hwXCs+WnPW1hp0PjB3s+mmgxgQ1V3pnYAYtECuwfmZ+3XVv1le1esnoTvkrI52bdPzYrLGe8y/b6gSngwpVEaK2pYV5oWmmvW29FVvNlxdCeUhG80857rEKgmUNwuZE5bNMzBXQmKZlPPFfaA656pVAlnttVNSDIufHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kk4VTiGm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aAIdNZsH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kk4VTiGm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aAIdNZsH"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9M0Ft789894
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 10:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hGKEQYpSuSXB/Y56MesVtsGp
	Jo7XRCToceowX7JwN+Q=; b=Kk4VTiGmSS4bsU8hB66aV8jAbMyuqKtjz5zW30bh
	k6oxKfZogeuz+Z3y1nip1ixM2VFhveniiiPl8pT63+GmvIaczTBybMkfbxkbbSBd
	2svBEhy94uahK4Jo3MfuSf14xc0sZCEMaojqIfC8bqYqgVpK4DxqmYjz75rrFJQx
	hBNkAyb5VTgBz2QfuFVjtU/qtvKYyFM9hWNJp5sf7PpgkDuF+YpATTylgWASNJgg
	YzvHSvd6MuYTseRRwSFaD86lbXlydP0L+s3+tBcKhPFupoW07AhS/fYpVTX+kLTm
	sKdVviYecdLwLWfWBBFAOcxOD/OfEa5JSP3lmnVyowtjVQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6ebusgj0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 10:31:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9349c5af52bso133304785a.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 03:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787308316; x=1787913116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hGKEQYpSuSXB/Y56MesVtsGpJo7XRCToceowX7JwN+Q=;
        b=aAIdNZsHXkvqidISG7C06qJwFAKt3YFI/1SWQPeUX77YArstPH8f/Bi43R4ef/fylE
         d110DBPBlZatQ82k/yseDynuz8zII00Sg2I8oB4qWUW2iwhwM8jTlHXWIlYTa2sVouP7
         91vEcNv3h72SnuoA46NjFHcFByT5U3zeWTKEYymQWdfRQtfMrPaFwb3gmu401rw5kKIO
         OU1sVgK/ktKLyTurBBeyPNEP9JZho471DDBvyiDt/dE67F3zgScW14tnUGZK6ZApsC1q
         a2qx3WJXnyNN2/DsVltF9b1yXMwPCBP57QmLVJn0i9AbOU4OuHqIdkv9UN6qBkrsxpzC
         hwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787308316; x=1787913116;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hGKEQYpSuSXB/Y56MesVtsGpJo7XRCToceowX7JwN+Q=;
        b=anGckDnCrgJ29JPHiJIQiWfoxNYDRM0B4SjUcx44+cEoT2NcsnhEG3rgFM1nBbAQSb
         J0ZJK172LX5IpTOgIetODg6bo1eGV5XMhT9vlu1KNvrvt99JhyDaFDCZTA9S4o3K+ZnS
         KpsuVJnHGJemTzuabYL9eaGP+8EEGwqJSSoktk/yTMnmc6AK9QZMElUMTpk9ny7Z1tYe
         1RLgpzzVAyJgrByOv+rWSLGVfp2rPTbre12V5fiS0+y7NrFOijutnVqZ3l2+IKohwa8X
         n/tomR8jorrf3ueBh1Vm6V4wL3iPanoRqnPY3rQR5q6lS8fVZoBR1JZSuNqzKKbQXv8K
         4pHg==
X-Forwarded-Encrypted: i=1; AHgh+Roquv5WjCSfp+yS1Y2SQKabFBES8N/mDnST/2dvch+t+UKWEXvWIiP4oDMtdjc37FYUwiTKdUDGeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbzyyJlD1teP2+Opm3LIg6FpGo7EXQSm1cUpPAaWhMFidKdc5z
	TrPeR0cnbitwFOvKnHRa4q5T0gw7DY7iMFTPBL/xxJVoVF3zjGU9LnncQqcnoCzfZOYGna/T7xt
	pHS34UTuvm678yKyWcaUKGNPDQWWYUOCivF+5sxEUX9AjbyyHdZlUZp+5XT1+Uw==
X-Gm-Gg: AR+sD12X3nuaVF6cgruM9TkgyrXKnhBL/hUbjvfrtPms83B2dvePuz3xP0lx/N7DNbF
	7xRB/xJvBPFf2rLe85xaIS4ep9XYYYtGFpfgDLNkUzFcK8DvesinGX0kjFF5id93Wx/DTMGvUbu
	FmQbaNnYDDZG36tOR0RJkESM98oIq6RlOwilpoV6lRdOjvOPaNsJcgQ0UUbFYef9Z6hlYvuDzi/
	n6xeSfqs4EpRZSHCvtpCnn8CKNWqkDHbidoT6hL3E/+ZppkXFMkyZ9tMek+ML6f0kSRBmSvE2JS
	qxOpL3F+zHT9Uof9boO7bPYg20my0r+bfT5Nvz4LiIYCZb8+d81FD5Pe4ynktcR75tPVxB2DAUL
	pTImI/cWqPdBiWwg=
X-Received: by 2002:a05:620a:6b1a:b0:937:1097:feb8 with SMTP id af79cd13be357-93739537a62mr334784685a.24.1787308315788;
        Fri, 21 Aug 2026 03:31:55 -0700 (PDT)
X-Received: by 2002:a05:620a:6b1a:b0:937:1097:feb8 with SMTP id af79cd13be357-93739537a62mr334780385a.24.1787308315259;
        Fri, 21 Aug 2026 03:31:55 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24589d98b0sm398453166b.6.2026.08.21.03.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 03:31:54 -0700 (PDT)
Date: Fri, 21 Aug 2026 13:31:51 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Sreeshankar K <sreeshankar0910@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, konradybcio@kernel.org,
        tglx@kernel.org, ulfh@kernel.org, bmasney@redhat.com, radu@rendec.net,
        lpieralisi@kernel.org, quic_tdas@quicinc.com, danila@mainlining.org,
        davidwronek@gmail.com, mani@kernel.org, robimarko@gmail.com,
        linux@gurudas.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 13/13] arm64: dts: qcom: Add SM7250 devicetree file
Message-ID: <cgpmlh6hw3n67bgc7sxjrrixkxrxfsajnwwwucqzklef7zkusr@xiafwn2agcja>
References: <20260821081125.4522-1-sreeshankar0910@gmail.com>
 <20260821081125.4522-14-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821081125.4522-14-sreeshankar0910@gmail.com>
X-Proofpoint-GUID: HZE3rphzRPRhmhRpPS98EAkZAdeKjlJn
X-Proofpoint-ORIG-GUID: HZE3rphzRPRhmhRpPS98EAkZAdeKjlJn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA3OCBTYWx0ZWRfX7jBspsS9emPd
 68yIABJV/IGsnHO/OOxG9rhAcbQDY+hyDUSOXKhr4mo/Qtf3h2oIbbomx1VjHZj5ctbinD8g41f
 +Bvx98SePACWzHqzLP8o/EjohgkXu7U=
X-Authority-Analysis: v=2.4 cv=QJlYgALL c=1 sm=1 tr=0 ts=6a88291c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=Ik05HghEHh1AHjvg2kYA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA3OCBTYWx0ZWRfX8Ag9Aen4oK/B
 Ej0x3nLT8oBIhSqJ7qaeWnCYYTmvWvedin9HeMXT1bSou7azMhVm1aIXqpoK5fBeBZpLf30cuuc
 LNZYukO2knfKUJVnQP6fmydNN9yvXQ6SETlay4KzqYAnOZJtzEkhCXBbLUczwQ0B7g6sffD7D65
 ct+P6wt6hmQZ12PO022D0XPfbaP1Q2D+mcpjhesqbSJqEMHJ2qiQMGRG4mazysph8SBv+fBPduh
 Ckdi14zv4ih1DBLwJf6uFgAm4oS0d793sib7wzwpcQXNwmRg7kV1mJTSDiMKdxKwMnZHoX5i9K2
 mDnXfjvIRyGYylCe7IbgucWpvKiSiT+LamtPU0I6EPYg74bG0+9ceaiL99Us/SEw4lpayPC4z4B
 4nycdVHt/iXSo0SbHQCHBRexw7g9mLhaoCjBMsvbCBDCulO6xdi9XyHyOuRY4EpB4mpeTT3kcSa
 9HvdB+MrhFFtOJeAG2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210078

On 26-08-21 08:11:25, Sreeshankar K wrote:
> Add base devicetree file for SM7250 SoC.
> This file adds the basic nodes like cpu, psci and other required
> configuration for booting up to the serial console.
> 
> Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sm7250.dtsi | 612 +++++++++++++++++++++++++++
>  1 file changed, 612 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm7250.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm7250.dtsi b/arch/arm64/boot/dts/qcom/sm7250.dtsi
> new file mode 100644
> index 000000000..7caa11c80
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm7250.dtsi
> @@ -0,0 +1,612 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2026, Sreeshankar K <sreeshankar0910@gmail.com>
> + */
> +
> +#include <dt-bindings/clock/qcom,rpmh.h>
> +#include <dt-bindings/clock/qcom,sm7250-gcc.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/power/qcom,rpmhpd.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +

[...]

> +
> +		cpu3: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo475";
> +			reg = <0x0 0x300>;
> +			clocks = <&cpufreq_hw 0>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2_300>;
> +			qcom,freq-domain = <&cpufreq_hw 0>;
> +			#cooling-cells = <2>;

No capacity-dmips-mhz and dynamic-power-coefficient ?

> +
> +			l2_300: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-size = <0x20000>;
> +				cache-unified;
> +				next-level-cache = <&l3_0>;
> +			};
> +		};
> +
> +		cpu4: cpu@400 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo475";
> +			reg = <0x0 0x400>;
> +			clocks = <&cpufreq_hw 0>;
> +			enable-method = "psci";
> +			capacity-dmips-mhz = <1024>;
> +			dynamic-power-coefficient = <100>;
> +			next-level-cache = <&l2_400>;
> +			qcom,freq-domain = <&cpufreq_hw 0>;
> +			#cooling-cells = <2>;
> +
> +			l2_400: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-size = <0x20000>;
> +				cache-unified;
> +				next-level-cache = <&l3_0>;
> +			};
> +		};
> +

[...]

> +
> +		apps_rsc: rsc@18200000 {
> +			compatible = "qcom,rpmh-rsc";
> +			reg = <0x0 0x18200000 0x0 0x10000>,
> +			      <0x0 0x18210000 0x0 0x10000>,
> +			      <0x0 0x18220000 0x0 0x10000>;
> +			reg-names = "drv-0", "drv-1", "drv-2";
> +			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +			label = "apps_rsc";
> +			qcom,tcs-offset = <0xd00>;
> +			qcom,drv-id = <2>;
> +			qcom,tcs-config = <ACTIVE_TCS  2>, <SLEEP_TCS   3>,
> +					  <WAKE_TCS    3>, <CONTROL_TCS 1>;

No power domain ?

