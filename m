Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2B63E3C5E
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250949; cv=none; b=jKpFycOxoxn1DH13Mey+ix0pXLKJxNssswKG3vtfvFeDDhLukbNnfZGAPKHwL8WoZc6wvLSgGv0bT9RdZIMb/4sEczIaTSipZoiaQmRMlUu9Aux3WKEsEwOU5VDOo2cIb2usFyP+v9U5lW+i85RTpc9KBoEQXXqN4EShMy0D0f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250949; c=relaxed/simple;
	bh=xj6Cf2BFkU51demOt7x8+AYXxPPZBpyfYO041yfzpz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPNeO0xYptQ4ieA5GBRXgIW5vtoeaaH9ikqXC6nMPfA0hhUITNrZ13+PFElZQoq4A5ZwjnIYsLhlpjCGp8DoOs0HGSPKmg6czbbky2gL1XY2QRvbrDQsE4lFBN8XrGefoMPGJxD9CUzMumggWV7JT6y+BvwfKR3nXrfcQ6LC8d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pdxCmlAk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M2KweZx5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pdxCmlAk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M2KweZx5"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C3BbPT2548181
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 07:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NuE4PU1Q4pHoGlJdh3wxKiMh
	dG8JaFJTJYhR0esJV/c=; b=pdxCmlAkM2SjE+v2ERBB40Gjf5EBbMy/cVjKrLvx
	zcIuKZpReK6ie12vexN0nKyOaVbne3vn+WmQrOEHnshUriy1RtNaarCmFGgMXf9d
	scYKdW+VuBY2+DE2UD20FZwRzfMdi+ZIkcTtBwTKddAIZaU8fhSZMeRjBE6wsTqU
	IJtQg07+B7FywFmRfuEK/hgw+WKBuYQ1YDExs3XSr8Ac76G5V2SMPc25GF4l5CRn
	H1HpByWWlD7qPgUx3+2SfscbwJTW0VV7v85B5Runs1mb0pqiDtjUmdSATkEVG7lh
	mN0ntIyYX3xjEqMe5dI4Y7YbBOl3hIPKJclCWWSwzyu+/g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er29ut8rm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 07:55:43 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-517c65c019bso18299731cf.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 00:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781250943; x=1781855743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NuE4PU1Q4pHoGlJdh3wxKiMhdG8JaFJTJYhR0esJV/c=;
        b=M2KweZx5+3VqCz/gVJwFS6EiLFAcQKG+bFJiMv6LW4M3pC6D24UUkcuzM9YwnsipF2
         DKaHrwhZ9XPbM+kRfOVrsT2tjcjEqkS7PBxF+TrZ0yT34U0SZvjEDs7Qo8RukfWhl7fP
         S3fv/JQV5nBnwLYR/QMdQgWx0Dm+7Lmn6KwerOp8RJQpsvtfjg9jFVI87CEYwxjekWZA
         1VnsGHpCY3uS+SOgQBNjReLflm0apBzGSxDB4BF4/wT3XVwhI4+66RH7wV48+dd5Ig0Z
         uFGd28pDZk1srWPjkpJgc5jCW83B4QrnOCPeOp7xCNO4dYgnaPlXxlVSVdc4vTkazxQe
         kyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781250943; x=1781855743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuE4PU1Q4pHoGlJdh3wxKiMhdG8JaFJTJYhR0esJV/c=;
        b=Aeu1c0+9HyCTgeoKiIS5LOqMcpZGQWzK1KrSwwiyw2Jt9PzkPYl0o+926s3JhuTt5v
         k2cuBB0kujkenYVDtskPXaOEmdt4DgdY5W8whv7DuwtoyLjqj7LP5rXd7KI7FgUQlu2J
         H2VHHgMX1//smEaGWRUI7usmjepGGadkKkF8emCDhHtRnA8x10dosxuhml0GLB6NdXSw
         AbVnQRaf9v839yvSF/QUOw8mOm8tt4WXj/zYYRYi0DUJszCw6E5S1rf7rJ00So2YGuK1
         SzZ3Xbw5w2w1asmXV3r4FQS/DASs+WJdlVw6mVktkgWguhdDSWMFXeXqyaSvWegfSX6G
         lYmQ==
X-Forwarded-Encrypted: i=1; AFNElJ88K7ZcAmFv1sOC89QMHb8aHJ3z01p5ccKLwC0lJLVMovSmVuej9AXaRah5X5L9Xf2uCOiVi7HBew==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQUWTEk/e8hvVS+PS3RAsVkNmSB3ZRlQDygMi7HdzzkDjOUx2t
	yyCyz1DCCthZYpWUNGcKYIfCvkmzwa46G35joncf2CNa3dVvuRa/YuwiOdo1xnvpb2t5wXVdmZV
	kjzhsZIaX+VS38F3pter+SqgL5ysOeNTPZr5UQ/lxvuWZPWVG8l5q/FZwPRog4g==
X-Gm-Gg: Acq92OEBe3al49WQCqRy8TG5a40voVBHXKCLR275wpHGTUz7oSnl/T35KU7JNnubGHi
	6WOwWUiJsAasQKX3izRawTPlljkIkETpPkOxN5bqCA2YMvpWnrVzcY8zhgfvzkc9cjlKJGIOB+3
	LV1J122Su8As0tB4/Y8xrJYbDr4KOmMArtSyF0x1qNHkfA/CDmLeeHHgJvnsz20hKTnrdRiohIK
	dG4wRDYtei7objDiEsZHc0hDWjfNkXMLHqJVcv8x5KpdasytZL8foSOp11JskTD2Z3cq5HDIzrI
	2yNm5ACUi53mhbHWtZmXXEIGiCGg5/VL9TVwHGk4Ypf35GC4E6aOjyVym7NgPBuVP/WBtvVPtvY
	MKXWqT3Hj89rEOICNTCmkNfSZRzvI9paql1crgkYy4Ed/OevynXPCqFLJXNzDEyw4e1nLeYGI8F
	6mXjFgZ/o6UF0+WnH7EmGp5acZMUGDh9jknbU=
X-Received: by 2002:ac8:5c92:0:b0:517:a9ef:ce23 with SMTP id d75a77b69052e-517fdf19634mr21653571cf.16.1781250943020;
        Fri, 12 Jun 2026 00:55:43 -0700 (PDT)
X-Received: by 2002:ac8:5c92:0:b0:517:a9ef:ce23 with SMTP id d75a77b69052e-517fdf19634mr21653341cf.16.1781250942593;
        Fri, 12 Jun 2026 00:55:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e16217fsm326756e87.15.2026.06.12.00.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:55:40 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:55:38 +0300
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
Message-ID: <ijevonu6ib5daesvvzis53qh5ztufrdlqdsfmx33kiajplqwhm@muhxbznlx5k4>
References: <20260604-iris-venus-fix-sm8250-v7-0-7bd2f0e5bae8@oss.qualcomm.com>
 <20260604-iris-venus-fix-sm8250-v7-1-7bd2f0e5bae8@oss.qualcomm.com>
 <5eaea87f-5fed-4869-93e5-55c9da5ced84@oss.qualcomm.com>
 <cacfl4livqlkuk2c223hgapl45ojd6hsqg5sqqd7g5g2q57kk6@codcnqhfz3e6>
 <73a30753-527b-4662-ba99-2ebc3878861b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73a30753-527b-4662-ba99-2ebc3878861b@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA3MCBTYWx0ZWRfX2PTeDuJbj60H
 M28E5+P89phniQ7iVTm2GLdfvb4hLCiyA+KqUQBAD9bB0NhjslNOwwNK/AWHs8Fo9vQnA22cvNx
 CHjZRlKtfXvzb73OXdS50PCSLu/Nrzo=
X-Proofpoint-GUID: T9aW1M07EqUGo52NTsqvmkzfZ5t8VRKD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA3MCBTYWx0ZWRfX1tmnck+DC0mi
 EIImFVCRtFualsdrzA+t8GbGlWLiDYpDBwnJDSsFHZNBd3S1FhpkyILLv6dDcnk5OlfE/+DZWnI
 Bv5sbLPIg9xqen9aMaNMDadx4hngZ4GbTHr4dzW4Dt+XdSN7XRw23x910jqIdF9HXTTGTBBXxRl
 LDimTFaaBcxu6WZ/SnM5BjDSEZLnMKT+tUNIA5fbcBdN/svHz1wZPFwY4gxtwD7IoTV/sADZ8zM
 EaWqpzL3ryeYQgZrBtAfSX5uKjT4qgkyb0/T3XIWp6M0GOLIibrW6ZTq56iDRTsI2GUWKXeFLtO
 ubmN5sUUoeYOrbiVsGQvs3xbRpy89srMwhXoMfNOQEZsB+SlTVv6MWXj/XlB5Pi0+DdvLBjTFNe
 G0VBRKxrTJRFFqzkf2RQXfuoT2jpDQ/RkiWFQCdV+LTMErhEhWjkbKSx3lWB/MmFvt5gyy/o4ik
 5T1w5cvWg02Qg9/3enw==
X-Authority-Analysis: v=2.4 cv=DppmPm/+ c=1 sm=1 tr=0 ts=6a2bbb7f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=mcP3zJosRo5iYj3H2dwA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: T9aW1M07EqUGo52NTsqvmkzfZ5t8VRKD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120070

On Wed, Jun 10, 2026 at 03:52:09PM +0200, Konrad Dybcio wrote:
> On 6/10/26 3:34 PM, Dmitry Baryshkov wrote:
> > On Wed, Jun 10, 2026 at 02:24:24PM +0200, Konrad Dybcio wrote:
> >> On 6/4/26 6:22 PM, Dmitry Baryshkov wrote:
> >>> On SM8250 Iris core requires two power rails to function, MX (for PLLs)
> >>> and MMCX (for everything else). The commit fa245b3f06cd ("arm64: dts:
> >>> qcom: sm8250: Add venus DT node") added only MX power rail, but omitted
> >>> MMCX voltage levels.
> >>>
> >>> Add MMCX domain to the Iris device node.
> >>>
> >>> Fixes: fa245b3f06cd ("arm64: dts: qcom: sm8250: Add venus DT node")
> >>> Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >>> ---
> >>
> >> [...]
> >>
> >>>  				opp-720000000 {
> >>>  					opp-hz = /bits/ 64 <720000000>;
> >>> -					required-opps = <&rpmhpd_opp_low_svs>;
> >>> +					required-opps = <&rpmhpd_opp_svs>,
> >>> +							<&rpmhpd_opp_low_svs>;
> >>
> >> So the computer tells me low_svs would be enough for PLL0 to generate 720MHz
> >>
> >> Is there some transient dependency that bumps this to svs?
> >>
> >> Your changelog mentions you altered this in v6, but I don't see any related
> >> discussion
> > 
> > There are two sources of information. The "clocks plan" and the "pll
> > info". For some reason, the clock plan doesn't reflect actual PLL
> > requirements. See the info on the corresponding PLL type.
> 
> OK thanks, now I think I asked this already in the past..
> 
> still, both point to LOWSVS @ 720 for sm8250

Not really, PLL type points to 615. I've posted you the screenshots
privately (sorry).

-- 
With best wishes
Dmitry
