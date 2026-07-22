Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EFB23183C
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726275; cv=none; b=PYboNA7WAD3z/RRxGRN7RhpEVlGwJt5qjYOSA/uKBSC33qX+valU1rL8XDY/StUKmZfOGmCQYrPEF9xBMdTDjhHqhjmmNUcofqFDzIBWkjjInHakEcq3XrMo9R8FRl8KrqyyBUcBIPDV9SVBB6yMHfA/pnUdjIZMEzt8nP8PrkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726275; c=relaxed/simple;
	bh=sh9ZU5Ncc8RUC8V42Rp9x8UPi3xY/aC/ruJVJxi2z8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUMmgV1SN5bxv5/ljG2D9wY09UtX1QlKGl4m2Cr5Nf7dgDqbMA8lS0SawnRMc3dIHIcgAZmsEbmH2dPPpUBUOviKI0Wb2BAYJOAdShiel/inH/qLumWE/yTXxjgYmbdxu3Se8HCmcOxelZ8qMVfbxtkmKI9iwcjPp2zFNzSkK3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kqU5K5hl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EOxhOYyz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kqU5K5hl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EOxhOYyz"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MD1d0A574071
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 13:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=f/z7Vf0CFs4vDGQLLJUD618C
	7Uy9T9x3H6mGeOakJz4=; b=kqU5K5hl5hqAHl193dF9LYbBD1n6i+hH+eRENipq
	F/kc+RwlgKLOjraw99yyeEPx/Nq5GbVaQfgg8WeWn/Ug+vXer9jq11xaazD8fMh9
	KrbQGTT9vu8Vpfmjx9VnoC+6ESAjtY4YpZJIuUYUrvIYXk0Z1+zFuGhkOd0NIaTT
	WxWXV+VmVxDCfvsbEjAshb4wjZyK6K5wIGIDRH00cRJDVQHrOnCtD2qHkXcx+xZf
	UyAj/k//BodvU8oJUteC+8qGT2cQlXBv1zpZMmMnnsyL38ic7qZZ/RQe+bY+ra7W
	1iVTlDKlrnF4vZKO+LJA6E/WgpzS4ULLZ73Ya4csiZdYWw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fju228ys1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 13:17:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51a8b0a08d2so184070511cf.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 06:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784726273; x=1785331073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f/z7Vf0CFs4vDGQLLJUD618C7Uy9T9x3H6mGeOakJz4=;
        b=EOxhOYyz1uVQFkmKD9clAzuBAN47qnTHcZIl88swaDIh+AMUu9ov8ijk1J402apIBN
         t7X5Vpk5CpQKdO7NrxOAa2f5H+bek4MYMOlsd2ouaKTgNtE/+dQQqWBl4WrT609E220e
         cY8pzWizJ/UtUjBzBlpmvFl41nt9OJp1XOGkRg5SIFcyVrCxB7AQeO4FFc+ZvZEUve9g
         +Mw+bZTZPUwa8gb8O57W//VAypph4ylbSNPtJrmfBQyeq/0/TzszKHl2Y+H+1bQzKono
         hS0EldRhtr7EK7sl2RvtFMflqQKC6ZSvao67ROvNPFyWw8wRnNP4OVC0WH6HFazSCdMm
         nL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784726273; x=1785331073;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f/z7Vf0CFs4vDGQLLJUD618C7Uy9T9x3H6mGeOakJz4=;
        b=Zoak/4c3FmJmEKQFLuZm4DimHhzIBJ+VM0MC63y1wFsmO7ouAMScW3l3B1Gl/ZgVKn
         yI6KhkQro3Sq7KtaT63QQKxaRmo1Jg6OEuB0hjjik5cqSI5xfygruqS+fgJic9llHOLu
         MRuyjIzYHm4c3XLA9vvQJhoqwnxpFbgY69bYXq1E+rM3fdXQoYraAen2//qxK780Uqm0
         TdXYKCyhJieE7DWe/Ho+cXzYspzEtpEX3nVp/Fc87R5eBE4mljgCl/4WNtgbf4V6rzNO
         lYRCSYwRlyAMFOdO51x3jsE308PCivC7EmMWgGWBGBJj5Wcq9kcxLv6miUx0fCATTAIY
         E6iA==
X-Forwarded-Encrypted: i=1; AHgh+RrbcuYAZHp9dzJ7az7myDpdcDAbDI3YTkMkKfOIi8JE5HZ9leOVCL7MjI7oDSIbVDZvf460kk9+Vg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/H5TAhcnOCLeBs/ODp4OIw+AQDL02ygmv13VUv8fS7RFgfIUT
	6uccVKD5u8L3los5P0qiezbm15gBJen3PXWGGzWsOKz0xJFgzuaXq/dkN4JtbVPk3fiX9kAfYBj
	WwdHzllJqva6ZiYMlg2cgTQ5KeIzz3PSUB6veKAcw+SqgSs4yLRSt25pFH57dfA==
X-Gm-Gg: AR+sD10lPVh7Bm1PxjnUQMT5vocKPhoBZNfaiOsgAoL0aEloGgWGamrTxEFFve01sqP
	v3zkBts+1ujNnK7b7gJJyvNWTs4QamQmy8fuxAB1jxRcbGF5HTd+P5jGBOdnN7JbIX6gbxGO+rD
	xo/ZdqVo+NQcnznByzihZQ9aWj5E49+sLbJyP3y0z4BA6Sx8Ve5jxrWYtcKkhTqLwubjeQ61ytG
	ZcCY/Q2fpDcYQIaEXG+i0OEbpcoDR+AlvXF0pz7DDLQYLFwSAcaQ6ad329kvHMk5q8JtFr7YyYy
	dOgF7PIPsZEdBFGNFx7qIHVa59J0mWAqTz1M4/ZeExFcJN6LcE834shWN8W7VT1jWfFdnAhGmMV
	vTMUmo8GmrQT5ML0x/r8/HYxxi7+Osnjtpzll8Q0PeNJg77Z+G4goKJ/PyNYExUzPLNOk4k1sRF
	znIrQ9AEJ6MeAoqg==
X-Received: by 2002:a05:622a:351:b0:517:6b31:8058 with SMTP id d75a77b69052e-5213e0821f6mr207212581cf.40.1784726272512;
        Wed, 22 Jul 2026 06:17:52 -0700 (PDT)
X-Received: by 2002:a05:622a:351:b0:517:6b31:8058 with SMTP id d75a77b69052e-5213e0821f6mr207212221cf.40.1784726272083;
        Wed, 22 Jul 2026 06:17:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9e4313fsm463602e87.60.2026.07.22.06.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:17:50 -0700 (PDT)
Date: Wed, 22 Jul 2026 16:17:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v5 05/11] power: sequencing: qcom-wcn: Report power
 controllability
Message-ID: <6lxktlm5suakzub7gvlhianc65yeiqjbbodimsikvcicciag3q@ugcdr2gbg4ok>
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
 <20260720-monza-wireless-v5-5-69ec6743543c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-monza-wireless-v5-5-69ec6743543c@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=X4Bi7mTe c=1 sm=1 tr=0 ts=6a60c301 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=dA91eB7zeV-DSUTtgBcA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: rYrqnj6mPDGHhyG8r2KfbW-uwFltQfKE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEzMCBTYWx0ZWRfX/676z82gk+Zj
 TrAl0hYXVxcNWFK5Cp2YQmmr3sHBDKiBlFte7PVap2dxh6tsuq0PEX3QOF7x6AsmuU2m1l0eBtH
 rsdEeHbl4VA8GrQsgIdWmeaRGs26Q5k=
X-Proofpoint-ORIG-GUID: rYrqnj6mPDGHhyG8r2KfbW-uwFltQfKE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEzMCBTYWx0ZWRfX363FtzSQa10u
 VANiU/uZTPZg5z+uMa9fMV8c3G6R/IPilyPjylL/DwGqypADNEX6C68tayCnwwPQLdKoWEUheOj
 aldeP1/PiJQdsmVuJYsjDjkX0Mu2RV7mAIedRMS7D504S3QFLU6/2EsEGEmfNudvA42Htnvi8uj
 nkjKO2RgWFLEiFYYUzXAJlzp46bhjlWqNLnKRQvcvWoatkJyNC1Ey1UkL5eWKrY9C3qUWYdzEqP
 VxjsqUIAMxMp5WjemoHDQPl1fo2Zh4LgWdDj17WeyDNpWEjT066WAOc61IOFLngxtcqdn5qegEq
 v6GW0nu2fMetcbc6RGLhr9wCzt8slpLWCnufNh1gD+IQjxHwh7ZriJNYQCjrulT4LFA1oUGVwWe
 ksIrzHVONinFiZHttEHLwEyY1vjjwFqrnBpDzmIPEWBuxxNPdSZ3wmNzdpCMAyFgDZ1/z2Z1b5f
 O3RKwKcA8lJalBko8bA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220130

On Mon, Jul 20, 2026 at 10:04:07AM +0200, Loic Poulain wrote:
> The "bluetooth" and "wlan" targets drive the BT_EN and WLAN_EN GPIOs to
> gate the respective functions. These GPIOs are optional, on some boards
> they are hardwired to an always-on pull-up and not routed to a host GPIO.
> In that case the corresponding enable/disable callbacks are no-ops, so the
> consumer cannot gate or reset that function on its own.
> 
> Implement the .is_controllable() callback on the "bluetooth" and "wlan"
> targets so that consumers can query this via the pwrseq API.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/power/sequencing/pwrseq-qcom-wcn.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
