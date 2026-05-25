Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE38A3382F1
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779700758; cv=none; b=trAx0ogvPMLlEJzMJ21rLsN+MU42WV44J9GKlu4WbYn1Nbng/kgvUc/7Ea21QDkF5+ZY5ocngWeMgU70pIftETw71VP7sldaxKbMwO23WboCJard9LPvfZiAux0b0Ys0EvyUmBoahcEWMwV/oJZYpBdrdhF6PqPxgC9vNHLXHdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779700758; c=relaxed/simple;
	bh=wUdMiM4gznb6+rt3vTR+q6cMpxLdznGhivqWLAYNrG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlPfHW9DXMxWpMD/XoHH5Ab78TFXUrg5OSvSET+2t1qCtUW+i8FarnJcLwIirkvp07txxKN0OMAuy2CxNRqOOHIHRRESp9TF/Y/4trz9xosrRlkm5AFZW7HtdlRKsMmjalGHTsiGC7SsuLLn9xlQyy8QrHUFVhbrcAIx97MjEus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DZ2ogOOh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yougnboi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DZ2ogOOh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yougnboi"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P2uieA3580685
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 09:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bmgCDfsrFew+pg6RojZwQYb+
	pd6o+Ri4V4tsZlDZDeo=; b=DZ2ogOOhcNvpHlFCfgpKqgyFLqn9yO7FArZS5Paa
	DPpSUGk+80vPBbIJyaEp9thVPUMwsbRgEmPmIu3TzjGsg4DQshxGnV2h+WNybQKJ
	W70mbM51yCHCiCDmgbpFVlGjk1AmL6TzdZPC0YaceT4qGAWy7maCjH6OtveKq/zd
	d3zyvlOd4cpUiTUoACK6LKIegS4tT9gKII6/RdDLORqDcPEaR10qG3BUn4ZbO8G+
	6ApEAtsa57iSR/dE8bWNw/ylUaOA666WeBlz3H1YdUNkoy7/f4BP8qbCBu0jOAlT
	+Bqhqq/nNYdri/g065Mua9piP+NHkFItLcTNnNMY3MRlWw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb3txp00n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 09:19:15 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-575b418c83cso3616343e0c.0
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 02:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779700755; x=1780305555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bmgCDfsrFew+pg6RojZwQYb+pd6o+Ri4V4tsZlDZDeo=;
        b=YougnboiE8xlKuiDoElCBh3mR1ilC2hCb80HcEuW2UR0navXc+DCOjL95Jdwgirdsk
         CAF+h9y4O/85XwisdIVKIdE6XitEMt4CjecvTnsfori6y8Irn1Q36F/UE3W6sgLdVbzs
         q/Dsp4rUnDdOeWVARCJBXjTgMnyUXz+5Bk/y1HjPs4F0OKdI3wFxVq1Lwoy+zqjN4Q9K
         9gBVHngBSHxyXwfIuxgKJ+YBTc1VoChvGweexR6Fi/lZ3L+fbwEmHfsS1qSy+QFASGxI
         WoXSIBG05cJv0bc9cpwhsqVBJI0rf+oTuvMGOk8pbefT32/P5LnVJ5Yif/XK4zjrvu1W
         Uxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779700755; x=1780305555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmgCDfsrFew+pg6RojZwQYb+pd6o+Ri4V4tsZlDZDeo=;
        b=Nq3OmVhfLkkHl0llILA/zlB5tkdt8btFUvER++FV0OD3Zc4P8IZKLnpukusrsznbxR
         8Qy0R9fnQKun/mAenMi9dvf9za6avUPJcuVmNG73rMIbNxRU4W1ZWJxdrr0fGyhfp1pW
         ijVLNz35AKdcL9mZADkY6yXgWGgHwMaaeOA6EttnBlhwdAzwn4hTGASBStyU4uvGCclB
         4oCqc/i++oanGoSZs6bBdiHRVgs0aRMoQOMqVNZVwoUh26mhLl4DHFC/KtSLDren8DfR
         AYR+S7mdYBoR0agVUFNjyzKOyLvRfHCT3CzJPvqGHJQxD8ngYMW9oezjCr8w3RbJ6/AJ
         3OGw==
X-Forwarded-Encrypted: i=1; AFNElJ89rjer6+Cb26Wkb+GTBaOJZ2KjZXhm3h1/peQfZtjW2riTr5apTpMwXDKqtuMrlVb3RAyYHWE34Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyY4RPN4vR1JvXwiBQ3gjiC5Y5F1EZt/rfs2Oyz7EKp1onlHnh2
	2eI4bNUmZ7d4iwUVGw+LyEzgmq6fgTEGcalTtrZIS3DfpsTijhPFDKLKS6KeVzWplZUm/OG32Fv
	M442ZtATFDj5t04KW9YuAUbUr77v/82QY9XzL97HtvGH7bhKUcSs81wKc2P/JUQ==
X-Gm-Gg: Acq92OEN9egt1AAAqxu38UbbtAHiqkwgyGiyO7p9ah6tWGf0PK9hAaT66I0wr/KUsbc
	idPnVjAXgJB/oDEE+Bfi7mBna/xpCxWQALFnuaW+W8yvs/UidM6l8QI3/ISBc9AmDPSIc7ct2Xs
	HDuPfPg6mMR4nqnLqLyu8m/kn5fKxZPDJu6BOhlj/Ivybta9LL6sbrGsf4JPedqpOSvTNJNfi6q
	qjrDyLAkUAPPflJjvdTWm1Tr47a8LXQwU26bHL1zW9/SLLZTIrd4J7FaPvSisQbDA6L6AUHLB4g
	jmmv5vHT6CZchKr+im/mgHYN6gddZ4slo8Apxsm13st+UoRC7NED7UTGR5QuxpVCuW16aI/InHQ
	gJav1lGb2S6wa9fTL5VYpAjAfR06OzOpoxvlqqzFlbDsdrZw+ZfEUl6spZ4qsXyWanxGb8mbJU0
	VDBazOedQKHNrXLSELoPmjzvq7yngljsZ8QZQ=
X-Received: by 2002:a05:6102:418f:b0:660:d26b:5077 with SMTP id ada2fe7eead31-67c738b7be1mr6149850137.6.1779700755010;
        Mon, 25 May 2026 02:19:15 -0700 (PDT)
X-Received: by 2002:a05:6102:418f:b0:660:d26b:5077 with SMTP id ada2fe7eead31-67c738b7be1mr6149831137.6.1779700754643;
        Mon, 25 May 2026 02:19:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32cb369fsm2511211e87.15.2026.05.25.02.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 02:19:13 -0700 (PDT)
Date: Mon, 25 May 2026 12:19:11 +0300
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
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Subject: Re: [PATCH 04/16] arm64: dts: qcom: shikra: Add cpufreq scaling node
Message-ID: <aibebzgnfdvfnb7hapjoym2ruawpsx7qbtedhyvn6b7gd6dqnk@3l4scbc74wsq>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-4-f51a9838dbaa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525-shikra-dt-m1-v1-4-f51a9838dbaa@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA5NCBTYWx0ZWRfX4OtNaat7NMXj
 1plNpNrHm9VYrSiA3J2UzyUbMecI0RVhuVWbvJsqgCrNLGhd2FpXdh4EDLgR5hBC3cnUexlezd5
 3927ZSrWcDfeDQ/n/uXVTV5JYnqyOOtjptx+TRzIvAmE9Z2f8g5b+DXEMAtDfCOhwqxO5AidYmy
 FUQPBAdt8+6ShF7wygctreUYpJAQni6qQVvuzu3is7alVRfrwBGJFxppXMW/V1BCs+E/Yl/Ynv1
 1pMcCVLFDc7PZdYswEk7HUe406u0h1oTviLVeuE3e7QPRfiyKfIZ1ZYtNghGim6ZfZPHOkdtlNI
 u95IhQL+vd8EMSRVsjysF+BtApFNXthj3agJSuasJ77NtWEyEPiI+nlm1z7OuhyCiyDACmuR3Wc
 SrWyqqjQAXA5d3R1AMfQlmPh2reCgrABOZZZXyc0JUc7eDQbAPtPNFB3EbFk2Cd3Ixo2bGWdHuE
 c8PK9uq2ugSMvv0eyYA==
X-Proofpoint-GUID: ekJP6V-0lqyWyHx7U78hsAFlQpPte7-N
X-Proofpoint-ORIG-GUID: ekJP6V-0lqyWyHx7U78hsAFlQpPte7-N
X-Authority-Analysis: v=2.4 cv=MetcfZ/f c=1 sm=1 tr=0 ts=6a141413 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=gR7PYC-x2pxtVi67x8UA:9 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250094

On Mon, May 25, 2026 at 01:19:08AM +0530, Komal Bajaj wrote:
> From: Imran Shaik <imran.shaik@oss.qualcomm.com>
> 
> Add cpufreq-hw node to support cpufreq scaling on Qualcomm Shikra SoCs.
> 
> Co-developed-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
