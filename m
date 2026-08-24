Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992083E6DE8
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561575; cv=none; b=VFoGr25AJtRiw6qtARbcnWAkUvM5WxNflbE3Tq/aAT+nUKWsOMz9mSmcOZ6RzASzC4lZ8pw+GcWDnSxI0e0knia+IYKg8Yx5ysWbqVxDCl7Z7MuNT6WZqawW/MHQX4xqa1TTWESgGQrdR/Yh59GEujw7UxhkIAxF4YpIjtd66DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561575; c=relaxed/simple;
	bh=DKumgshbWin+GIVZDyjFXqN2fIp+BEAViJFEGBnKa7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XH10D9UrTBQ28AmeE+sD6W9OjArL1zKEipIn8+XVJTiGKRNcbAp2Z559mkTQ8OCD4WrXRaQTjeo1yGKU+XEzrKaAAs+Mb7vJFZWgAb8GOKT7HV8c4W/CJs3jf/ZInqdajR4ft3o88cBu4qpPoUuqTVtSuJham+gIAFXGlvd///I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GSVZZzUh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LdUWhUdq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GSVZZzUh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LdUWhUdq"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5RBgh3066883
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 08:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	81N4kV2o1v+XvSH/7d55uXGNnT+DU5JPpdy5v1w9dHs=; b=GSVZZzUhLuZQfqv8
	/2ZAsYAZBLLJzpHUDcjfkMdb9+IBApxxFUw+5K3dnyfz/81/6xVdhwm8qGV89BC0
	TFKE4W6+W6p7tum8OwX5LTFvsPYM8fBuwzkpUFdt3GcOTsu4JiZpZVoaiWj4E7+c
	Idux6HH1czBmHHVMPYnCZv+TgW9bDHfuurm0jXHwbFRnrWE+qDoi8sLhi3ID4Sk1
	rgczhFQr20TYKZl0oAM6blLnxakSeFDPIOamN6cELlgyik/B+92KqoWM3IOp3O0O
	7gziYK04nRdmSAUJNBmqe++6afKS/zl1DqF0vRXkIaiTLSO7JzkuwDOWrr94+BdJ
	3r5hxA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g88jphs7c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 08:52:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-936bd9b045fso30200385a.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 01:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787561572; x=1788166372; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=81N4kV2o1v+XvSH/7d55uXGNnT+DU5JPpdy5v1w9dHs=;
        b=LdUWhUdqSrhjIFIxrUcoNnM/a9qFLjSCXrbDmGDtQvalgrUwo0/73W/+29DeuCGrPJ
         s2TAm6slloEbLBm/MkKs6aAVnDARZqu+KpT3OMGjz9YTzsfk1p31n69VTddq+qx6Oqzl
         f8BKXXtaPBkjh9vRxQzredi1BC2olPQGoTFGroyks60lrm8ozMNfOjCk3a3RUjeUTsMA
         XBDNfDWmm/68e7Bm5/wVjFaKH6+3rUgaMs7SLqmu+LAGFQuqWV4FrZvfCDxNhRx0yJ8H
         2+b72aeehm22NZSs6NHJVdP/0c46Hz3fJ13GzZrBYC1qoUA87ZgCjrOKB8Dke6pTx1mt
         oVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787561572; x=1788166372;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=81N4kV2o1v+XvSH/7d55uXGNnT+DU5JPpdy5v1w9dHs=;
        b=NFDIF+wvXy5L3FOAGGNlqe0D9vqkTgl4Ose3SuNNlumWq6u82IfJSg8PyYAmEuwG/f
         ZsBRGJaY95Ml5Q0UAoTNWAuv28fCg1VllRHn6gvVdESe7gi0mbBQ485L61WbY5vHWCyN
         k+jSaQAzQMYljehIW7QCdIiEyXPZvJ0ZF5hwvdAq2eKsO75k6XuuoMLdS0RawOiQGa+m
         nxEIo57ncoTcicW2AlWdu1tvZqc1rq61QN+/3Yw2sgjU/FriopKkweH0NJjjkTVkHnxo
         XLKAbo1c3VWz51j3dotl3Vay5k0j6vnN2PmoAubn3i9ZT9pmwdm3BDChTTkuDxINiaOy
         s54g==
X-Forwarded-Encrypted: i=1; AHgh+RqZ63g7FKe7cTxYzYtITcc2zz9N2cEz2zGm5pBlLREAXRuZ5cUB9p3JsUCbvlCCimuHWeoihNYchg==@vger.kernel.org
X-Gm-Message-State: AFuF++mqKnQYu2Yn3nBJeNGE+byOwbPXKc3n8vGji66jwtRPgo+CK9/N
	smkIpxvcieIRwPMUhPKmJ/+GZ8IEDu4KVGN9YLuz80/oTVvlJMY1H+Zr573YXOdffb0sj3/2tte
	WxGDKmWBTsFLMvMVoKY9YqMRrJOCxhNEXp7rVvo/7uWPELqJi+m2/NtzMeA/cRQ==
X-Gm-Gg: AR+sD11VlLLFOMBWThCJrGnUlzoi1P5waMlxND1PTUwd5q0x7ELDiJzB9kje3CECcVd
	uymoeCZtRH2xyeTDiHJktQNpXPmZlk5ozB1MLeoyOijpcAmrwKfCZKdoOnbc26Ns10NiuzPF24/
	SzeRz8NmYaXVNRXjVUMEusZeIymNj27U8Fj/ccQMqy6MhFTMEdQjLgVlmpVDr+F+EXK39TrT6Kp
	FbXUX0HeTml7QGEVt3g1XtV29bbBL35lw8yFB5Eq+84xEFbOKyG77F1dg6R/3x/zlHjBuEwk0hc
	V5fko+acSoPgPVRr7WyBAgeAdA7hAggiE86n0d725DFALB75oLmsP4dj59Q6lgH6Pve+o8Y8tkK
	vFBuwYxpjSi10s9NhuZjygFSu
X-Received: by 2002:a05:620a:4804:b0:931:23a:83ca with SMTP id af79cd13be357-937397348c0mr1615429585a.4.1787561571858;
        Mon, 24 Aug 2026 01:52:51 -0700 (PDT)
X-Received: by 2002:a05:620a:4804:b0:931:23a:83ca with SMTP id af79cd13be357-937397348c0mr1615427885a.4.1787561571465;
        Mon, 24 Aug 2026 01:52:51 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b60asm1065146866b.9.2026.08.24.01.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 01:52:50 -0700 (PDT)
Message-ID: <d8093899-48ba-4e6c-a61a-144113b39c51@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 10:52:47 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/13] pmdomain: qcom: rpmhpd: Add RMPh power domains
 for SM7250
To: Sreeshankar K <sreeshankar0910@gmail.com>, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, konradybcio@kernel.org, tglx@kernel.org,
        ulfh@kernel.org
Cc: bmasney@redhat.com, radu@rendec.net, abel.vesa@oss.qualcomm.com,
        lpieralisi@kernel.org, quic_tdas@quicinc.com, danila@mainlining.org,
        davidwronek@gmail.com, mani@kernel.org, robimarko@gmail.com,
        linux@gurudas.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260821154030.2514-1-sreeshankar0910@gmail.com>
 <20260821154030.2514-9-sreeshankar0910@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260821154030.2514-9-sreeshankar0910@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3NyBTYWx0ZWRfX7d0d9Fm0mPJb
 x+qWgWtAru6kQQWOIYR84/Tla0N36GTHm9V//zYLE02QVxEOMimdMXjMBpD9Bg1h4HVmY/jVuXz
 sG4xerDLkKMj1tI9GkdJoOxBdFjgvooXLG84CJ5+JB9pUW/RgcNTSoP1z1DoxBrwt4/gx5w18vj
 2IKIFO9P7Pazu9re1mYlDY++8AJGxrXj8+1E9uGViK6wKAM4+mQHr/VGz/ANIWCLWzWETbXpci7
 0NxpDx4az9FFv6t1l6zVyDR9jD9A68II/KN1ExENPQVZ4yRCJTXbHIa6m2XZQ9mz3P/9Mui1Tfb
 33qOT7nHo4A8jjApvQENLWcW8cueqIWS8GoU8H3PwZ17+x2YR3hXQwS8BZzRIvPJ9amBa4p89c4
 vbeN5iAwLnWcBDQUYj4oI79L6FVHYyQW0ArvkEm3nsDri4UPTl4JFzucW3Loe89syrEHQEKY8Ut
 bxcn58g6/rDeNHbyekQ==
X-Proofpoint-GUID: hHkrtvRArESTR7cYt0k_2o2a5WecRqfo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3NyBTYWx0ZWRfXw29VOANt4TpG
 LmxcxrhkVTVUj890VeKP5HKsALJ2khLv5YJyjMi695BCz84jt1Oyt//v3E6pAqi0jhVVMPjaaKM
 Yc5eZMmR1YaVfKJG77zxBqKUqYr4/NA=
X-Authority-Analysis: v=2.4 cv=Xey5Co55 c=1 sm=1 tr=0 ts=6a8c0664 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=0Fz9-S7UgyL-nH97HSEA:9 a=QEXdDO2ut3YA:10
 a=Z0LeWUw4VpMA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: hHkrtvRArESTR7cYt0k_2o2a5WecRqfo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240077

On 8/21/26 5:40 PM, Sreeshankar K wrote:
> Add RMPh power domains for SM7250 SoC.
> 
> Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
