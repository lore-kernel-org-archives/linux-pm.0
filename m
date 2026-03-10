Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E4A3845AB
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140266; cv=none; b=kanGkkhyD1baDoc76mExzVC3PVh12Bb7cBojNO2QnekMh6pw0eHJjOgR5vTEx9TDdvapRcgr2Lmgmpu1tgFUpMWintvL2PSM2p7nDKXgEkL8+MXn1AJVAHGXA5zyZinTsdNzGxHBUd5p8ypUXAi/JZTX6fL+xQpQ7Job8MophFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140266; c=relaxed/simple;
	bh=2sZKhs3kxipcKqLWw1bDogM8lDDGnZ73NTE5kpvVObM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qMqgtrOWaXP8E2O/qTkcGA4aKEj0Cg6U8LdEvnZjQyvM8bImCETPlrzvYxHiJTmO3dFcGjbZNFYFovOFiWbIe+aeAPhuzB6AvfHPm1P8umdnCdB4y5nJWx2lovijJBPUOuo82XSyLJYtutWh55zRLScildD4pwgsznNCdLwwgoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SeLJ/555; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j1ftV8KX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SeLJ/555";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j1ftV8KX"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A7wJYG3124462
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 10:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZesGPSQea+/zVMBZRRHwVi/ocDIAP2gXJwbjrhhC7bw=; b=SeLJ/555/3YsoLDj
	EmVnCY7/wJFRjs6Pq9O6RVGqCIltmeHEE6zsLd4e3U+OmJZlvsaqby2XWLCJ9sJD
	NUt0YRQID6LFzf9ukPebcVyQLy2W0r3VoJYm0xNVhIMgSBoFRScN9sKjyqA4LrjE
	iTGcsHWzgakmjxauURNCgGvlvZPWUeWbCW6nzjd4Ia+uHDIBcx7lp8O77bJl7mph
	bToGAGYjPiLnvylkSAvtWCO8CBsxrLulZWDv91kC8OOp9dJDSfz3X43xpjrP1FDM
	G9tO0SQs5vvIXxyMFfA98uIL4mwIsZ1RWOqCimWfsf0Tm2cvRqq0xxB+mS87iIZy
	F/Dwmg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctfcj0qut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 10:57:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd8dc8b434so122175485a.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 03:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773140263; x=1773745063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZesGPSQea+/zVMBZRRHwVi/ocDIAP2gXJwbjrhhC7bw=;
        b=j1ftV8KX9VI38HuW+nf1pLMkg0vZQ+J3bXh0q0QmzfW18ZBqXTp6c7hGf7Be3bs44t
         5qwt19lrw3pdPuybR/Fd4vNoyvniBArw4swDWz3aXmCcLJZDd9RswmW5E+IxkMqEJX7z
         kPmAyU7q6Wa3AV7L3vInTnGi6etEVo+OElJROPhROgpF+cm6lnqquXaGc26UroI3RfrU
         xAKtfEb2LFjcCW8HZonAS8GDAwI0T5SAat3aye79p9if5lal3Z+k0R6zdUXUKvsH4wf3
         /oPnIB+L1mJPEjIwYsQzax7TGE/S09bd1kXnnxH1rkwuSCTiVjKK9fBSJwGFcahYep1P
         BZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773140263; x=1773745063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZesGPSQea+/zVMBZRRHwVi/ocDIAP2gXJwbjrhhC7bw=;
        b=U00tlxAJzzbLmfiHDVZfrPyYaktyRKbqyR2rS+55u3Amhg+rN3jjqwBlYnzr8/hAOd
         g0F4zR8FRaJ6zSJop9vUY44QrzT+rKuBxreOJdgiE3JEHsWsvLUm3s73KauD3QbYutIY
         EbuvtAs6TvoLVxYMSkuQAroCiG7xznMd6cs8ZRp08E7bJzT9VZvTi3eLah+tKLeBaALm
         J78eAHuZaUDj1PSb8aI8dGTFm7FrvgRWs4UJ0PopRAg1UAbMwE9IDB+N2eu8h6eRYxbO
         PLWmBkOlpkbLXJ7xcos0ggroWrfbVUVGa7vdc1IPiuNx4A6FNVCwUmnlJAeQTtTWSqii
         27CA==
X-Forwarded-Encrypted: i=1; AJvYcCX5CdnBCCANdi9+7P8SXI63ZoSI2es3ahLJbmsevMm8BVCdUissGzahKKtFsXJhibK0fj+MTNf9CA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyWadoZrVpueFQ62vfET1Tu77jpjicZBLDjBLmN+dXS5h630k2
	8iFr7NCWCAhEv/T1qLXkrgWnonNS++JhMpLe7UXpykkXEtHfiZAnlmER1ghovlpZe0bmb7oKkYB
	rAcze1BgGicv3vQIyzHEMjuLcWIfcdy8jD6WLaHEkS5jAYWRySZR3k/2rBAk5fw==
X-Gm-Gg: ATEYQzwJYqHf8pnPJEL40qN2EJvnP2Gy4Rmgs4CmMyb+a0nmPwQw9zmDKNcFPiMlilr
	PIysNPCXldL2CSV6t/mfmEbfsq2ojyMHedhBGq2VkQOtbQA4wtgTOWfdIlCRkYDnwGQQU+ptM/h
	6Y+r0nHB93azyILFYsKXVH0XboLvfqiLr3cT/SaWQAu4ykiHyyVno+wt4jArDA9SqLqux8rFFio
	rUkF/iz4HLM0E0Zvl2Y6Bt6DSDt/bqZrPBFE8/K7hPrmcd4czjYNHHuS03x7xqbU1ND1EViTmxI
	no94R5NQUAgDDdQwk2Oar5+QzZfyisVxTVxTOYS6RqZL48YaBRZrOpzcKed0dOyLU07xiCBiWiv
	m/127OERe0WK36U6Xo1dcqe01+F5l/mCMxGRF1GKh58vKccV4g8p86DQfUe+w8ISWNWkGWyAyEv
	WMR0Y=
X-Received: by 2002:a05:620a:1a17:b0:8c9:eae0:d1df with SMTP id af79cd13be357-8cd6d43bc63mr1455915385a.6.1773140263021;
        Tue, 10 Mar 2026 03:57:43 -0700 (PDT)
X-Received: by 2002:a05:620a:1a17:b0:8c9:eae0:d1df with SMTP id af79cd13be357-8cd6d43bc63mr1455912885a.6.1773140262504;
        Tue, 10 Mar 2026 03:57:42 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942ef8a861sm474036866b.16.2026.03.10.03.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 03:57:41 -0700 (PDT)
Message-ID: <caa23d34-f71e-40f5-b142-dde53e95b6f4@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 11:57:38 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sdm670: add thermal zones and
 thermal devices
To: Richard Acayan <mailingradian@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20260310002037.1863-1-mailingradian@gmail.com>
 <20260310002037.1863-4-mailingradian@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260310002037.1863-4-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H7fWAuYi c=1 sm=1 tr=0 ts=69aff927 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=Asad03Kaw1qaHcbSJF0A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: fQ-PYj-Lui83pA8PthUNcLEWywSgk0_j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA5NCBTYWx0ZWRfXw9ED4+zW/+Ow
 qq9st/LhpgscAsQ2LnVcZZTEvpeKBG/RUGnBw/SJHjhRGQpwUTgFczKCnoFXyEk2gV9B1SFPjjW
 FbkmDYOhYaxv8ZoEX5pIPrgL5aYhQNs8ujvVjolZzBJ+6j+Y9YuPLfwld1JETKN3o93Te37COlD
 yjohiMVoFg1YEi5NtqVJ05W3AwiVJ8XJVECUeRuCUgSocwiw6ky0rffy+BNUzkTXcXlGlwxvIzd
 JuDptdzVZMo5PQd38mLJ87UlGPjrBv9YYKtr9dBKLO6PzxS357kjpN8Pjrj2hwqXS5l7fqcMKVX
 zdK9dQUigbXPvjmgzWeg6xfmIQrpJsrgYRG4K1buRk1lE7akxMmcB+5jFy2XzKIHiMssQlXUvDy
 sUmXRahqJDGNQmZq90bOn5U+qfjFcccvSCRw98pl4qZrQiNwVMGoiaE5NhYQDZL0oUQ3kAaMbxi
 V4UVBm3qswWlLtejwOg==
X-Proofpoint-ORIG-GUID: fQ-PYj-Lui83pA8PthUNcLEWywSgk0_j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100094

On 3/10/26 1:20 AM, Richard Acayan wrote:
> Add thermal zones to safeguard from overheating to high temperatures,
> along with the thermal sensors (TSENS) and CPU frequency limits (LMh).
> The temperatures are very high, but should still be safeguard for
> devices that do not specify their own thermal zones.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---

[...]

> +		tsens0: thermal-sensor@c263000 {
> +			compatible = "qcom,sdm670-tsens", "qcom,tsens-v2";
> +			reg = <0 0x0c263000 0 0x1ff>,
> +			      <0 0x0c222000 0 0x4>;

Both regions are 0x1000-long for both controllers

> +			interrupts-extended = <&pdc 26 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 28 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "uplow", "critical";
> +			#thermal-sensor-cells = <1>;
> +			#qcom,sensors = <13>;
> +		};
> +
> +		tsens1: thermal-sensor@c265000 {
> +			compatible = "qcom,sdm670-tsens", "qcom,tsens-v2";
> +			reg = <0 0x0c265000 0 0x1ff>,
> +			      <0 0x0c223000 0 0x4>;
> +			interrupts-extended = <&pdc 27 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 29 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "uplow", "critical";
> +			#thermal-sensor-cells = <1>;
> +			#qcom,sensors = <8>;
> +		};

[...]

> +		lmh_cluster1: lmh@17d70800 {
> +			compatible = "qcom,sdm670-lmh", "qcom,sdm845-lmh";
> +			reg = <0 0x17d70800 0 0x400>;
> +			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;

I think you got the interrupt indices backwards (i.e. 32 -> clus0)

Konrad
