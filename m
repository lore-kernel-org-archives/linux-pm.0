Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795440644;
	b=AFSY6Qp3//rx41ArKc2hOgKfBU5WcbeNOaAyC32bMU6iP/Lywz0OEnpHOhe3/tVM4E2x
	 BUF4/Uk/SP9E3P2rfyv5JP6pct6KiglO+45rNncBfVPu0uILMDnnYr1C4uJJ2HxiJBblH
	 JNwJcILyC/EUf82KrRuAX/r+qBDw1+5KKAKHjma0weU50gUYulLuU6Y53xnbfoGh4jlg0
	 8XYPt1IgTBfoR2RXpUmVa48cYqdiPlw41Nw6THi9DM67Mzn63ss4V9eFs1JMXjHNZMNy8
	 Ta7Ab7Wth+W+drs28gubtxkUsHGSUgRNwG2kQRFK8AvN9T8cDuqNUlEpgYIpxUGMgtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440644;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6GW16cYLEXbLEKRxCLcZ/hm1ouVgqsdPZ8UneMsZf6M=;
	b=gjN29szwHT8lID+GBkv3ZSLBIj6pYDXgrVlZbyFlMYhbdL3jm1uCqmhHF5iEyJcnWk5k
	 lIRS39ANgLU77nBYHnlIVgpVAMUEbFswlGZUJIrqDspiO/nybl36Ir30+d6sOuwINVBSt
	 H1obOOq5qJOUQAai9kFpNfEKGTwDSVryesCuAwVz4GIH+R9e3o8LWS1w3t56QVHCDly5e
	 CXuWINK33bO+KJnBYbJya0UCLchPimZ4Cib+iA5pBVzXYyDdEddh3TqBLsvhd/imsyKmj
	 2CI620cPuyO65VqOWPXEbQc+h7UY4b9xItgk/G3r8tTL/y4WPMX5yUtqKie0rGhToeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c6TAGOg6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gEn7+k0A;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C24606A31E
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 13:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24C24606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c6TAGOg6;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gEn7+k0A
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDLH511461386
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 13:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6GW16cYLEXbLEKRxCLcZ/hm1
	ouVgqsdPZ8UneMsZf6M=; b=c6TAGOg6zi0O5kcLuEuN/zocBSDmqajGdyt5ZKdp
	JFQcnRh4jGqIi+JgJm8LtbWG776NhXnFYt8IBDEHEWhlq8tGnCAvG7N4gjx/fs0g
	RwHLHAQ0AzKISsPBHeN+T7sgGPzfp8mpNfUmyAahFVHjGEuOHoNy3R93Ypgji/1x
	n4pNZrIEt+skItajBuFA0fLd6AE16jE4U/KuS3s5WAa8MHKNEOwVSL6qotCUiUp3
	3+dwTPk3RXdaFMfmjEmBqkTy8QrljLtE7P+E4n+wCKsGj1qZTeLYJd9iiTnTunK+
	jzcavvfDiGJ0pRTcooPH0jqLoiD8wvpfK4VnnCpM48Fu8A==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g9a1gv0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 13:30:42 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-990c957f129so327240241.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 05:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795440641; x=1796045441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6GW16cYLEXbLEKRxCLcZ/hm1ouVgqsdPZ8UneMsZf6M=;
        b=gEn7+k0Ajaze1vGjd+9YvxrKbxZoK7CwlUziaxShMn1c1qP+qCqUtb/j1rm28nqQwA
         Y9G5KJT2NfLeCAnij2TdjEKJIlympH/oaHji3lp8qBvgVuVYWyChaRLZx3sgT9b/PTxc
         p8bet/RyeZCRyBoQfYzzX3DqVwMXDZem3ZR5VwaUFIOZrvkY/hFrNuGiwU2M2wVKEbI4
         wbiBBMC1OHIN9icmt0OZTzInNPheC04yokttgfMsx8FMab8/NfGzDw1lhVN2Xcg0uLJe
         xfggIo2sp9rX4uqV5FsyOO/MC8rRRT+p1B0R+FAdNWA5HjiqZ0ahuRMDE0XMy4DBiuxa
         i9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795440641; x=1796045441;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6GW16cYLEXbLEKRxCLcZ/hm1ouVgqsdPZ8UneMsZf6M=;
        b=1tw5znYzC1egc1eiWp0xZl2tH0yYP7QznpJyCUIx6KcM7A2uCtpjnyQMCBQpvjUzHK
         0TuISr/Nl0Mdgq48IV1kJOJ/XYYISgEJQQP2tCsB2wGGUQUG9GH8FQqH8CjKKA/L2inN
         KhZ4JwKqWKZcKvJ7QF7KJynWTjFWfAHxmDEYu5wG/jKkuR6rot74maPQl8OZXii+Byiw
         PHsSHOd2nvEr9038TSYtDo/yYT7gBacC6lXNyGEGGHCUuiEGI30PPR5XpGufurKT4MXC
         dT1sCUyCOd0xwWDXb0MTZEBuNZ+91PJZduMLdDudyxjZ2M0W2h/QhLiaNkmczfeYu62a
         YCUw==
X-Forwarded-Encrypted: i=1; AL+hErG2S47+8QdN+qZuu6fbIpfQADzkpAWJZ9ch3g/vIvOyEv4xBlwC/WLeOL/NRnWIk9MPkgISH7AgzA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/7cpehDSPLFwuF/F023ys0besNiEzXU8QmjLW/tAahudySFZwb
	z8MjChtdZhaQWmlmmE3vfiQvVZMU+HtdVp9uN1ETyoFlanqLgW3wDLp2T4QzghyyNIQ1VbB/qz6
	CNElmLT8vNzBhCM/bgX2OAPgD/syCF/B4rF5GHeB8bmPdXGaE1YEA0dsq9AFZCA==
X-Gm-Gg: AZFdTZeVxWRN5Hyr45yQ3F07fKJBiD3rV9CRfXdcrx4LoAdfvHaM+TztCNDQ+iWjhFE
	sDlTzfnuEgCYmZD7OnVz88yRS/14JgYdPv91pUTfFr5CbOEc448ln/5DiFG9AwOkpbGo+wOUGQH
	QiwkWiuLNHAemlzaW5wO2O35d6g2vdS3Td7k83eZwGwrvcMBcbSBrIwUUayOBU6HEctnEUaL78c
	PlxNIiV7rAASMSweEtoYYu801Y9G4qoQrMcWZ2wl28youlofj7GJ4eWfDnykuUd0adsxA4l1DRM
	dJ+Q/T/l7O//w9ifpp7+70eWyhSkMeMjadmvho8b+fJDnm52KvArLHZZLlD33mMdk/VvGDg2t49
	IXnocjrx9febcdaAihHfFUrWimbf32//XPCihtHFqQCVT+6S+wq37d1tFVnILbV9HLtXr7UYnu1
	+tP9pqwfn977L+WCU=
X-Received: by 2002:a05:6102:580a:b0:7ce:a840:e736 with SMTP id ada2fe7eead31-7d739626308mr3388884137.13.1795440641108;
        Mon, 23 Nov 2026 05:30:41 -0800 (PST)
X-Received: by 2002:a05:6102:580a:b0:7ce:a840:e736 with SMTP id ada2fe7eead31-7d739626308mr3388860137.13.1795440640566;
        Mon, 23 Nov 2026 05:30:40 -0800 (PST)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7fa0467sm11903416137.6.2026.11.23.05.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:30:40 -0800 (PST)
Date: Mon, 23 Nov 2026 21:30:31 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] soc: qcom: socinfo: Copy new SoC IDs from bindings
Message-ID: <awQ_90R8_uGWm2Sz@QCOM-aGQu4IUr3Y>
References: <20261122-qcom-socinfo-id-dt-bindings-v1-0-eeee0ffa25da@oss.qualcomm.com>
 <20261122-qcom-socinfo-id-dt-bindings-v1-1-eeee0ffa25da@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261122-qcom-socinfo-id-dt-bindings-v1-1-eeee0ffa25da@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1MyBTYWx0ZWRfX9SYox7QIFAfb
 mai6kdB3e8/WiEQnQ5Y41GeCkM/JS0BnAohV5SVSCaqUmc8EYz61oFcHTkOxT3IFcbb/WTOHTeF
 qEMjYi45suRwHj00DbTXDWs46QP8c/w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1MyBTYWx0ZWRfX5WEHolG+SAbE
 5h1zgkSXKjTl9rGx0Cl6ID19+HUoOgA1QwJdoNfflQKqlcjQL3wPTtYSBMt4jyd7h4iTRrE8Syx
 YUiUMZmavZnXnf9x4Cneie9lGpY4nZTR4SlO2P7IQGe9k2dT5pPTD8t92/IwKHObKLklS0GSOT2
 0GzflULbImWaDbQ8N9F6fYy6i1ZO+HbbIDaywK+Q14/56xrKDf4yI1Q4W6Jgp0LeJPv/gaSRNwa
 Ie9orEbE5jWkLeKygli7doBzLyGf2YN0V0fy2y9dk+IbKe32pxflSK63n0VLlCnGTggHH1vkhMl
 3qTCWww7mkOV9VW0h/PgUMOc3HD70B2HUlW1U+I+lReQbv+PNKKdpLbZiofQvqHwpYXgTJLFB9l
 B1YecwbZ381HWqmL2VGcB+VBq3I+jU9fH9Px32Xq9aVM731qofdgzUL6MhaFAOdGsVjP50G9Fl2
 oFdkcCZzqjOyvSfjXRA==
X-Proofpoint-ORIG-GUID: FjqwqiSh-W0If_SiO5x4ClH50vE8B4Ih
X-Authority-Analysis: v=2.4 cv=cYJHPXDM c=1 sm=1 tr=0 ts=6b044002 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=votV42V3uHCFBabA7mkA:9 a=CjuIK1q_8ugA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: FjqwqiSh-W0If_SiO5x4ClH50vE8B4Ih
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230053

On Sun, Nov 22, 2026 at 06:46:20PM +0100, Krzysztof Kozlowski wrote:
> The IDs of newer Qualcomm SoCs, as reported by hardware or firmware, are
> currently used only in the socinfo.c driver.  There should no and there

s/should no/should be no/

> is no in-tree DTS user of these, so none of these constants are really
> proper Devicetree ABI.  IDs of older SoCs were being used in DTS, thus
> that part matches the concept behind DT bindings.

Not quite true for the start of the range. The constants themselves
are not referenced, but the values are used as raw numbers in
qcom,msm-id:

  qrb5165-rb5.dts:                    qcom,msm-id = <455 0x20001>;
  sm7225-fairphone-fp4.dts:           qcom,msm-id = <459 0x10000>;
  sm6350-sony-xperia-lena-pdx213.dts: qcom,msm-id = <434 0x10000>, <459 0x10000>;

So QRB5165 and SM7225 are still consumed by bootloaders through DTS,
which is the same category as the older IDs you keep.

> Copy arbitrarily chosen newer SoC IDs from DT bindings to the regular
> header of socinfo driver and use it when needed, so later they could be
> removed from the bindings.

I would suggest converting the boards above to QCOM_ID_QRB5165 and
QCOM_ID_SM7225, and keeping those two IDs in the bindings. Then
the in-tree DTS users become visible, and the cut is no longer arbitrary:
everything left in qcom,ids.h is an ID actually used by DTS.

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/apss-ipq6018.c      |  2 +-
>  drivers/cpufreq/qcom-cpufreq-nvmem.c |  1 +
>  include/linux/soc/qcom/socinfo.h     | 94 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 96 insertions(+), 1 deletion(-)

[...]

> diff --git a/include/linux/soc/qcom/socinfo.h b/include/linux/soc/qcom/socinfo.h
> index ba823a0013c5..cd2e8eddf3b5 100644
> --- a/include/linux/soc/qcom/socinfo.h
> +++ b/include/linux/soc/qcom/socinfo.h
> @@ -112,4 +112,98 @@ enum qcom_socinfo_feature_code {
>  #define SOCINFO_PCn(n)			((n) + 1)
>  #define SOCINFO_PC_RESERVE		(BIT(31) - 1)
>  
> +/* SoC IDs */
> +#define QCOM_ID_QRB5165			455
> +#define QCOM_ID_SM8450			457
> +#define QCOM_ID_SM7225			459
> +#define QCOM_ID_SA8295P			460
> +#define QCOM_ID_SA8540P			461
> +#define QCOM_ID_QCM4290			469
> +#define QCOM_ID_QCS4290			470
> +#define QCOM_ID_SM7325			475

[...]

> +#define QCOM_ID_IPQ5404			671
> +#define QCOM_ID_QCS9100			667

Since the list is being moved anyway, this might be a good moment to
fix the ordering.

Also, drivers/clk/qcom/apss-ipq5424.c includes qcom,ids.h without using
any QCOM_ID_* constant, so the include could be dropped while at it.

Shawn
