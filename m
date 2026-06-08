Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B886352024
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780900614; cv=none; b=kROr/PY+RYIRYndLo0DDWwFcbYRpgCnkj8B6UkFube1NXQ34vPPXwqqzqjC8t2euKTbwtx7ei7cUP7m11JNtHVD3w9dWyrdBtV6UnpmU/VXu/8z1ypVEb1wkPnAfn9ceeGeotOIhfqAU0nbsEEBMGwRZJIezCrGPz5biWIItHqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780900614; c=relaxed/simple;
	bh=3GnuM4Wj29EhJDY4B2tW89H800XohRGeS5DitbRQfJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePGkJM3TrsAZnQHObBIaMTWK5f/lJdhy5yblCMOAYPb5CqQHRVHYrwa1zg9XIjbURfQA9iKkPAYZyHwKspSl5laR8tVaaoQx//nFqiAcWR0Uedgv1Uvw2K/H3Tuukmsg/6Ax5HLvoj6hQTTFpFlAUyzsGfXLfY85j8n+ik6Cvmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QX9eyfRb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GFlra47f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QX9eyfRb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GFlra47f"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586PjlI2733082
	for <linux-pm@vger.kernel.org>; Mon, 8 Jun 2026 06:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=u2b9AHBd7MZE3H2QcKXdMJY1
	Vv76xd7PoGCmj92nygs=; b=QX9eyfRbNc5PQT98U326cfPrdhG4wYFr/ivXOjfG
	xmeFlA+KjW/ggrnKj52q8VHbeiJJX/yEkHYjeaTKpGTfjCmLsTOeKkT2Hnxj9V8J
	lezk/zBcJ0ppNr6/D5DsDJ1nQHWa74ZNWrae+nzeVLGfabClTy4bVj/wkr4llsZ8
	OKKV0r+bgkbrAlRD0Uw72qyZRc+qefp9ZaYlnpci0aEk2gvRYTBicA5Y1/O76CEy
	Rkr3bjVB4ikPDNcaiCnmfYfwK6Q1eG94ERUaufZ5o7ydZwwoSLBTB42Vvu0ejj4K
	UYPHGwgdGo+SEvn24CWtWDjgcuo/qvfFLTBqw0mLCTlBJg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emavf6dqx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 06:36:50 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-963b099b539so6143611241.0
        for <linux-pm@vger.kernel.org>; Sun, 07 Jun 2026 23:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780900609; x=1781505409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u2b9AHBd7MZE3H2QcKXdMJY1Vv76xd7PoGCmj92nygs=;
        b=GFlra47fkmV/AYcSXluENCvK0AEJ/l2fgw0VW9akGtYym7m0dUrce+bxifHx98+yvI
         4uHrwCM7Uac/CtyjdP5L04ot0Zh7Y7UL3VgfpcVaKo2mVDERfdmH68hoggV9i4AcU53Z
         yOxx5BzStob/H/Rm0qZhqcfQUMlKOyhGKLl4mnWfB3vgDRSwxBSjOgqp+F7lChMkiljG
         K2I8+QdKhTDkU3eleZS7VeCXI1mwsW/G9E1BC5CRorS0AJEZXcX+cPDIZq88lOgLje5H
         pwTyxQ3Komu6yyrpIQFbdKnfX+QeWE5LohLHX/jq+ocDTgL/izisvaXqJyXuJP3s5jIJ
         zPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780900609; x=1781505409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2b9AHBd7MZE3H2QcKXdMJY1Vv76xd7PoGCmj92nygs=;
        b=gi39DRp0HMfzsuxfUV5BjR8x7OgFjSuEKBDolpULDR1szT2CfPZkoJ1wM2yvZC4p+6
         t5L3ogKkvf64cuim/0U7QhrwIa3ONchjpi6FhIoMa3UOWGuXLoOmhtEKGaw8AuZiVKao
         OH0UKbWQRNapoKh0ynMgSn8sbP/A6qdLUX1njs01M3lxdaAhk4mvTnyBySa/YxvnYxzc
         Vqxg0gV99yS5flL8VVBJ5efeDT+GnCSqgSsG0Idm3NJbEoklcBNCicoQKF4v5fGWy0Wq
         lM90UZUE6iSfeydkk9+75ETX0g8j2T3cOMREcvaRAYgnZIi4fK2Te5vIwpYqeQ1sWRTr
         iBCg==
X-Gm-Message-State: AOJu0Ywzhw/SVQ44lb5z3RTTEoM67FoRnx2VhZSeoVo/9m7TEwrb9Hgf
	wPluIp+F96zCyvLlzoZXSkE1BusSNY+5h+8jOIfWx6VyYDjronsPnEqM07exQjksKBdaSJY1c3Z
	HoEssGsKlZ0fVDoVVJT6l4K3E6aIQ/uwgvfY0IKGkOFdHwOJ0mG8mCDY4gMB54Q==
X-Gm-Gg: Acq92OGi8B//ghooO1C6q+ZmTZmHUNJ37VgzIy3cdmKRswfWked86WJHfS9Za+GXObS
	q8+W89n5rnrp1YowJ9mZYc6YBFxxGPf5t2ybo+IfzOXeU2xbR+J/nIWomnUYJUdunGG27XMF9KA
	WW7dzeDGbDgJnCzdcdvRIQLxq7zIq3WDiPzYvoshUE74ceF+TyFpRdU/6QKZCYpJtBWOT1SgNLu
	AOYMcikHM9B2iI8IhygXOagSCXXhPZX8JmmnwZjAwsTn5AgH2Hza9NVpryLEoa9Evwxk3kVjR53
	j8/4XE2dh/kmBPfE6IPV6rdlXmOg4ir2JUfxQFF+fxtetV0mj4jagGS3x4uk8/f3f1iUuS62d5k
	NtG7KpeW/kbeabHqp5tcsz43sr1pu/EpymXUPRc0woI2mHGLmpIJHazIBZE6wQT+3ETzUsHOWYY
	biyysGoRUY7gjCVt5MCQNue6HQU1y33T0mRNFZPCyuXbCs9Q==
X-Received: by 2002:a05:6102:40ca:20b0:6cd:b43f:72fd with SMTP id ada2fe7eead31-70039aaf3bemr3147985137.22.1780900609619;
        Sun, 07 Jun 2026 23:36:49 -0700 (PDT)
X-Received: by 2002:a05:6102:40ca:20b0:6cd:b43f:72fd with SMTP id ada2fe7eead31-70039aaf3bemr3147978137.22.1780900609184;
        Sun, 07 Jun 2026 23:36:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8880basm3565026e87.0.2026.06.07.23.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:36:47 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:36:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-pm@vger.kernel.org, Georgi Djakov <djakov@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be|_ptr)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] interconnect: qcom: simplify allocation
Message-ID: <czjwf4bstyhgekmilv6tgyzwrk3tkbglbjthzjf63t7uqbg47i@xxztth3jhiy5>
References: <20260608050429.5990-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608050429.5990-1-rosenp@gmail.com>
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a266302 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=7l3-gkCRI4JLb9_0IUsA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: h5No13HnoKQn2fUQj86B2x58RkiNt50K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA1OCBTYWx0ZWRfX03IxwRyMQ/bs
 R+NGI7qGAo71cx6GXyhCOXCAx3oMuhiaCl2qwI/iJQldBk6lkKreE5G1Sb4ba+xG7bY4QHc29BS
 3WCQaYk87qmE2bWTzQ6iLPGFc7EWHWLahfAjBqHFXW0LAdaVBAPF0EGFI2z35DxsZMmYWRmZ0eL
 tIPSYIaDB3KVS69kWyM+ViHzX2jnJelPgvXd90oVRRCDqo1x2JxTzs2c/izZk2Zjvz1nNybx7BL
 cXTR2NxU4RalQdUthnpxkaF/nCy9wXh9ajiE1gH+d64rmlf2BTNxNKBail5mlmZvHD7JjgmGJFT
 YMitkpeFP8e6vz8vNLleoUI2DzaQRAl8EWJOscu/yWbSD9d0qwYqKsGBZDqaFN8l94AosxLEqsY
 Gcz6j1NYsiUkiHPbqui2Ds6kqQwefgYbarAqkXKbi12oFUUJFNV+4ObsUUlHxb/oODSIfP8v+ng
 r7Zdl37S1wOfgLJRRWQ==
X-Proofpoint-GUID: h5No13HnoKQn2fUQj86B2x58RkiNt50K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080058

On Sun, Jun 07, 2026 at 10:04:29PM -0700, Rosen Penev wrote:
> Use a flexible array member to reduce allocation by 1.
> 
> Add __counted_by for extra runtime analysis. Move counting variable
> assignment after allocation before any array access,
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/interconnect/qcom/icc-rpm.c | 7 ++-----
>  drivers/interconnect/qcom/icc-rpm.h | 2 +-
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
