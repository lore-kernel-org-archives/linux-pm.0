Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1E63C3C16
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 11:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787742414; cv=none; b=hhUuPNgJ/ORy8UArgm3hQAW/3zw50RP7PS7je1+mumcjUDp8Ue6JSP5jSx4+BkXQOO2Paw3pdnaDUS9vZPhm2AsQFimzcXy4SyrUHviU2s3SydQucJXCLL6NJ2tt4IBZ0y9spaZU68r8d0vYnyWig6kFJanfi5QaToaQL6JAXqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787742414; c=relaxed/simple;
	bh=QXD+KMdenghMXKt2asCQrmIZhSFh3ss1fUfzTg5sbtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCzuQZBLHEcqhDkWf6wyO0hACx7kdXZzV38gy35nymiHFn/ZlD4U3qExMwD6DXQpH2SGyb3ZGll3pDkxlhyfZdIevsDS4UYMXtZ8e5LVrFvH3yBFi2/SlpH8Sob8Mb845wJujSlgIbQ/4l0hU6nlKcGlYgHghXwhNkhMVWrbFcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VizyG0ZA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YFnLHIVT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VizyG0ZA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YFnLHIVT"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QAGgQM647024
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 11:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3akmcxmoJl2rrZnwVhPbG7VW
	IuceBca40SU704s+Vjo=; b=VizyG0ZAQLnp/gh09NW5WeC+tMxNpzP/CBa01hSC
	iEkUEd8xrnER2mZzLqYUIdGQZKa2LBlPVWEEVeWqQQBh2o2DXSlrXDssioB7/SM0
	yOyB2XQbBJp7dFZOlh5Rr0Lwidqv5Q0iVHfNp/18kqyxSoorf0H5Wd3N6dOG7Bu3
	dd3PDI6Sel/AcUJDXOFVBCmSNNxStGQCpZnCBaLPjFvZIsWAGCUQbTWvQN7etV0t
	Yr3kfVOqZCjebTbX0YmvgroYGPJCcOna0XPFgt2kNR9HnegzXPAvCN0RiwOOgEru
	sbRYh+QLtR8Ko2TZ6yDQctphrzGadSQN9kc6DJ5wNYF+HA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9g4mubgt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 11:06:41 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52d827597fbso8105061cf.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 04:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787742401; x=1788347201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3akmcxmoJl2rrZnwVhPbG7VWIuceBca40SU704s+Vjo=;
        b=YFnLHIVTsJwmYk/1N7Otva2/MA/oSZFMHYKBN8XIVPp0EBRD98xs+OIrAZuqfSjKw0
         RL8X5Z6jaNL2dL/mJlQk9QuCAYXjM731Uv98pyI4RpPTpQGm2/X3JAKyDXl70XZygCvZ
         q3gAXb0TIrwNGszSRB+4m1NJyMVeOfP/jjyyNAkv/w0TAT4G/H9fCYz7Dw41nkdC/qSm
         hpciw8pMxUWMT1oa+8sriJu8hFD0iGgGEzQLPOU3oFhrDAvf3XpA5sRBPdeEIriroi0s
         LAbzg8qUgzaKLocxeJ551VrDUbl8/AECmgjrDnGiiCN9MXH8ozfMJie6Cm07brLxaGKf
         tDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787742401; x=1788347201;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3akmcxmoJl2rrZnwVhPbG7VWIuceBca40SU704s+Vjo=;
        b=S8r+O96M4EwEKuTNNmBoVaXc1NZL3hUBMOAfaP6bsGd+bY8nkj/XaixxYCAfEspZqh
         6HSGHg4iDjgoxSD2V1+bwBrkW66tN9x5SsA+7aJevAXXSiqv4LyW4DWR2HQnnQ97dfLa
         IZQ0dopc/xA3fpR/AOpANQiykMwsCz1ZBrb28vpBwhH2Ic+gt6m0+bBAHNTTFRQGh02I
         gEY2RxIchir4hhuF3phVHZNIWvLDxxkqfYUcSH39qWY4J2ooyawDhZdBxmYVbSZll2o+
         bCGP5wg04Xw1gSuqpv3WHuV4WMKj1kO8AcM9+hN3c0dyXjfpASpWXCE5dq1Z1fDxLR5a
         tzUA==
X-Forwarded-Encrypted: i=1; AHgh+RqxoJ0M4NvL0ky56En40kpjxRMo1RoeiBDvxjMSy3Rdoq3OCUMJo/Eulsg3Pmv5lJFwJdcmBUksnw==@vger.kernel.org
X-Gm-Message-State: AFuF++mH+Es2VcFEwq+16z95ns+VoTrLL8xbJ8f7nuVz+cBEfq+YVPmD
	+xXW9ViemTcBeUseByGVqX1Yh2NDoWJm9QtTKZ00GQrrZxUwufXy9Rorl4/1mGssTD/49hu6M4t
	QcmJLdDj7Mu1Np65mKYv2I5NQdx57ci7GI+fz2J/2VgANYVRzv4oW/EpEvUAsXA==
X-Gm-Gg: AR+sD12BRbwX4mcSNcH5KRrnBUnmq9crDCZJTTikDNnRcOSh8yrOHp6ejGW+/8+RIc7
	B4YIA5JWYTkhIqA3SaMCRLXFBKoNq/nrt0JdIC+Mb77gbXXA09kaFOYHTUx5E74FHUid1p1dfrU
	rVRI3htRfv3RXnsex7YUYOHnsUwa0FHhrUZIg5cCqp5NZeBEpQg7hbPyeJYSse8k7zBOagGIA2I
	v0Mr6QSZeezXwJgRn1P3AvzP6+kvAkuoxpl0xLAOYV6KArYt7qHLd3wTY+oFg38wHqLgC3GPxwi
	+wJ08f2nGn882ZWDU9WWOtrHW0AWJB3lS7ORunpqU2NmWKiBU2eCCexU8hecghPelAjWMnRkZJE
	Hnk9bsrRWvYLqOA==
X-Received: by 2002:a05:622a:1786:b0:52d:6afd:7d9c with SMTP id d75a77b69052e-52e4236c916mr51625441cf.29.1787742400630;
        Wed, 26 Aug 2026 04:06:40 -0700 (PDT)
X-Received: by 2002:a05:622a:1786:b0:52d:6afd:7d9c with SMTP id d75a77b69052e-52e4236c916mr51624871cf.29.1787742400131;
        Wed, 26 Aug 2026 04:06:40 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a88ac7fsm566727466b.30.2026.08.26.04.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 04:06:38 -0700 (PDT)
Date: Wed, 26 Aug 2026 14:06:36 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] remoteproc: qcom: pas: Switch Nord CDSPs from MX to
 NMXC
Message-ID: <etena7qgrcb334rtkkctjdvojxeu4m2nxbhhg2tygq5wg2zmgc@5lgkk44lxgqi>
References: <20260826102746.633076-1-shengchao.guo@oss.qualcomm.com>
 <20260826102746.633076-5-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826102746.633076-5-shengchao.guo@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA5MyBTYWx0ZWRfX95thjtAtH4XP
 0aUpl6/OjXSDQpU5fyezvhRa0ZeaDqmFdvoGNzK2jAC3DYJL/fUVYdqJzggC5lZBYH2CU/GY7up
 nj07TRiR+keAXxzWBNmFJlyH9O4CA5Y=
X-Proofpoint-ORIG-GUID: 5fjbVEiLrJ6fPTZB-u14GiOImbsaEuWy
X-Authority-Analysis: v=2.4 cv=eYgNubEH c=1 sm=1 tr=0 ts=6a8ec8c1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=clBUptZa5v5FR042Ey+sjA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=GZsi8ShKKcF_LqxBH-EA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA5MyBTYWx0ZWRfX+DIufp+nhert
 xfdFwXkJ7nmbNHlT3OK0AWK1Jbr+EbvVclg+xZGr5K+at8q/fkiskISxtye4kbMulVOCoPjJZn2
 D0TPFo4sEWAFZrK4f1gnllJE5BS6vh/fp6eOt8/NXBkhpKCeD/BsJDuTxTxJ+JFjWqbF1tWgsnW
 OjuJfeRFFdnK6mq4xd+NeiVHkBfamZ02HGzCW5DyI7rpC6y+sZrMKJEfYcIpghsyKnd/hIKjjxY
 X4/NVCQgIq0HQCWPIhH3s9xmBVWYEC2qqKTJny04hhskMk7CIm3t7QQAVrqmVXvVjzsd5DBLoFE
 OQogxC6BZh7+ACrrgDy50NR/HunmCdYSfSnUuXS68SvC6q09CGrFA6XmEPgvWO8nwAjH09xaLTZ
 CTXzpTmbtoV1mPQzvZUgCxgCUb/Rx5/9qE4xfSyd0SmWiC27wVQo3HBzorVex8e1N3O7X9VvX/q
 Tlnbp9AV+Myp+7T7c9w==
X-Proofpoint-GUID: 5fjbVEiLrJ6fPTZB-u14GiOImbsaEuWy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260093

On 26-08-26 18:27:46, Shawn Guo wrote:
> From: Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>
> 
> The Nord CDSP subsystems keep their memory rail on the dedicated NMXC
> resource, not on the shared MX rail. Replace "mx" with "nmxc" in the proxy
> power domain list of all four CDSP resources so the correct rail is held
> during PAS authentication and boot.
> 
> Signed-off-by: Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
