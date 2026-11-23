Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795445184;
	b=5M58BoWhN3K7Ceb2dUw10UY6V0WbOsl0FUXkovb2yNbmXS8ZzJk7xrNNtNud5O81OWHj
	 544WkTEutt9taH1KFruUBcWc2AmFH/TLNKZi+OXr6lwJl0aA+ti9EmG6YQv+dE6Gytkoe
	 Z5cC6U8GReBvyj4ygXNnTtQW88qrvGl49o9bGjOBONh+LJuufvnpBKwMLMulMtlGZwO1v
	 cPeyiMmzmHMc4NykGLu7Uf7EAvw15cInSZ1+e7oBckj5fcx+xVsHSPhAq3Yx492W+aY23
	 BlL+6DkqmcdFgGqPReVFsXjKkW4ios4DNOmoAVZYUBWKlwekyiwP8n05mXzeU/5Ve8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445184;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=0C3NoitA9Av8WWs86mXYCEZzLDYugsCOm1mVss1Fq+Q=;
	b=ghDbxEQCBaQv/4W5ja0ZFwTmUPyvDoyCxAzD7iet5FcqZCibr2X0nFSI0AKtCfGxUiTl
	 8EfL6VCf9ZkituOOgnpDSuzupw8hAN97iuWXynQDHegzZ5ZnvRcSInAdqd7k/D2496QYH
	 5WFA0n95aG/4Gy1j85/B2RbZ87wsBJE0rNDlrcTWEthtZoSBP6KKdkRZJGramchMpW/yI
	 2Sa+jYq4LIjZ9FAFQIhAj1K1xlifVg+Tljj1P9PRXFsyK79DcDiR+/TdXUdyONYv1xKck
	 U55a5i0L/NKDor1kseOqIXd/nwBwRT0T9rFhahvlJAO7HjzI8fFuLax34LQjl9IP7ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lZne0xSe;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gIFjtVbz;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B40606A32C
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 14:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39B40606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lZne0xSe;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gIFjtVbz
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDL06K3072380
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 14:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0C3NoitA9Av8WWs86mXYCEZzLDYugsCOm1mVss1Fq+Q=; b=lZne0xSeimoZUi6m
	xd5ezJREO/oEIjS31i3OJlvbxNM1Y+OwGwMJTUomHDsUk0i0AFPy5CFjld07b/Sv
	hm/tWtNma9bvY2AeaxlEphpitULe472t62sCogSSPbXMRiBPqev33DIPU+rkZDHs
	JagW1CjyUnHZ623Z++xwaM0t3ma1Lvy3gumtCbpo1GheRh4cvSqzjP2IGShouGxs
	dK4hKswBprzykWX5ShgiZsrRIC/xyytLYce7rC0Fn5N5w6kHxmPjmkrTqmdvMnG+
	RYLP7XBk8Fh/J8EjXXxIeDFZiRJyK4YuL0M+iYpGZsAwslmAq4LTz7Supx1icyrZ
	6AyIuQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4hn7sgsa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 14:46:23 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5ecdc7807f4so111084e0c.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 06:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795445182; x=1796049982; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0C3NoitA9Av8WWs86mXYCEZzLDYugsCOm1mVss1Fq+Q=;
        b=gIFjtVbzTUFUcTeYJeOQ9IaHpE6ozqjxQpAj5aQSAMJtLnhIf3Nvhv+ZSofu3qwTGT
         28eqwq3CSGvayQcNplS/C9azJr947aDxGWuCd2fu3PerYFOJwwWKnbF0wmOaDzAILZNP
         beaj+EGGYvsaEq5Q/8Qp8Sz+MWTKhAtIPCXnHAaChehoiNJKl970MBYq6KPgjebRBQp3
         6CXYF1tEbXNs0/WEa2thdtoVBl3wIY04Mjws6B5EnE33L8sf4KbYey8f+bcV7Ufb28go
         YLcQaIPsdl/JmpPCgLxmjxjvCfhBBTC7taoO+xYmMzW0A4kNUq1YBAIs0lWSfz4/ji7r
         CdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795445182; x=1796049982;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0C3NoitA9Av8WWs86mXYCEZzLDYugsCOm1mVss1Fq+Q=;
        b=buEYhh2thZpvAIQimssNXd5tN/skKYhMjdJ+jzK20Dt16EhhIEVLPrmRVRf8Ny8A9u
         x4LqA4XYj1JmWSBqbpXxM2CfYFBfDxhqQ9GbLc5PBTsZzn9wg6tF0sE9sGEUl/avNo5K
         uHNYNzOy7x02Xfst30Ny7llFfzM1Eaghx8VUEv8fiZprNYUT08wnLfjXOx1SXaTdjOUZ
         xLkkxVSAa+/crXpLu5EltzC8ED4phJFKM/82AzlG9mRxGx9NXxX5/KHrYOrXCaVxkJkb
         rSCUD2jpwlzXA9CCHSJNyz0h/LQmVY6+Ftu3oNQJRVPKtWdha72JtwE10en9Tz5oMof4
         hbCA==
X-Forwarded-Encrypted: i=1; AL+hErHr/tKSUqotyC1aXclXgNxetbXqx1YTKmQ0vRFEuwP+ghDDwjrZ7OTeJXkvovYuH3jYKgWVhGg99Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z8kNrBaDhqY/TRu+MNcnaX33tJrcUGecbNTr5pcdIVTtFSG7Vv4
	OL73n/uZNmbaIXZSrKBaPyW0ahzbu3RSYN60uzKvPhVnEEYk8C9KUZHUQTm7ZpMV0Fu6b/f37fx
	rlpdDadKC9jkaqB7W9IzShjgH66H72HjDkIpoU0ZCMBiZ+d9bA69lfekvhUeaQw==
X-Gm-Gg: AZFdTZckTduBkENjjdR/SjTqHlgnGJXZAN2uvOynO4BXJ0LxTVp2eXmNUzTUFBqIQ+v
	9ZIwkM2KcfeDanv85pGJP7ihrLUt/Iff8+JqTzB9asr1HE1sDlHXFc39rJqYLVYCKGuj3ocZqnd
	ulwJOnqKMTprMsleP91Xib18zVKsT+JHT2cX4KDGs820qZEaJ8KkN+Uz7BxT24AxCBD5l9VVrnw
	B6M19kDSB7MUS6iiJdzra7bF6DmQGWXR0XlqX8pfPfDn2ATBcgxqF3kK2DdMb9PR2B3sPrzxObG
	UQsdaS5BjuiOyuArgMi0HRFoVvyWAmRN55ATrTWDnz2+TSkgoz8OUgNHzkuo8Go0KFyznR03leg
	P5cnJ4y1EC4WKPWtu4M1E+lS1OUJR9bpilsaCQPmJPqCKkB+Kpm43wy+Nz7+cCELY0HYkBps=
X-Received: by 2002:ac5:cd3b:0:b0:5ec:e2a2:b70e with SMTP id 71dfb90a1353d-5ee8af4a71fmr5946740e0c.4.1795445182289;
        Mon, 23 Nov 2026 06:46:22 -0800 (PST)
X-Received: by 2002:ac5:cd3b:0:b0:5ec:e2a2:b70e with SMTP id 71dfb90a1353d-5ee8af4a71fmr5946678e0c.4.1795445181553;
        Mon, 23 Nov 2026 06:46:21 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afed51asm407622466b.76.2026.11.23.06.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 06:46:20 -0800 (PST)
Message-ID: <a97c0257-0651-46d7-96fe-35984782f331@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 15:46:19 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] interconnect: qcom: Consistently enable MSM8916,
 MSM8939 and SDX65
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20261123-b4-qcom-kconfig-unify-interconnect-v2-0-99b282e87d40@oss.qualcomm.com>
 <20261123-b4-qcom-kconfig-unify-interconnect-v2-1-99b282e87d40@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261123-b4-qcom-kconfig-unify-interconnect-v2-1-99b282e87d40@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ls0HWXdc c=1 sm=1 tr=0 ts=6b0451bf cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=LjraZ-jLxIig9cHSdckA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1OCBTYWx0ZWRfX/2LPrhv6cGF3
 DEs+c/8oiRjgbJjhVwWsY5CN+bZ3ljxW5qZdlNyKZ4+XCr5Fmjkri2cJisidILGHZa/dFI083W+
 DGWOgH9TsScEiBvx4LEXn7gCghqxWJawU0sDgoP+exJHr8fzBCOTq5FP01TQgcmNjnd4qbGDCQ0
 VWCv38ZpcaZ5/JfeN+XJxW25loyuqHriO9D8vlgZYaM4fV0xTbVJvR5xNS5xvZKuPRw2XWyMMCc
 2EypSVkVFjLoPdGCxjZcExWqw3YmlHI7Vpt6nFXgYUeSEtFibR1aU4Da7CwMadqJ9SVvh7F8l5l
 IEQeeCLok3LyDWfeKJJVUoXc8WoJwJsBFJHR3iWfSOEohvqw0zbxHTe0SgEpbl0x3M0OuEZqtiH
 yYaJC9wQH+euEM3MYg6LW1cZwrFD8OSCbcpel3GrwBigTtg9/pz4oLjz7XHiMyTgr1t402rwtbr
 j8YeMZxZt4nuktRwPKg==
X-Proofpoint-GUID: 9FlONG2lkdfVtLvG7T1cISK8M8_1R4qS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1OCBTYWx0ZWRfX36V04sZ4Dzbb
 vOYXg9DLEuD1Vx4/HejFyRsNAsKpH8TAvVSBKNY2PaB0yPk0h4ccHhkZutEFR0GTJRRkjlKcing
 YwbTHRTNXGQKN7wANKMR7dWAjcfIdao=
X-Proofpoint-ORIG-GUID: 9FlONG2lkdfVtLvG7T1cISK8M8_1R4qS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230058

On 11/23/26 8:56 AM, Krzysztof Kozlowski wrote:
> Critical drivers for MSM8916, MSM8939 and SDX65, like clock and pin
> controllers, are already enabled by default (MSM8916 for both ARM and
> ARM64), so should be the interconnect drivers as well.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index 7f3a977e8f10..110789a2d232 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -92,7 +92,7 @@ config INTERCONNECT_QCOM_MSM8916
>  	depends on INTERCONNECT_QCOM
>  	depends on QCOM_SMD_RPM
>  	select INTERCONNECT_QCOM_SMD_RPM
> -	default ARCH_QCOM if ARM64
> +	default ARCH_QCOM
>  	help
>  	  This is a driver for the Qualcomm Network-on-Chip on msm8916-based
>  	  platforms.
> @@ -111,6 +111,7 @@ config INTERCONNECT_QCOM_MSM8939
>  	depends on INTERCONNECT_QCOM
>  	depends on QCOM_SMD_RPM
>  	select INTERCONNECT_QCOM_SMD_RPM
> +	default ARCH_QCOM if ARM64

This could also run both 32 and 64b kernels, but hopefully there are
no devices with the fw as broken as certain 8916s

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

>  	help
>  	  This is a driver for the Qualcomm Network-on-Chip on msm8939-based
>  	  platforms.
> @@ -367,6 +368,7 @@ config INTERCONNECT_QCOM_SDX65
>  	depends on ARM || COMPILE_TEST
>  	select INTERCONNECT_QCOM_RPMH
>  	select INTERCONNECT_QCOM_BCM_VOTER
> +	default ARCH_QCOM
>  	help
>  	  This is a driver for the Qualcomm Network-on-Chip on sdx65-based
>  	  platforms.
> 
