Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B6F314A82
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 08:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777881721; cv=none; b=aiqiLfVgsXvvEbmyeIJep3VCzmw8LgubQNpbyO/AdnAKsf9thJxKI347FsVMiIc3VfF9zUEtxmurvBrKqoh5oewCTj6K0R1NCyjI9rt7tOAMvAmbwUmqkakm/IdmK/wUv9WnYndBvCQ8uCuZcasOQvvQFegeeXq+RdpM0dKPAdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777881721; c=relaxed/simple;
	bh=SHvxN1FAQ67hKKAgXjoPnPc0lbu1oNAtVHKEqJqvHao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQrnPDJmuN/KbbldrIUH8TanJoUZ7eV0XRVprTo93vaj890b+/7fiIpZpuq4pLxzoN270b97dbRpt0ZPKL3jOXYZZ5Tmn8sqEkoIgwWpCNTq0RYJOzuW2UwAn1mBj8sVOfCdR3KNQxoFDHntMorEEV6z8ITQRJDjUHlCTsdUmQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bmBwkzUK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Cdbyq207; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bmBwkzUK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cdbyq207"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6446EBog3549988
	for <linux-pm@vger.kernel.org>; Mon, 4 May 2026 08:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KEtWraP6YaM2azxEPO5mvuryly/qQzGWm+7OWC4MCv4=; b=bmBwkzUKjTgPASNK
	ARMiNNDaQOvNIDuniIYZzQB9jnNrxyqWEDiSkUwNYhX4+WY5VNowDqyww9Kl6+Hz
	uCkiXFLFki//7MAkSUOGMkQG4/xGN0RwTA2wxLcKSMxQKsi6lJY69h8zhgfmId3l
	Q8VLald/4r/2j/e3rLyhg+QoRbm3RIWVnID9oIPsMYqzaOv8kzb7Y1Q5HitWGE7m
	cXDjE1FzpKtQVlHFp9gksK3cWca3y7kyNVtbWX2+hQ/vexUumd0SXB0ckZCBmLJe
	TxL6YuWrDBfSKf6ffahQCU1Z8l7RFOntovkCQ1pxY89A9jIouBMrFoJonrFCNgxF
	pton5g==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw6mpd2u0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 04 May 2026 08:01:58 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-62f3bea85d6so10855137.1
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2026 01:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777881718; x=1778486518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KEtWraP6YaM2azxEPO5mvuryly/qQzGWm+7OWC4MCv4=;
        b=Cdbyq207kj3su53YrYGmDCnMmPpEOiIAxxHwHnFBDDF24uvYZLQR6i4JAXxyvjPE6l
         r8uDTnDiIk4SE/uE1j0BdyVKdIXL76kCrPRMWyAqXUs4TyC+fZ34IEInLA00OlflwuLL
         oNQShkdMB/QedlzQoDJDBYket3BzICASSRjiN86WSAvS69LOlB/r0j1ljCkPUmIAWZua
         s0hF0U6/cMGouF6Zuu0SbkPwJuob2n4WYqI9Nf5Z0CQqJw9AxEf+oJ6BL/QB3d5RK/MC
         LIMrJXCt3LbHfenlxWurg6+SUZs6XU2ESahCWpB+ko9kE/PQxHNwpCr3MvOKxKw2S6rU
         WnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777881718; x=1778486518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEtWraP6YaM2azxEPO5mvuryly/qQzGWm+7OWC4MCv4=;
        b=ZZ9s99zzAS4NZInWPu+slpMiSq7/+zQrcYVfaCintykvcttW77uOmFDdalJNbjeE0O
         v4BCDmoAAXNMlVR8AIaCB3+URDbCh1n35xIQAfiPJBTXHLVN4l1QFDD9ELdvg3I57FB3
         Q5fwqDzglTD0y5EkbTwXB/tuGMt35Al93cSFTLcZiPSLAl1noCseekke4ErWGXayNxYD
         XtsjNVtKc+dL1MBPn3KlKdL2IO6cVA/atj+/c6ODOFYIX5fkUyXEJdFhsTd6U1mJ3egy
         gEYjJR4DND0cmxXGJJOh1M5/ahdai+M4RbITh9aJ25A6B3C5sZ5TP40TdSEL11yjvUCP
         Xtcw==
X-Forwarded-Encrypted: i=1; AFNElJ/nFI/DCdDbnKq2D+uOrVlAKvOQwYuLXVqXx5EGNY1zX2JmpSDdxng7jfytAKjHlKsCjuxQkpYzlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmaLt5SQrkwyzSbSiicG9PeW2w2ndydNy67zQXg3fDiWaqbbJj
	j2Mq4iMSFei57d6k+8jpXKmtR7nLb2aIQbYo1hIDkqXAiOaMj6nej9m6IY8hZXN4CWgcXQyxK43
	qGHTzfzi1WRlxm+OGVjhP5ry9qthiq3JtajfSAMLLrblDL1/2dWjXi5ZCUvChsg==
X-Gm-Gg: AeBDieslmEp9yiZJ8d9L6rwe/pX/hvXENgl3Kf8a+me77wAhCbhtGSmFVFcFUqG1wKn
	eBc9DlswAU+o2v2JSpCkcS/iAZmJZc5ug2YMsP/CfztQ2uPPJopwPEXE3L95kbckG+lx3gsibBq
	6lYRGwfI8rZiyIV9tyQKvawPahkmlkjpL/9j9ASWcMZn8tTVOIqnb32EOpdUsj6SYVwfrzn/t+R
	nIyZddGkPEbgfh4pUCPkQHeH4rV80N3BYzIvjjY2K9UNk+2cFEYlzWtwIvvbKqJZtyZ8r9lj++E
	1OxBr3W+nixPv6MBKedn4dtqLzcKvyLd4sQKZ2z3UE7/YX9+w9QeUzbvK5TxPOsRw/zEh8Mky5q
	PC8tY0tP+vzt/kRbyRFtvfoTTRcroM2iOvj0pkS6Re6Qy4C2eM0sEsujqLxxZhbyuuMtWBYJELj
	CHN+ijbzvD7uxWsw==
X-Received: by 2002:ac5:cdb6:0:b0:575:24c1:f668 with SMTP id 71dfb90a1353d-57524c21934mr476239e0c.1.1777881718153;
        Mon, 04 May 2026 01:01:58 -0700 (PDT)
X-Received: by 2002:ac5:cdb6:0:b0:575:24c1:f668 with SMTP id 71dfb90a1353d-57524c21934mr476226e0c.1.1777881717760;
        Mon, 04 May 2026 01:01:57 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bbe6d06e417sm367209666b.33.2026.05.04.01.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 01:01:56 -0700 (PDT)
Message-ID: <670bc922-0a50-4f60-8be1-9fadf757b76f@oss.qualcomm.com>
Date: Mon, 4 May 2026 10:01:53 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: milos: Add interconnects to
 camcc
To: Luca Weiss <luca.weiss@fairphone.com>, Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260501-milos-camcc-icc-v2-0-bb83c1256cc3@fairphone.com>
 <20260501-milos-camcc-icc-v2-5-bb83c1256cc3@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260501-milos-camcc-icc-v2-5-bb83c1256cc3@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H6rrBeYi c=1 sm=1 tr=0 ts=69f85276 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=6H0WHjuAAAAA:8 a=jeBussX95TUAqHeP4CEA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA4NiBTYWx0ZWRfX/gWLkqWVUpXs
 /paqbjiaIpwnfCntRSjI/FzfLtYGIHKimI0Of2LTHK52Bt7nFDZPWUBt08plpH564SOaAaNZ4Bj
 CcxKSChfS8UYPGFPjfmv4Uru+tXZxOQuTr77OA9degODkovBtXC6FtRQ08goPtG8r3CtQXVifvU
 eFkLHwrCK7TncjqQ6q41yHo85TtuRvJ6Afr7TyTDJDY4d6tHyjmSNe+joVCHdAywPb4CeYw02+V
 PI2ow0WpK4ZdusUuq+szYpR7An71BUd1yNavHVRBXQYi53g1Gq6L1QDHTzmqFjN05or+3Sqbe7b
 0X++BOvS7riNPPo+RNrYj8RCFVQ8Zs9KmtOgzM6RBAHJE77eppBenIa16GU/w6X0DgSHXhGb6LI
 zPE93rsck8u6ph8NYSuq8EZBUpUwbpUvhCUEbeCx0heSxs69mcQ3a4wMbOGkUSYmcn9hig0H/OT
 k1hee8M0BKf4r8ITICw==
X-Proofpoint-GUID: aVx9Vof7lW4uMuf5aYUEdUfoxUYdLT8L
X-Proofpoint-ORIG-GUID: aVx9Vof7lW4uMuf5aYUEdUfoxUYdLT8L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040086

On 5/1/26 11:18 AM, Luca Weiss wrote:
> The CAMSS_TOP_GDSC inside camcc requires an interconnect path to be
> enabled, otherwise the GDSC will be stuck on 'off' and can't be enabled.
> 
> Add the interconnect path so that this requirement can be satisfied by
> the kernel.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
