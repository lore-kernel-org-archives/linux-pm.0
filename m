Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794EE43C7DB
	for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2026 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788433060; cv=none; b=NVcxts7WFSA19MNY2ghrfwW6XesCHcqdqjO4ZbtqRl8B3eRE+yBuHBaWtog9kpVsXW1n7r7Yfd+UB8Ck42wxjTno40CIE6GwOjnc1/hX42kHrWpEHQNc1C2p9Xn4YRl2RRir+lcgy/SebQMAt2W86Lj0rsSuWbRL0PShlp0PRxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788433060; c=relaxed/simple;
	bh=QEo9QxrcNRKVWIrskvYI0BS2e9up5gkgj2oc9zsqXFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vFq5A3iGQ/f6wvkcf5sYfTVVTRotHNr2+6FH4OURl7/+AreYXl66NP3doWWgStEmhDS5l9fcTHWgwmycM+MiTaWPdfdJVbdzFbhpd5mBF/SuPNc8lLROSDFn5FH9qn+DqHpCq6gaxAr+YLgPJ2q4Oul80UdfMUhXnmsr+osu3kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SRdpJMIi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Suwu4xCS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SRdpJMIi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Suwu4xCS"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683AHDSW3782330
	for <linux-pm@vger.kernel.org>; Thu, 3 Sep 2026 10:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hnH4y9oFKK/g7NAxKawFtUfKKGQ9b2LE6XjrMUqzw7I=; b=SRdpJMIiq9NDmrdv
	UAWcFDzUt9xsWYnKUJBQih4QlR5E/gTEnhcGm3caq99WQZrQfjKC8gIORrj/7c2w
	ef9TqPTSXkvHfFVvSoOValzb/SEQbSiuSWMLO9nwCHOh+mmoooW8F6fO93Ut13JP
	HlA2nXYEACjWPT8HSIzcJu93IHMuDpz+/Vdf5fgnzzOgU/ayi0NinCCNLWYF1ZS+
	5RYtUlNt1eeGFBDEaMLvyCICVJul0NEQb6wz+I+fYqpuNRrUn1dyPuvbV0Gy8FFQ
	w9HXAjqH4pS8y+xB5HlapeQoKl2h+DVezAApTWD/60X2z5vjNv9r6eP4nrYj4FCj
	ppkyZQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5pdrhr3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 10:57:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9349ba88188so48792185a.2
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 03:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788433057; x=1789037857; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hnH4y9oFKK/g7NAxKawFtUfKKGQ9b2LE6XjrMUqzw7I=;
        b=Suwu4xCSYsl+5lkXstj9eGrPbkR/nP3Wh47gM4rVLL+XkfC/ofpUXyl2u0S6SWmPya
         g2lfBmYmjyqJdhMiezE+/vN0ec4D3/XVu2PZiV3tc2O96yyRg5/n+UQb99VJXYfOZ7Wg
         arfzmd6yoo+DfVaEo3DnkEyCfrtS9Z1hn7R6v5sCZVowllG0dxj9qT1oT1udBvF5SODE
         xw2TSJxDTln+mabZ2Z/xUGRJaiE+YWScg1CMoWw0s+MVldTscPKoS2tcpTsMqxsKWl6k
         sGKYbl9IATC9or+8jYMMc9ZQFOWLAFlHAEgCxvlpgSLM0kHCM2IgrteFFgh3l1DY0rm4
         68GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788433057; x=1789037857;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hnH4y9oFKK/g7NAxKawFtUfKKGQ9b2LE6XjrMUqzw7I=;
        b=qDenVgGBVrV68dbc07UE/Ix+H/qrvLC/AA1RqOlJ7BfuWBkIeYOxw2iDospGIkPChU
         O1rQPtgTn5BTWwxDjEq+xOmz+O8Ow7cv7mYJ/G/8njV1TaPzFy0UquIwbRJTkDbPNKg5
         6Dw5rwvXnFEq3V8Of3zSGnD7EjaUHvQcmUM8e5QA+MorBn81+c4QKYQc50Jkxql0FfOY
         jtSaoziEOXgkN0exbSm7EXoUSMGfpAMXvzQl37zmmEjF7a+rHdN9cBSsFpx3BSpX89vE
         SeP2kKgZG0YlmsaXja1H0NjqlwFxEumpE+m70NX2/TS0tRYZZgFxmRAyHb+TsHxmncO1
         EYpQ==
X-Forwarded-Encrypted: i=1; AKwUvByPHPd54HpSrKqtYj2exdJ1CVCtfTczCXoyiPq5EW2rmQ9VvV+f2HuSAqe91RrVsGRoF+0EqRAB6A==@vger.kernel.org
X-Gm-Message-State: AFuF++lZ/EXXzl8DifEFEr2q4yEnEJPdLkaOVCn242p/ZJuyu6a2JCgl
	UeOgflVDjP26RCRe9CSepqJmNSxcM906HRzy0H/qSQRUaoTgNTuAi3Pge2AueFovHXd6IyDyihX
	JiewPAT1sggC2xxhi/RwY6Yo6/iMYoEohjYH1DHzNRPFQnQ2iR87GIbrDTNM7JA==
X-Gm-Gg: AYBFou2+PH+K/fboLlPNliOLEi/u4dnZNg75qNm+JdJVsCvngfbPhzhJJTFq/nsQc+a
	NUpeB1XHUUoLhTjYzxWwg0LdPFK99eM7wFiGPYd1XF2EqmMqGq59/LKyELYlWuy6cP/+uPBcI2k
	r3UGXlLXfn0NA0b2rIGS1gigWYdazfXR1HUNtxxFuYYJfIn5rbf2SeLuMEEIFhWp8+WpQfHegJm
	n+L/QSrM2OgAWEYg8DdTP630GSEuAxZ8IWHQwuxcI9FnVq6RHvl/pNwH0eWO8+mJWpIx9TDoMom
	RUAVG/caqcMvvfr75isZaHXUiXSpjaIQMxbjHB+qCfpvttrIR7V0TUfK5BribV4hW1mkuznDiA0
	QrScaiZ2wxowX7nW9jwhUWw==
X-Received: by 2002:ac8:7d44:0:b0:52e:467e:ea8a with SMTP id d75a77b69052e-53036b33098mr86032251cf.1.1788433056659;
        Thu, 03 Sep 2026 03:57:36 -0700 (PDT)
X-Received: by 2002:ac8:7d44:0:b0:52e:467e:ea8a with SMTP id d75a77b69052e-53036b33098mr86031871cf.1.1788433056291;
        Thu, 03 Sep 2026 03:57:36 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a67f8bc496sm2173512a12.11.2026.09.03.03.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 03:57:35 -0700 (PDT)
Message-ID: <97fd5a30-9469-482b-be0c-0ed6da6424e8@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 12:57:31 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/15] ARM: dts: qcom: Add initial device tree for Kuno
 SoC
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
 <20260827-kuno-soc-support-v5-15-6d47636a8f09@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260827-kuno-soc-support-v5-15-6d47636a8f09@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5NSBTYWx0ZWRfX2OA+fwqOLLn5
 VmJlCVwUCBVb9U/8i2sF8TgwPC+uzfNFRdwxKSPqgT6u8rcyDGrw7tMIXUUALh83JJYWpVgD2xm
 2jIzZZEslDxI+nYLNOfd0lGx3bJluAA=
X-Proofpoint-ORIG-GUID: 9JoEuAABYLnNYlZt__9ZRvR_8gfO_dLR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5NSBTYWx0ZWRfXx+ZVPFJXXBAI
 26F/jdTJDe5sXC+mmRDkB0Mv78oGb7onQxrJDA8zpk+6zssszlTLDJ6ROigHUhY5AtIoh4FTJB1
 1GYH+/tq0RP0t01DJ8mKuY0vfWRD2qRXJrhLs9jT7ieTL2PUYqIpXf4ptOf8HP958UpVWFq/Cs+
 VzKruagNVduhe/8XacUGDSFOm6BSHc2pK2A4dQ9ixF1SnK0uHUKNY+QjuawTcnuNmJ0m4Dmm4Ho
 Hj2ic79DTOgdxVv4LxwA2yHjPhj7QrcPFCm+hGMNS2Th0cKKqI7YKjz74Wi0g8Lb4vLzFNVi2dj
 1c6jlKsVU7eqB85Whh3PcOtZmBsTg7afuBKWC0sCQUQc0+ko47mdLuWGA5e92Dse/jB9/k/dyNP
 sjdor6qcbnxEUz1H6v1HjqorXknE2cTn1XAuKWUjGxqEUEL5E5ekdVIYzfBVx7iMpPK+NF02cY2
 ka3akHJ4rrvDeZmVAQg==
X-Authority-Analysis: v=2.4 cv=RsL16imK c=1 sm=1 tr=0 ts=6a9952a2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=OHs8NuuX1ptjo3lIKY8A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 9JoEuAABYLnNYlZt__9ZRvR_8gfO_dLR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030095

On 8/27/26 7:51 PM, Hardeep Sharma wrote:
> Add SoC-level DTSI (qcom-kuno.dtsi) and IDP board DTS
> (qcom-kuno-idp.dts) for the Qualcomm Kuno SoC.
> 
> Peripherals included in this initial set:
>   - Single Cortex-A7 CPU with PSCI idle states
>   - RPMh RSC with clock controller, power domains, and BCM voter
>   - GCC (Global Clock Controller)
>   - TLMM pin controller (110 GPIOs)
>   - Interconnect (aggre-noc, cnoc-main)
>   - GENI UART console (QUP SE3)
>   - SMEM, hardware spinlocks (TCSR mutex)
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---

[...]

> +	soc: soc@0 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0xffffffff>;

that's just "ranges;"

[...]

> +		qup0: geniqup@9c0000 {
> +			compatible = "qcom,geni-se-qup";
> +			reg = <0x009c0000 0x2000>;
> +			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
> +				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
> +			clock-names = "m-ahb", "s-ahb";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0x0 0x0 0x0 0x0 0x1000000>;

likewise here, you don't need to precisely limit this.

Konrad
