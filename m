Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155D936E498
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778145051; cv=none; b=TN6ebZm/UqDzk0WMuu9XzGCePfPgJkLpn+qseF4PtXUYPvoHIX8NFJLcnU0FML89b5PaXEppbh43NOjWv+vkuZmX1HUnOKOgs4Ce/mPCz16I1KPVPHLQPIN18V2pGDwFXb0u2W5+fntPJFvBroDS5FfUF/3Gg1nU6GNvWSH19PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778145051; c=relaxed/simple;
	bh=cSbnmKIeK5PiH7jDW+BQqyiKxH8RY05vb4L396PVn/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIBUVmL8MpeRIy6nPBapLy/hcU5V/tTPzyYqTRcnTK9u3JqK7KEAk8oa7y7+VUWJRNEYxKMNxY9l2/7NqYi4kqwFz7y/p93Gg2f0feOuwSt8QmpNBL7XVRJhNPWmErUoTM9+5iLjQEZrI609YFal81jkxtSUj9Jnhx1jCagc5do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aaj2kPf7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eaayxXqs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aaj2kPf7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eaayxXqs"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647440wf150875
	for <linux-pm@vger.kernel.org>; Thu, 7 May 2026 09:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fiLRyqVWGS0Ix+7Et8ZETjKI
	EZ4pzdPJfw5gz/TlT3w=; b=aaj2kPf7Vt70KA2i3+8H5rqr4GaTBRUxUXfFCAIX
	1wdBO8jPUfsMqMrznswtbQ2P2Sc+PW6u3Lv/QSqcGF6r0+iMf3u3kaQtK6o9hdEQ
	CbqLEGnxg2KU0oLYXWLl4EXauJIGscXmUQ7FkaJ5ATmeVNCi9CPdyPreNdMhujls
	lo2BJ7dWx4/ULLNGvksEnomZ1gSIjLo9AVuTUsGBgxibOK+a9ikaCy7nV2o1vnKy
	+7+q98leDPrDHpE1aow5LsCT1+nLVzy8Pwfnb6CvPbz7NcYllukprl0QwQL2LNMG
	cMQ0cNd/S3qW7IY5fCfePp5fy9uOvRNQhHlP8BRedEPrmQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0kcts3es-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 09:10:43 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50fba8d8c40so10481251cf.3
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 02:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778145043; x=1778749843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fiLRyqVWGS0Ix+7Et8ZETjKIEZ4pzdPJfw5gz/TlT3w=;
        b=eaayxXqsFRTvarNydVcHFRARBFPSw+J57YxMg9pETfh8Dga987mHzV4BWW/Np7q1u6
         g3MtwRlgZ4/rQksxVHQQC8hyu5qCqtpMHtKyd/wNSMP8q0I6bp86lycopKq+FeOBuKPo
         NpLT19srU4rmTZH1UMu+19x9fCIuFl9TIfS1sdKzQMGIv97rsHnoH7SWVVHEjjqsZywM
         Sxpft5Hd5cGHKWV3zLyFrAyDiFaSJiq/qQhN3Or2GP0TXk2ZJ93X7KCxnZnPEaxGHYwv
         kf7u6M0+fxHKa3WueAMgXYneJGNfFvv1cPPfyy1cFfYmezT+GzBajtZi47wIu8toiRii
         68ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778145043; x=1778749843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiLRyqVWGS0Ix+7Et8ZETjKIEZ4pzdPJfw5gz/TlT3w=;
        b=IfBaSlO/K+QfBnM6MdznsABM8oz2JmSst14Fe4MJAF6d+cRkVTYbeCVd9Cyc7316MC
         TypkjRIy9KnTrMNxpQQA+TMGYNYBV2WctfTaF8Ri+WbghTyCVyQJPvi/j2YA7eE0nh98
         rkeOI/gpHRvmnaMOuP5VjBIEFdlItRjlGfAn3ma0drhTnywazEyrsCH2MjkmR7o+P5l9
         7Bboep3jiBbkPo3d2N9ik73R0FErnQRB8arASi8GyMyFfT92Au9qlS/tDAX35u+rnapm
         d45jXFUHnCU5MfyGL3RJiohKlHUJ0SPC002ACtJgYmszjnIHhTXXRPmG7fRhar3uxLYU
         nfpg==
X-Forwarded-Encrypted: i=1; AFNElJ+pWFFjpYn2+CqqLrUK5ZvPkD/qIGNay/A/UBGpCDcYl41wnbTAoQk7zXiSZ/1hk6rgszcbL9vmdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMjwtadnlYUtfBda4NJZL8hlUkMWjecHC7N+T23sGbqU0e6/g1
	K51obFmyRZC6pHtS6/+27jJbPFrgAyPr1vYDI4K5hkid9MhUGFN1DHUlQCtvIgpgzGCj/HIof0W
	c3BcWPP1Ff/7BkLQ5WI9PsYtxq2v18girZK7PkUoZ9HEEkpfCv2u+zhPBq/GLEQ==
X-Gm-Gg: AeBDietnRO4BewpFQuejsT1nfrRlQj89h8Wmzkw/KUcNTz9gPocaE7VXNx0+PCF0JU3
	ZCdpPStcyMEvkkbHKvPJUwYQZcB4d55afoGI+xTjadBORYmgmsE0lf94Ah2wN1P+MbXTVQWBKkZ
	lPgu8iIYmYK6R2fMEN0pJdLkXI5Ac1sADyLSaiFWgQDUM5EQ0ETXvmXZjNCcu58lg2EE2vLs/Fx
	OKOY5rekEO+qNTkskJdmCByHMyW7X8Rliza2NfZgrS61Ns3rDLH4iJWAN9WNesMSCxs7jFTTS4X
	6pbKwc55zA37883bSF0B7+WQ/aDH+RQmzRzFKGUWyzFhd/5OE28cLjgZhPXvEanOW775JSNHaA7
	wdjcXJn+9dP9jewXzJcibQxWqdVUggs60viwyF5pclDGBYceRcab2hOVwPydEHOjaq/N5gev0dX
	14gPzv9BOcYyEYDVDSuI4/XMv2//Nj9qFsrMYfHXki6Xgdwews1VfwNblr
X-Received: by 2002:a05:620a:2848:b0:8d0:82e:7423 with SMTP id af79cd13be357-904d69d8e00mr989744985a.44.1778145043100;
        Thu, 07 May 2026 02:10:43 -0700 (PDT)
X-Received: by 2002:a05:620a:2848:b0:8d0:82e:7423 with SMTP id af79cd13be357-904d69d8e00mr989741085a.44.1778145042666;
        Thu, 07 May 2026 02:10:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a86e65fdf6sm3822632e87.78.2026.05.07.02.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 02:10:40 -0700 (PDT)
Date: Thu, 7 May 2026 12:10:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: cristian.marussi@arm.com, sudeep.holla@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
        konradybcio@kernel.org, andersson@kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm-scmi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, jonathanh@nvidia.com,
        thierry.reding@kernel.org, digetx@gmail.com, conor+dt@kernel.org,
        krzk+dt@kernel.org, robh@kernel.org
Subject: Re: [RFC V6 0/8] arm_scmi: vendors: Qualcomm Generic Vendor
 Extensions
Message-ID: <mplk3qvyslzazuolwlcgy6fb6ta7ts63x3dq5wwybyejaxpyh3@fctfzjkyxi55>
References: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=XsPK/1F9 c=1 sm=1 tr=0 ts=69fc5713 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=RJIkCpciCD5dGSa3Y80A:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: Mg1daV8DJjJDoDaLGDEJ0od3gZjycDpe
X-Proofpoint-ORIG-GUID: Mg1daV8DJjJDoDaLGDEJ0od3gZjycDpe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA5MSBTYWx0ZWRfX9x8RTIam6y5D
 eVzoWQZwwdvzJZZTbH/KxS/c0blALSSfMO6jc76kCWIt5QNXTwCjZg97rfS7WQzaVC9I1+/PMFV
 kvhjeYNpJPHbZpigfXksv27Iu9amDB812AHyJ7aCn7qKNhkF55OKvxk7SdBpRg2YDtF6FSboQLF
 7VW2JQF4hpxajnm2dllnVfCC8tf7NLmaGY/H6rLIDpSt3aoXwbKsqCCdhUod2LKUKAIsi/xqnXL
 cwBr2D33RF9Hk6KZq7M52ICz+2nTNzmTrfwGlHARR/HHdrf+VAGdoESBtI+TT4Fq9thhuf8+Hft
 qs4qinRlz704lM1cxc9PQmKoQ+et4ea2o1TCZoid6aMKzS5qz8HtybQhcQWX+htoM/zWQftOWHI
 qLvaPYPUbmtYbb7xGoOqPLmg4Ise8UBDLvCwE3ScLPeNxFKXhNbNmgI6i8G8sqI0bQ6LxR0+iJd
 eML0tC+0Xb4QmWxvEXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070091

On Thu, May 07, 2026 at 11:52:29AM +0530, Sibi Sankar wrote:
> The QCOM SCMI vendor protocol provides a generic way of exposing a number of
> Qualcomm SoC specific features (like memory bus scaling) through a mixture of
> pre-determined algorithm strings and param_id pairs hosted on the SCMI
> controller. On Qualcomm Glymur and Hamoa SoCs, the memlat governor and the
> mechanism to control the various caches and ram is hosted on the CPU Control
> Processor (CPUCP) and the method to tweak and start the governor is exposed
> through the QCOM SCMI Generic Extension Protocol.


Could you please clarify, does this apply to the common commercial
Glymur and Hamoa laptops?

-- 
With best wishes
Dmitry
