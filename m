Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE1D4119F9
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339176; cv=none; b=Nl4JkTq5gllIqlIoSGTI0XCjNjeQA9Os7dd/P0ew+dkVkbJdjQvSo0ICgifsVKa356mZw+/4ScP+cDPKPKMR+Zu0wAYpPK8LbE3c8F2Dk9G2lBq8pc26KFeYJzcbUqK1U9hq1fRxc3+dKf1/pP7ZPz/rOjtPkbenHUzXPF8E2UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339176; c=relaxed/simple;
	bh=yfrsC50ioGPIMFrNhawpkz8O61LnsoDnGzPO6q6DRQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QeAt3WGenSM+4rUnsEZcSsbER4Ro1oqZ0hhCXpWpVjQamBhXeo8Gdn7T8WFimgHTqIx5vOv7TmN1FCZOVDSmwrLwlAKU+30q62a08EaaINey/1Hkl0D0/Inbogb8RNn+2b42NT8RKNvVPLjJIKs0mSVIwKKHpWMbUfxH0GOr8Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b4Mtw74K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e365tQXW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b4Mtw74K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e365tQXW"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TF3FgV2181889
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 15:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yoh+63SttaOY9zCSusjP2waN
	JNCY11RiLRNnfqSUL5Y=; b=b4Mtw74Knj8bjb3cqtocKVGS+Excgkj2UhNKT3vP
	1APzxR86R2TYk/YbG+ThF+rRPJN6LI/7PyviOP9OC0GLbtmSme0Uw69qVrMk7Gcf
	3fPQfTPNKocTd3Nd5xBWbX2rPN6LWDLVQWFuLbtIDXeNEqENT1ONWhmcfiTJ3uvQ
	tMqfX7/NWnvZyhcNNAjFIfYyjkO9yKreTrDe8UrcVahi2HvmZywrhP+hN+YjyjrV
	reWQ/qQhsLBS8cgKwC+wQKYWVx3jMdfPMBNHCNYm88Q5BV5n6aymLzVI/2OS33Ar
	YrUQYkmBqt5Jfc8CsIhs6LVXYtbELRsR4fcA4+4syKampA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqhg8rysy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 15:32:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bff5c7035so20890011cf.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785339172; x=1785943972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yoh+63SttaOY9zCSusjP2waNJNCY11RiLRNnfqSUL5Y=;
        b=e365tQXWa99gI9WiJ7DsXJTtjwZJeeSn5mKsw6a3DoyWv+Fz+4qtoz3PMnJ02h0EJC
         rf4zprChOH0OYcXPQH6SOUJB4kKJI8auF/ocMwDGzemR4jZ/bmE+ipX+Z+x79qr0HVtl
         dUzIB1uqLD1Mme0IQHcxUyf7b+tkhjSnpFohMiyHzqkMlmwk6On8wVkv3FagvTTQCUtZ
         57Y1etHoDnqSnaZuIxvYcqcBq3JPg1H519AOYMlhA35XcuuvajEY1HjgXP8iReMdMzvm
         rP0pxdIvyEiefp7NQbQ7ml+asDTzNysVUJ/4SMIpLGXbcfBNhkixZb2p7yJDGS4Hgq43
         dF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785339172; x=1785943972;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yoh+63SttaOY9zCSusjP2waNJNCY11RiLRNnfqSUL5Y=;
        b=CDVCZN2awj/F6giSgjwfc7IEvZkkSiqc74FD3/ksn71CllcRaSnUxqqL3FYWzS3p2S
         B6SZX2P8uhOBtjcEMzcCGRSnj1pwVKwFHqtxYLAXVDFqAuzIpIq8D5cIjIVOm+A4hQUl
         9VhqJq6dghmB3r0dQA+Dutg2Aui5T0oOqLNV/V9Ep0xNDX4WDPBT5Dtb4bvJDKeSW7oF
         9+Y8ChV0oM6KgSPINqQGAioe88yl0w8b8YOC/5y6K096pEi43/w4rIYbE10a34dcpcg/
         PmjhtqsFFSPw1ngXf4xJxt+ZAx/dfdZaQgRZgAoONXjtcOvbpckSDh+ZxdjwZk52OYVk
         qoqA==
X-Forwarded-Encrypted: i=1; AHgh+RpewLIE4KKFkNDeaccdWEld0hTMDQMtB425zlXNZigbAWpF/xSZn6WeFX8V9pALk6Mr5lmKgWHZgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9WbSnbGmAfLwCaW1FTYc38cT2tjsGo+hVReuaxIl8br4XS8cE
	54znr/E4DISxGztXy/KieQj4/rW6C3UgdKzOWsswbOzFzXQLl6L9f+bdq29z5MvBzSGGaTh1GQo
	GnKUAqJQ2abreJE/NQu+LOGixVK84pCGQqkVjt6fneqFWBQ0KYukNWMih96gZJw==
X-Gm-Gg: AR+sD10/8M85LjP3m0pc0yJAbBYz/9TaS86FmkL9ihRqIX8QA1RNEPZJRcQ8A2Wzy/5
	gf+rrCUNz9Nko2KEjEiLtfxsqXY0ezlEwGS8C3l4UKZOCY2FtIC0Wre4F82b0OpKTtGWiusekFd
	YP69o+dngjuRxYxJiek1IsKYxocF/zGc9KRBguxe++xJlHjiWr7NePTPcCPTKmbJd7/c+apQXU9
	RLeDC3CHT/jEO1u/vg5lBVUOwqh2zs7PtGt3D9kYKy1t8Z9lfflQenE7GIZVSJV0KNohzGnV7DI
	O9y87skH+6EXSVuVuiFl4NHoFRL7mtPTf59eSV/V0R2y6hUcf7zlFe+x+ANJ7Sh6r48Ps+OFTof
	AvTzGslubs43qze4=
X-Received: by 2002:ac8:7dc7:0:b0:51a:8c86:bd42 with SMTP id d75a77b69052e-529d7148884mr64378971cf.63.1785339171989;
        Wed, 29 Jul 2026 08:32:51 -0700 (PDT)
X-Received: by 2002:ac8:7dc7:0:b0:51a:8c86:bd42 with SMTP id d75a77b69052e-529d7148884mr64378391cf.63.1785339171272;
        Wed, 29 Jul 2026 08:32:51 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.163.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4976bd83fabsm66366305e9.15.2026.07.29.08.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 08:32:50 -0700 (PDT)
Date: Wed, 29 Jul 2026 18:32:48 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with
 TC9563 PCIe switch
Message-ID: <aajfoxioypwxysjme7wmdlkhfdvklwjc26dldvdnkp2axlizp2@df3gcwfgjadg>
References: <20260729-eliza_evk-v5-0-41790a5a24de@oss.qualcomm.com>
 <20260729-eliza_evk-v5-3-41790a5a24de@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-eliza_evk-v5-3-41790a5a24de@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNSBTYWx0ZWRfX2RereyeaWJ4R
 ABalUAwFUq5ZDLYcMBXj78YlqeaE/PkbkAcXZhhLgFURL1tD269PS7ia4+2CaTQ6QL5bEcYDA82
 SwaCH7KvW8AtPBCnuepEgafiO2Y93os=
X-Proofpoint-GUID: 3H7fKfjSytWXxfv8Vuaq4NOyKlN-IZpU
X-Authority-Analysis: v=2.4 cv=LOdWhpW9 c=1 sm=1 tr=0 ts=6a6a1d24 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=6dw9+iwJWV8PcCi9M4lOBg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=adJbRHicXYsKkr84VsUA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 3H7fKfjSytWXxfv8Vuaq4NOyKlN-IZpU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNSBTYWx0ZWRfX5P1td2WQFREE
 BEGnQVMq3P/KE+WiqiE9Jq5atAUTNiuZADwR9jzzf7vH7ryBN4xFhnyVJ2dRcNEGnM2Nk99v+dK
 fYxxqw4JzKON02T1DJgc4U24cRyfxw2EQMySQkgWbc8xdQae6AWpm6KWPRKzr4276ep6PiMnMnm
 UTrDAd3u2uR0A+7pRdJI/7vWTtGHVMpnuf5vBIk1FPzq5iF8FlFQHiuNRhkCq5fdFisJ7FaHCeM
 g4QaHncBREBqyOb77l8mHzAvspYZQoEkr/VBszZBC19noEk8GGDRXMbArF/r6gweoxwJAlO2tWg
 GWY1APPeFI3A75R64ESa61JFISI22iwQb//jS+xJB+R7YRxHtbXmSQqREk6o+9d2t6GQHP8Xv4L
 S9RcvD8Osa5v3F75AMg+lDZoCB5s8GzvK1MPleyxCjPNxl9MYRhIDf6nCOnhd9e/ISXW3eLgMti
 e9Oc4ComPA9JrjGccQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290125

On 26-07-29 20:18:38, Krishna Chaitanya Chundru wrote:
> The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
> PCIe switch. Enable PCIe1 and its QMP PHY nodes.
> 
> TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.
> 
> Override the base iommu-map with the expanded set covering all the
> switch's downstream ports (0x1400-0x1408 SID range).
> 
> The TC9563 RESX# and PERST# are OR-ed internally to assert reset on the
> switch. Use TC9563 RESX# pin via a TLMM GPIO and skip wiring PERST#
> from the PCIe controller.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
