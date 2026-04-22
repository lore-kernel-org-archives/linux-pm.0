Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D356B311958
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871516; cv=none; b=rU8W4vOrnkCoglPuPkWcaAWgOtcqoY7jdzQ4eOTVGwF0QrbWvRHi6tGRKOF3efRf47OX3HqBMMJ9DjuT9NjKcTRxliyRHDUMi2PsrouBRS4mjZ+wSzRpkrNe+hxfQfpSR18VLTlVhO/5/hL4n7yINpiJMOi7xaJB7NThiBhiCZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871516; c=relaxed/simple;
	bh=W/o4CK/M62/W4UaDTIsuYYRjmgttl5pkwqHmlVa8Yao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZrFA8fiUpOsHxrU6qVV1ByMmHGdEeNilupUZqOgdgx9vBwhwiHbodS1n6EvTX0ikU0m/kYSkcgrgbMjYPIaRz6IIs+2ULNe2H04fgtTcrM090FPKDxEzPsfS2KimR2LkENTSLSkhREsDfYKcOD2tAG8WW/mvBhtrtw0GftuyjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hPc4kSjK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NxfZXHY0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hPc4kSjK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NxfZXHY0"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M96EjQ664097
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 15:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XBjmt240DJA0WcHkbd/6a3tL
	PkKq8fZWKUi6P5JuDHg=; b=hPc4kSjKwiw6RNRSChLJe7eo/HHjzvGEqUHdedtH
	nl4KzpMt7sAxWIbK/rQ0fJRn8ydG3l+G+iVgvSMOuOXIQcsz8om4ZjSLva+7heRt
	aA5OsKjTPn1pp5ICPtPqS2KhkWDyHI7lhZC9KxfhVqO5RIie8oQr4jogB3J3NAfK
	QZiUEdI9JGeeTmk90huBd4eCK2TwtEh5medWpjOM/stcEC6dVNtDmusDtMk2hx3b
	YtPC1CrCq8iHecgbwnUkgUQfoKTMKwoxrZ01DaURBiyMiLpggLmpMfBQfRQWhd51
	ChzuBCPhnk0WvZCjcECD0pFddiE0AZdbTW/bIIoazRFDLw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpudgsc71-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 15:25:14 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-61010bc9c12so2510610137.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 08:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776871513; x=1777476313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XBjmt240DJA0WcHkbd/6a3tLPkKq8fZWKUi6P5JuDHg=;
        b=NxfZXHY0ZAy3O+ZzbBbv2uviqlSTIVpYu1YQGSWX2VrQo+uhPNpZlO5tSm/oe1tOHn
         SVjkh/pEYL4kwnRypH5dEpQvqmEQXXibInyqXtFQwnwjFvwHpfcyomMS8yOTwDLDwgLr
         xskaktsDcsgdLus5GYq4uFjG4y0XJ5KIHMGBata/XahjtSm+HJo+retFCHJolQY1IBl3
         wAMgnrCajhJqi/8k8Xl/Jd5jH9yM6RAQNR41+V+AZoQYzZdWdURiJMxO62URbsZV0uTb
         pNY4cCuww9AhH3fU02zHv/cczyna+MVZOvzDovu2Aby2EFaisjNiEu5gUNsFTTJ3NTxc
         JeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776871513; x=1777476313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBjmt240DJA0WcHkbd/6a3tLPkKq8fZWKUi6P5JuDHg=;
        b=T3lyeMmLCF+Im/z3iFUOt4fHOQW40tlFDHm4PCt5fYjV0ra+cZk/vJRox71nYd3hnU
         M3PAnnCX05qd2Pex3+kaN/0OtFiXeC4PmL8SeNEvgl/p4zMo3LT2z2AW7RUS/fNerw29
         imflQVsfchv+kQDKJ05Tp89qtRJmtumeEI5H18R48MX56xdhvf20pynhvTM1s38o7gOI
         JtGBDyNFE2mjof6vb97cm7GNRRMi2QMCGvqPCE8pf5YyXn/k5CkBF1AqUlCCiPkjdIBn
         kKiMR+0kvMvh/3mKjjxle++zaqkH3WiKXhRxvTiyaTTLXMJqao150V07HWyGve1Et85q
         BG6w==
X-Forwarded-Encrypted: i=1; AFNElJ8CZIKCKB23fMFiN8tBCohNRwIBzr2wI3QBdD9gEIIGXc+z16C8D7Suwbd6FCjuqfANEV5eMqgOFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlIwj1QlacLG3sx7WV21Wsf2qFiNb1bWZOvWwwIoanUjy6Xjkc
	+d6CQlBDlFBM/qdzW7i5iHPwb0Rng0+UTgXFV9ci0yhnJTLucHnsoe1199kG5RoXbq0tDUCjkpl
	XUcbs229Ssp7IUuWf7UvFdmIkh1dzEYJPUGbyEflwFgM0afTeMrl7/m40HbA+8A==
X-Gm-Gg: AeBDieuufVf8LizzctkGn/3hLw2TucSm8tQ0AoKdLxm70Caj+lWB+B7I5IyUaAOGYFB
	cNtkyurZNqoO9t8Eut8TT/tVdvrBTyqUJxh4tZuonM+eF8DgCcd9rPuPYRC6WwZlh7t73fugdtd
	N7ZNH8Z/MUT6yiOkU8FE4WWG/8QEOt73a8Bl7ULADforjvODhSF/ikFrjMmXcwnWnkaIdAj2DF7
	tasbYbMPAtiv3GGXp5j7/eFFN0jqu1T32gi8AUqCEXTVm6zZSZx0DdwGiKzsFccSozE3wviBScx
	zggPRrFAx4c7vEWZvtERJq/DqpDnXSaByAyQ1jFmcoGGPSoQJc4IqATeEZ5fssFnoYlQhqEE6k6
	3QWzka+k8DCdMYddmuBc0ME9G9I1RzFnTjqiFiHCufIg6mR5scgNJNNFGl6hD97N+GjCoU66Qnn
	euagXufvucFuoeJmQ/qo8GJdxtyIwMujT77QepgGoeDKq//Q==
X-Received: by 2002:a05:6102:5122:b0:608:759a:53bc with SMTP id ada2fe7eead31-616f1c595b4mr9994385137.0.1776871513033;
        Wed, 22 Apr 2026 08:25:13 -0700 (PDT)
X-Received: by 2002:a05:6102:5122:b0:608:759a:53bc with SMTP id ada2fe7eead31-616f1c595b4mr9994349137.0.1776871512472;
        Wed, 22 Apr 2026 08:25:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187ebea2sm4416197e87.76.2026.04.22.08.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 08:25:11 -0700 (PDT)
Date: Wed, 22 Apr 2026 18:25:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] interconnect: qcom: Add interconnect provider driver
 for Nord SoC
Message-ID: <l2o2g2gci5o5wzfhxln323eym3vb6xfaboff6plfg42re6hc2x@oygjgy6tpxey>
References: <20260420021351.1239355-1-shengchao.guo@oss.qualcomm.com>
 <20260420021351.1239355-3-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420021351.1239355-3-shengchao.guo@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 1JwfpodKaHGRpxqe66ffRSpOtZMxtsBE
X-Authority-Analysis: v=2.4 cv=c5ibhx9l c=1 sm=1 tr=0 ts=69e8e85a cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=wvzT7jLtkUm77yG2w9UA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: 1JwfpodKaHGRpxqe66ffRSpOtZMxtsBE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE0OSBTYWx0ZWRfX3UhCouh/mzyB
 lwEVhFQZyIV9ddQjO7oSj06hgnKKxp88XZMchUwHJpRqvP4D8qjb2kbw8t+ayrAKQeMEgPRJEZ9
 l6F10s828OQaR11b6WaNS1/yALNPklk8O7luntvH7oEWnRtdYPloPY8OgiKUNO9tQApFIqERg1o
 1daPXCtwB1fD0eXtMCsMk+IptLE/ZqhwCgbqwxkttnOYn8Gu3eLm9pbKeLrwTU4jrOKWKUbX0t/
 Ah6mZhwHRA9UBWinGR9HxuiPIG+EHxP2mJ+Qx5x9KckUgGFZo5pnQZ92wgFIwOdqRvZW4jkIFQy
 orWzaYoaekJBqShHd0gsc5hAPgJaDkBcK46eAQJLoUYzrBZOlr/zi2DhMA07fD1du7akicv7BSO
 dtv0ZAifi1PKN28DDZx8BBY5vnPAy3blvmWBoX4Si+53sDdCcdtwZwXIi08+BD8V55EJH3FGXrD
 0lRzRKwiftonVEWQ8DA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220149

On Mon, Apr 20, 2026 at 10:13:51AM +0800, Shawn Guo wrote:
> From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> 
> Add driver for the Qualcomm interconnect buses found on Nord SoC.
> The topology consists of several NoCs that are controlled by
> a remote processor that collects the aggregated bandwidth for each
> master-slave pair.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/Kconfig  |   11 +
>  drivers/interconnect/qcom/Makefile |    2 +
>  drivers/interconnect/qcom/nord.c   | 2682 ++++++++++++++++++++++++++++
>  3 files changed, 2695 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/nord.c
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
