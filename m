Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792578471;
	b=MpUSMYhN9RO7g4LB3lEQIb3aOBOG7E9t5i4FUBjbPufLfEEzEd8hZK05GgU2JpKH3ct5
	 3jwFDvp1iP0gIU5ag7ouG4I+VvRpCnNvtfAX5B9aMHW9MO0LqjCSNRgN6uSUEfjqFCVjs
	 Sl7LyzHExPzSf99MUC6Rtf8PFz5x9qlGe0wrD566tbdklxdOf8ghw1CosfkxegLBw2PAm
	 n0jplH8q2lyQh833xrlonbTvLFPV4spkot2l2qtsMK5B8ljIxQRNNEOcdDJlnUyYzFJVm
	 tfhndvtUfy0Cq47Mr19NIbKSw7ijobxtmWwLTZZ4NR0BH5Ktg3a10+dK8N7RpkWcuLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578471;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=lKIuPtXucGTuUrVP+08mQo0qmmFiAtXLjNuGxi16fbQ=;
	b=2NifJt16Rzg50sJKwhnRQcYgCGE6poKetjhBlfzsaO5iHgYas72JbOZFwno9MJIkejYd
	 vjHpSV0X+3ujK9w2tRtNsdfEMQk53QkKCLBefMpuAyS7PsJAyhP2kUg9g33lvh2PCoLpv
	 jOKmPQVtKxUPiXErH9o7ivBw1WJgetGxcpyBcMeF/C5k73E/Ejk3r5PrPsiJ82/OAy5P4
	 3Lb3XYATzacVSc6ROF6X6jCiWoMiMYCoLOfxDP0baoef7pC9q4pQ62bWwd866+feKQWPk
	 xakWEgB3/jzEnwwuRY5aaj0nD2f2D6sE0ozBdsT7rCAEA5nLUakKPdUjv7OdmOOoLeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Mw9yS/dk";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G+7KEscF;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C645606A31B
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 10:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C645606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mw9yS/dk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G+7KEscF
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LA6RsE282269
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 10:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lKIuPtXucGTuUrVP+08mQo0qmmFiAtXLjNuGxi16fbQ=; b=Mw9yS/dk+tSEmZUZ
	/4PGeOp3wb02AZnS5ew0LavnrtXYp1V03Yt6CVm9vJadr+WHsJE6Q5Ox9Y1rJwzE
	R8lUX4HdSiL/DelTpMxlxZIh/DX3YpCab3fl8rBg+ee0XzPhhYRq2P5Osf2nD2TC
	b1ml2+5+00jI46BIIyPS7KpRDGlrfrVy52OIeeUhjQh4qI4kds0rhj+GvvPXUEGu
	CCFubzN6mEcZQ5Bo04qkV14omeG+huKbhqG0hlwBJBTCgakFvqruvrWtwaHTJG51
	StV96JyHONLGcgBI2cvAkPRu1hje6Cl7PYTKJf6d8DFPjC4dL0SwaeZ4fCCoVT7H
	BPJymw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heh5r2jdj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 10:27:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5338bd59032so466361cf.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 03:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792578469; x=1793183269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lKIuPtXucGTuUrVP+08mQo0qmmFiAtXLjNuGxi16fbQ=;
        b=G+7KEscFR5Si6SZu15Qp3/kJopef1mI14u9r1uErWBWk+odbsNZvJclkiNbRB3pP6X
         6XBDWtqj2Lazsbira9nwq722RIG1mexSH/qQYi9jjhtpM53NcOPFG+LNg7tkLYFb90qh
         BO41QjEOAiTFrAoq+8aSuYUS934LEPAo3giOtmsEDrxM62uGNu+IxYxw6+r9hk0Sd0Bv
         4xPwT1P19gtjLvmChMPW2UFQ+1Cwg5R14oj8Vhex1UKgHM+QL/7Wydrt1DVlJUSSp2RA
         Sn1NgKFyjir07hf4VtRZajVt3BgCPFOyFJVcLNvxIMByiVj5y20TF4Mk2w3aSX8QNHY7
         MUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792578469; x=1793183269;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lKIuPtXucGTuUrVP+08mQo0qmmFiAtXLjNuGxi16fbQ=;
        b=JXy9aDsCT7EpZFabeP/YFODmBnHiprLfhd+Ubkvgyj6Ua08Xj37dncXJUV0OReap9K
         4GICBwFdv0HhvCSAmUsxD6wfraK/S9I3o+G0/2llIHypZVRFSTsgFlOFVSAc8osaT+9u
         AmMDhBrilvfywCC2UjboPXgtH0t5d6A35ci4ecYVYFWWVvTu1I6xMS/Y7T2FoRguNsnE
         3nZQnfZE0FTu6sWMuijPKpf+ZzBLtxj1TU+ZfDL+ES6rrFvE2UWjqnbk0sVoSdQsnOU4
         QdCN4hsCQqft3rT44I/jLpaIRvhqPWQl1FGK+Hyyn9pzW5lPVgjqDwWVO8sI8WwAyv/A
         AtNA==
X-Forwarded-Encrypted: i=1; AKwUvBx3lpQ7OHm5ac2BFCuPWw9ZEwYWt+8uNaREEGCziYy9aCRKA8ShMLfo8MDbyTC+L2asK8H7jtq7SA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKFZ67AIX5p51r/RtqOOvkoTR12Zw37P+C9c6eH/bcFaZljqE9K
	YkZR7wzrUX+6mXS5CBNcf9FpcQXtoI21eApnO39wmIQRy8gSszyox9WdkuZXb7tjppl53oh0Ng7
	+5a5iRJFsknfdBSHPDS7itiwnJPdf2dX1U7BPDFJqa5MgfTWLtUV6TJ3By3zy6Q==
X-Gm-Gg: AYBFou2oxmPykpVoXb9m6JWnwTuHBj4z893AHpD2A9hzNGF4Nw1p9zsNVhVKRAW4ti7
	BtX7+sBUvsGc72ealJ9cHwm9CMMEpdA48mQf327NicVtCB3zW2epIPPe/Ulj4kyFMdLukC8VoF9
	VqeOkaY7bMIOenEifNRjGJ7SoGTbqUFdGZfM1rwVu9BbFZVmA5XvZCX2XfyHgbMA8e5cQxiafw8
	N4yA8mXaRoyub67IQ0YuPRMd1p1uoX7pVUAyp/NaoVGodocX6BzYhrtzF/9ffFK9i7g/mIziekj
	RB5/nTTmwU6IchppXS+U1sbYuu2Ofv/0HlqhmnIaO6DlfllndPXsCk/aUksZmpN+hVkR6wf9WSa
	Z6YHNYNY6ujh3vD4UYzk86A==
X-Received: by 2002:a05:622a:134b:b0:535:162c:2e81 with SMTP id d75a77b69052e-5369bb640a1mr26674641cf.5.1792578469436;
        Wed, 21 Oct 2026 03:27:49 -0700 (PDT)
X-Received: by 2002:a05:622a:134b:b0:535:162c:2e81 with SMTP id d75a77b69052e-5369bb640a1mr26674471cf.5.1792578469077;
        Wed, 21 Oct 2026 03:27:49 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4678f7826csm65275266b.27.2026.10.21.03.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 03:27:48 -0700 (PDT)
Message-ID: <31b06177-69e0-44f5-9f84-28dd86a4e5a3@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 12:27:46 +0200
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
Subject: Re: [PATCH 3/3] thermal/drivers/qcom/tsens: Disable hardware on probe
 failure
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: andersson@kernel.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        "open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
        "open list:QUALCOMM TSENS THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20261021085749.3786101-1-daniel.lezcano@oss.qualcomm.com>
 <20261021085749.3786101-3-daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261021085749.3786101-3-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aI5lOr9m c=1 sm=1 tr=0 ts=6ad893a6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pCP4VrvfTVqM1MFBOCEA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: LJJYwulgAA5dHeJGorUdgesQonxk3SI2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0MSBTYWx0ZWRfX5oscyHLX6ihS
 6LBKfDX/+4M4angn9TXLJTIH4nXDLwi5FaMQOxMjGHjmH4LdzyfQm29uXJgGrScmy4DTMctRB8T
 5rfHJXCxv6NeNqaXeOCygEH4tN6OpU2U+VVDUVtxgBmGFfmdduN9JWbXybR0JatHvy22tynR3Yc
 oMqundPb64inkjUpawkRsyjQ8LTVtBWJlE4LaGtGFl+wApiJgiG7asFmvPukXDykD/gXePhYEM9
 F0tj+4MDIgWil9oa/Cu0zXlWol6WfQJcdKc9Ou0kvUX0sn2ArCbaRkO5rHetcEg6s5IhfPX8zkY
 E9B8WDbWXDGO9tFimX9/JZFzSSUvpgwg1U1LNmaNqQzBs8vleJbIKyMa7qAOBsUiW3IsLff4nz0
 ff+eo2pkpyGnaceFjSwBfcm+msz+hzQl3ZqOdaOzCXP98jc3deUdyrVTZApIvlCLMVyYAP/vIOa
 un2aRlwv1RkAK8YhYcA==
X-Proofpoint-GUID: LJJYwulgAA5dHeJGorUdgesQonxk3SI2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0MSBTYWx0ZWRfX8QfRYnmwDoQ2
 3CqOLQFnvLC7M+JK54nykrWRnugjO5nDkpw7IO/aA3wz2UjPQkZUOIwd6ATHimZmDemE6h6pkuL
 x5O1r5MiZkdsDbVIrn+E61BSwTF16tY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210041

On 10/21/26 10:57 AM, Daniel Lezcano wrote:
> Hardware initialization enables TSENS interrupts before calibration and
> thermal zone and IRQ registration have completed. If calibration or
> registration fails, probe returns without disabling the hardware. Devres
> then releases any registered IRQ handlers, leaving the interrupt source
> enabled without a handler.
> 
> Factor the hardware shutdown sequence out of the remove callback and
> invoke it when calibration or registration fails after successful
> initialization. Disable hardware interrupts and call the optional sensor
> disable callback before devres releases IRQ handlers and register maps.
> 
> Fixes: 634e11d5b450 ("drivers: thermal: tsens: Add interrupt support")
> Closes: https://sashiko.dev/#/bug/linux-4b873699-7a0d-46e9-b768-169916c70d1d
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> Cc: Amit Kucheria <amitk@kernel.org>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
