Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BD029E0E5
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776194836; cv=none; b=DPeEI6OBQChbmSVq5W8ZieGIu6dD+CG8uPnkc/ZL4LDC0qvqRAbeH9sd/JfWPPacSadd8NYMgvmadbpvyWxHG/t+62sYqN2wqCkctJgUIw+GtjUI6xMRptb0B+aBHuw2wIWCNpbYeOgFii5B+AhXeja5APhPiNfeOorfJ421Fg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776194836; c=relaxed/simple;
	bh=HIxYCzzwdBgIIgcddlq2kTcmNf7WFHQffDvd/3eoxAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCWJiNSjmImZYcckTocaLw/jmngdnrVzlrX30i43du0bqNrWQcjqe/uVgMYLmuFabDGc6Q4/jHta23+St5SSUkis9kOOopJO+fPG8HxcgqqD8zaTWKo/9BMcQJMGE5qeyEMsEAHeVDEpXWxSVvaXxJ33Kso2lrQ0EiQgLutFjaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l6AfA2/R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mjv9c88K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l6AfA2/R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mjv9c88K"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EGBk621778920
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 19:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RoJV5yRb42H7Wx3oSKEa1Xz8
	MaF0ZY9VJkqL/VP1l88=; b=l6AfA2/RuDvL8DMDwNTXzJ1F8ERMizpydS8tAZv0
	RJFW+4K8S/INQ8XFSVc8fKS/jcI3cinKROir0uB4NWZKNg3eNh93dp15EDzABRzY
	IzIuRzWPsBZ2+jyd2VxxnjjntcYsoSBwJg6cYQ99AimfYPq8ZM0p04xSe+yCzy4U
	Q0iia4Gg62U/Sv8TD1NSfe7JXVwccAsxQiiVjhyyew/eWNghJbcHM82dEuJT3Ps5
	cifPRiYnK04zoLg3LNeLpUiA4rNt0+53BsHGt5k62cDPQNdQNGimvN4mFuUCrsL6
	9Dgo6zvXDafPcRgEsTrdUY8+r/Gbmen1IUTa930DgPVWrw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhrw00pxq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 19:27:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d890580e1so112780651cf.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776194833; x=1776799633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RoJV5yRb42H7Wx3oSKEa1Xz8MaF0ZY9VJkqL/VP1l88=;
        b=Mjv9c88K8Y68yIfJ599jEtoXQI7o+O6DkEECY0elz+mV9abZwKjULY+m4E5MJHVAqg
         k9TlHIR1AS2/1AKVS2GEL8RxX/jmUB9izG9GnUZWjUuA/Ysrm2HJYhgugMeOsT8D/T0d
         3nMB8Yx4JeH8s8eHNw44EkHWecG1K94UxZ7QyLqMvF2rCLt35PTSTPwcZDUXv+DG7SFk
         hXSI7p1dL5rdiblqWqQuhCAVtNRWlk+dtAGuRyHgm7hDkLUUUzc3W1m+E/JEZu/U+njZ
         Sc/dUfXQHcGX68Z+ikj3WsWl4lLgDGkfRfd7ewsQsNPzOPiAILk09EjRDG+txEdZO3u8
         gsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776194833; x=1776799633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoJV5yRb42H7Wx3oSKEa1Xz8MaF0ZY9VJkqL/VP1l88=;
        b=hR435/xNEzvrhHOrRrQ8xy3zXetYYv8qHwJTUMukw8e3caC/DvsXfXTd2RZB5+lu4a
         HbVKl+TS5QYf2hnn50YrwYbKqiCahLIBFYKsN4SzRmPwsMvrcO0Z45WQh99+M+g006Pw
         4H+GkC6foLXAAWGXSyZnhm9JPzVQO2/QoQhO4Sdzf1weWsdMwXemPKbUWMvJrNp9xzA5
         jaCGhNYAdpvgBoOGyd7c+4KZ1hpMTdcOZvNXiEiLMEd8BJvN6W8VRCtZb9m9JfxHbGq4
         TUx059rkpCYH9w9wTnQKD296ZelIyYh2HlsjluE3nGwK9VX3bT7NeM8AgsCWi+2VOrtH
         GZqg==
X-Forwarded-Encrypted: i=1; AFNElJ93MYjCe5KH6yrKfCP0YXuvE5KyMfkztfrOSbh6TvKwaveNsVRD2s6vHS83LH2aDR2bxXCSngRXXw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5EGYuCwMiQsuQftG7CoHFRuR8WRXdDL8aKlxWTAG8kEehXw6o
	6uHJQaMloT0CQmDQU7nWmU39IbONTP0t3RjlQcmhb4/VSh/zvZfjNsH10Y8Y2tIdk4K0Cen5G2K
	YyyrK77XDK4UU1t16jYhpPazvaMA7xrjZDyeqTJMGP5wJ0+Ax6AyXNV6c12a3Hg==
X-Gm-Gg: AeBDiesxIeJm6w1wZyteXxgDQoi/pEIjlZfnmhBGEgrOhTs1mce9im198lae8cAEObX
	9+UhFOoEF/e4cLUwOgMC0+7k+NcZYCugzbAY9Nsh1oRfCLMzUeAMVKWanYuLGiC+XyeSW4Ha+KI
	u3i62BYpLywVn2aVfVqKHgfE8hGaPo+MoQ5tPMVCSsk7PPUannECbIIZpoPXNAtKFXjqLlfutHS
	C0Yh4nFZ8toH9lMqMd45fxYVlvHdAgJROOAI25cTNkYLZluiaLtEKP1+WYxIn6VGpK+uWwl4Iaz
	6jY7Zg6rzVVCdifFF0TVEgEX1yrqmX84nEILOXB3O+zhute4W+n9+JYE7QBFUbEw+3O2OZmI9z1
	ibAyBDwaBX/xO4B3ydcCKdxhSA3STYkTfonA2muPVCu9GALKjG6zRf0/R2+Eb16/+etlLts3jc+
	3mdYZfebahqrjmvkq+NILvbQeiar6rwq56odsFMBgi/OVBrA==
X-Received: by 2002:a05:622a:181b:b0:50d:9b4a:e6f with SMTP id d75a77b69052e-50dd5a91b71mr264673161cf.1.1776194833570;
        Tue, 14 Apr 2026 12:27:13 -0700 (PDT)
X-Received: by 2002:a05:622a:181b:b0:50d:9b4a:e6f with SMTP id d75a77b69052e-50dd5a91b71mr264672631cf.1.1776194833080;
        Tue, 14 Apr 2026 12:27:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3eec42ca0sm3530179e87.0.2026.04.14.12.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 12:27:12 -0700 (PDT)
Date: Tue, 14 Apr 2026 22:27:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] pmdomain: qcom: rpmhpd: Add power domains for Nord
 SoC
Message-ID: <2fue4vclozesm4d55id35eutqi7jxomwoc2fd76k4yfjvx7doy@3lfukpmsvoy2>
References: <20260414035909.652992-1-shengchao.guo@oss.qualcomm.com>
 <20260414035909.652992-4-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414035909.652992-4-shengchao.guo@oss.qualcomm.com>
X-Proofpoint-GUID: 3oJ2iMD0zEgBXLnb-RAC_ffub9sHPVb1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE4MSBTYWx0ZWRfX/AjHdCWSp99v
 VVQ3QlZcR/90D5wzZ9fhu2mm7spY/AEu8NlxlhM/poGO3y5LQpFApjMApy3AAzFXyxMLDC6nc95
 IIJUSTsTHwmr0+cEUsdDsjBwl3MjILKjXfNzN19GYUi9lqD+1S1dr6cPGevB+OKTQNBdw28y4F4
 SKdw5dPkl6jKyw8N/E7qZPncbH8zqMewpUQQJ0LZZ/eWpTVEzE5b8LVdREdre2DsDO7XXDrOwK8
 ovBEtj8ATb/QNDb8EfcYHiLSNZ5/jL3NXel/HnyDS9jWjx3c+gywnMRGA099ckzL2sSIXcdyccQ
 5W8FYvSX5NNiU7sOXv8uAcN6MRrFrkrHnALLtu6ZG1wtyh6XBJJ3jN14HBl4Src3jJS/lAk9FNh
 z80hfCd7ejMs9Vby3mozAvVtbDLzjSA1FJ50IZBfFS4bSJnCTJJ4qxZ4/Wil5fC/x7QryLGqxD/
 ubDFbli1DSdOMYwHMnQ==
X-Proofpoint-ORIG-GUID: 3oJ2iMD0zEgBXLnb-RAC_ffub9sHPVb1
X-Authority-Analysis: v=2.4 cv=YMGvDxGx c=1 sm=1 tr=0 ts=69de9512 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=JNP-2SwAGeoVs9V6pf4A:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140181

On Tue, Apr 14, 2026 at 11:59:09AM +0800, Shawn Guo wrote:
> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> 
> Add RPMh power domains required for Nord SoC.  This includes
> new definitions for power domains supplying GFX1 and NSP3 subsystem.
> 
> Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 35 ++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
