Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE04A3F20F6
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776888175; cv=none; b=oPyrbsMepHytqe6nvZfAo6mQ160FEZBg8pjT/eLLIvA0J0E3Ft8/XwCO1AeVGoAlIRI6QfTUjK07qXlKz6J8EqPGZQ1//7q4E53smVod4dTTaLGOKGDSMJ4QAgw06mwmkcqoYxIMaCiWVdPL9Z1DoRJDaz+QKiGhtczjyCxNrwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776888175; c=relaxed/simple;
	bh=jMYpbLL64WOaWpsgBTfjMt79RbB4917t21R2mPwgWJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjKjRDSxx9MERy6Jt/WmjyEC8R2/xNWIQdf7Rmlg0N0vnOgA48kAryLIwG5d9PlzWYnKMN2kbW7FfR2GaR3A3XvZOUWMxZejDcxGKbyTKvteTZ+l43K9j0nlEWbSXrJ0XGeKaQobw/CkNs4gCX25uzeO49kmd1U5CQW3CxnL6Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=euWayNQ6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=enioLelG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="euWayNQ6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="enioLelG"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MG5KPq2185960
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 20:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XlA+3Fg8UBxQ5lYzPMzvkMyS
	dKoVx8IQ0KNPVbZ/tKs=; b=euWayNQ6aS/msB4QyNSPCgqo4V2flm5fNtkCaPMH
	9RbWrFQsIG8La8+U60xsfBVl+WhrqsVDsyJvR31qT1bV1+oM0qlFuVP+wCZWjFoo
	yvUW3+cCFdbUwkMmRbEBh71ZW61hDN0ESzy/1N7B3Lqg2QvxYAWdlqgKst0XLIen
	azeT7S0VL0ESVMM9exHutL4aQADOSw8W5rrBR0d5BmTUn8rs8hvsj37pki4BMisK
	vCfu7APh1IW2g+7QjueTGtIPTxMRSDi9hl1juDP1MzMp2lAQKgw7k57jYeJQtmjk
	xUjYzuELKHumTs3PU+j/uzLYreK+UgBE+lYcfaJiHigcCA==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1hvgux6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 20:02:53 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-47018d3424fso7955726b6e.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 13:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776888172; x=1777492972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XlA+3Fg8UBxQ5lYzPMzvkMySdKoVx8IQ0KNPVbZ/tKs=;
        b=enioLelGzskDQALZlbkz1qeEfon/19ywmi4mKbVUs60N3U9EpCMPjwPMII73AVvRrx
         hVCmNGXPbxaKeswb6d8wzMhhxm5Ttc/Gig9flICKC5lxX3Bdg2f53kMxm8ejHBmigjaH
         nEjn/NpnoH3dNTaQoVWIVVDnApTyVnCrezSvTNAKw9OUJRqS2iLMcoOXufgYE7u7zNEf
         hy2swfO57kr5xMaQk6IXeFX8IEKa70UD//0XwphGxyQQv8CE5SWSjwJpqtDNZDeRQ2BJ
         j51oMWkbkjpPMnHUxoNfq5iwWjd3S9Ba+CqaNGVQK4K5NJYluKbjICFXLcHyu6q5VrPn
         mDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776888172; x=1777492972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlA+3Fg8UBxQ5lYzPMzvkMySdKoVx8IQ0KNPVbZ/tKs=;
        b=BlPYIoTSUkZNc7ZqjhgkXEvuvAMdD43E269/Z+cdVQMdcZ8QlitsHVZ4Rqv0vdudgW
         pfUKpTP2r/aQuQi/NospPheqQ7jmkwAzd6PyWSF7KCkcGzP2KTSrhtsEbTh3fGBFwjFK
         qjUI9IZ1L8vam7ndDsImCN5meZdi8+dkF4iPvfVBre3syxSbxTTDNnrM1mn5VcnRZ648
         Soc/kb81CuDhvZ/Q1eUp6748v/BwrqhRUi5Qh/pfmQay3StexfBlWhuWCpAkZGCBUE8I
         tyq5d1e3f/YV2ANoO0ADvDEV5jYFwUnEnv1GbyRgXgputcCpxPO61xv2gjcg5QMcKJjj
         qhBw==
X-Forwarded-Encrypted: i=1; AFNElJ87vQqbcAhlCpMK3cHbGcYDMMK4BKclhBImcGTrAjKZerpmHavozk6cikt2ctyhx05kYr8hmPkIFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YygNIu9kzLSDjKijJ4ccg6QvisKhFdXU74dGVAliVnn0ZksnC9I
	fWj2924SK1odopUj5ZZ5YHM3BBC9gF4gOSIH4giAHi6n8nGIavFt9KAqFiB2r0s34VIGdSJAAuC
	9vJhdYJ6wJX6h/urSZNvlFFYMvdzi9geubeSWuozgmMtA7hLnqQmzQUBrqTJPpVrRjTH2XQ==
X-Gm-Gg: AeBDies6ny+HTTTgXH/qgnlQZ6dlHoEDsB73W0RQQ9tNJHk6iFAJ/rA0OxoZ6Dm4gCZ
	0ahXvnJa8LB+qne79f+MJb74sD2oEMTO58TXmHM41BUHwnclpNPu5HMB6zoAjCaYPzA6aEsSSyY
	3a+vI7zkqX9No/xfiopbLcm36jMhwS2THP1kFX/C3r6T5FtzoJSDobHn+AA1j9ASdqTMPAIdH0v
	ks3mvJZXsBZQz5pBAND8eHosG+azE70/S/qhjDX1MYnXru1U4tzbN62XvbXmLkwvtlvFuHVFGXI
	hCKpTLlTSTKFIZb+P8/h5FJdi3uZdeFKcKem8iUV3Pnpbv6WMwWgsprSnjFTyiyWe6XYmv4DurF
	g5ps2X1qrARSWTrqUNcHQTAzSD5yXUE2qhVBhB0vjHurOcLDrfygJGC9K5CsrNWa0/QhLuviLME
	svjqxBLq/D49RrdtxqSASh9PizVLnmZU71P8xR7bm2bWyPOA==
X-Received: by 2002:a05:6808:690b:b0:46a:746c:2d53 with SMTP id 5614622812f47-4799c917825mr12518464b6e.2.1776888171962;
        Wed, 22 Apr 2026 13:02:51 -0700 (PDT)
X-Received: by 2002:a05:6808:690b:b0:46a:746c:2d53 with SMTP id 5614622812f47-4799c917825mr12518421b6e.2.1776888171535;
        Wed, 22 Apr 2026 13:02:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb6f0b6dsm39086411fa.20.2026.04.22.13.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 13:02:50 -0700 (PDT)
Date: Wed, 22 Apr 2026 23:02:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] interconnect: qcom: x1e80100: enable QoS
 configuration
Message-ID: <ndutslrzvabc5xy56ooddkfs5jhxsefhdngqde5migrybc4nk6@m447f5sloya7>
References: <20260422-x1e80100_qos-v1-0-bcc2afe4cc78@oss.qualcomm.com>
 <20260422-x1e80100_qos-v1-2-bcc2afe4cc78@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422-x1e80100_qos-v1-2-bcc2afe4cc78@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE5NCBTYWx0ZWRfX+N+sAUDJ8m8I
 CBrCu0MOt2+t6iuWivLoyoz9jI0U37Qb2UF0TPH+fzmyFjqHVgqiNkJKnri/k0XiWAZHoCc8nE3
 /KmYThmEdF+A6qj1QXhzGe3mdqfv+1CdC71+NzCi/dUtGTeDT95tVz7rtRYBtgctIxbU/5rUEku
 +/mm3TW3kItQJx2X6dg6WiGi7HK+BmC/sVyvAAqzKkfDs6E9UbmVJBtCjMBWMcUtfnCj27vm5NO
 j8PEBzGnGkUsWqTUaYXNUw1vv/Yv0tIbP35yTTXaJvtr2QM2dcB3BfBG1EI5sTonDCbrxGBboks
 b/B/k+o6cozQ+nvnADQseFiidZEOJyTdQ5ZR2Gh06fcoBZ7+S9thSy+ckYsUgjXddaSp/98szaB
 KSKamyqf8meMqUa1iNLdnWYd4wowOOXdMFUdZtsBjrwhCJqen1kN00lNPK1sU9NWDW4WEf1xVoe
 DYUlhjxClirRBjoIh9g==
X-Proofpoint-GUID: OGADUnhVJoHjUkVnRtUr8hbZMftsusoi
X-Proofpoint-ORIG-GUID: OGADUnhVJoHjUkVnRtUr8hbZMftsusoi
X-Authority-Analysis: v=2.4 cv=HJvz0Itv c=1 sm=1 tr=0 ts=69e9296d cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=OjuMvAmBQBMAj6EH008A:9 a=CjuIK1q_8ugA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220194

On Wed, Apr 22, 2026 at 02:05:12AM +0000, Raviteja Laggyshetty wrote:
> Enable QoS configuration for master ports with predefined priority
> and urgency forwarding.
> 
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/x1e80100.c | 485 +++++++++++++++++++++++++++++++++++
>  1 file changed, 485 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
