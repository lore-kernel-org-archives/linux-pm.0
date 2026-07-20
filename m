Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBF6305E3B
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537300; cv=none; b=K1d+PjHR9rg/Y3hdftcpkUfO2i5BYAdfJEUZbSitUXgnGg+RNC1N7py4igPLfWgG121KJixfK8KbreG2xJbod6AYeos7c72f8yguQGJ2i/giscruS7+zXDvTNT/+DOc4GjUljFCcweqA/oi8tRorHuEosO6IUyLXN/PmHDnDr08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537300; c=relaxed/simple;
	bh=88M6mX6+xZtRa4h/hGHs/FKdReIvDzARwgiR186i8hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZBmd2GI07wjBcxMiEWGNoVHu/vtvS1JSPwdpWC2PzWIzUKhcUrnNLD3YBelnyK6pEErnL1k7rE7+zwNvxjLNS9Bf3fIcPyeJKpCqGI+B7ybP2vXJ+t8PKFuyHKLL7apv2+c1P6kOTsOqMF2W9VzQpff7mQQGVglGKlEANNA1OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o08ESG+p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WW0aAtZl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o08ESG+p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WW0aAtZl"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K7rdYf2979848
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 08:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a1JTH3wU3Ng/OHTb873hnii0bjM0B9Tou7rMYKtlqNQ=; b=o08ESG+p8dccA+36
	tYS1jebgUwu9lTvO3u3UfzFH5ivU9r7fWXjQnVwkvQBKexewJoQLVMUBHaC3ptw5
	HAoml4/Wn6koksiGPKTQGidsmNyK0YlgFznbBmrB2k1kwdH9JMBohGkctEa1BJLO
	GT9EeqSqQGtfJgsKLprP6ewmA9oaRvgML1hvhrsiLotlu1A61ZgkTXyCl+tMQcYO
	vIqTPrRcn0/C51JSwNPvgQUwxgkzm+/gCev2O8XP9LwgK3M1JMzg5jf6R7qMGwPJ
	nVdBX+GVMXc7B5aHFoJ0s67Z1Y69wdczrq2fQByI3H7owtp71zqe6m+IuaCUQnzl
	4ryI+Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfpg06w3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 08:48:17 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c069f73e4so21193771cf.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 01:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784537297; x=1785142097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a1JTH3wU3Ng/OHTb873hnii0bjM0B9Tou7rMYKtlqNQ=;
        b=WW0aAtZlgm1YYlvlLp+umeF6stziGWejMnD+BBPQgWLMLXuHmeOy556/JeijF0VNq+
         R0XWlzC0Yw9Ju/6sYIS+RAHTX9mVlwZMyoXJroTP1a+P5U/ZrXUgAA1VLTB4TANdJ0Md
         uuUo7eNNZoZFtObg+l7xlmTFt5d4Bh7Yn8lqAyEWKQCsARjZRAO3BSlye2UswPFSDjv9
         C6UnsnQze4r+bblewqmJOOxDLhA+64SQJka+IyEnaWHvybXcls0UbcGXX0b4019wvl++
         ir6dafNdcEcrnP9M3KUP6hFb0wICKzJfRls9pAHZyHmHv+Vcr+WRQmtIvUzk0cBXzq0S
         qTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784537297; x=1785142097;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a1JTH3wU3Ng/OHTb873hnii0bjM0B9Tou7rMYKtlqNQ=;
        b=I3N5tIPPMRD0vd8NBI0ipQ3nvQ8Zi1NPzu3BqJU27cyezSCL0a3wL7S0SlMrwyqqeG
         KUP51aU/Y1Iam0kSh0Oi3B8rDNwbgrfrrgWFCApcXwzfr/JHnyuizP05nF8cXHP6L5Sx
         8Kb4FCGSuLp0dJ5rq5xYv/RWUIDQon3qkszmvMu8fblTvjvwPR+kE9bTjsabg6ykuDdD
         4ap8xiMgaXUzvDajdno9Jjpg9UrvXgryaBVOWc6kHLkquF8ZqUJ5wHmCjTNOldAdH6a1
         WB95/3RR8+66uwt9QqVG+PiNQB2qR4gL6HkDUz10Go6i1Cinb848/pt1OStZbMX8UMWm
         7+jA==
X-Forwarded-Encrypted: i=1; AHgh+Rqn7lY3BSp4PmOEtmqlXm6wDD8gKlR1hQBZKEszGcpVCQPKIcg+GjFaOAP+GjJPm/gS8SmaFy1kYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjGlhZoacpk0Z5dNplfEmPMA6oVpHI5sWbAClLqlNWTg5e59c5
	Qn6WhW2T9S0uAAKELx43bd+JOIWfdcGK67wggUdDffsb7Hd2vZOXwtpm1q2G9d+vWpGsXvCIzjt
	ge3sSAGtBEnJpfWjWIjXIRnQgYXM1JZtMlG5m8wU+NIaNz9G+WEB1SFJgh+fO9w==
X-Gm-Gg: AfdE7cl5/j3x/yQYNXVjmPSHoBWAGogiTNtfBuvyEFSw3s0iPECRizvxc3ktj2Qbp6C
	hkuyUG9ezmRkEDNxLaaRl2mAkNcJEtWq/x5iOrdDDjjETVxihQSEq4ee5LYYkPofjgZazr8Ci/Z
	Ir1ArB5O/ACOqc3bFdEqYP8danLFrkSUT4Gc/cpJCSgzAN6ezBkla+ylJ/bIkyAeyk4AjicqtsN
	jCr9oi5Qon4n82I4i+c0H8d+A2tBDhcsWhNu9lCjCKMueG6wuCcZWI5s9r+PTb93lmcDbVDRI6g
	enqdJlhFPHcNvC3zZZXaiWBP1qsb8prmVJxXSWBjDYg9t+mZFiqWER0RgDPsCs9xPQDki8nWguj
	JabRaMf3aL6+C6OagXrC4DJOy
X-Received: by 2002:a05:622a:2515:b0:51b:ff1a:3d80 with SMTP id d75a77b69052e-5213e67f307mr107117591cf.7.1784537296885;
        Mon, 20 Jul 2026 01:48:16 -0700 (PDT)
X-Received: by 2002:a05:622a:2515:b0:51b:ff1a:3d80 with SMTP id d75a77b69052e-5213e67f307mr107117451cf.7.1784537296423;
        Mon, 20 Jul 2026 01:48:16 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1712a5fa23sm428198266b.39.2026.07.20.01.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 01:48:15 -0700 (PDT)
Message-ID: <49f442b5-0d47-4f63-877a-76ddbcc92959@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:48:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: milos: Add CPU-to-DDR BWMON support
To: Luca Weiss <luca.weiss@fairphone.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260717-milos-cpu-bwmon-v1-0-dfe0bac9898c@fairphone.com>
 <20260717-milos-cpu-bwmon-v1-2-dfe0bac9898c@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260717-milos-cpu-bwmon-v1-2-dfe0bac9898c@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5NyBTYWx0ZWRfX/MgjvJfrBqhs
 t/3R0tR5IOYRp4nBW1nk3LVSo/piFVJpC8ty35uzG2PqIJWTNaJZYdJnv9jtS8uUQTT3Vym0PTQ
 DoEELuANIDRny1MXjxepPZj5ktv9rYA=
X-Proofpoint-GUID: dtgjj0CiaoSy3vhgC-5L-hv46S4gU_hM
X-Proofpoint-ORIG-GUID: dtgjj0CiaoSy3vhgC-5L-hv46S4gU_hM
X-Authority-Analysis: v=2.4 cv=c+6bhx9l c=1 sm=1 tr=0 ts=6a5de0d1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=9qgqu1SA9pjVKMr9YXcA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5NyBTYWx0ZWRfX5whZr9D8GJ3e
 vDBuIzG3kRnKQQqCUvQpvaTNfXFZgi0BunPJVfIf9VvRfZMHg4oKA/YhU8tOR4z7ZBBoZ7X0cYz
 jmSqSGPauJw0edSNncvL2/pdBR7m5vELkaJWTa5KYWHOT+XTB5BnREE5SKTgDfS+9GnjCYbahBg
 /qxE3c6kyKuEZa6jTfW9zXqO7m3M8CjsXXaba3xngaVuU6No+bLHTRKNMRNLIRNRW/hmU8Pbz2T
 VED1XVNxOFCrSKVqDj9CHEUecyxC9fZrRn2q23cczR22iPqB0/L6cigewPzn0kXljXdbry6NpsY
 MT3ah7Kp3hIwwv4oas+Ilzv8NxTiJhQ6C+FOEQ1HY4kXKj8E00D6wR70ejvbpzzXG1jvZkxXeyo
 AwANYDhoCTi4MgWl3BvhYYYVDruVhfXaH1iDJTUs4aud1pR9+QoeepfNqUZCvXB8UM2m/D9v0cc
 ae2EzTk/84SF1Os84qQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200097

On 7/17/26 1:45 PM, Luca Weiss wrote:
> Add a node for the CPU-to-DDR BWMON on the Milos SoC and the
> corresponding OPP table.
> 
> Currently, the table is for DDR5, the values for DDR4 are put into a
> TODO comment, until the kernel can differentiate between DDR variants.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
