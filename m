Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C863CF04E
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840731; cv=none; b=Y8/O64Rv9tGWWXfA+uWQUy+Rxt8mf7VltJqVGYUMABFscy2EiYKEjdobqJTdeZl5iL0WZugc3sbod73TCz3kFcdVsYSYbCKB0NWUslJ8c7W2wSEe6K/kEO+JxdMsDTkME+paUm+Y8sG8z81IZtrxyg534pJt+85eppDxbi7sWfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840731; c=relaxed/simple;
	bh=FIJBGrHTL4FdYrHCnRzSc0YOaWpM7/1dy9GeUxnVF5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qht3mCsYZfBXc74zoRkq4h5bWt942AEwXhtmNrK+Mzmm9iKdPtFb5eFgEcOWiXGEAQSXcHYgMXOR9xfDFGTT/IkNpjYM4x7fd3tTIPhdaR78aZgAu7+C4XCiAU7YBhpDLklp2IPzmn0gbAIwt2Kl7rS/gVT+XgtWnvnsop929bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OmBmKlay; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XfOAGsO3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OmBmKlay";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XfOAGsO3"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F95dOo1714959
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zRSMmQ/Cq1LqIW/QrE3Bu/0w
	2K7GvYNa5jVkdlNAg/0=; b=OmBmKlayRNMel9mvbgdMIZEbSilGItVQXKMJueXE
	4oa29BqJbWUkUOK3xI80BzH7SG6WiDAuC39wZD8jCVTqHHbtEKgB7xlHQB13AKX7
	7aFuHh4DtTzWyvaXIr2ZF/YDyPmdgLExzMwPSL8vkaWh/MzloL4ogZ0XL5WKRuEK
	93f45x7Iv9XKk8QeeKWNaWAx/oFBlsjnZdUwPm6kfveHj81nPp0s3o/KaSjDNvTj
	SD9qefJdk4kLCvoPwbpD2MGnbm+b+l+tM+YqskX8HqaPa+NEnJLFFk3hpZsxEZ76
	A/4SXKFrthKn84w/iWvO7JJQF+hGYFyIaKQNX0j7hQdFHA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5tyxsm2j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:25:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-514ae0e3ad6so19653961cf.0
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 03:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778840729; x=1779445529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zRSMmQ/Cq1LqIW/QrE3Bu/0w2K7GvYNa5jVkdlNAg/0=;
        b=XfOAGsO33lM4+D92VLqmsIww0yWc5xfJCqOVDd0zNFEAKI+bwCNn8s1Qm9WIi2AJA+
         hRoaCswqwscD5FXVqhS4+Isa/q/w8fLqyGy5jkaL2g2zcVrV5A4Kul9KbtC82+zGalKc
         GFnrh2brh1XDYDfqUs6BJcBgael9VNQeaXJBQ315LwTR6lxdgF6Ssq4AimzHz2JXAIq9
         886eKnWPGfTX0vxv/2ijWXz7luVoO2q9yVw5s4qTJ8CciQ2+aQRHs2PVG+B9ETe9cJf1
         ww9HoavNvI+DE4YO22+6Tmx9683CSizxuUxGoRmlQcyvsKZuC+siuKLOFnsv4c7XQlF7
         os4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778840729; x=1779445529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRSMmQ/Cq1LqIW/QrE3Bu/0w2K7GvYNa5jVkdlNAg/0=;
        b=aVNxn99Xp4TiOsOwJxSjlluPPS2VWdhJ9qMXvkibriPXy8yz/U9IhWhXwjd8OOAEkZ
         1ufAaLp718/Vx4ucZIfAMJosYYWpl7fy4tE547t+30P3xV6DftyKuWdfcWRWylbBKn0X
         Aos7rFXwc1C090cWWDIYGc4Nte8v22TFIgzPIDyN7krKDMR7S6h35ovuMlMJRjnM+Tfn
         HKAgcg9G90sehOiYarv5VWHp7KWH6lZR5qzxaYrNML9R30Zo/FeJ3jNqGrhh1rMVC5OI
         fX7xA8Aa3MzGAMPqMgZu/3e8Pp0KRvN8XpU2zOk8tAv94XlJudqffzSJbWPTUTiz+Y2m
         JmXw==
X-Forwarded-Encrypted: i=1; AFNElJ+qp7bnHSVpAvQ2b8vkG4Vd7vO6itX49CYM3Ro+6Lo/OfvkD8asIuDJ6P5t9O/v87edSsFLvMOfEg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5D3rHB29zR2FP4oFZPsYzq1fZLt80PGPP+nDXRm8TVnPXgEkD
	SnugJIUoxv5ZDNKBpj31L/gG8cCxeToUEJf1IJ2/14TjgJkFsEdMcfnADpdexy9yXb/CobQscSd
	+tv04p2nDxcbe0le+GBwY+JS5U/fAnK19/q/7xbbVUeZnp7UUJA3fBfjRjdixKA==
X-Gm-Gg: Acq92OHTwMv/QOKxOSfKj7AH/KeGaZwPN3XQ03AUAUe9dJ5y/WAZgqdCVP79uoeNPTA
	rbetGQqMPWEayJFedJZtSa0CiNwkHTF9YRkB3XVHi06SL/aC4dGK/WuBPF29H/AYVq+rQBQDhHq
	AE4JOSeFkBx/OwtffPdtUialg7rMQmoybfHgmLhox96OjpzqOeHvEk5LyTPAO83dp2H7W1K2ukh
	00enlR7TEcbeP3bUWHjsKXwBgPZ6Wa0QxaaTLK09MA8+k8D2ajCAbR7wYkh3t1avpzXOHV1KQ56
	/q46Tzphwl+RDSPQTkXi9KC7RF5r6DHD08itqA2aQZtEDlHIdrtTd2tjCYwFoqHFOuBFxsyvSKk
	+lvM+UQmWiF1BUjPYPEWaQkQjjLGUPdlQwzApvpKjoTto/33xiZl0jlPyjLDHLX9j9J3DD5+tfE
	Tguce7jjJ9ZGd1dY6uAHZu8UoeV8kcToyBJ5M=
X-Received: by 2002:a05:622a:a90e:b0:50d:ea1f:f99f with SMTP id d75a77b69052e-516418bb578mr75905871cf.31.1778840728962;
        Fri, 15 May 2026 03:25:28 -0700 (PDT)
X-Received: by 2002:a05:622a:a90e:b0:50d:ea1f:f99f with SMTP id d75a77b69052e-516418bb578mr75905671cf.31.1778840728561;
        Fri, 15 May 2026 03:25:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c531sm1213085e87.4.2026.05.15.03.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 03:25:27 -0700 (PDT)
Date: Fri, 15 May 2026 13:25:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xilin Wu <sophon@radxa.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] interconnect: qcom: sc8280xp: Enable QoS
 configuration
Message-ID: <yorktzddkpgf3o64wgx67v3ti6an4z4o7yupcgo4hh6zfrpeey@lypcddxnocxg>
References: <20260507-sc8280xp-qos-v1-0-15135858cd98@radxa.com>
 <20260507-sc8280xp-qos-v1-2-15135858cd98@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507-sc8280xp-qos-v1-2-15135858cd98@radxa.com>
X-Authority-Analysis: v=2.4 cv=dMWWXuZb c=1 sm=1 tr=0 ts=6a06f499 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=ksxQWNrZAAAA:8
 a=EUspDBNiAAAA:8 a=NfFXuZlUh8PrNxB2MeMA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-ORIG-GUID: 0jFBNVDscceYquiFtDiTMXGoytH6lTTG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEwNCBTYWx0ZWRfX0rtvy8Emdknk
 Qh4ZIpfQoISXXT07AqLJnIzrgqnjry8Nh5/p2wFVskstTCqIbs+supSzFg/6DYDQszRisim2i4E
 RMHmn9PWXznRRah9q59gglDBTFliz/vG5sTpfGjSKRuAELMj8hn9AP8w948xPcz9qyszs2pH5CS
 vhfCUOM+bLa4y2JesqT37pHBbRje5i9WvIxcpMP7bnmGhHr6bKBPMbRGoDJqwuLDsD5l7jkbn34
 Y/c8ic37qfVz3dIL9k6vVSvMfl38ftGl3bi4x4BhTwu3zdgJxSx2Z7aEyjlEzheGMQUwLF/AlDl
 WmvX3BnmH413ule6faIrZ9Nm3ZVFKcqVWYwnPokH/3b4MzDCwfD4zOUn+cwXk9RElypU77nisqd
 ne4KdPIuNlYRZJws+VRt3380N98ORh3+3/AdDkUQBO1dwpI7PHH2PnKmvJzFGzdAkRnMqX+k9ax
 xbWgLUkSm/7RLtblOiA==
X-Proofpoint-GUID: 0jFBNVDscceYquiFtDiTMXGoytH6lTTG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150104

On Thu, May 07, 2026 at 10:25:13PM +0800, Xilin Wu wrote:
> Enable static QoS configuration for SC8280XP NoC master ports with
> predefined priority and urgency forwarding values.
> 
> Add the QoS box data for the SC8280XP providers, add regmap configurations
> for the real NoCs, and mark only aggre1_noc and aggre2_noc as requiring
> clocks for QoS register access.
> 
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  drivers/interconnect/qcom/sc8280xp.c | 356 +++++++++++++++++++++++++++++++++++
>  1 file changed, 356 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
