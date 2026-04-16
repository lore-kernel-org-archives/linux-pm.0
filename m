Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975C23BF69E
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 13:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776346353; cv=none; b=NRoc5HZl4EuKN47nupCdWPiuHaeAeTHWfvOYw4Xi8Jf7AIa2eXaObSPKfBWPEkNzh8/qKw/WzG60WKy1Wqh6icNUSghRPlUxc7OdC1YWNr07Fjq6getxhPf2bau2a8NyxoxAyEIhkioekPVJdMj8AeW80oVQiVdAyJQ/4p4yBVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776346353; c=relaxed/simple;
	bh=ykQtwldpahujIM1r6rCPoMYUWz+ENJXFV+25TcjTMkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jR+xKJHO+ztU1/KAFZwnC5O5Sa6+hizFDT2Z7TLrgSZ30FKq/CD/B1qG2ThsWMQJQGH5pW7BD9MK0ywGBkuhzYx0Q71rACEnnY+oDuvJgZRO9gc174Bpu7qmAgvLwn8Rm1NX2b+rIrf6Hv9GJGfog/a/s3vLsL5c713q1EMwGmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WwS/ZaMf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SdSQCvP2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WwS/ZaMf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SdSQCvP2"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G8CO3A2575815
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 13:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G/vnzQBX53QqlFQ/E/rAKt7Rwv6wfq+aRZ3MY1sgtbQ=; b=WwS/ZaMfw8WY9u/2
	EstjN+0VRmjmnDK/3eAFbgMYrmm6u1aO/OZUnqKTD5aYACajFnlyPnn6MjHtJ7I8
	xAc20P/aJuJcxIkI0UIrp5v3P39PeQNGMbyw/guFeHtZwsG4f0UN8UTrSRjSKs0+
	FxYoDPH79ASNTfN6jp9G5ukHDubwXzglH4i+3pu7xS8NUKB9qbwjJESoZsVz0vKF
	aG15wzxppoNxwzq/s6cVxbnMRghpMr8l8mDVHUifhgdB9OMSbNDVo2StCLCfEFvj
	wHRCvYwiIlpwalnLTmtU7xh4pFSR0dxIgEeEqFbYseYy0SSWtdBXIMhVvO8LTAWc
	sYmcAA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djv27h4ec-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 13:32:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8d1d81dad37so202704185a.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 06:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776346351; x=1776951151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G/vnzQBX53QqlFQ/E/rAKt7Rwv6wfq+aRZ3MY1sgtbQ=;
        b=SdSQCvP2IBJph8THQUoLo+9YV+w1SninywXZ2k/rV432p8DPOzlaZympTzUUdPz8xC
         gUoQ1LdocjIXvooOjHXaebPrynQVtKyV2Prj5yrkLsjTO4OZe8gc20Lm19QVpCp2xNJP
         J66bTagnILR6KIT7SggK+Tw9dFCfG49FSI6b3pyMTO4jFMk6qpIqBKNV8gHhgFE6Nnyq
         zzJzRZVW5BzX1yV/kK9+yMtibeAOUOujjM94t21LWWgQ8zUJWDVuMKjc9D6qcgPT/Q7p
         4AsbimV/P53XkdFt4ZhR7dsGAK3cBJC61n/dmHJzbCfuJ34ZE39hCHypT0nB5QmOM2W/
         r/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776346351; x=1776951151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/vnzQBX53QqlFQ/E/rAKt7Rwv6wfq+aRZ3MY1sgtbQ=;
        b=NvwDaWzT+W8xITbCfaKOxQWLt5ytVyh6ZSh8CRvPgM3lQpp6NEF+D0kpTS/lSJ6vrk
         LaqZM9GPupH2nBRx3D6MzFPPsm+4cXqc6Dez7HwfZH5hTu8oXhgsnmolhD9pHX03iUbG
         7m4bd8SiNI6C0tAddnZzqNsGWzkH00abvvk8IfW3Df7UwVoA3ywMfT4eOAmPhxXO0Y2x
         ZSLsgCdgomwbcsPvnVgNdjlPoCLPHxTY6rRu5qETdVMAUFHlQSpFtzyNzOf6NxQXJ9T5
         x7F1+qPZQ8FDBH40NBdVeLX2vtlRSSN2qmFaxOs8sjHDaxwhOAiTNyWGfQtEDdDJ7D54
         s7oA==
X-Forwarded-Encrypted: i=1; AFNElJ8DXKBXLsgC0P7Hkj6KHFrDlgOMgTGLLY09w5s5GX005qud0IULAUI/Na6L3i/IvsG/hTxYRILbuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlePrUWcUByIWd8POX99UbWgs3Fz13DUM8IdiPrtvQNyC3nI2f
	tB1RFguaNfPaNWpxm61zP1J7Pw3yGQz/0fy3lj8n4EQqpIvPN2d/GEi/kYJSVPZR0eigfKk96jL
	7Fs2FEkt8K89Hf4rndgSGWjE3xidk/QhYY2osM1B5AXVhfvsiZKfgLghB/btdlA==
X-Gm-Gg: AeBDieuj8VFuHtUwwSNf2S1L3O9W/bMKzbOqlaLUzxrNMX2GLi8BMYWZx4lizE8AaSx
	OdL4AAEhwkhdZLJ7je/jE7YFRNtJvxbO1UAbvjkbkuR4fvULpCnZzQiqAVHmQtV7cuHcB7M5GbG
	gyMRlq6jsx0GtrrDVw3zWEVm6bKHAD3dUPuJpJjOdc/azTVL71kx8HzHLdKMu0TReDCifJtSgXO
	6jIH+QHjKLEk8tWj9HnFy+uAdvI4n8NSJSGc8vWDSWJinjxiPh3SY+O/5AB50FGQhqd8EsQmg0v
	TtKm58FLGtsBxr1+boG7Kqz4UFJUaA6Tb0hTbbOibHXaQF+iUKm/t9Z2ly4Y34iS2BRmUczp4Wa
	RrnAHNP9EROgBsXjPKL89qsvPO8wLj+b6PUjsy1BHBow8RXQe1seImxnowju2D84UVigVbjqBRY
	4qIs/Jf+ile0zpTg==
X-Received: by 2002:a05:620a:448b:b0:8cf:d68a:9aa2 with SMTP id af79cd13be357-8e6353855damr250662385a.6.1776346350911;
        Thu, 16 Apr 2026 06:32:30 -0700 (PDT)
X-Received: by 2002:a05:620a:448b:b0:8cf:d68a:9aa2 with SMTP id af79cd13be357-8e6353855damr250659385a.6.1776346350447;
        Thu, 16 Apr 2026 06:32:30 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67237d7899esm1201511a12.1.2026.04.16.06.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 06:32:28 -0700 (PDT)
Message-ID: <35e8f654-214d-4e8b-843f-87fa8cc1a782@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 15:32:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] remoteproc: qcom_q6v5_mss: Use mss as regulator for
 MSM8953
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20260327-sdm632-rpmpd-v1-0-6098dc997d66@mainlining.org>
 <20260327-sdm632-rpmpd-v1-3-6098dc997d66@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260327-sdm632-rpmpd-v1-3-6098dc997d66@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PJQ/P/qC c=1 sm=1 tr=0 ts=69e0e4ef cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=OuZLqq7tAAAA:8 a=_svnvpbr5Yy232N8lfMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: QwzqstK4ZJBHg-cuE958mY_Fmv63D9aE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEyOSBTYWx0ZWRfX7jav37lyjjYJ
 MBD9oob909VM/LVjTE2xK7+nrvpnbzXb8R66CNz1EtqDug9kN2z+14bLHboEf1nC73Kd2sCfW/7
 pBlf4hpx046rmRC4xJbXJlnv3Yshs4TabrDdDKK1+79H+apGn/rylC3976WbyAc4WhxN1GE9Cme
 IApv/484VicLx/mPvDPhRyk7BDg2F8heHck08PgX5DsZRIliWiUqV3UgQIHu3+1/le161wRUPkU
 Xmjxl6CH40WxkIj05QhpU8RVk87FGfCo2JCICO+QpPlOzjgIwxiXVwQSany2HmDz50FINUNHnej
 VoaP8Jw5hGauFhMGPCNcnCnECl9/U3pWauioHSTV1pfaP8VdQpA3u3KmrhXGIHzBzChvVQQtiTU
 tLT8Ohy2XscIaxCY44TYL4YP/mhCQnFIJJpLrADvxbdh27dz9uToxEREnnAJleTS1aU/UiQ0mX7
 MwSRyE+8aRrlaEtZasg==
X-Proofpoint-ORIG-GUID: QwzqstK4ZJBHg-cuE958mY_Fmv63D9aE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160129

On 3/27/26 9:11 PM, Barnabás Czémán wrote:
> MSM8953 MSS is using mss-supply as regulator what is usually pm8953_s1.
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index 4e9eb5bd11fa..86edd826ede8 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -2705,6 +2705,14 @@ static const struct rproc_hexagon_res msm8953_mss = {
>  		},
>  		{}
>  	},
> +	.active_supply = (struct qcom_mss_reg_res[]) {
> +		{
> +			.supply = "mss",
> +			.uV = 1050000,
> +			.uA = 100000,

I don't know if it's a typo, but msm8953-regulator.dtsi on msm-3.18
suggests one more zero

Konrad
