Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098965;
	b=X8CL+ryUHo+/KaqFR7jTCRJIfu3lbGUWidEC0gIwHsiYxxSwt+pQ+TU8kL2vOXsJmFBb
	 NPBD43nHTrQNsyOZjXVpQShZnD1PxhJSMgI+H1hP6cXk+XZ86Y+G2b0hdqD0RnJJS9gAA
	 QStmaaDncvuAEKyMTw8HuG10ojrxHo3q4sX56zyB7IQRnYkTO8DsvXg462FOSaTfJ2zxc
	 XP/V8GVSPNVPAaIi9s1tS7Jn8CBdQAhwtP9iU3ccq5tLklsDFV1FXkYK3C9ZK65IHRRtQ
	 hos3P5IaN+3yP6rJyVT+6dVjnxsn+g8pNb+daUfQ4WzaNwHGpoDmpKsAC9zGDmf6SKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098965;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=IPB0rn2u0rZd9tURP1svLhgonHTIM2Yl2cNHTf01vDY=;
	b=cSmyLiPqTiQxsx4nzz/gEukbGLlNOrqC+f23Re0D3ixd10bDP8W/V24eQko7kSRE3WnX
	 Cwy92LOOdsRfpq49ibXtyFgXUUoa0AUT5euM5QsrIYMKN4IpfT1Z2FoQstsLRWtehSlEP
	 eU6QAg9lxwsHo+3kASrHxDR4ViHUz2pCYGRhSCO/icAWcsQTHWFbVdJHg0cfkTFEekhav
	 jHikZ8+IBa4Eewfu69Vdoi0/IZggGpmYeZw9GRaylEs8rzgLrTpKrlyHw9/4jha9jSHTi
	 WO5xjEiYtaPxEPeW577PLzFCPd146BsQqyYwmv9TBJvbJT/S8DEXerFJRlzXb18m27A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HU5qGGV5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PsaWdfVN;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556C7606A321
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 11:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 556C7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HU5qGGV5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PsaWdfVN
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAdsHK1921591
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 11:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IPB0rn2u0rZd9tURP1svLhgonHTIM2Yl2cNHTf01vDY=; b=HU5qGGV5wqWI+V1U
	yH99kQc1m2007GWWvoH/qh/bTeS14xUUJCWmIjkN3RLZbgUqaD9bWSKK2UGuH+an
	uoY6q/MRYulFHAFZJwg0ggPdZhurMKJSU54vVDKwUmWQFJkAEBrBujM+8SShVPqd
	D8QhQzS0xTiuA+WZh1+zZu4tsDJTWXHM1sduJG2/qJI3Aq7sNZHEiBP9HIcKuwIE
	k8VI6XCm6mXKMaY+r1qVJY64yfAiJxW1MfbdDBx63M/mtFsG7XPrGjdceTn5j8ZV
	lJp4BT/c8SntO1VlEwe0po1GTQJZ5MUMZRMqrm4HFsjbTTC/svZowsyF6Gb3x8OF
	w9pNyQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjrq68hcd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 11:02:39 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-99082f450bfso3997965241.2
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 04:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793098958; x=1793703758; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IPB0rn2u0rZd9tURP1svLhgonHTIM2Yl2cNHTf01vDY=;
        b=PsaWdfVNQWzZvjhyiwB4PWNgxhrkqh9YfKWjkG1PNfhwfHTTkw4chve1Urur6Fahsk
         g8GlWeJ9v1CQHQmUEWlxWgKdPn15iX9f892GmFuE6il4eYQrmOZVfEnf+hgEG5X/qxdf
         0h1133cBXKPFJT2F7idShAqLeheOAg+bqIIeLkjbTNjOcAlsS036205nPUy9/MKFrRVd
         vqytpB1eHEkSQDjJNU6L0M5Lx8bbRh/6mc47ieMMHBdwC7n/0pMVDwugxsaQMeELhtQA
         6KD+GiNVTRcMo/l6TG6yQjOAMmBI72r9Wtdzf21+ahYePUV9ZAMaX4jVATlBTzoRk1nT
         w2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793098958; x=1793703758;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IPB0rn2u0rZd9tURP1svLhgonHTIM2Yl2cNHTf01vDY=;
        b=ZixP7vIRfA+TG2mn49CRvDjA0id477yb2qHjWItynFz4TCxBCIU2G2SO8SmN5Iu01K
         gLEgChGggerEnUipkN9mGJydUos4kCxTAVtld5yfulNpxWTutdZHUzEZPh4bGFaSNCEj
         8dG63IS7LdLQhS5KSODaqYBX60pWsvfgaE2k1fo1XjTa+LnToDrMiXGTMwRWIh/tx89K
         xHWhi79iovvh7eijWgxujo/LCqW/NQIY4VUCHrls/Of4WI/QFuAVTLyCqGjl4D2SPwOM
         sbftyoD0ZxDHcBCeQJJqFfDAFudYTUB7f26nimJpUp/xJAB547b2YXS2kY80Mz59Z81G
         StGw==
X-Forwarded-Encrypted: i=1; AKwUvBz88FVzeh8wD2TGBYyhkB+zqrBMBRXNEtVCVV0n/kpKdIUMXafl0ksFTFPQUInUMyfT1iyFMYVwYQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIBib6agcKntai7rVqwEOV/lU3BsMDM3/5XSxjz0bArnwb1egkk
	u8Lr1lBFFcG4OPQuLJDwl4SGYXrA7t82r3aIA0hJqDxTD3yUfpbRbUWKiCNwUxIHpPX+k9L46J4
	t5SU0K+BXK6iWoW0pEtk+E9DQREO7IOHeWW2ieE69Z8/0Mx8GcNqcUZG0S69d/w==
X-Gm-Gg: AYBFou1Jl/wzUavxGCmtVtotMBgm51eHuIJqlK0XLEK8/O8Pzk4srhBiLvIlCFcHTUf
	8Ygshq4zeo96xRDOhCvIjBueTGJuT718UrOLlQNRH2pzwpsrCFMgAQjImf251RIlQF8BhnWkBYM
	QL9MtM56UbiI3nw3LbPhD0BpQ8hIOCbgt2iBlQdgcekBClkVFGL3HcVfuAgajYi765lmaLAqvJh
	eE12TyWZA3HDugSWExnMQ2FJ71+2CbtMFF1ld5vjrCSR/PzpyjKr+TUN9wDzd3A+6/2WDut9Rqg
	ZB7im1FsuNlM6sWbfM5ZvTDEjPB5OeSoyJwX1SMXWcLOdB4ZuTpZvG5eByn4g/0gtzWUO5HS+cO
	OGR1QhCJavM6j4EVh
X-Received: by 2002:a05:6102:a4f:b0:7a7:ad9f:53e2 with SMTP id ada2fe7eead31-7ce5ca0cac9mr3759051137.1.1793098958278;
        Tue, 27 Oct 2026 04:02:38 -0700 (PDT)
X-Received: by 2002:a05:6102:a4f:b0:7a7:ad9f:53e2 with SMTP id ada2fe7eead31-7ce5ca0cac9mr3759013137.1.1793098957565;
        Tue, 27 Oct 2026 04:02:37 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359fc1207sm201832465e9.1.2026.10.27.04.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:02:36 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:02:34 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: =?utf-8?Q?=C3=84ngsblomsterskymningen_Zefir_M=C3=A5nskens=C3=A5kerh?=
	=?utf-8?B?w7ZqZGVu?= Zetterstrand <angsblommansken@gmail.com>
Cc: dmitry.baryshkov@oss.qualcomm.com, djakov@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: qcom: Use semantic names for BCM bandwidth
 fields
Message-ID: <lkt2ryacjrculzbnwwg2fazue2ylocq62uknhwpzomqevfz4cf@y5gok3esfvpq>
References: <20261027095736.94878-1-angsblommansken@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261027095736.94878-1-angsblommansken@gmail.com>
X-Authority-Analysis: v=2.4 cv=RYwFmFtv c=1 sm=1 tr=0 ts=6ae084cf cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=Qvngrl3H0rQgGg+94q4QgA==:17
 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=SDxAmmnRaevP0qTVZYgA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: TD6KiXefc2ywc7DdrVV6sTNcV1QBOROx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0MyBTYWx0ZWRfX3d5K3ti5cQd2
 UFlxNdN6BfKrmFCOovySPzlkwZSnvS5kIF3J/+1sbfTdBkcSpaTnasVcoMBhc7Ez5xrkMu02+dX
 y+ObODrXAO2zPHoX2xtHLG4P3Z0jEUY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0MyBTYWx0ZWRfX4tws6DdVJnNy
 2iem5taY7o+G5Jst+u9+PypKLLbKt9hsQfZKGLdLDZ1MQn/1mYqXcTn63nHE7edL0AvD6BpHBJa
 xQ0u3ZCpXgcEwNHd4NUebpc+T9Nj4/twUqAlin/IQS4WLb6S/vCBy06v/efKv/YJBHm2qQtKA3l
 UKrOX3dAJj/cUNBHb1727QlZn7Ejp/JRWdhXhmvUmCCkwVWJoFenzgf3iXPtQlAEMdxWGHh5Kme
 47pHOUuGLs5jNbkGOZsF5RpAnf3fUcP5IS7q1h00dEEraZtL0R8jNqfJzWTHltHpe+dia2rg9oY
 LKOIK8JaRiT2VhzEjWX//98DOJAvmYEUvdBfKWh7K0EKvWpI2QgZuirVpyyT90MdmD4qeU6MVhW
 QSfn1wLFKDoxFaBFoaEYtq5RqICCakDEb0YHOaDY/1MoLTV0plE09qEAaLreN3sadQ0GsX7cUpN
 aubUFE1n0JjbMnX/kcw==
X-Proofpoint-ORIG-GUID: TD6KiXefc2ywc7DdrVV6sTNcV1QBOROx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270043

On 26-10-27 12:57:36, Ängsblomsterskymningen Zefir Månskensåkerhöjden Zetterstrand wrote:
> Rename qcom_icc_bcm members vote_x, vote_y, and vote_scale to avg_bw, peak_bw, and bw_scale, respectively.
> 
> vote_x and vote_y are legacy names inherited from the low-level BCM vote encoding. They describe X and Y rather than the actual values, which represent average and peak bandwidth. At the command encoding level, X and Y make sense. In the data structure, they make readers remember an implementation detail that the code can name directly.
> 
> These names also match struct icc_node in <linux/interconnect.h>, which already uses avg_bw and peak_bw for the same bandwidth dimensions. Keeping the same terminology across the core API and the Qualcomm provider is preferable to maintaining a second naming scheme for the same concepts.
> 
> Sure, we could keep the vote_ prefix and use vote_avg_bw and vote_peak_bw. Both names would be valid. But qcom_icc_bcm already provides the voting context, so what exactly would that extra prefix explain? We would essentially say "vote" twice without making either bandwidth component any clearer.
> 
> Rename vote_scale to bw_scale as well.
> 
> Keep vote_x and vote_y unchanged in the TCS command interface, where they describe the hardware-level encoding rather than the BCM data structure.
> 

This is not a properly formatted commit message.
