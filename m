Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02DC40BCB0
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098484; cv=none; b=HXSHD+zEYIZYxytLUhiDx0deOPLPDB1tebvmQr2EBK7+tuTTOHjIKez1ru5Cznc5loaHpU+1oinluEF1gCX6oi4bYAy4m+g/SZsXoCzvYAPFbzi46t9KZqj/8B6OoX7rgCjM317iTDVRJuOu/5Ms8jMX4SNnhlNuwJy2egD+DUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098484; c=relaxed/simple;
	bh=ND4tQ/H1rfG2Q/XT6UBt+j4YQ1shI+hbBcVgUETCydg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJHZT4LFRSorBbQ6iq0fNZlk/iquyJBQbdo5CPvmotDSuyqldu0+2XKwkVxo1ZUCu4sTBVaolexebHAYYfzTjYuomL71mRjjGqDntjGKE0Ge3RMbtjiQO3yEoGwrmcklKqPFeY534EGYaSCk+Z41HRSBJeqAB/IEd+h9dKlG41Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y/a2JvRz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PzpRFtN7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y/a2JvRz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PzpRFtN7"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ACBxdC1511555
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 13:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6/RLqbZmVOrKAcmQjh+udgmQ
	IrAjIBneaAs5twIBd9E=; b=Y/a2JvRzGDJYJI7R4QbLOwjE+/mwNgH+JqIj1II3
	j/nxWVo19m5Ufr9vV9xFhMmkzJotXWksQBW1TRp/UvHMwi2TwgUY+Xi2gYk1EcR4
	C7nm8tjJ4jLrOrsCeMagwPEcScgCEhHCASkcWSjBYIB4syD+A7+qfCBIhjSYh/Kx
	gnRcUYBy3aOTIwODluFFA0uCGIK2zTk7v6D95PuBO/xEPbDu1yAz6GeGWiPg+8wE
	xf0e9wnjSL94dInb9IeeGtaNQOWWuhHZdGFGUsLSinNOW3RflfovkdCoxMyIuJuF
	C+7p5Y12FSnotl5CnArVNRpUcxy9uF73765RjtJDRi2ubw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epukeu740-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 13:34:37 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6c67361f5easo9522555137.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 06:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781098476; x=1781703276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6/RLqbZmVOrKAcmQjh+udgmQIrAjIBneaAs5twIBd9E=;
        b=PzpRFtN7yrR+gEWI4693qUsE9ZT8iFGJNO7RIOg4yXTSm4+NvQAYdigDb2SFYqW4vK
         si+qGO4tYs/cd7Ba/BqsD4sLfIXtLi+ztTEQkkGtFX7sYotFqtrCiJ5syvMJVu6QuVoG
         1hpV7L0KuzoBGm7A5H6C1fuzejbeviueuu2mloFJHU+hQ143yrahsBoPNPnxT2lcUqcl
         xrBpcutaoLW8FeRr4WQAUobKy6fPlCQK4PxsQBDHaWMa87KxtR8qC4XsnNG8lDxzRiia
         NywLW6UtHyULmZ90UxIxbOtXvWHN1MrxtkeTDHD9VcpTBT6Md7XaM37QfkJxQbFdm1SQ
         JQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781098476; x=1781703276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/RLqbZmVOrKAcmQjh+udgmQIrAjIBneaAs5twIBd9E=;
        b=kYt/o3EFAwLN/PbvruHCDhCSOwsigyTGro4972/ouKtAF08M7tzAJxJxrKrDu8guvE
         cvaN9wM9aFHNzf4gVEt+NKBxpARFkBTdlzKMzwBO03dHl+5oZ8vbJuxpoGhLU7gTJYZY
         t5ul646dwmn0L3NJ6v1XvMp8yNZVjbhQcbqjjgjo0GbMbg6KYW1X2Bwq+GE5Ouf46vnP
         wvdCkK7BCHx90B82s7Uv1keIfkE5XQHjGppZRlyq2RwQICQBramwTTSnvmTE5ma/6xWD
         nGH6GBBj9z94SbHyJ26AahhPmAo+r4xPl+7kYzrCMEOMf4gHv38J7RO5q1syWRTHYSrV
         1JBw==
X-Forwarded-Encrypted: i=1; AFNElJ96grbUsPe49z+IbOu8acGyGb7stGRlhOjfd2TBXgx1Oa04OPg2MMbtNUvggQhdj84gCDtAW0AHFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwADtmN3M7gbRDNqDaByXIEPTpXI1vAx6LWkmS4n9DRhC/e2V43
	qQDmvzc1i0/NdDkjv5W7udQofAqeOOT9fqv272Y3RQhioFUPxU7+aUN7hSzqdy8Mw4Nuk0Wn79m
	PSBj1M7S75oqY7LHKmdMhEwnGrqRd7P0OZixVGNvDIDyRrzzUSwqpOMt7j7FVsw==
X-Gm-Gg: Acq92OEuhKY/EuD58G7W1b2kAFpzMsJMbpjdE/S99sh4ih5/aDMdt6se/0aIns7rv5Y
	I4sewo9b2qgWL4eju75MkHnffczWdkp2gx/kB7htHcy+E+c3mCTh7Kpqabpo+NBmxOduwatDFqy
	T7w9k6CB323IJ/NVDARwBstHkGktsSrZN6Q2FKNwfnYnpp03ATUqcbbZaq0BIUcYWHmno+/94Rz
	H1++NiGs21e5K1OZfFEa3h0Bsvj4ZmXUbQ89UYgD2vBskeOZBSdxBZVPRiPA52DAgSdsanD86WD
	yEVBT3Mk3fTOfipUQA4of0kwuD2m4Q3lw8nYqs3pZ20odz7KyIQFMvUUoSyDv5K5sM3muBsC+QW
	gLfznz6aiDcXe1d7OMqtx/eaW8nSx7GhcAF/kbLTyzCAqr66SNTBoe+8HvL++XhO08laKmJ4EOe
	e+M3Gbsc6XvQeQ9ymykJC6i7NHaZwFTnLegoZvs4Bm1XixJw==
X-Received: by 2002:a05:6102:6204:10b0:6cb:b3db:c31c with SMTP id ada2fe7eead31-7001b3c61d6mr6100208137.0.1781098476574;
        Wed, 10 Jun 2026 06:34:36 -0700 (PDT)
X-Received: by 2002:a05:6102:6204:10b0:6cb:b3db:c31c with SMTP id ada2fe7eead31-7001b3c61d6mr6100179137.0.1781098476165;
        Wed, 10 Jun 2026 06:34:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed2adsm5386728e87.1.2026.06.10.06.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:34:34 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:34:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v7 1/2] arm64: dts: qcom: sm8250: sort out Iris power
 domains
Message-ID: <cacfl4livqlkuk2c223hgapl45ojd6hsqg5sqqd7g5g2q57kk6@codcnqhfz3e6>
References: <20260604-iris-venus-fix-sm8250-v7-0-7bd2f0e5bae8@oss.qualcomm.com>
 <20260604-iris-venus-fix-sm8250-v7-1-7bd2f0e5bae8@oss.qualcomm.com>
 <5eaea87f-5fed-4869-93e5-55c9da5ced84@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eaea87f-5fed-4869-93e5-55c9da5ced84@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEzMCBTYWx0ZWRfX8oLVqdSo1NLt
 SNEKOjadQGq9CUIkwf1C0vGjv6NsmnBiB9cNW7+AEqHSYXcqdfWmRJSahl5S8j2HjlHHfABHVYe
 rC6S6VXHcFISV1uwiKtE6qgnQs/+YS5mgn35R9Ltoy4nlyBvIk2E7oKEkHsYNghT0/rZEtydo3k
 pEF9O2dejLfwcDr3FbLzrJXZNgshqOvq8DBtWu1PxqgzoDMcUUcbCj9aE5iykls1ADoNEmaeDtT
 UcjFVSsSQh5AVJ6OsaFc89CZSWmcXmpCAiob4kFx28fDMy8iBFF8P4Xuq4CnV98H+7l5wMeqhf4
 hfxC/HnACUiYri6oWMaUGBe6riuQRn5Bm5ZunOaLRrBynOzKy6UB9hOXDDr3qyVtWmT1JVj+Y0g
 fsJmEgABxOYQ9+oB6CpgQb7RbdMD5KKJ9eJpixAIXUZcu9kxBzAzMOO2jntNigJ0VQcB9BgpvT+
 gcTzfBgbCnXPfG3EqVw==
X-Proofpoint-ORIG-GUID: ZHa_o5t4OWxXRTOZqinoP7pgea4xfXPu
X-Proofpoint-GUID: ZHa_o5t4OWxXRTOZqinoP7pgea4xfXPu
X-Authority-Analysis: v=2.4 cv=DNG/JSNb c=1 sm=1 tr=0 ts=6a2967ed cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=t_nprInajcUdtdUToWcA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100130

On Wed, Jun 10, 2026 at 02:24:24PM +0200, Konrad Dybcio wrote:
> On 6/4/26 6:22 PM, Dmitry Baryshkov wrote:
> > On SM8250 Iris core requires two power rails to function, MX (for PLLs)
> > and MMCX (for everything else). The commit fa245b3f06cd ("arm64: dts:
> > qcom: sm8250: Add venus DT node") added only MX power rail, but omitted
> > MMCX voltage levels.
> > 
> > Add MMCX domain to the Iris device node.
> > 
> > Fixes: fa245b3f06cd ("arm64: dts: qcom: sm8250: Add venus DT node")
> > Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> 
> [...]
> 
> >  				opp-720000000 {
> >  					opp-hz = /bits/ 64 <720000000>;
> > -					required-opps = <&rpmhpd_opp_low_svs>;
> > +					required-opps = <&rpmhpd_opp_svs>,
> > +							<&rpmhpd_opp_low_svs>;
> 
> So the computer tells me low_svs would be enough for PLL0 to generate 720MHz
> 
> Is there some transient dependency that bumps this to svs?
> 
> Your changelog mentions you altered this in v6, but I don't see any related
> discussion

There are two sources of information. The "clocks plan" and the "pll
info". For some reason, the clock plan doesn't reflect actual PLL
requirements. See the info on the corresponding PLL type.

-- 
With best wishes
Dmitry
