Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7212A46EC91
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779065; cv=none; b=MGTMXhXwAfXZ6ngf1xAXFWTnrMDy4qwOQpCW4GdDYWWAX9v2xBokIzoSxD/4zhctWOIM2O3Qfs5+irzeaeQaLmBKYLyezXmv6G8OGV5Cv2x2b8YI94eWadGXxH/lxONyHNLa9sCIGDiCwmiJCsOMUajRgDPjg967Z2HROfQQuTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779065; c=relaxed/simple;
	bh=fUDCEYxySoxCRaRhUyorwv4kDhDUQpIZplJBgorTcpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGKCsXA9WuqOrH1Y/7xeNoqRuFsbA0+Rx/gdLro7z+zERdodHTAmA8lBzedYe04rhQZzogi9Mlz43jAsBVUWwmnvYNUwHDvovrCPnmD17wGCFFgJkUFsYBjmffxSlLF1NeAQKWlr+ZNx/P1sh+RXaUsyqeXlwdkhN7cEmccxbNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T7vbh3pX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hxg+f+Aa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T7vbh3pX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hxg+f+Aa"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687AnUuT4064632
	for <linux-pm@vger.kernel.org>; Mon, 7 Sep 2026 11:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KU6so8CejBjFsi3+BBcs4GZz
	l4XTntXNI65b62R9Ly4=; b=T7vbh3pXv/qx4qvUcQMgClITpuSSW1czzuLzhMSV
	7CJdYy46p8R6qnsxZKopWMYY6Eebs5eQpKRc3zEd0E0bIU0Eik/jAuyZshcSD4lV
	p6f6V1QZd9ZhdSQEuEqJ9Elu0kdCDIXw3iVYTdwtcgmrawHzV5+bwNHffCONwgdD
	bkKSstEvIoc7RpaSlxbicClH/gXn6xsaIDJ6npdab28qqWIjcdDt16jhbl/pbfVW
	T7TVxvQcxuq07PvhnS+bBgy3MHxbu9ClY77dETCHFBXp20UjrLf64S35EPPSXZmb
	Zomi2EYb+BOEDVhmBp9TOnTpCDkXQ1s9lLASrxHKJkTZOA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghs86rv1v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 11:04:22 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90cc0ed09b5so33912556d6.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 04:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788779062; x=1789383862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KU6so8CejBjFsi3+BBcs4GZzl4XTntXNI65b62R9Ly4=;
        b=hxg+f+AalBj0fcji+BVSUTQoXTvT34FpkAElHMUd1CEs5rK0uSrzpMHThMhO2Slcjs
         vJkXX5zZsflI7EvYbLVN9lxckL1PmYmtWq+yWVB5QHzNifvavQPRcwTlO6ZjLub0u26l
         4x9s7AxSrKj/8J9/UGPVuWOMm4yHHcD61aT84HB9RLCH+3dsIBc+HyJc3+6GkEx0ckZF
         TXxouDR9hr013Z44t9PctlSnQXjV1Jj/XK8UYmaQFQ/e0xBalg0LThUcs89guFOddoUa
         Yg3dpKsVShCUcOMb/HF+E6xjsobmfFQKB9rqdcmY1KBqlGNXBB6NxnxbYEY7Cj0otG3Q
         WN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788779062; x=1789383862;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KU6so8CejBjFsi3+BBcs4GZzl4XTntXNI65b62R9Ly4=;
        b=H8sW+wTR2yG/Og/LBYEjd7WF+Ou7QIzB7bIdLn/oLz4ONmCraO73En9ZmTm+biE/bO
         o5GIsDuESAXbdXjuzZVBHd8peWrIIxEIX7/mBYcQqJrwSrqJgp4HVtcHKsidNg77ViBm
         5io9nmRrBbhN/1wdkkQaau56j8baCDV8PNVXt2Xr4yd2KPK7pg1+IrF4+PNCGddaEFRY
         WUIaVJv5hleIGvmzHo+N9Neyz1t7vZnYnDRO5KPvmGNK+mm0NxewIiWteVypaA8eBsYR
         19Riwpn9KhbWxwWeCHvwJSSIe7NPZZGE5IH8KJUZjxv+rFoaeg9OmH6vdqrNbl3/xGUf
         t9CQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5udwtzAo/FL57YOjmgIC9TDOovQA76vsK9np2svC0+r1+uRVjJr6T+rhChfSpQi1W0+gdRCKGCw==@vger.kernel.org
X-Gm-Message-State: AFuF++kHphcn/XOhHTlMPtHYJVND0f5yN/iOMUbJW9cZ1DRZh9iE4tbQ
	2Sqyib1qSLf9iV/vl2ueUM0mFrqsro+mVfKqDR/nqHssHFp9dgm4vLS9QqdeKhJLzWmAPrAeBkD
	raeYt6/fX83ffFiZdB1ghIsEhqVF4Zo888QobFPJziiOPr/Prk9gqnV8aSi0rjQ==
X-Gm-Gg: AYBFou132tjZgO3Sf5xxTpQZsq2aVPnnYY5fFHAE8O2u3jPUWx1WlVUpnUf0/jIv8EW
	lqT+JTD6FMjz+SD40UmRncxnCwPMGLvf1tJ+vr8polhaW327ghfW1cDh+mdtjg5ES14XwN2rJEP
	aHwlhfRZVOLVA2QnCE+MmBtE/OLzIphC5zKASOlmENPKPSSMW25HkD7qWlqGjGth/m2S11Lh0Ny
	aa0qLDsCjhvmEzt832vR2iBB3tUgYYiZDeN/VggNBSXSziFOKTbLW7ZPBvavIkFuKxyJPKjYO5d
	PWXwrU7JZoPKueU/lR1WuaBD5m/LbA6Xz3j5coOd5taaIfa6AbYtPCDtNnmN2SPWuAtx8zeviWJ
	LAUNktmEnfnfI
X-Received: by 2002:a05:620a:2855:b0:936:eb7f:d2c7 with SMTP id af79cd13be357-93980400609mr2799093085a.27.1788779062276;
        Mon, 07 Sep 2026 04:04:22 -0700 (PDT)
X-Received: by 2002:a05:620a:2855:b0:936:eb7f:d2c7 with SMTP id af79cd13be357-93980400609mr2799080585a.27.1788779061607;
        Mon, 07 Sep 2026 04:04:21 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885be1c1sm27092081f8f.32.2026.09.07.04.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:04:20 -0700 (PDT)
Date: Mon, 7 Sep 2026 14:04:18 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] interconnect: qcom: use 64-bit SMD RPM bus votes
Message-ID: <fwhzhkt76zmpdbaehbiihulokhllhvb2zfrajmd4ovme6zqm22@ujsrm6yvhxsv>
References: <20260904-topic-icc_rpm_64b_req-v1-1-37e24f1991a3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904-topic-icc_rpm_64b_req-v1-1-37e24f1991a3@oss.qualcomm.com>
X-Proofpoint-GUID: ts7VFgLuNs2LFD2cWF_73ps6h2o5x3y5
X-Proofpoint-ORIG-GUID: ts7VFgLuNs2LFD2cWF_73ps6h2o5x3y5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEyMSBTYWx0ZWRfX+vLH/kFQux0L
 Yhc548mdY9cpLasdO3Xd40yjT5fxl+jRhrLN/oE9Devj11nb4MNBFVwlohG9GKZuz4X1s/lP+3d
 PYJ9tokg97v2YlDBV9Vzdqg92ZJx+NI=
X-Authority-Analysis: v=2.4 cv=LseiDHdc c=1 sm=1 tr=0 ts=6a9e9a37 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=q7XEBjOi5DRkXzmV0jSBjQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=zrAAXKNDYC0mzo9CIGYA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEyMSBTYWx0ZWRfX5+8O17WgIVIJ
 W2rZb5O1ENytzMjJ4W07cxG9Q+XAb7jZegKI+n1wXQ7vcmTEjzZe9xour2yefTSn5Iz9QPmw0fc
 xG3+rgNgOoTEwzL4j7XycMR6NbOhl2Z4GcoALEekFSE9TNZqWm0g5bxczj+tZgXTXSUg/XLTdo9
 o+gxNlfdUP5dXiLgN/XAK19Qmas8qvELHBzKtWvh3NbAuTLEgAykL82w865rEyHK9J/CjcgE6Gs
 eKCQphwj5UW5jON2TwkL4tFoCrmvUQ2CyFeve+fMoNbAL2tzGfdwFaNC34ihvxyrCOenajsCoBv
 854wVaJU/qc1wibIGLfJSXXaKWAywyiWwM9ep/FpjdYFCfQk0W0T5IMzI9U1DopIOHzDIFxi5cf
 hBeTyg9h+zlWlvOuD7Dzgkgq4rS7cJLCxueyPyE3cQVYu4w2SSqDBHEAWc/fbXl+DHjVRpODRRb
 zbFQXpsAgvuf/CyUBXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070121

On 26-09-04 13:55:37, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> SMD RPM bus bandwidth requests carry a 64-bit bandwidth value.
> The interconnect proxy declared the KVP payload as u32, truncating
> votes above 4 GiB/s and advertising the wrong payload size to RPM.
> 
> Use a little-endian 64-bit payload and accept a u64 value in the proxy
> API. This has always been the right behavior, even on msm-3.10 and
> 32-bit SoCs.
> 
> Fixes: be06f8e7425d ("interconnect: qcom: Add interconnect RPM over SMD driver")
> Assisted-by: LLM
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
