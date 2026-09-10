Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95EC3B3BF0
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025431; cv=none; b=Es3J0dpNmAhYlayGwQzlIjsgvKOBa87Y+Fa2xopH21eRIw65cbAu9s4k5OOiQZrtFASmj1J3RWHFInB7hIYrILg0RTQdWc5iDCQ9nOdhuTJklkI15hdyouPwQ0anoNR9Hri2vCB4fpDP/+c/QkupIa8JsDgSH0ST91aSTCFxxn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025431; c=relaxed/simple;
	bh=vrht1znXt3uXcYuBQYKysFl8qOVtK7VhAGNmY9fRB7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCCMMRKt1/z/A8lH+odWBTfwJS+VXmEd/Kftf6vDyVIrpAD7mTifmzYn2OBy1zO6ceGeqskYsyjBv4J+7lEFTukt47D9CbP9hS9GD/KcreGseit7s54mbohhCmvfxTMUXOaB9XAO9sGpY1S6hEOpP8hLYN8T/DLqSqFJX6tbesE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LRauwKF9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q3v2rWht; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LRauwKF9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q3v2rWht"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5Gqhu3655309
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Iwsy/k9/JWXyLyPK7PZA64Yi
	AApCiTXPVY8YLasBJSU=; b=LRauwKF9BEv+Ycnpte8YLZ1VE4QK1usNB5J+h3oQ
	v+lel0VHP2JPdUpx+euONLJYK0ejeeTNo5tIGn7EBqk3OgmSMMqv3V4+EWd5BtVD
	kuCwNBc7RzDwEcFQZhMlvEtRqua5lbSiAIfuWVALWsPDhz9nsKa1+Ld10l3b8gte
	TEnQ26glGhhk1XTwFQYWYpVP1gbW8eGA0c0rRWMFyyPlGCFSC+LmI+UCx5vfScPg
	oZhrn+ZS2kKcFPifIKl9JcSGbGMmSVVFYMVaBr7YNlZ9/0BJ37btEvgnGPnvsWZR
	zvjMgRIBNSAru307IBnd0MCFLEFFyWidn3xaBJkgTG2Jqg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcydtmvv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:30:29 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-936708f129aso895595185a.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 00:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789025428; x=1789630228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Iwsy/k9/JWXyLyPK7PZA64YiAApCiTXPVY8YLasBJSU=;
        b=Q3v2rWhtHfieqBD9/EXaNZ4IUpr3RhXXXJs65MT/87/+BhbwVdCLe3K/rV1Z46Hsck
         lPyLxMk2E0UmE6fcfm4uPH6lNN6yRnNSdDTec4XobenXATEqqFtMkAhka1YlssteBkYf
         yDUvUal4CGghM0yK0lL1jEEobdGLqB9+EagBT1w2TJA4ip6yd67C3AE4413G4GTcvqZT
         20cL70EZAxTJq9gmAJuQUNjdhWNbuy1xvcwhT2Bi9ObJq+Ol1leS5mgyR9Z7MQOBaEtG
         R446sVxKfEtOoRgrGup6EiOFzulVP68fn9XtAJbj52Fqdb5R450wpsn3iyTJrADmCh2y
         6hlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789025428; x=1789630228;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iwsy/k9/JWXyLyPK7PZA64YiAApCiTXPVY8YLasBJSU=;
        b=khERHrttiAopiki2lY77295vTv3LDOXrjIYkKUZCrooe2+eu6xXadHD9hEX5huRGf9
         pYS2Ri4HTBEcqb/bckKk2WVx9OIOxtVMu7/QDl7YF5RG6/IVSBCfHxLdsEybcutES1mp
         VMaWSuLhg9oQt+PEzfLk2ef9yNTy8rGOHcB3awveN1sqBGtGz5G0vG6T5T6exR/Tbnsp
         tQpEsp+eU6X27Bv19Cr7OEsE8IC40uwzBWiHvQN9nhgW3YJccPb4abtX/PCa5jXiLVdq
         rObPG/cXhA1lHckBc/dWbHMykhEj6KK4pZyCa9XDwJ4vvrX16asfbJi3U/ZN33jNhjFm
         5w3g==
X-Forwarded-Encrypted: i=1; AKwUvByzecaq+a1AFtf04QfT3haHK0hXfktRt5vjfQgz9d9T9OTSc08v5i8aILkduzSNLY6CtCoLkcOSjw==@vger.kernel.org
X-Gm-Message-State: AFuF++k0yVHIFNmwFktlI5AiB0xBnUVEJuMTBuWybHS8RTXqNofHbdKR
	94j50DaQoROHv3Xnud9tbEJCqDvm5Wb7LaMzbml2gJnJXfiGtrFq4rtlIJOarqh1xkN7vx+NHQ6
	bCALwuQYjcYvJP1fyA6XodFhdvLQ3mYz8k0SfJtSc4XkkNB/vX00jj2VBodov4w==
X-Gm-Gg: AYBFou2GprWmuSJDs+ZvdZ+X/zpd/tLBb8aDS55wsctZ0yZYKqCOqcPfwKKz4jzSRIl
	ZV7rCBShugQHrzka1wYVvQT+/SkEzlOSThXuSGKo+TmWc2rpN67wcNZ61OnWOTrTZ7E8E6EzvAA
	q1kEYTYOgR/7rqDr52YfezFcfM/nPsHmoXAC3Hq/MrAkCvkAiUDtOEXnLwP/TymV+d1WOmaWA/w
	2r4xiqKZ5Zs37ZQPFge8SZBQeD0SXFHWF+hNHrHYWuOvgu76AJZ3vO/OTFdnkQpL2ANvoy+8WwS
	DXwbgLR4gKPT30pLktKnCWZXUREUakTPH/wRYYDEq+VoLrsDh0leCzgyvQ/50dZevl6cwAS3Uho
	QXD+rHcK3o3u3
X-Received: by 2002:a05:620a:7009:b0:939:9d6f:91b6 with SMTP id af79cd13be357-939c94f0f1amr1437921385a.42.1789025425571;
        Thu, 10 Sep 2026 00:30:25 -0700 (PDT)
X-Received: by 2002:a05:620a:7009:b0:939:9d6f:91b6 with SMTP id af79cd13be357-939c94f0f1amr1437910585a.42.1789025424776;
        Thu, 10 Sep 2026 00:30:24 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.7.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bf3f0sm54356958f8f.33.2026.09.10.00.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 00:30:23 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:30:22 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Evan Green <evgreen@chromium.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Adam Skladowski <a39.skl@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 2/6] interconnect: qcom: icc-rpm: Don't skip small votes
Message-ID: <adpb46vmpnr6ypnzh3jhopyqlrrfjgckkfe2xbldw76emx5zh3@k4zxa4y4j6nv>
References: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
 <20260909-topic-icc_rpm_smd_qol-v1-2-6dc5b5e97626@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-topic-icc_rpm_smd_qol-v1-2-6dc5b5e97626@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=IfsSymqa c=1 sm=1 tr=0 ts=6aa25c95 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=dePp4Gl7O00gmbwhyVsZwA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=6T9HyGjP-Dkx_CtKVfoA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 6sUZAST5czzbA_-WPEmF_BMX88gMW0R-
X-Proofpoint-ORIG-GUID: 6sUZAST5czzbA_-WPEmF_BMX88gMW0R-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA4MCBTYWx0ZWRfX74ejKmYyqwUT
 Mu1IXi84gxJOJL1UCYGfHMZSZ4F/AIavPPEo0u6/HRPIHUdT+MMeh8/LW+8uplBm5t6kMZM/LNe
 Y+JFuYzv2ZY//n3S3A9VN3SBiM4GHpo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA4MCBTYWx0ZWRfX1A7UHEKoQBhm
 UAW7oOiDkYwdeSNTdAV4VlqlNvMSJHGKDMO2uDEq18vcMuoBnA/RiJ11vOl1LmOx9h22pguVO4k
 CpaCLtYX1zefNB09sfCA/LNBbO+stKPisejH7PX2PGsqAxISfljmiIRiRKf5zj1mBJNzOEtu1X3
 KKXLjJ7iy5vP5P++YVT+K77g16mh2CadNHu1EDVZpIrmNuK9PT3KeTZVVEhlffioJRhlK56UCre
 Z8viNG9fFsTbgY5RY3nKFKuYZK8zllHenPqy1RzbyJTodDPmNeh1w3aYi+6VBhofjP46zeoWJ3K
 wl7S7vffygTeo27lbVyLzZgm+0zjBu1Y7yZrnRMS1bn7vn18FRhmbIn+AoO87QlN2+kUuS/z1EL
 jsQGDKdWoqhFfHZHjIabfgPzRXzSaJAOMIl4LX+jPUG6JkEc1p1E+njjDMIWqc5DhzjOTrRU4jE
 p8RWvm8UmmcDcORWEBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100080

On 26-09-09 18:41:55, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Small votes (such as 1 or 100) can end up being rounded down to 0
> midway through the calculations. Use qcom_bw_div() when dividing to
> prevent that.
> 
> Assisted-by: LLM
> Fixes: 30c8fa3ec61a ("interconnect: qcom: Add MSM8916 interconnect provider driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
