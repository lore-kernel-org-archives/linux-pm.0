Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364870;
	b=nz8fWU7kf8aZ5PeDOe5EDwBPU+suUBszXSthWd/6+RQZpNm+fZeml3m8KXW07nprg4E3
	 /lfuhLV5qLM19EcD9JFNwORQ/yXYGpaINpFpSaRsdL4MlazmiWxc2HAvnmSNSzj3C5Fbp
	 VncbmJOEe9lVQ/7s+tos9aonpsAJsP0IfdsQ92L/VvxaVeXDbMTirtfRrpkUktXe3ewYX
	 +zJo5zatI1+fJCEZxfLxmnK7kryvxokulDNd7JdXkgepDJmo5prgCFjnU63SG9VKKsp35
	 HQ2h+h43CEBwmAXLaAyyewOoo40odomJi1seZdRbMR+bmvOwTuY8+3AeaJD4iKqheig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364870;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pJN7OniSPVy0+buIjyCXoBHR+lwJ1eKIsrybnLKWdwo=;
	b=NrFtmNDXfr5T7bW7nddjSdB1GrMuFWkVcXL2pBmqIHFyJgFmfYeaQ4MnZoraxXfzOnGC
	 aTNUF1F+6tl1kzAkQro0zDsoQifGaHxoXGiwdtb2AkQT1wRal2q3p1AXwFp8fPcDIdsMo
	 Ms8QjPAQmtAnBxG9aASq/F1T1x/GQsfTWYxaQ0aYU664whqOjP8XmMT/wfqU16zO3+4x5
	 2TtD2Ba6XRftZH5KJFe5w+tWuWvPbo0bpvqZrJ5Mj6gXf7nRKc6FM+1CRd7K4Gqqmf61s
	 +7uAsSqANTJlj49B3yxVwFKfdwAEiDPBb2pxZQDHGTc/Mspzo5lbdf/sN6dFc8legQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R2hgXAaz;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R8v9JfxK;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7233D606A31E
	for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 12:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7233D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R2hgXAaz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R8v9JfxK
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBG16m2071543
	for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 12:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pJN7OniSPVy0+buIjyCXoBHR+lwJ1eKIsrybnLKWdwo=; b=R2hgXAazkcgtm8S6
	6Ksjoa2s0v3Zvffkjb8nFWNB1d07jrWfdScfOLB+Z9x2QULsUNeXsCt9oLVU88oY
	xWaOVfvb8EmsamAGr98O9YwOywe7Oy/YvTvtipITnfTPW10m+QIV6wdpE4ahUt15
	5E6WtSAQSYPWlriD7RFSBuTZTAO3aFoCOV5Vch+C2+vtPysDhgN65866gbmqlGKk
	UXCe+oWmM4be+XGk80BPxE0rRNiaeoB6jeAwCEdVWHGQUUwwElB4X6Qpv2qz+htK
	/rotaXpto/KIXKWRo3k1E6CHwcz8jzAuOurL6aJp67hwL6JobmYPPpjMWUv+x5PO
	R2E44w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p34vu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 12:54:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92eebb130dcso14919785a.1
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 05:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793364868; x=1793969668; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pJN7OniSPVy0+buIjyCXoBHR+lwJ1eKIsrybnLKWdwo=;
        b=R8v9JfxKQAejQXPmCEnLiyBW4JKjzFFB6T9RHAriZ68xz+pcUxMWCaP6Zvmk+6/dG4
         JoVbPnY3Yq/LhBDmp2IEaJFzxaJptaukKzwBbVjNe9R6GU1Md7ffD6sWDthM434OZ0Fa
         /qhnBKUofNum0Nxbe1S41162OjrZDBSiFaUXeekD6ufYT/1CGVqU+Gm/8xJp5bVNGgFk
         FRUnmCsDXMrZbvE5IF+3DTmn9AXJ5UmuUbWy/n1fdSfooeAunPPpc9j30kMcHyZ5Q9eC
         SRvWCErc0XqfmHeyeoLpWDmSBzyH0kZUgJrluizfwKWKECqrs1DsLXs/r4tHdZJNsK07
         c/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793364868; x=1793969668;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pJN7OniSPVy0+buIjyCXoBHR+lwJ1eKIsrybnLKWdwo=;
        b=ZWrl1HgWiG9IBHsFZLrJ9I8shLhRVb0sANiqXoEEO9HZ1OgW+kkVP8pxWJfBTDJTmt
         SI3mYbkUCh2DexJV+AlCEbBGBN0jnh3tV1bPEj2pu1lBplrEBO0VOovZRbmJwRq6PMkl
         ueCda68mI3laYMfSDsYThy3+XQDJY2zKNmkv27iv4N3De9ovSDRwtCeK4qmVoiE2nJoL
         ZHlpHe2qwOQ67cfRmlUNI9WSVB5EaD5wQYu3EdBvcoM4tB2zX85NGb2Ml1kSbB5hGN3G
         rVoRwSRdOqhQBi4PD8swqTK2MGqkIJj4S4RMSbUFCr8uv7T++IDpFIsyMmwC6glKDbc5
         kXhg==
X-Forwarded-Encrypted: i=1; AKwUvBxvwlVp1raU3ziRly85+ciEDCZW+5pnIpw1neQjiw7ZVrNVoIU2zFfuVx4M4jpI3cD+rNOcRU1GKg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKRy/tY9QHJ3GgpAir/sBjBobiPKPef338sq1FEM0L/cC5cqFif
	8952QfeWAKUNbG+yy5ITgl6OVoi46KU1+eH094EKRHY3RqMQoRFboShcP8FlHZxD7Am3s0LPNXY
	wUwgjJhiNFVSKP3mgQoEGLrmxTNx9qoGZw93qqISLUa9dv7C77wWCIF5sAlJsaw==
X-Gm-Gg: AYBFou3uVtwGSXSLE0sbudiZnzyIBcYdFsIbCIAprvlffGjbdJ9Vl6EV4hhkWa4hUaA
	Mh6oNqrmIVK5VSiul8FW5GaiPF8gZP3I8LD7cOvmALz/XQnUVYFq69KQpn0D08MtqcHOrC1m9na
	p2r8tM6PrjK1bI5zHnyUBnY6hhApcpbutRdmYrE2f9sjGos277b6Q6b4CA7iunLkRlPtsdEjQKd
	1yvWrw4VPLG3VtfSgk1zJS6OHtnRTA55YlD0aXOGNSowM3PLXu3Kt9to5yy0ZwxAJkqm/Oq/Ms8
	HDzYsRJcnnBY7CT6a85tIKg608pTv5IBZR+QAqllDB0ZmTtvrI0RvFYJ/BllfLekTl8wippFzMf
	JCDUVblU3rgnaEBJwgaH1Svzo66ROSaU4J4s9Ky8Kb3QInfLoV8LBrS22iUi9u9J9JbfRsF8=
X-Received: by 2002:a05:620a:a7d3:10b0:939:8bc:8826 with SMTP id af79cd13be357-94421529babmr363507285a.2.1793364867683;
        Fri, 30 Oct 2026 05:54:27 -0700 (PDT)
X-Received: by 2002:a05:620a:a7d3:10b0:939:8bc:8826 with SMTP id af79cd13be357-94421529babmr363503885a.2.1793364867295;
        Fri, 30 Oct 2026 05:54:27 -0700 (PDT)
Received: from [10.169.205.110] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4d7ae6eaesm590547a12.13.2026.10.30.05.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 05:54:26 -0700 (PDT)
Message-ID: <c4e3943f-a4c4-4793-8d44-0b578fdb6463@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 13:54:21 +0100
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
Subject: Re: [RFC PATCH 3/3] arm64: dts: qcom: tiare: describe CW2017 fuel
 gauge
To: Kupreenko Danila <keckerz@yandex.ru>, Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <179329639684.489944.6322623410181934358.cw2017-first-public-rfc@yandex.ru>
 <179329639684.489944.11313132727575469130.cw2017-first-public-rfc-3@yandex.ru>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <179329639684.489944.11313132727575469130.cw2017-first-public-rfc-3@yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1MSBTYWx0ZWRfX9qrQM+0ewCq8
 G8JB1lUMbyZbcK4qcnUYDv5TPRXqVy3cgyE8VYLkJZyF7njWPGY9COt7MxNE4JdbN44uIw5nPnw
 /H/W5iAwkMarkuvdLYixdHEJIfn0xMZ4gPzAxoCNz5Ge6htm90SqnI0h0ChmM0i8fud3uH2KCv1
 VdVXa/yFLlpDo5MrJbGlocgAV1uGg7kyM20KIWFDcCKTgoZPreMv+cQQRv5kF0niwl7WnWE7fjx
 kJLmWnr5yIO//xvqwiW+cGUHWwwR7x5uKqhcHXSz2xOnr99DBLsYOgDT+8ICxh3jsZR94rlKu/X
 W/vkhxJgsUI6seLQtyTUWk7ijab9+ZRmpeUy5CdzpW3iwbNpdWQd0/tXgNAUvHmOESvsoWmp1cu
 f/sItjouycizTzm9Oie5w5dy5b8a4eKe/aSu3gsmy4JTqzIZpbcx0W2nEsqYIvDIl9MMl61DT1H
 a6fgZQQq8F6o8SGshXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1MSBTYWx0ZWRfX5d/+CTRZWIfD
 bm4MayGGgB9vY/yTdLZ0RLjnL4uWD7M1O3P0ocZexkbXRpdVqe1BrOEUoV5uHEhq4VBS+JbJlef
 Ouw1NoPIUDEQR062MEwTTyDNOdjKZLk=
X-Proofpoint-ORIG-GUID: fioDCZ-ef1D75NKGWi66MAijIDbdY-1z
X-Proofpoint-GUID: fioDCZ-ef1D75NKGWi66MAijIDbdY-1z
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae49384 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=vaJtXVxTAAAA:8 a=EUspDBNiAAAA:8 a=ogegbmFYXjI9hOOK5TYA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300051

On 10/29/26 6:53 PM, Kupreenko Danila wrote:
> Enable the I2C controller at 0x7af5000 and describe the CW2017 at 0x63.
> The controller mapping and gauge response were demonstrated on Redmi Go
> with Linux 7.1.3. The independent monitor also registered power_supply
> on that kernel. No charger node or battery profile is added.
> 
> The resulting mainline DTB is host-built and schema checked; it has not
> been booted on the device.
> 
> Assisted-by: LLM
> Signed-off-by: Kupreenko Danila <keckerz@yandex.ru>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
