Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABE539EF22
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 03:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774323279; cv=none; b=fNJ1NZesWChy0Y56MuHgDvTRrbSvMPdejm2LJ2vRrW9pc78dYscgTbFHkdJpjBLN8dz0uSIcutkF/JNfF1Qi09DWkUeSyhe66AB91BROKVsobNQ6DhdGSyh9GtBkONhecdiQe9MGNUe3RkzbqeUvugBz5JKnpxEIPQRzPhBmXxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774323279; c=relaxed/simple;
	bh=JaEgEOwjmp4nnNNKZw+Gej39KXI5sl7inIVgQtr9HnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dou8ayOywZZS8zB6kmmVgm2dasy1LAR0lFmucmdZlcWxWGN1wYRcx7K+fBL3kTEuPI5MilWBRoUMhcR0BQr4p1J6tp216HaLm1NTZpQ3QZeREV2dOWjrKr1kZ1xl0QN6OzAPuEvbkaHtzYCPBxOuI9vtgDLmlw222Wb9IR/Lpt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DGgpZ7fE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WCwQ1c5v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DGgpZ7fE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WCwQ1c5v"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NHqWmE3817318
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 03:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=whDI1GA1rv1vXsO+5RObRJvS
	XkoZkTiE/QS5vJICZzU=; b=DGgpZ7fEBkrigK8ukyNqmZjHmiTLRoeC4J1qtET8
	rMb+8PpJ8QN/Nq915CwIflEdFRLZf1j4XgRSNrbxJQIvQjAGY7rvNDhp/4VpWHAN
	pbOqpQW+1M020z/B8nIZbQG+UvtX6EPFmtXHL+t40IdXTGWDvcFitSJnxV2KXrnB
	/wRhTaiADe8PrSBQN36tDVIZAX8xCVa/ut6BMYU6nswgHPOgv+bZ2/vT3+9AzwTN
	FSAJfH6CJYj7Ez1OB/BTrUtYcaYky59Td6Qfk2xzQ0cdd6T2jkhDyEcaqyRsJI2K
	ObEsKP0kby9OKSOfEfvCkEw2PYDX4fsDq7Q4L7vwucvsag==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d355w2xjj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 03:34:35 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1270dcd11c1so984293c88.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 20:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774323275; x=1774928075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=whDI1GA1rv1vXsO+5RObRJvSXkoZkTiE/QS5vJICZzU=;
        b=WCwQ1c5v/gHP9uT8q5sYoR1g0JarzpF5o1fmmrIGppOWP/ncAZKQWUMPpZaMycCpsU
         knqh02pLTyPjO+S09djui1kYb5dpgIP6isvHrMN8Y73zKQ75hg5n/FamrMKHnlSQaedN
         +wrbT/eeIuEO+CIyQ5XCr8utqH9RiLvKOuHlctw64BKXbOTlceomWrm1k/mubo937ZB1
         CTP5DoUfEOMWFR+ai8k5NKF5ixYpAtjMHQUO/ungR99CBgYlm2BCj45qHTdyo3fp6P80
         OI+NfB28rNbRcBVZrLs4KA0VVMC3pDGrj3+A/GbVz5T1C3JLcwJzdlgh6uKpgiDuaK/T
         7dLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774323275; x=1774928075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whDI1GA1rv1vXsO+5RObRJvSXkoZkTiE/QS5vJICZzU=;
        b=U3VCW3n8oNBLhGjeIMVHkSh4uM0qCPIaQVRX0cWSxjpHUk0ipPt53iTtcj0RZMGjNS
         RvyANjwBnKaWU0MoqKJjOSK2QXgOEipFup8CTgavImUW2WSq5mA1fTlwoeFlrgES6RCu
         sTstRn+WfTJoPOxfX4k6m1a9yyLIOaQ3tbKJ99vmTEWbBCxCylN90/OdYB3biJ/83BH4
         8aP0EjHVy6//VwzUfputJYfCZnhS6kvb0KWRbV28w4y1AzH3ipJbd/uKNFY3x2SJ+oEu
         v0yHAyC6sHx72xcn7CJHtJoOZMX/OYm5hIFwYSmqmzPeuGDpkUCZI7RgEkMaI2uEpbV/
         qd4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4HtHpQbLTZyzYnpIj6UYaBMxJnXjr88glr2XNflYmd2X1gErewE32jjehuJTmzxtL+EnfsdnYjA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1VJgVXU3wgIXt+M/NlWM2Vwc4sa0b6eCkg7lIB7PNrN0jqViI
	DQZT+c215LTVHhSkxzUPqMtgciQ7EH8bk7hWuYPxD65HgQWNE8tYgoMOJkuXRTAwbJaaxK8HsKI
	1KHYt0eetXf+sLwr9Hw63rBpndvpoVRbZtodDAfVKid1lJDx63Si2ROIKRu9DBQ==
X-Gm-Gg: ATEYQzymHA3rpLwCOKjW1pAZHXfOipFkqwnWWxq/kxysO3xGA5T1oQBUq92/NUWelHl
	+eCzhqerCqmrkl0GxVWKZ83m6ZYsRcX0+kZyApImRnFvHBQ2EhJZQU52/yi7s0KbboltIv8F3uH
	dny7YWaBudEIzHCYJIYeOTl2iehs1SVtfwI0qcvzbXe7brqSkrhD36B0sCYPQ2+cjxIpGB5Snkk
	Ok8+UWIak01pZsqWkRYb3WeKPZ3jGZdgqEPlfEmE9NXvTO7CyO3KHHGtTOOz7EWKSzVFwkSiOF3
	Lm8qPZmcIyKtjaixtELZUXYTW51+M9fimd84K9RjLWnjQkAR1iUcI42RoFussm4/9E2y0xOIijn
	uB+kZwp29LrKVom5Tbp8S52PTr9o0GT1xk9Me4mtIjNsBSITIDaem5z90L6G+vHe4LFG/MJWxyd
	Y=
X-Received: by 2002:a05:7022:ef09:b0:129:fe5:117e with SMTP id a92af1059eb24-12a726a2f31mr6177647c88.26.1774323274669;
        Mon, 23 Mar 2026 20:34:34 -0700 (PDT)
X-Received: by 2002:a05:7022:ef09:b0:129:fe5:117e with SMTP id a92af1059eb24-12a726a2f31mr6177629c88.26.1774323274016;
        Mon, 23 Mar 2026 20:34:34 -0700 (PDT)
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a733fe80esm13039261c88.7.2026.03.23.20.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 20:34:33 -0700 (PDT)
Date: Mon, 23 Mar 2026 20:34:31 -0700
From: Mike Tipton <mike.tipton@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] clk: qcom: gdsc: Support enabling interconnect path
 for power domain
Message-ID: <acIGR7WDjjs0SGF6@hu-mdtipton-lv.qualcomm.com>
References: <20260116-milos-camcc-icc-v1-0-400b7fcd156a@fairphone.com>
 <20260116-milos-camcc-icc-v1-3-400b7fcd156a@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-milos-camcc-icc-v1-3-400b7fcd156a@fairphone.com>
X-Authority-Analysis: v=2.4 cv=fq7RpV4f c=1 sm=1 tr=0 ts=69c2064b cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=6H0WHjuAAAAA:8 a=PAalmAW71AuKxujjx8AA:9 a=CjuIK1q_8ugA:10
 a=vBUdepa8ALXHeOFLBtFW:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: LdzdjhvQ9exjTR7nQXM7ZO1BkpAV6m-e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDAyNyBTYWx0ZWRfX7XfNkvlV+JBa
 75KCppYCFyC3uRyjMZPqG7PbDCVZz5GF5AW/1FmBLa68EyCX5iOOP3mBkkoqyZUFMITr7zJ08zu
 Pk4BovXNbee0AkLD6FNhyrKGhKYWICndYvm+shkRqXEG3rr7BMReZvnShn8pTF6ARNtnew3cmGV
 HLtyhmlf1dfn2Tw1M8/e0SF3wJwg0BYOGwOBnpG8TUicMYI3Io8VEXfTwbSfpd5oifjH0NC9GZ4
 3TogrfJRsUgO2WzuRbXWoMmvchUjO9/zkAIFubAh4ODI+leEnWE/ZN0Nszp4XezTLtPmhJ9y42Z
 5eXzpoIcxsnbMfBUMC0aMqK2V89LcrmraiWapeIv9VcyZeRTJBHovVz2gpOuHJtD6Vvj4AaoezU
 V0WyWYZmAZdhkGX0CYNzCk0aDAc2/fsUkmVNaNJqfJzrTZ/hJ64puA0DcfN7Qcn4iWIN50pbn0h
 XXdFQaGjZg2RrCPNVBg==
X-Proofpoint-GUID: LdzdjhvQ9exjTR7nQXM7ZO1BkpAV6m-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_01,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240027

On Fri, Jan 16, 2026 at 02:17:22PM +0100, Luca Weiss wrote:
> On newer SoCs like Milos the CAMSS_TOP_GDSC power domains requires the
> enablement of the multimedia NoC, otherwise the GDSC will be stuck on
> 'off'.

As mentioned in another email, the dependency should actually be in the
other direction. Where MMNOC gets stuck turning off if CAM_TOP_GDSC is
still on.

> 
> Add support for getting an interconnect path as specified in the SoC
> clock driver, and enabling/disabling that interconnect path when the
> GDSC is being enabled/disabled.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> icc_enable()/icc_disable() seems like a nice API but doesn't work
> without setting the bandwidth first, so it's not very useful for this
> driver, at least I couldn't figure out how to use it correctly.

Agreed. In cases where a driver only needs simple zero or non-zero
votes, then icc_enable()/icc_disable() don't really help vs. just using
icc_set_bw().

> ---
>  drivers/clk/qcom/gdsc.c | 19 +++++++++++++++++++
>  drivers/clk/qcom/gdsc.h |  5 +++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index 7deabf8400cf..ff1acaa3e008 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -7,6 +7,7 @@
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
> +#include <linux/interconnect.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/ktime.h>
> @@ -261,6 +262,8 @@ static int gdsc_enable(struct generic_pm_domain *domain)
>  	struct gdsc *sc = domain_to_gdsc(domain);
>  	int ret;
>  
> +	icc_set_bw(sc->icc_path, 1, 1);

Need to handle the error. If the BW request fails, then we shouldn't
proceed to enable the GDSC.

Additionally, setting BW here doesn't handle the case where the GDSC is
enabled as part of gdsc_init(). If we move the icc_set_bw() calls into
gdsc_toggle_logic(), then we don't have to care about how many places
could ultimately enable or disable it. Since it's a fundamental HW
dependency, then placing the BW votes in the common place where we
actually toggle the GDSC on/off seems to make the most sense.

> +
>  	if (sc->pwrsts == PWRSTS_ON)
>  		return gdsc_deassert_reset(sc);
>  
> @@ -360,6 +363,8 @@ static int gdsc_disable(struct generic_pm_domain *domain)
>  	if (sc->flags & CLAMP_IO)
>  		gdsc_assert_clamp_io(sc);
>  
> +	icc_set_bw(sc->icc_path, 0, 0);

Similar to above -- we should handle the error case and ideally move
into gdsc_toggle_logic().

> +
>  	return 0;
>  }
>  
> @@ -574,6 +579,20 @@ int gdsc_register(struct gdsc_desc *desc,
>  	if (!data->domains)
>  		return -ENOMEM;
>  
> +	for (i = 0; i < num; i++) {
> +		if (!scs[i] || !scs[i]->needs_icc)
> +			continue;
> +
> +		scs[i]->icc_path = devm_of_icc_get_by_index(dev, scs[i]->icc_path_index);

I generally prefer using string-based DT lookups rather than
index-based, i.e. using devm_of_icc_get(). I know our clock drivers have
switched to primarily using index-based lookups, but I still generally
prefer string lookups:

  1. They're self-documenting within DT rather than relying on magic indices.
  2. The property name in the driver being non-NULL can indicate whether a
     handle is expected rather than relying on things like "needs_icc".
  3. Would remove the need of adding the new devm_of_icc_get_by_index() API, in
     this case.

There's nothing fundamentally wrong with this and I won't argue hard against it
especially considering that it's consistent with how our clock handles are being
looked up on more recent targets, but I often find the string lookups to be
cleaner and more robust.

> +		if (IS_ERR(scs[i]->icc_path)) {
> +			ret = PTR_ERR(scs[i]->icc_path);
> +			if (ret != -ENODEV)
> +				return ret;
> +
> +			scs[i]->icc_path = NULL;
> +		}
> +	}
> +
>  	for (i = 0; i < num; i++) {
>  		if (!scs[i] || !scs[i]->supply)
>  			continue;
> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
> index dd843e86c05b..92ff6bcce7b1 100644
> --- a/drivers/clk/qcom/gdsc.h
> +++ b/drivers/clk/qcom/gdsc.h
> @@ -9,6 +9,7 @@
>  #include <linux/err.h>
>  #include <linux/pm_domain.h>
>  
> +struct icc_path;
>  struct regmap;
>  struct regulator;
>  struct reset_controller_dev;
> @@ -74,6 +75,10 @@ struct gdsc {
>  
>  	const char 			*supply;
>  	struct regulator		*rsupply;
> +
> +	bool				needs_icc;
> +	unsigned int			icc_path_index;
> +	struct icc_path			*icc_path;
>  };
>  
>  struct gdsc_desc {
> 
> -- 
> 2.52.0
> 
> 
