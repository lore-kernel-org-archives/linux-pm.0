Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6534E421242
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692838; cv=none; b=Oj3b+OzBuJD8xJSqE908yJi7fkxJZmHhYhAy/GtI855w8Hi5NLifg1PkyL4GLitmdCZ1AQkegqJQ0rHRHglWmq3Q0j1ek5/h41ssxdhX9ihyunbwml2mujr6mE4+1lr4A8lBOJzREmhgwwWdvMUtmvW/laU2bCLHdLSADDpu898=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692838; c=relaxed/simple;
	bh=vL1ammLrJyXCzm52KAZznQOjQx502y5WBIbpYHNdsio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4E3++YlkMnACVI3Je0zNYzAvfGrjte7zKnSojYPdmYBEqPGX2Z+qIGn4CBIWykLaCzAYTndBvF/V0rTcQs3xfRClfACA79lGgrDs5A31WozeZrQjl/TIlHcRAy9HiARnctv07Tp+IxgDOJte/qbNymbBcFo/o1whu5cC9qMJwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SVj/c4bh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MZMq2ayJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SVj/c4bh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MZMq2ayJ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4Qrtj283559
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=86t7FtJbfTtH9+F6tc1w5TM+
	iyE0kvnL/OQSt2AAHuk=; b=SVj/c4bhl+F+FQdHMT9zcV7LAGio+KeiN5bTcnqQ
	n1mYjBGFDlYKUGmSm40SykSpN5zJeWrxsSJzMwIck2YlQxSycuopE1WEnccO6lPW
	jdUgrd/M0P2OevSMlNJlSyoNEPu0Pk/8BZz4eXhIDriehpb088RwEC9bdcWBthii
	tAf3/de3ucrOLBVQUlBmx6cqojJdl06c5e0i2OK8u6h4W5VwIGsefWqddl4t2yBd
	72uNWsCST1WV03M4s+XAzJp3/U22k/DwgvGIaVy70HcBUkZ9sBaVA2gF1xQzyA93
	Ko4bJtGERXm+/YvsJEDoGsd7fA1dylsD6fyxwlb7ez9mHA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1h90u5pu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:33:42 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dbe39ce62so620292a91.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 00:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786692821; x=1787297621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=86t7FtJbfTtH9+F6tc1w5TM+iyE0kvnL/OQSt2AAHuk=;
        b=MZMq2ayJMppOaAHBFkvTu4mgKIulEAsefI8ZRcUWUtxDOkztRYS28gGEPC93Rdt5G5
         sfMJE2Z9H9DQ3r7zE5J8osrQPvT/X1nKwehQAUdOEdB9Qn6FTUhYKF2ZtZleO0xlhfVX
         BIcuOAE4aOTV6xzhSL5Eu9VBASSz1F1VPT5+YOehM2eUrYyJRoNeEBPcbscQH8XI9XWF
         w/9NiyFCy5yBznGcvqrtu1CLTSrDaq8nNjL+sFVWaQUEwRrZW418gArwLeIuCo/G6OuH
         XpfmehziciBR2pMXl4npheI/4rG3OUSVppFQlpSOLozAcEOQhkA0vkeciHNsuw34etgL
         ifEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786692821; x=1787297621;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=86t7FtJbfTtH9+F6tc1w5TM+iyE0kvnL/OQSt2AAHuk=;
        b=KaVDJD0eLDUPOP+ttDYzHblw6K1Ks0IFdHUI6BBxiEbSV+rWkiA+MPMmrnOY20M+al
         pHbS63UpwEHIQjZuu7qIhr0hexe6EeFKyfNiUU/Fe5g81RvfbEtIMwwu81VO4rkQXYLi
         nYy6Bg/H8Ox17P0kHCX1O8tkz5+go0iX5fbHL6YuNijV9FRoVQQBR2t6J7Yeq+OhMj/G
         KGp6nPp2blbmACxj5/HqIIYaaX1cJWhGlFfIAdVvyLi9kB7JRYoYDUsJFiQmROCin9vn
         rOkx2gIBBOYmTraUFUyQP53KVJ8dhGBqzE6b88+Em3KCeZPASQ/jijeGc43oHfT3Ypep
         CVlg==
X-Forwarded-Encrypted: i=1; AHgh+Rq6LfjQMIVBcyun1IlEEgc7uznzefNQfSlAYeJBm0GpGEZRGwa4m1wy61TlhOkKew3qOLtQxm26Ew==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRGBRCyJ5U8SCiOBGdsybtoRy9IqemIhJDvC39jdL6neIErxDS
	dwbvHrhou6uUS8bT1w4mr4YJ6Pt2Hi2HMfYWGqrHDuPb+IouQUCqmYq3Z7Vp+5gW2ZvFpjAXdwT
	jmnPkkzeC1ofoFaGl1rrTInUMRaPr0/siM6Pm/k6OVXT4X9Gm/gjP1VUOBDOGQQ==
X-Gm-Gg: AR+sD10Z7403yYp3WF5iUnXXmRNTXM0S2gW4piidjNhSXw9dU4Of1Kf4KP1hptvjbuo
	PcdASdSqreldzhAADKM5PYG/IHOWcR4AzO43vN1rbKm43bpQard5yMu895/ebjRL7HfJysr0sFI
	WrEr/Gn2R8tIkHYbKuVau8lCIFiqIa9s1x9zcd7ZQtr31gGDWrwXUzEwFWCYpFn8/HxntJBhvn1
	obo58BKO8pj+kta6QFumwX8dmxC+aKMGV/wmelQm6KrF61ib+9nIF8mq2Qmr7FZi2wDezMbqC9d
	nIyL7EUoKeN/Ojp3fiUsfSialIvg76goQOkVIuWuE8r+nUnQ3wtgBbafBwre8h2VuqllzhMoG9x
	GVLG1a36ntBOCViRxniAuGc6UoDs=
X-Received: by 2002:a17:90b:2c86:b0:38f:657:6823 with SMTP id 98e67ed59e1d1-3933afc1382mr3188372a91.8.1786692821249;
        Fri, 14 Aug 2026 00:33:41 -0700 (PDT)
X-Received: by 2002:a17:90b:2c86:b0:38f:657:6823 with SMTP id 98e67ed59e1d1-3933afc1382mr3188345a91.8.1786692820619;
        Fri, 14 Aug 2026 00:33:40 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387e49d3sm6408911c88.7.2026.08.14.00.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:33:40 -0700 (PDT)
Date: Fri, 14 Aug 2026 13:03:34 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/3] interconnect: qcom: Some defconfig/defaults
 cleanups and improvements
Message-ID: <20260814073334.7orbdongswfxgc42@hu-mojha-hyd.qualcomm.com>
References: <20260720-interconnect-qcom-clean-arm64-v3-0-942e8ee7ebda@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-interconnect-qcom-clean-arm64-v3-0-942e8ee7ebda@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Ovh/DS/t c=1 sm=1 tr=0 ts=6a7ec4d6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=K9csx1bNu7bmPCVkKm4A:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfXw3x02mZJQXb+
 ACCgvFKfiCfKElCHPBx++1Qz76O8RBj+pTxi/5WjjF1Nl9qCAOvHrpGr6wuA6cxO20w+3wWBlNn
 PdYNTJ6NWPKSPYfTGVt5+TMJLO4nSGU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX0SjigFlFwuXo
 QXA01F3fEfB8DJV15FfzfZj1+Xul1riZA7N2nURh2356UEWC2vbVfFgfbiKtRHtotpl6wlRPlkK
 AHLObm68qQPOgUC0aPcelpIBCODf0IV/u7ZqTD/xfqV3wl055GPgCAPeD9fRF/rlTCZb03Rku+e
 qUTdXTrfYAaakAmhFyxpjX9BRcGE2W+BHx2ZkHJArfuHxRBjdaxr3XN8r5SqvJ/CBwwQvXXEcML
 YTNJQOfxQBGbUUkL4UmyR6tOUVQbC0kNyovgDD4UVdXwJ5x9Byik3Z5L5RwvLdmBj78WV8mfaDo
 zpFvUnSWaVxZ/9hua2/9vq6QNhzuzojEWZhxx0TlEiUjtpOLrcOzz9R2W27NTxXHODVJuAqVz2M
 7HDSWChxoOrCiJqYZazXwnwFek0wthuseKg/bxYtmy9cRD/I5x1r5AwfEp0Sjinp9SWXtfCFZ8R
 N3VR8r8uRMZ2vPxigjQ==
X-Proofpoint-ORIG-GUID: fSk0JktwTW7jir_QeOTYFk2AuICgD4kP
X-Proofpoint-GUID: fSk0JktwTW7jir_QeOTYFk2AuICgD4kP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140058

On Mon, Jul 20, 2026 at 09:03:26PM +0200, Krzysztof Kozlowski wrote:
> Merging:
> 1. First two patches via interconnect tree.
> 2. Defconfig a release later via qcom soc tree (dependency to avoid
>    surprises).
> 
> Changes in v3:
> - Update also Nord and Hawi
> - Split defconfig to separate patch #3.
> - Add new patch #2 for arm64 dependency for Hawi, Nord, Shikra and Maili.
> - Link to v2: https://patch.msgid.link/20260515-interconnect-qcom-clean-arm64-v2-0-adeebc73596d@oss.qualcomm.com
> 
> Changes in v2:
> - Patch #3: Switch to built-in for everything, with explanation in
>   commit msg.
> - Tags
> - Link to v1: https://patch.msgid.link/20260428-interconnect-qcom-clean-arm64-v1-0-e6bc3f7832db@oss.qualcomm.com
> 
> Similarly to clocks and pinctrl, interconnects should not be a user
> visible choice.


Looks like this got missed in this merge.

Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

-- 
-Mukesh Ojha
