Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CCB3B38B8
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869340; cv=none; b=JY49DOyeqznRK3+Hdl3tdLI9OG7XW6wTfe5Rti68FiIAakLl+FqkCp0DcAil3lJb8zTr5V71+IjmKBCgxMGCpUANM1qxkNQWaRahJTi5zbnjGwqrTCg83x9QTUTmRWxlM0WKIL/6lhyopKyEkxbXXXRMCK+iNSzTn6sSVuLZ4bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869340; c=relaxed/simple;
	bh=tr1+vZrmofnSpYn90Eztx0OhSCniztRM0zdtPMgCtUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOJmN5rVM0LJiFtdxLeHoU5hp29SR4AJoZC/ABSHnxe9jwL7Trdn8da9zpgbmq8sdeZPaZJUgjojloPKR4RSNaoFwkiYEcgZ6IdvlzXbq3C+LSThmJFAWzLQS+zmn1xCiM39X9iBaJd0A7Vog4aJdO0seBACjOUVvUT/69LkAeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PUzTz+HD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z76CFxAC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PUzTz+HD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z76CFxAC"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U9nH5l3722183
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 11:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ogPJDkAzaFSmdt2dEX3iL6F7G9X1L2BalMH8sF2B1Ro=; b=PUzTz+HDRFT2Hlw2
	duCtE2XerKDJzQ0jr30gwqNyn3cimdZUrvRnjMlPvU4Ygail7LR49sddtPz+t/bf
	i5chtgUV5L3nMJnq/LZ8RKz9YJx/nwOz+MpGnaO2dCRlwy3u0xvA+bYeQ57Zxw9U
	dhxjNNzvvYLh85/hGl1Z2jARuFAlg5cDCmfDHJFV4KXGRPL1DBergakYyXM+NGkI
	mGnDGOFxXJy/0Yq/0E9wTiRMJCSEnJEajrW5CDYKUXKJ89olvVFlqk30vBSTjGHM
	uu/NofAR24a+lrQjntYQ9UP3/LdHTetgBFh7aOmW0h7XUhHkMP012frE4Rl6l2YQ
	5yfMKg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7pvmr9w7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 11:15:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50b3544bc7bso59100221cf.2
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 04:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774869335; x=1775474135; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ogPJDkAzaFSmdt2dEX3iL6F7G9X1L2BalMH8sF2B1Ro=;
        b=Z76CFxACwNsGhNqTX76broBwXUabr1nNPd6njPaLK4U1BNBuSIOTWNGjln5vvdeH6c
         P+abJlCiij7BmpppFg/rsDCy/d72YDPHHct/5CjzB8Hop/T9cysI3XKym7+Mlq3HODbr
         /+vTAqiEG2TUniVjEaNkAaM6NkUTISQ2rIQWfI+5D3QC8DVRTMYqHuoQRpid+Zqvj0gx
         kJHh/P55Wtl6krr5SABPTPP8iUe7IF/UE33hKxvhTtWA3ImT4Np9CvqE4z+mOzAtgf8n
         YfMEJ9RIqr0BbpAvnWcTRw78UAIdVL2Efj16kDIW92MWkKYPtWhnSc05tzYkCR1ZZ5Dd
         VXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774869335; x=1775474135;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ogPJDkAzaFSmdt2dEX3iL6F7G9X1L2BalMH8sF2B1Ro=;
        b=BO6G3BU7rk2FzX5RVwqbFeFZCPTKG3udQORH/bF0+ADJFG/EWDZ7c8yt9qKGugXdB4
         kdsl/6Ft85WA560igPqqyb+M732hlHG+GdMryLTPGfDArW0WUJr2r4Vw65qf5J0zsfBK
         ER7oBegouhJ839BePxPNSOVcz+g4grtZRPmfcqfCxAdCZZB/KSx66T392AREv+VKf38L
         Ub4CbPbczO6iUog11Guef9UGDSSlI8NuIQzdZ53zwamlibknQo6sxc+fkidg1m25ZL2m
         n4/JfWouD6dcPOKUtC3UT6pgTcoJN1rPsW8DB0/aJ8VdPD24AGgYhZOu4dP1VBYF/N78
         kCOw==
X-Forwarded-Encrypted: i=1; AJvYcCVp+94iZwRhexObR9lqFKtkrSCxhKb4xRd+btBlsDGiLBJ1QhxarcihNqPbkApN2ndh0ZzysW+XIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCRCGndRw1Ct3IsO/4VjCeX6KAznXa0P+HrowuK99EXBMPf2Jj
	jUHb39O8fVZbLmx9fj4RpOqXhw2wtzeFi41OMDCQfOYIuIkpkz886fS3wgvqAJN/5tdf778A1Oy
	liV1Os2/OINPZ4unuyoLmN53Su+4m4ddbGzXBnc+LPvVbIv/IP32RydTN7/c36g==
X-Gm-Gg: ATEYQzyOvjbXlp/953uq8ZreZNGD7+qJJAM3zd89j1zHOIjsPx+6d7uX1JcWgYuwu75
	aG51qBbw3Ji9uule8YNSOxNQOBl0aS4OXvGxNW9orJQyzC8zk1QLwSwFZsx4I6EKRs+8S0lQuW9
	xP8yDGDbZd85mP0ExflHloa7QN1aPMIYwe9Z7Uhu7Ykdax/EELPhWpO1YfnU4P3QvtHiW5JiAi0
	AaAv1iBhTAxW32vmy6yTsiH6y5Bch69YVIVEgS+gGnZprfFcTkjnvwwvBCt+pYAGGoSlXOrcBuD
	8s0/DsazWsccbsjMVYMXUcOHZ4Ubhmw539DahHKJiHrm+bmvK8y+rJJtPRkSAGseqv1vmkcOh+t
	xD4ZCwzRh8T4w/m86d2o7O0JYF67UhmseiAGAmSBDsC7HrP3XRIExwcIvA0EAKDoR6QIUYWffe9
	0DBPOh5kyoQ74RHMh97Gc2a0LkJWPjnm1ntAw=
X-Received: by 2002:ac8:5744:0:b0:50b:42fe:d2a2 with SMTP id d75a77b69052e-50ba3836e2dmr178221111cf.18.1774869335161;
        Mon, 30 Mar 2026 04:15:35 -0700 (PDT)
X-Received: by 2002:ac8:5744:0:b0:50b:42fe:d2a2 with SMTP id d75a77b69052e-50ba3836e2dmr178220361cf.18.1774869334457;
        Mon, 30 Mar 2026 04:15:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2b13f435bsm1572580e87.9.2026.03.30.04.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:15:33 -0700 (PDT)
Date: Mon, 30 Mar 2026 14:15:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v5 2/5] media: iris: scale MMCX power domain on SM8250
Message-ID: <x5gv6dxdum5klzfjyo7xjqull6o43okkmkn7avssg26epbvrz6@z2brpssbk7iv>
References: <20260209-iris-venus-fix-sm8250-v5-0-0a22365d3585@oss.qualcomm.com>
 <20260209-iris-venus-fix-sm8250-v5-2-0a22365d3585@oss.qualcomm.com>
 <5e2635ac-35de-645b-b5e7-235923f844ce@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e2635ac-35de-645b-b5e7-235923f844ce@oss.qualcomm.com>
X-Proofpoint-GUID: 3Qe_MCl_glARLl0BDXIdiuK6resix0cN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4OCBTYWx0ZWRfX54oDPRdeJ3/E
 8QqagQ87MNHXAGVJxVNW3D51bfc7oTJDE3UpbmPkgs3Ib8/URplyoJURuN19XXDTA7nKiZn9LEH
 qafkfPJGwxFkGtGscV0Nj39xt4lA5w0W120DuVdUGObjhPGSY7rq8y9yka/a1cNYPCkXGNH2BAz
 OxcD877pY7floOaR3TJMlXksHG9KlfPB3jzRMTw7v4UJWZt2h1o0T4mHfrUmdNvYXTfIjgoGp7Q
 0hjCjRJMWNECqCOXnCL5Wu7n9A30DtRrUp05DaK7HHKRhIVJCNaaInO1WyMrqVd1JY3WUuQkcul
 x07D3igQbzAHDCUAmAkeRRZf6hSzs87a1Y0U4VGmffHaUY1p1P8K3rc9sfEMRrYfFdiDwhUMIfk
 5fFFgZNRaJBiysil5shdUAdYI2PxTMoOifWFbm5rbbFBfw6T+H/mTLz58jxCpM/BwnXYuhRSzqk
 tXiT1aONjdTtlEiR/iA==
X-Proofpoint-ORIG-GUID: 3Qe_MCl_glARLl0BDXIdiuK6resix0cN
X-Authority-Analysis: v=2.4 cv=S9rUAYsP c=1 sm=1 tr=0 ts=69ca5b58 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=9MiheJ026npgdNaa-0UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300088

On Mon, Mar 30, 2026 at 10:55:02AM +0530, Dikshita Agarwal wrote:
> 
> 
> On 2/9/2026 7:02 AM, Dmitry Baryshkov wrote:
> > On SM8250 most of the video clocks are powered by the MMCX domain, while
> > the PLL is powered on by the MX domain. Extend the driver to support
> > scaling both power domains, while keeping compatibility with the
> > existing DTs, which define only the MX domain.
> > 
> > Fixes: 79865252acb6 ("media: iris: enable video driver probe of SM8250 SoC")
> > Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/media/platform/qcom/iris/iris_platform_gen1.c | 2 +-
> >  drivers/media/platform/qcom/iris/iris_probe.c         | 7 +++++++
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen1.c b/drivers/media/platform/qcom/iris/iris_platform_gen1.c
> > index df8e6bf9430e..aa71f7f53ee3 100644
> > --- a/drivers/media/platform/qcom/iris/iris_platform_gen1.c
> > +++ b/drivers/media/platform/qcom/iris/iris_platform_gen1.c
> > @@ -281,7 +281,7 @@ static const struct bw_info sm8250_bw_table_dec[] = {
> >  
> >  static const char * const sm8250_pmdomain_table[] = { "venus", "vcodec0" };
> >  
> > -static const char * const sm8250_opp_pd_table[] = { "mx" };
> > +static const char * const sm8250_opp_pd_table[] = { "mx", "mmcx" };
> >  
> >  static const struct platform_clk_data sm8250_clk_table[] = {
> >  	{IRIS_AXI_CLK,  "iface"        },
> > diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
> > index 7b612ad37e4f..74ec81e3d622 100644
> > --- a/drivers/media/platform/qcom/iris/iris_probe.c
> > +++ b/drivers/media/platform/qcom/iris/iris_probe.c
> > @@ -64,6 +64,13 @@ static int iris_init_power_domains(struct iris_core *core)
> >  		return ret;
> >  
> >  	ret =  devm_pm_domain_attach_list(core->dev, &iris_opp_pd_data, &core->opp_pmdomain_tbl);
> > +	/* backwards compatibility for incomplete ABI SM8250 */
> > +	if (ret == -ENODEV &&
> > +	    of_device_is_compatible(core->dev->of_node, "qcom,sm8250-venus")) {
> > +		iris_opp_pd_data.num_pd_names--;
> > +		ret = devm_pm_domain_attach_list(core->dev, &iris_opp_pd_data,
> > +						 &core->opp_pmdomain_tbl);
> > +	}
> >  	if (ret < 0)
> >  		return ret;
> >  
> > 
> 
> Hitting below compilation error on latest kernel
> 
> drivers/media/platform/qcom/iris/iris_probe.c: In function
> ‘iris_init_power_domains’:
> drivers/media/platform/qcom/iris/iris_probe.c:71:46: error: decrement of
> read-only member ‘num_pd_names’
>    71 |                 iris_opp_pd_data.num_pd_names--;

See commit 7ad7f43e568b ("pmdomain: de-constify fields struct
dev_pm_domain_attach_data")

> 
> Could you please check and fix.
> 
> Thanks,
> Dikshita

-- 
With best wishes
Dmitry
