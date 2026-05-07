Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EB933F5B6
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778152261; cv=none; b=XheiChil7oLe3m/8Yyx7E+fyQF8MSfxZYkxcQSYgjHYjYeGYR3rmd1FnR0LZ1UDJnxBqPJmin46EFieJwFpv5bByRCIMcify7S5lfa6Q4djKFrd5Sbwtx0uX2qDCmzGgw2FOVN0VDV/ryZdc2YJeMI7w6BYGeHwRaF119HIQkf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778152261; c=relaxed/simple;
	bh=iwBZ7AtMlhelEvLw+tye8c1q7oBAuTMT4QG11XTcpvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyDJfevB3wVdT3+LOTggy/i14PlVOPos7a9q9ByHak0BXSLPaQCL7HSfVS90mH1s+eIF7Hlegi4cfIIF3Ivt76lXUTkuHU9VzuXfJp7ZXG5p/vYfnJJlMgOAX6KwxUqXqIcXJ/16JDFywlfJfISTmPtEwh0qCtdCqMFPuo7nzt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O8jZkoVA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g20X+xxt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O8jZkoVA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g20X+xxt"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6479vNmh1669563
	for <linux-pm@vger.kernel.org>; Thu, 7 May 2026 11:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2Y1kuY6AIGy+U4i/Y7pzL/6z
	K08GGDx+3n+4jmLdQvU=; b=O8jZkoVAqt+2HLCrU2eOD6YB3L6iTXF67LpCaRSu
	QAseQv6SNf3eYEndOf+rlKeYTn5xvcmLoniRiabHTBNmoqEMId5tALIdR3xOYLal
	M80isMChprYO83Hs+kwz+mL4ar0l+0LD04kBgpK1seap2XZ0v0VI+meYkfLPzgo3
	KBDG4EMuoWNq5Zso9HhvywmqbfipwOrbHtnNVXWsHQgvlbg5GkRkX0VlgFlAuOP/
	XMvHY5T8+aYuRcvjrt7euN2/KcH6wo7D/lvgSKY71ochyglzsfOMjdPS2CMXeRpC
	XLTzyjYCysKfoMAX/LiT99/jDAE5AaN5C03ulU4NuObiYA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0k1p1jx6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 11:10:52 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6312aa1d7adso33531137.0
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 04:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778152252; x=1778757052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Y1kuY6AIGy+U4i/Y7pzL/6zK08GGDx+3n+4jmLdQvU=;
        b=g20X+xxtK858QKAdfgknvaE5wdXkNyjSMvfJhZsM6umA6INVGTekjmpmviDynIAbE7
         GY0wLAqURl7qTs0JYq3mapcEpWu2Fci6AnGvHS5lWqGGtjLs8omBvAOxFfDObaMfibhF
         PwM+jNftyf3QhpHC0hygrhI/driWYyGigVa1n8vhZcm/pYz6q4ceKZF/BPx4K6ckm0B3
         bAxuqhXMrUvK3olSICpxo3v0TDsKXKGpClj5VB/Wav5BaxT0xWZo1kQXQiPQXF/jGCcO
         UYnUyrkyA2H1y6I7DVw4YAOVH60PjlPH+ZYzE3cyu2qYSL2llSduqNx9xD4WpT/d+f2Z
         DikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778152252; x=1778757052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Y1kuY6AIGy+U4i/Y7pzL/6zK08GGDx+3n+4jmLdQvU=;
        b=h91iNztD+VMSKuGzjcoYkeArkF2SxIYVkt/xNXiCLx7yMvjA8Pby9KZYNz7cZBK8XL
         Dc3JTsBX4fOqSlIFvMKYQ+Wa9CJFJHdXEzqRWCEdsyS2IxoOX/PdVfP9cvBqyQlOabqL
         9TlaZNHef7lNe96aEG3v7DAM5eDhBLbzvnFBgBgAEBba9fnczsbjEMpaOfjJK5Em7I8g
         MCVk8xJ2X0Be9eQLrLwRpV18sRAu0TEXg0h+3k8ni7Y4YZln6mSU9zuIXx0C9rnKkz0Q
         UcabSjrs4TLPXiMmmzFktkOGp1i0+EG2llH468ElfndEeAjKsKEWYpgLEMRAwB1AaqpS
         5VHA==
X-Forwarded-Encrypted: i=1; AFNElJ8FMjSc4iOV1XU4M04Qk37OGv2CKx8DdLoPFnZ/0dWdKtNF8M7hdP5T6n/6IBIQgYrAsVHEtPiwcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQZ2nIkfbA8JAcWi7pKdxEGqURMNwDZrqp67k9vhYb4nDjTC5C
	1uSOjc1YvjmJ+2K2OefxNDDfxOF/1ovN5PIwNCETWT6hJwn74KfQ/cQvnBUSpldQEtLmfN9zQyb
	4nkO0X9EMM10YLXWKpdFRKBXe6k//iAyFR2CRo3JQWAAZULvXtMsTxnYmi68Slw==
X-Gm-Gg: AeBDies6FB/W8xiFscYyfy6yM9FV0nZyrlR74lBLKow/6P3xb8Q8yL89urEeuU4IXJU
	P5TLTgVmMFQRMWhEUi6LeF1JrntctRMLTH5XV5GTZpo1o/rI6c2+NDvm/36cRrl58TUoFj3O/F3
	EsMYszro65CLxDpkxGpbMOFrsYkg7T4Udw8RBIkPJfaa4ShZfdq17GiSg1p9aYsEaKDfMYbMv0T
	Xw2hlrg8+Tn0Jj6rRHJt18QFDrbrHxsDZIZuLvDG+P0BED1wJTjHjc3tE6o8u5Twcmka7br5vZ3
	JX5F0DvoXifLQPO8rpr01OpRubT78LZWWsgZIMPczW2A7pUCmIWAVSnqTfqmuLS1gI3oNQEfK5T
	l/a8XUX5BhrNFR+Z+lWmQibwK0iaw2cFTqKldKmXihJaVEBXs0r0hFt/ZhVu3OKCpxlvXmzIFzL
	HL4hRPywaXQhh8WwmsU27nTpDfQev/l/qRW6mpXF8lUWq178EMXjgHxZAc
X-Received: by 2002:a05:6102:84d2:b0:605:38d2:26cc with SMTP id ada2fe7eead31-630f9036c70mr2284833137.26.1778152251757;
        Thu, 07 May 2026 04:10:51 -0700 (PDT)
X-Received: by 2002:a05:6102:84d2:b0:605:38d2:26cc with SMTP id ada2fe7eead31-630f9036c70mr2284814137.26.1778152251228;
        Thu, 07 May 2026 04:10:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c22de94sm5528582e87.7.2026.05.07.04.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 04:10:50 -0700 (PDT)
Date: Thu, 7 May 2026 14:10:48 +0300
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
Message-ID: <nfh7duwh3o6hayhxz4pxwfwng6fi6q4l5rlzlgjjk3atakw4h6@6xbyk3nppdrt>
References: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
 <mplk3qvyslzazuolwlcgy6fb6ta7ts63x3dq5wwybyejaxpyh3@fctfzjkyxi55>
 <605bcc1c-a4ab-4125-a4b9-facf801db26c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <605bcc1c-a4ab-4125-a4b9-facf801db26c@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDExMSBTYWx0ZWRfX9ezvN5s8h0Ki
 EFbdbeVIHu//ghf71PsI3LuYL5FiEHLk9QMS8wNrhD95W73iqqePn+dbgJG1WlWkipuDDk1f+O1
 ReIWkVMhchTqoQFPpTGWA1ggJBHVRaTML73QWhjzltpyIGA8SK/VNd55MyQ1zA43CHxvMivWRpc
 XdHwB5REfSNhOwRL53hfK2J0u0J/mRmopdy3Q1rNOxk5lJJRoUTBPb4bamiGyyeM5vS+hV2nLv/
 EtTyomCROmSgfkOZ4aTCOprpF4K2QUwtmCuDI8LyHX6MAiwrN+VJAKnvUWM6kmQTDhHssWY43F9
 qnicCgk0nrORC2golf9UAs8ztKqfTk7yaQxnlcBXu1U/bYXmoESyYqZi3Y4SDawqfid3XLEWQag
 3zIfnaL0xIDxnAJMRzlPwyI2IBj1LtUqsX2GAsmho8rud+sk/w40tgGUejvwkuEojbeepaUBZAR
 7QEYcWMCnAeSrMlGLMQ==
X-Proofpoint-GUID: UObllwOsQFYdTRyw8DWBR1KqgP1hU7UE
X-Proofpoint-ORIG-GUID: UObllwOsQFYdTRyw8DWBR1KqgP1hU7UE
X-Authority-Analysis: v=2.4 cv=K4IS2SWI c=1 sm=1 tr=0 ts=69fc733c cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=kzQ9Fxln275sraQuM_AA:9
 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070111

On Thu, May 07, 2026 at 03:28:21PM +0530, Sibi Sankar wrote:
> 
> On 5/7/2026 2:40 PM, Dmitry Baryshkov wrote:
> > On Thu, May 07, 2026 at 11:52:29AM +0530, Sibi Sankar wrote:
> > > The QCOM SCMI vendor protocol provides a generic way of exposing a number of
> > > Qualcomm SoC specific features (like memory bus scaling) through a mixture of
> > > pre-determined algorithm strings and param_id pairs hosted on the SCMI
> > > controller. On Qualcomm Glymur and Hamoa SoCs, the memlat governor and the
> > > mechanism to control the various caches and ram is hosted on the CPU Control
> > > Processor (CPUCP) and the method to tweak and start the governor is exposed
> > > through the QCOM SCMI Generic Extension Protocol.
> > 
> > Could you please clarify, does this apply to the common commercial
> > Glymur and Hamoa laptops?
> 
> Yes, they do apply to common commercial Glymur/Hamoa Laptops
> as is. This is the same solution used on the windows side of things
> as well. There can be certain cases like Johan has reported earlier
> where certain oems are stuck with on older version of CPUCP
> which requires a the memlat string to be sent out in lower case
> we should be able to handle those as well with overriding those
> by using driver data and specific compatibles.

Ack, thanks for the confirmation.

-- 
With best wishes
Dmitry
