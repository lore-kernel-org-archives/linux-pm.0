Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F7A360EFA
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791356602; cv=none; b=YMnGHxEOlPR19/y44CCDHfhRkRZYfcnMY4iyx573ER6vz6lnCnUZWfpnSTi1IjfSILhfiMZIo36uE8euhLlNzCkBuYHqh8Vwi7JnzD7UwqiqfTMezQIquHjmq8jwZm9v2+zzfc5zHsemuHteNriYNB2Dd/u8lUDufd/C2JHTUk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791356602; c=relaxed/simple;
	bh=ogEzu6UuBrOBMLU1YQ+/foOwKAGOPzGySwOnvVrCrBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOxtI7OWzBm7ES2ngK2mTAaQR6WsbOidFLadtc+iILnyIIllSXRZUx8XMTnWhRUqtt4OP04IxcQCvsj/biImTEO5dPhsGdLATwSjkMZxuB98mJ1rCoZC2OSL0R69Ta3cQAID0MUGbXJLHdlwZgJGJRBKGpVETaP1C4ZsN5CzU2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TVE1ICbm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YBESaM6c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TVE1ICbm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YBESaM6c"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6974UHgl2774285
	for <linux-pm@vger.kernel.org>; Wed, 7 Oct 2026 07:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=821v8tlX6UL8RPAzc5juUnjm
	9WDDhS722BB+xkV9YBs=; b=TVE1ICbmkkYZgbIAKI8aLQQJ2Lt4g0HPSHosjhhx
	azh1mwSx6toh4aavK/8l7SoSDOdXqJi+EripNJZkG/yjLm3Z4qX2HxNlSDATwWz4
	R6QMGM0dBxX43rz2SRex2ANNnwkUC8EVrpemw92PtQOWg476WwSPAtlun/4JS5cr
	xoax+OAdsjDaCyLtkszMq4f85bZXGqsvSgoolpNOvG1JJv+wB3i0Bu2kH0LN+kh7
	SfZZBBHD5dO04iS/+1OUwlKlq7QHyLDVVBmIZInV6uk+3bR1IKtdFlx86HwOREja
	Btvay3mRBjCCiudYaANZ5qG5uT9mxIN2LuoLYd1/RAJvZQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h541uk4r0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 07:03:18 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93e834ff4d0so532655785a.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 00:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791356598; x=1791961398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=821v8tlX6UL8RPAzc5juUnjm9WDDhS722BB+xkV9YBs=;
        b=YBESaM6cJ1AuXWJvTp34xtcvB9eCnImE5b60bRG+hj5FrKsgRfGP/ncIbDNKAV9WKl
         z8yiV6U6D+BZmwAPPpnm7cbolkU/9yoHY9Pb/Ct3qLjEztHPHLW3wJhg1yPden6k6NUL
         MxEgVV5ClDy1AWFfTPQI0DpN3wUGxXr4tLUvw/CIWDtW/dPf9DsIgIGvJ+lj3E0AYbck
         mS54szkiX4tTFzB17V5ET9czDQ5AP+yWPFriUWKmnbhj9IXSIrP+KPEcKRMLuJbpmxJ5
         M4V3StCCHxjqS6JfX4c79jgA6j1uYYFLqEt7+mMXP5Kg32mb81/bYejMWlk8/cZlq+r0
         fLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791356598; x=1791961398;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=821v8tlX6UL8RPAzc5juUnjm9WDDhS722BB+xkV9YBs=;
        b=RLGl+1MbtrpMTQdbfUx43KGHTZJ6QSD+ZAOWyTGoLvseejchWmAgf0BcfNgzmlWRgi
         Oiubb29JHb3p23LGKPBtICYmoBxwz7UmpqfztS49BR2OEgAIFNaA8zftexk8dM3t2FnS
         0S18T7c/FCqdbqZyAXlQHbNCAW/SxLGwjg2lCJhkkPt0008M8a9UCbn4P09hNvket3g9
         cFVgp3axV7vEDyNlMpNDbaslx1QIyeTbyZcnOiEqaKD2VhCfn8Z+txz7Q8xT6uwH8j75
         n6m1Ac3zA01leiWsvJ7JT+Wg7mQdCmvo381AXRGzPiMfd/wO4aXScsvzcLjoPcwu/cEQ
         1Jow==
X-Forwarded-Encrypted: i=1; AKwUvBx4Y1SUp3FqyLdgn3MwYCqemC6z2qT+1ZHrWJrETWoB8OiUIuJGVVercgyYA7TtwQn1tjBRUl3teA==@vger.kernel.org
X-Gm-Message-State: AFuF++maMMHYF1VWFLeR0N4ZhoRaosSj9b4UrvAZHkO5UowWmRgpUhJX
	IaaLnzR2AhlUit69Qj2o8R59qJtPYZMT2eLHv3emZMxDL7xw6uvF3SlhYqN8V57v3KnTtsDH3Rz
	mUNTfXtnH6EWjzAleVY5uQrDmM2Kdl8PN88HX/wGgS/PDV5knDdtvQBvmksZtmg==
X-Gm-Gg: AYBFou1q3xHW9qzqYBMuarUMGsAYBjBBDSgTBIQBf+AmaYKSeXgsu7l8hg63wnqy0QE
	nMbjs6KwgfMUI8jB48XkKQkQFeikoPyWE0gCcbMjF/JjD/C308lgMoYDC1CMNBjaHBxKCSYzoi6
	y0Oa532fsEtG9A2E6N1z5wTdO7bvZXNep+9moVlE3azQFa1brafa8WLNu1ICFJ6ZbjDD0R0lRj5
	lCoN5Ep0cD9R6zEdO1XfTeVokFZSbn0pyQWTyorZtV2VvjOy+j4ovKFGEO9LeoYFFXr0mh+Qx5M
	mdozyUbaiEYxwTawImOcXoFT+hoQc0GLiRLMRA2/Yy2q2AjIiq+fGfVsS2kwlqDdO3fLyly2wNb
	ST1LNLqKC7jBjfTAo99Zjm8pou8uqkUlllwCC8QGDzzovL+0D6Xdvv9ksY8BscJRS7TY45/aGQq
	TFKCiVmL13sHhA
X-Received: by 2002:a05:620a:46a6:b0:93e:9807:9785 with SMTP id af79cd13be357-93e9b829e93mr263582085a.70.1791356597950;
        Wed, 07 Oct 2026 00:03:17 -0700 (PDT)
X-Received: by 2002:a05:620a:46a6:b0:93e:9807:9785 with SMTP id af79cd13be357-93e9b829e93mr263574285a.70.1791356597214;
        Wed, 07 Oct 2026 00:03:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bccfe9d3e2sm417662e87.58.2026.10.07.00.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 00:03:15 -0700 (PDT)
Date: Wed, 7 Oct 2026 10:03:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Muzaffer Kadir <muzafferkadir@mainlining.org>
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-pm@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v4 4/7] thermal: qcom: tsens: Add support for MSM8952
 tsens
Message-ID: <ze6klawno4rge2276cqwdiutvwbcnd7yby2l2x2gubwone36sg@zk3odztmoojw>
References: <20261006-msm8952-initial-support-v4-0-ecdcc1ac620c@mainlining.org>
 <20261006-msm8952-initial-support-v4-4-ecdcc1ac620c@mainlining.org>
 <suzsbvsdlfrfsnvaerphqdycaaaiu5inh5uw5wups4jmfozkbt@n4lsb5pfdhbw>
 <f0b58a7b-6257-4dc3-b0f3-eba76ecc774f@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0b58a7b-6257-4dc3-b0f3-eba76ecc774f@mainlining.org>
X-Proofpoint-GUID: piMT8RZG23VrT8feE3CMrpnsLJdbXcNu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAyNyBTYWx0ZWRfX7T1GXqKvJ9ud
 rMbLy5tS1Hh4qLsO7CX+PzExJ3mlTUJJRIc7GXyfBrCXdV9QqELRE9AJuUnyG2Po0Wth3eQ/Ngs
 612yChwLuIoYfFwBj4rWuC0TIkxeYk0=
X-Authority-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6ac5eeb6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=Oh2cFVv5AAAA:8
 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=FwduPMDodLxw-pZHfsYA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=7KeoIwV6GZqOttXkcoxL:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAyNyBTYWx0ZWRfX/26oxFw23BuJ
 YJtPrwqjR98ztyUH2ATTrM8ncaYO9baYXN+KGvQ+1qZdtGgvOGGJq1rpaSmPtKa9f2QPq/VUWb+
 0bY1iQ39GVcmedXu8+s8MnCToL8A41FVpj8W4wZeXQPLgrGfhmgEH5y7pPwXXbVTL8cFUGbTsUX
 eCCRpoNSf6TnYJ0UeIiMLtMm5VESTTWnU8cPsKK8udce823/iSk0WNTBEwuoL/CR0P3g6sOKhLu
 kO65WK7N9akYBeZcdxH7pifaekS9E2gMFbbmxTQUS4rfla2saJvTPlec6AzUOL6xVaK9wpPkJwb
 QdgV12GP5V4IqDarPWFJ9X+VJ2gwdHeuG9lejvv21kAzqnUtxifJjbJ7Z69lEfJGixU/x5l9Ysz
 R6im3j8+NcZq3VXNWZLWTDzRDTV7oTY9veW08yP9qrOXy+byRHVq5lPN97lvPGxeStdt3Izj4Kw
 IghoXcnVNhUDGoT5yBQ==
X-Proofpoint-ORIG-GUID: piMT8RZG23VrT8feE3CMrpnsLJdbXcNu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070027

On Tue, Oct 06, 2026 at 04:49:12PM +0300, Muzaffer Kadir wrote:
> On Tue, 6 Oct 2026 16:19:04 +0300, Dmitry Baryshkov wrote:
> > On Tue, Oct 06, 2026 at 03:15:11PM +0300, Muzaffer Kadir via B4 Relay wrote:
> >> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> >>
> >> Add support for tsens v1 block that exists on MSM8952
> >> with 11 tsens sensors. Sensor Offsets and slope values
> >> are taken from downstream.
> >>
> >> Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1621
> >> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> >> ---
> >>  drivers/thermal/qcom/tsens-v1.c | 44 +++++++++++++++++++++++++++++++++++++++++
> >>  drivers/thermal/qcom/tsens.c    |  3 +++
> >>  drivers/thermal/qcom/tsens.h    |  2 +-
> >>  3 files changed, 48 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> >> index faa5d00788ca..f4201748ea29 100644
> >> --- a/drivers/thermal/qcom/tsens-v1.c
> >> +++ b/drivers/thermal/qcom/tsens-v1.c
> >> @@ -145,6 +145,37 @@ static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
> >>  	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
> >>  };
> >>  
> >> +static int __init init_8952(struct tsens_priv *priv)
> >> +{
> >> +	for (int i = 0; i < priv->num_sensors; ++i)
> >> +		priv->sensor[i].slope = 3200;
> > 
> > Where are these values coming from? The driver that you pointed out
> > reads them from the QFPROM (like other tsens platforms do).
> 
> Hi Dmitry,
> 
> Slope is coming from this:
> https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/arch/arm/boot/dts/qcom/msm8952.dtsi#550
> 
> calib_offset values are coming from these:
> https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1756
> https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1800
> 
> Should I drop them?

The slope you are setting matches the SLOPE_DEFAULT, so I guess it can
be removed.

With that in place:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
