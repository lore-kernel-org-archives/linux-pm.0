Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A821F370AD5
	for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2026 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425438; cv=none; b=febOzaKBF5sIaplhp7680b11WGtrNcTk0eLDzpeNk7QjnsN4tjBj01Ywzh4GBzBGxN5+TV9T+zwiBdrT2po0/vR2rXlF4A69S8ZOonEZWPDy7zYeCt8lXPAuvnTYgReXCox/qA2RHrIQ6owSa+VKMjA55TrwZei31hICLee8w8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425438; c=relaxed/simple;
	bh=yvRA6+RhpqKbBpG7vuhCaw8flA1Rlh5NgzfC5O25f+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1Pfb5HGnEjZQTywEnYnYY1WQanQ28Q2wCcur9KmNkpGgizFO9K8UE9WmGwZhUELqB3cUV+zHAoj01LGYH5bOepRXTuKBbzFNmo0iAzQ9slN7ln34ETgjqEs5GFdrTnr+RbwcBYvVT1Sl0eFbl0L5Xs5hSqIzTZaYmKfmAAVlQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nx9e6pA5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QE5w1MOR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nx9e6pA5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QE5w1MOR"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6835lZ2b3114044
	for <linux-pm@vger.kernel.org>; Thu, 3 Sep 2026 08:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	61ALK7PnCM34Vxnk/ZtnoDcsbGV97BxWP36hX11Z9IM=; b=Nx9e6pA5Lf9U0cjf
	02ESwiiizuR3tzGVYi1FxMJ3vSW7c95Z32Wk5jvxhM++h2xlKT8MciY8HqsDQS4D
	uMvbyvB5+dw1G2bDYO5w+q4u9cQL1tBh9muvPJV1WX2aGWL4MsyzIZqpnXKIvAFb
	Pd982xeucypNlYMW5fzturDSj5SAMzxPQbdUOch989M4XSuDqG8BMfaeVSqDIzOf
	VdVBldJvfPSPCexq77YCE/sNsIwh27y+SSM2xkoiNMN99287XZdekqgyRCMS/0ev
	ozxqPFgKmomtMxFp0q4vrGeby7S0pwLI4ST/IK/d7MkeJKCGq/iSubyOXWP4S+KX
	o3NvVA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf0gjs86y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 08:50:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-934a8cd3a8bso45936085a.3
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 01:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788425436; x=1789030236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=61ALK7PnCM34Vxnk/ZtnoDcsbGV97BxWP36hX11Z9IM=;
        b=QE5w1MOR0OF+mWTGiooj81jasZtrTv8KbV+QSGZaK2Jw6hbyG2Ys/9qr4fV1z24ujr
         9Wo6z1FTdgG/w5KJJLLsh6PFNxxcdQUSDvptuBf9ZCFvQry5dKRHv/M47VrD3I3Z4el8
         AljNMtPzQyY7rHm2fyPn7xe/YmdJy/UPPPDfjZ0m0WCZiF45Ld/IlsZC+Hcy9JsvsxXT
         BdW71z5+H7mvAL0izYaw0V2SHV0lHuMyEskqa6jnpearRpC+D0GeGP5/kEn/2X9PqQPo
         VtnvnwFaHqSfOL0uhqfAejUspmGCHobxKmA2SfcmtA36cz4VfoO1MOD3po2UIeAkFu5X
         SzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788425436; x=1789030236;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=61ALK7PnCM34Vxnk/ZtnoDcsbGV97BxWP36hX11Z9IM=;
        b=gOScuP8bbQY9HGgZt3RsXlqMmWEKCQakC/qb7OW6cZrJdVfp76CRaTDLScl7uhcZik
         0hpE1IThHC8P77w897Me0zGjRNtxzRpYBNiw3hJaMw+lAjdjTJ5UW3p/+1GI5RlN0CxS
         VTJc5/8l8MEmGZbnoPPNDPYFz58PBf7UE43z5wALJxdrLDE8vbTPPE7l2W2XI8FXAtYj
         T5OhDOKExn0VBoejRmCsj7yPuN+EkQ2tp3o3tPqo3h1mH4o6VI3avyC45pj2PlePSGU4
         EWVXoQV2yWpR0gSt6uGmM+I0hriPfDKdpt1KAfwmqZma525wDyEmY7NywJgsyLJhfPOO
         GKNA==
X-Forwarded-Encrypted: i=1; AKwUvBz+ULbgH1G5muq/c8IUxQb0kHhpkt6ivBd1qisriqBZ4IUqNv4XZZAe+0x48lkx2W2Oc2BOIh+7Mw==@vger.kernel.org
X-Gm-Message-State: AFuF++nsceYEcnkjJiF8FEt3bNDhuJ2eAC3mDTl3f4gIBeoQ3DDA/D3y
	hb1SfpxHomYQO+6n6aqWSZ9DJWpp5sWNROjmgtOHWxEoXpXYSrvGFbHq8W2VhPj+iPXuwfx2nkW
	eMNt58RFv1lNrcdjLNu0/dZbSIdGTkoRT5D9wqaU6jS091keiqKpWJOVadP2ohw==
X-Gm-Gg: AYBFou0A4bs5eRQEUBtR3tiR5a0AsXd8O7cWUFtkYk1/EM433A8lZEUPCIDTazx3hEc
	T5cjZd26xWRTOklhGFj6UHF3vzjmZGZcHj35CoiXrzWURTFA7olGjchTdgDfMT8vcXBWGYgcLSm
	4pxPtBIqsWqxrkTr4NZ30/2o6zdSI5MICQBAul7SIp9ZHS20gqS3+ZrzRBV3cxWK5L+4w7kYP1O
	fQI+5UbVHAHwBIvIrAfLjGD+BWaUiUFTKDsD8Rea8kxPgz1awOw3CqYIKk6DeQTqaO8l9QTuVxM
	tYFyDS8ktH1m4NPMSVabos3dUxatShTL4GuYe9EpeXC0/xMJFRT08YVUbJnKYErAWjg7Ktr1Euj
	2q4gwK+to5/kkLJ0ComUtmQ==
X-Received: by 2002:a05:620a:2704:b0:939:288a:8a0c with SMTP id af79cd13be357-939610b5598mr738047085a.6.1788425435922;
        Thu, 03 Sep 2026 01:50:35 -0700 (PDT)
X-Received: by 2002:a05:620a:2704:b0:939:288a:8a0c with SMTP id af79cd13be357-939610b5598mr738043485a.6.1788425435305;
        Thu, 03 Sep 2026 01:50:35 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25f41733b2sm67614866b.17.2026.09.03.01.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 01:50:34 -0700 (PDT)
Message-ID: <6ffd13db-1ca0-4497-9ad6-fdb65b001dbf@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 10:50:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] arm64: dts: qcom: kaanapali: Add ADC support for
 Kaanapali boards
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
 <20260731-pmic5_gen4_adc-v1-7-9c49b2eea6f9@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260731-pmic5_gen4_adc-v1-7-9c49b2eea6f9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA3NSBTYWx0ZWRfX9EdHC48FGr65
 sN6GEYXYcW3L2ijoKghqnPwpdsLR0xTYl9PYk1syPkByPbPLmegHTPk41aDLpAN/KPp30//1pSV
 YESgo4RDCpxFCHAi/8f6ub3IzIma51Hi2+VbV+AGVyof2QWBlOKtugB0lCuINryfYkpAVj69D0Q
 IIaAP1WSO5lGZXWdXZxud6mphhMcZsabHIG5KJ3hVb+ElnbzhBZX8MvKYXq32eBKsE3NzFyLfsn
 ELIFfBwbznjXjxqAlrWGcvJeqKrs6O9XJ0RKjzVeFgJtx6hnav4pKwq5dmwVWoSqxAOhygDpAv2
 lSa6SlaMFPOJKnnQRDpvudwc5PJmSUm1p8pmR0aPrdo/HJ6txF27jl+HPzd9DI+WV9uauIAASkh
 2wKzjq6RJQoXrx8lZThNKoPpzi6iJJYwNGXE1eYNLiIFIG9ivOY4aDJp8H5ZNeFOlsZjsURwi08
 bQOCuEPh2OMf2FiDdCg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA3NSBTYWx0ZWRfX7QTbPYTwg5yv
 Id5px4rHd14DzNVm4XXXtx6GFx2AUGR6fLwQK7Y1YR56EwXOpPd4/RDZ3JzhQjy7o0k5lq4OExa
 HZHRFMCnbJFrqhnbXl3Iaf16ggePpQU=
X-Proofpoint-GUID: z4uV-8O4PDVPKaCcovGN1tLHpDmYFeQ1
X-Proofpoint-ORIG-GUID: z4uV-8O4PDVPKaCcovGN1tLHpDmYFeQ1
X-Authority-Analysis: v=2.4 cv=LZ4MLDfi c=1 sm=1 tr=0 ts=6a9934dc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=T6yAfy7FHkEd-x0P2_YA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030075

On 7/31/26 8:06 PM, Jishnu Prakash wrote:
> Add the ADC channels under the PMK8850 ADC node for the
> other PMICS on the board with ADC peripherals. This includes
> die temperature and VPH power channels per PMIC and channels
> for available system thermistors.

[...]

> +		sys-0-thermal {

likewise - sys-n-thermal is unnecessarily cryptic

Konrad
