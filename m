Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401FC488DA9
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312552; cv=none; b=Hdv2433hWhhm2pwLsur7wUCDnpl65lc2O0M6IGZ0NViVyRHamfTtQxMb6/P3dYMg1jZxXvjA669XCxeYGytKcSZXVd6KCKA0zJolNvA4T4JpJOIIltmGC4mvKA58lTWFbyQTUhbRXBq9pc4FOk1KwBhVc+LjP9u9k7UblNKHTkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312552; c=relaxed/simple;
	bh=NIU7Sq7oLaNDjKTgp8yxgJcyHFfZx+ZAPkEAQ7ttYL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlHBqKy2B+gj0T4PnevdtYX1EQcJKADir01KLaDNvSv3jVTj2xRnoMwunZ2XRIHLfdcdHITLzum1575KsyykvvdK+umdOZl7KMhck5gzfJS7h3gYRy3vmRYBPhUMzmTF8N0uEgB4L/WIEXk48dj//RGh0mTvruFV9gH6MpeG8jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dIiHrkTi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DpqtGvVc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dIiHrkTi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DpqtGvVc"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9Lm7c2539635
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 11:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Oh9SGcJoUiskZKX4r4ZOUupP
	C4HusVwgeUCpZ4i0z2g=; b=dIiHrkTie97NjxVm4NvU2TiTEPat6N9VWVR5IIA2
	RhkfBrap9NoBtwZeXf84BAFAvVqDmeUEEBvzztw6grOX+S36Aah6OQKe33ZrZhj+
	IQUgKQ8o0BiJOn2Jx761e3/gJcHAjbEg0SDLZ7ZCNjGn/u9gzb4R5hXN7n+9nqVZ
	QGRYA89WYA0/kMgPqzGdns4lDCPLwQmN+Bt/35DOV1DFLVLdr4Bp02FWo4/EkgNt
	MNCqVVGTiHHDjxxxZ1Q7yxqzfCfBUWr6xzYIYYQ24/B/k+ePz6/3Xoxfas9PWnmG
	UCmHB6WAWGlYEXM9Yd+WTwz8LeHPhNHji2REd4PtzfIpGA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6fuhhdbj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 11:42:30 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c083f1818so9540761cf.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 04:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787312549; x=1787917349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Oh9SGcJoUiskZKX4r4ZOUupPC4HusVwgeUCpZ4i0z2g=;
        b=DpqtGvVcQV1N4mBYz5WAAg4+6YXoJQHaJQgCbTisgaOdFlyU7k0hSYXw2OXK2wakWh
         bNbTkMSdkNF3pSOoHYBGWPE6vHnU0vNsY6g0wsZexc/H+GDZJxHTRg/YYJOE5KTf8fxu
         35YdrEwfGNsKyS54dO433miWb0fqVi1YVSNUThJ6qannNlRm5kIFk9+apZyRlS7Xj68I
         fOROqVaurQCU6RL8OX2p2YYx67wF7gdMLAal+8HXx789B48xCWM7ul5mpQCrYeHJ+YnG
         s1eFpibwiynSZ9T1rivGbKAnno007/VIS2p1UyqRN4sVmtOFSyzupzM6jgi/TPLBw+xA
         K4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787312549; x=1787917349;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oh9SGcJoUiskZKX4r4ZOUupPC4HusVwgeUCpZ4i0z2g=;
        b=ooZQNbRvDjjEAZG2PuH3vON/1+tbvABHPSuvKCU4baBOJg+Yge9A5M+qCKhV8TLOPd
         IvaXCEgPJgOmu7iV4KOcqMppolrJKRmclN/V9zWIc64FgBfLayjXpTc1pdGWMnG8fIev
         lcJfJQxr264eJLNuS+BH587qDE3XHnybb54EYj9pZ93eifiFZlxNhTFtdCbuMKnGyWid
         di9YuhZZ47ueZOmhfNjoFkEPAE9CjDJcZ6YD6vs0OQ1XfIiglrOXf04lK39vVSxpnnBB
         RV89nqP3iYiFVWVZk1y3tHMU1uwotROIQk732968tKpehc6sfNJ1de+say+aRM7BRCAQ
         ZNvg==
X-Forwarded-Encrypted: i=1; AHgh+Ro5CV3jEQr2uoc/kUkAUD80annyvdBTUM7wtmCKFGEzRW3Qn2ScErhuh7HpDZgbrJHYY6d2xrheag==@vger.kernel.org
X-Gm-Message-State: AOJu0YypsSUBC+U12PWs7iRcbytnXe8fkJcfv7oYBrFugYPHlPBCyVGS
	PW2iPPEe95Sfi46Br97FPo6VIZpaFTltN0htuebWLgGKn9VUMFDnsAporN9p1AekHTuUWVBEQMG
	1kD30tWPnFAtmWHWYbYwOKDiNexwRY8xngEABiePM+g06je4qJYyBJGsbFCZJUegsG0Gm5uzVnh
	8=
X-Gm-Gg: AR+sD13YlxSRZofCNBSmpUdHg13zLAYL1++yfjFQP9g6y8W0o79JZpTj+0R4mx/jyEr
	g24egVg3lv0A/5j3nk6kYWq2+Oxi39vuUPBAf9hhs22uAnfAS7PiMecv1S17bMgfIET+EklVVXs
	JRpduRWpp3HcSEhAns9vE8QJ4vWjevRrEzs8yyRwbO4rv8qosDaM4KvKBg6lQ/aZD+0MLuwMnSk
	YTqK9hYwdwqJ4kNrvQIZBwL3A8XaY5ujtkbI2ChQZowa3ot/dmoXO2gA4YwwyYWiufhYOYp1v5/
	E4Q9DVoHSYBK7JPt4fDHbtv4Cnm8SloqLhTD4BRqYiQWihnnV+FGNEGuNvZcSDVLi5jdm7/GK2a
	/boS/IWjkcLOHfvk=
X-Received: by 2002:a05:622a:283:b0:52d:89f8:4f8 with SMTP id d75a77b69052e-52df56e491bmr49499941cf.5.1787312549403;
        Fri, 21 Aug 2026 04:42:29 -0700 (PDT)
X-Received: by 2002:a05:622a:283:b0:52d:89f8:4f8 with SMTP id d75a77b69052e-52df56e491bmr49499401cf.5.1787312548864;
        Fri, 21 Aug 2026 04:42:28 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24591df293sm474840366b.45.2026.08.21.04.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 04:42:27 -0700 (PDT)
Date: Fri, 21 Aug 2026 14:42:26 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] pmdomain: airoha: fix unselectable AIROHA_CPU_PM_DOMAIN
 kconfig
Message-ID: <7hlarbdpln2y5ckt3i6nz4gskcxl6e6rher6rvsgmwop6bj7jc@exu2d7paa5iz>
References: <20260821085222.140633-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821085222.140633-1-ansuelsmth@gmail.com>
X-Proofpoint-ORIG-GUID: iEiB688OTQZ5iF6w5osN50t2usYW4AZS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4OSBTYWx0ZWRfXykKa6bGG9nsZ
 CGNY6Vof3eRbsYpOyss+FCsD3Szj/gEx05ZDfTm7XQhwJum87M/yKtxFqMGfQQQBCvEZrps9jJW
 wKqosboxP8HnQfRpYVe0BcYvNeRfwWM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4OSBTYWx0ZWRfX5h8eCgmzNZBA
 jzbOZTxPuPzpJKGBgxJ99QS5tVxuGjD2WIRfF8cNQtzZ7m2Gggo8WZBD2qZBTc579QGujCB2qxk
 x+My70x0DB05JGsadeg6+SsbNrmK2rBmUD+zXAjt+CJ2maoecdPIyj/qCmGYlvHF5c6jsv+XUEL
 bHHWvaZp1ORJVy2ZeDAdoMcJF/xtTHUMKWMlp6ibT+PLn7pnM5VBrO0LEtS/T+wJqAJmUJzWRpw
 2ugmO9nUmr0N2IvHYY/WSEUOdPnPryAk38OkJBdNDExvz6n85zYe6+pceKMJpJBJVpvipyX+y6f
 8EBVrAgo31KRNQ0Oo5qV0zpyqgEy9hLokiHrZO5ftuaimTRgBPWYnvsw5CRiRlefka2Xe/XBEgA
 5wiVf+z4YKM8Z2Nz9tVjZZga9YL1EMo1wyt1HCLNHTP9vBj4U/oRLd6IsuAU5YFnfJQynkREkbD
 wVqzVElB6KK+/a3q3HA==
X-Proofpoint-GUID: iEiB688OTQZ5iF6w5osN50t2usYW4AZS
X-Authority-Analysis: v=2.4 cv=UtFT8ewB c=1 sm=1 tr=0 ts=6a8839a6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=8jWgAth1d_VLo0Q-LswA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210089

On 26-08-21 10:52:15, Christian Marangi wrote:
> The AIROHA_CPU_PM_DOMAIN config was wrongly guarded under the Mediatek PM
> Domains menu and was unselectable.
> 
> Move it outside the menu so it's now visible and correctly selectable by
> default on Airoha SoC.
> 
> Cc: stable@vger.kernel.org
> Fixes: 82e703dd438b ("pmdomain: airoha: Add Airoha CPU PM Domain support")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

This looks OK to me, so:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
