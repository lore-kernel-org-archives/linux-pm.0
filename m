Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D9C23E325
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779700790; cv=none; b=Dluku8kxhLJ/3j35G5TCqIvc/aCL8ZQAoGRfyJcjCE1fdLLsxWJ25MSFTLVD7zlj6aXpBO7rJmpO5nhjZDA5MNx4xW4j90Wr/XtoyWhm/uwkv2f8AcyGRDzAJMO/ZXCfelVX6cnqSZZ748qElhaf+Ku8YYoOJZZemiqVkls/flg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779700790; c=relaxed/simple;
	bh=NMWHkTxNy2mY9CbN/4Pzkn81alBbBSyaCV+OGmHpNe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3mlZdT/Lk0m4tmAM85YI5FDWRh9TVVptipCamOnzy2+4gtzxcAm9EG4lcQhjFMLGomNGTuiB8iIqnFpn9ZlAiXeaC17m0xkw2QxAaBM+tfJjelLTFAFvycR0q+HJTx5EdaiCnAcq2bXnnjQEHBROok6K3CDSTjLchThcR1t+pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kLo30QGN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PbANSB55; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kLo30QGN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PbANSB55"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P7aKl21871835
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 09:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BavdLDn43DqP7dnx6Q1ZiNLC
	40D+9S2q6v2HPybJae4=; b=kLo30QGNqJbyT3FZzykWbOdwvTFF/VCiAbL4fGmu
	JCOd0cytRCB3Qyg/IPJ4v98i9mENoc9yjY+FJ0jDF8u92KuuNB2P+YXiuaCBqEBb
	7oxlDa08S3n+22LVDlmu6FAVHqR878afCSgXx2zipTAEdBlktG0bcPZmLepZUhoU
	0ylzmKrQDmnXV2rYzLo5/QwKy0qS9lLI2gau0pwrPyrozWDAFb7k7M5O2bHehY5O
	Qk0V2Vl7HblYkyLA9dPj++VCgxea2aRE96zpZUlcmaRx08mVVD3fpJMSfsqAIgAH
	pm77Vky/ay3ygHzsW44KdzONOUhbXtvWFT+Pg/If6GNWow==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ebba0w6t4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 09:19:48 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-516d4b3f3a1so66594721cf.1
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 02:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779700787; x=1780305587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BavdLDn43DqP7dnx6Q1ZiNLC40D+9S2q6v2HPybJae4=;
        b=PbANSB55F/n0nbl72tJiPOX6nrdaKnbm9plHaHVPUnafkNghkAQ5emWqax9s+bNEGY
         YhxGAtlDcbrNb99570EWvTbac14h5mltNqhdXw0aau1Tvxx/kg1GpzVxC2MDqP1Msq6K
         P+H75JcBoyc8FzqwE8eVeKQ76ba8bMTHYeDeUHngWkga9GBkLFk/SPEdjo44hlIKeARC
         dvIGqNJD7MYFHgiBAGO7pzItmdHkfUu9UnOB0eHellIKpACK8F48RwxCEhKS8iKBylHp
         627b7cmiC5nz9VuJP2EKMHf4hMTyrbiUbCRJNg2uZ6H0ZDxaUKRd08u1LyjyL8WTWiUx
         TC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779700787; x=1780305587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BavdLDn43DqP7dnx6Q1ZiNLC40D+9S2q6v2HPybJae4=;
        b=MmG4dYG5Glpd0r0vf6TAB5bbu9ux5Xu5XRZHs9UmTKZbSuunpS395ZouvzQ2VJ5wX4
         GrbRgAeua0GCm4YOWePKjAcLET+kgbRr3vvO+e+P/WN0mgT8iibfN7aHQ7RFNIUK0M6N
         3q8eOUDpJczYI/mHc7yIsiL8EATw/tkhiNr9165I+bbnDlOTX+29r3i8g/6N8j7/YuX/
         LU7IQbGryP3yoIRbWR4PU+fcxWwTA5NZ6FCcFsMvXNGIPrQTAVxaMIAwvq2ilv7K/QTw
         iPuiu92fNHbC7VVQe5kBFLiWhkAgIkozKq1AjkSbG75xmJmpt/arFGOjS4o3iyzLA0P+
         Y2Xw==
X-Forwarded-Encrypted: i=1; AFNElJ9GPycB9br5fTd7ALBbTsiZ7oB9Id/sgBFJ8AqrVm0Yulz63QtWrLGtxHPEfwbfPhgDCcoBIXsQeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YznOTxXiz2W8a0wQaVo1IxUXE482KdhxgttAufP/Ktg8Akz4kR8
	C1RHMR9QLtCdgifL9RUslwSp/BRno5ZSwEcHn/lmgweEs+UatwT0UKkqCe8oSDKOORe11VjxA/Q
	CM6sqWH1OogAsMALFTOmxc3sH3IprkjAniPKo7tUlpAAlHFg7UA8AVGfWhWfqxQ==
X-Gm-Gg: Acq92OE3f+8jQbrPmTujQEFJ2xhi/dCC//AwfH6MdCEBAQzdtiUt3r44HUr05hoXWEF
	TnvVwcOb16BcnqM5zu2Z26tnrXjEhoP8aa2o32q3yzYdK9hCp2O6HxY5MM1laGlnGyVpcFM8PmY
	1T0eFxqk/KjG0bDgkW5CByeAu7vg1OC/JxAB4fxADl4WMacxjTltxF42Kj1XjiTHA9za/OvUJcB
	xyXSj9GULp/6NbQB4LhHb5VW2gdxcdmSrh2bV3pD19df0wuYwR2nGQilzCOHSdk+PO4W9mcaJwt
	WuISvpicIsJxTDh+P9Q5XJ8+zOgPmdxPLXoApMBfsXVAdc0UOIhGYVMqV0UTt1dZuyDhBcbcpQA
	1KJj/9x89NaFMvV5YyHl2Ctc+V9SW0A3JN4Ry1uz7rZueV2Arp/dhP7vJGvyhwPESXwhxm2STGa
	6hVmtHKNquH3m7h0joFOWG9vG00LpGshrfz6hwpo1a7J8k3w==
X-Received: by 2002:a05:622a:11:b0:516:e569:d3f5 with SMTP id d75a77b69052e-516e569d943mr100339991cf.15.1779700787110;
        Mon, 25 May 2026 02:19:47 -0700 (PDT)
X-Received: by 2002:a05:622a:11:b0:516:e569:d3f5 with SMTP id d75a77b69052e-516e569d943mr100339721cf.15.1779700786700;
        Mon, 25 May 2026 02:19:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dca5e9f0sm22275711fa.10.2026.05.25.02.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 02:19:45 -0700 (PDT)
Date: Mon, 25 May 2026 12:19:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
Subject: Re: [PATCH 05/16] arm64: dts: qcom: shikra: Add DDR BWMON support
Message-ID: <h7jhkbggli3l2ptf7gldjjp6g2h3stiwm3unvh7g6fli4ewpvl@idnpo53mnmti>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-5-f51a9838dbaa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525-shikra-dt-m1-v1-5-f51a9838dbaa@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: eWPbX06quYC1y4C96p7aRgmuV083bwBh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA5NCBTYWx0ZWRfXyS/Ch8kQ+kf+
 48Fry8A0JKIChLQ8RcqtWVsAsKJ9pu0h76TC6K3/+TXj2uTly6bw5SPaBB3yP6d588vGF7Q5tyC
 6PgOYJPqw7mkXPxGlRLWCQvnEx9gbOzv1Xd4d+N5buUVQJ7GHXSs35dDpMix/sWT99AmIrHOxSf
 WGrLUMF585rnXY1/x4/3B9leb97jwL+XAbY5HcgnI6d3KyG+9GuY71ahHF2WgJ1WiF3KrNiKpRn
 Eo9U7o1aKMeah4CXYA9VH4MK0JbRG5hxg5Lkdz+dagjCd7U55e/siDj8yRh2KhtsPb37alJ4nok
 f0I26+ya0N34/cJjoxL7ojVRG9bI4L1n0RbAGZrNReCMITnN271/kHg9PPUsswVfkNiPUsrbXFS
 ym2urktDQr0/lii7fRxFetj/wYobLvHzKBIROTzuF4Ene+pIZcezg5mqvYWztHd01vvQ3tvUAPe
 BJghpKLEIJfHyQ8uKxA==
X-Proofpoint-GUID: eWPbX06quYC1y4C96p7aRgmuV083bwBh
X-Authority-Analysis: v=2.4 cv=Xca5Co55 c=1 sm=1 tr=0 ts=6a141434 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=cJf_ainsN7bWJEJn368A:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250094

On Mon, May 25, 2026 at 01:19:09AM +0530, Komal Bajaj wrote:
> From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
> 
> Add CPU-to-DDR BWMON nodes and their corresponding opp tables for
> Shikra SoC. This is necessary to enable power management and optimize
> system performance from the perspective of dynamically changing DDR
> frequencies.
> 
> Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 40 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry
