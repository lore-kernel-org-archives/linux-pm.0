Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4296817C220
	for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774781071; cv=none; b=bvfVFHBM9+edRhwGkH/zBBRsQsvGBN+5DnJVhBjwKEtWsMGWoAD3aY7IknNiAgVErxClgXDTkV3q1q6/nkCiIhprMNzDVMvdYXgL0zmsRD0Ws8kOUVL4gVkfWOVDePMDb/tduH6Lr12H1KQyBAerif3cpaZfQtMHuDyY88fY97c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774781071; c=relaxed/simple;
	bh=vhfz0nPiZUD/mEsvUgfDG2+/f1UsnrHRMrm0iAugh+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZuFktlgPOn7s/i3BvF1o8o+k2U1PeN+8cdq+G4Zjz5hHQPz35BmshodpRnuAXtM2DKr1S+/3yWLzdFsqqRts43TOvLfAxWdz1mIQjx07/QqvCUHqsbm0zd9KNGO2w1evrohlLc/j7/yjN10ki1m+8I+LZclWhH9velwurG8DtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N47DLME5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h4AngdAV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N47DLME5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h4AngdAV"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TAhT4U4086203
	for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 10:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OKdlwfPurs7StbBKnRf2C7EN
	JtQQjcAVg1fRHz0n5Xo=; b=N47DLME57dS9i6E8ZZgUnr3YoSqM/brhkuSx5z/g
	KGDcNEOhenwVziB3VUKmlSBK/9zeV+35/EneQVdFXspMO5u8kvRa2zyDXMAI+hla
	EtTnBkoTeX12YvXO0i6cD3pUdUBv0GAO5wVsoowVS+u4qbBLhWZd8XZ5HkwEqDRr
	bSFbS9sdgdgBe4Er5tmRF0sRNVXgcp+8k8Ff8FkEPVJTdV1JrWT4TQVzRlbckruK
	vGgNOaoiaKCLefPsGkAEB2CdnTsx3QZDiI/d4TZVPGGlVvi83PPco5bB8JcZfZTG
	gYBHWFE6EtaxjRPFkR0Ta++D5zNEBy71SMIsJZEui37WhQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d67712jmv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 10:44:28 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b3544bc7bso49000341cf.2
        for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 03:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774781067; x=1775385867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OKdlwfPurs7StbBKnRf2C7ENJtQQjcAVg1fRHz0n5Xo=;
        b=h4AngdAVWEZ0F6CenlBeKwoajePsYhO24+OG/hPQt9bOUjPCR8uwLy9Q9vYSGWfk+z
         /Vu9tcDnyQNYT+z+7btPfyfRp8d9PsWbvdq8xFyhJ/FX5wxAC3MT+Ja5DRt+IcxvxIIO
         UZ7d2EP/oumEpxMejlhxBosV9MTKHiy2mLXLtTMqdN3u9DJc+/TCyhAwhPrn0ZQ+Y1zm
         vEJC3fqpbrRWH/zLoNdzhxuD9vWr18uzlWrmutWkx7brAX/avLybHbcd9NrgMRdjM+J/
         fFB3Ya/V+UxRqCY9jDcg3KTavKHMneu4uMJ8hkxXBPyPlV7kqxb8ROQQVXTYeRHn9XJq
         RnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774781067; x=1775385867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKdlwfPurs7StbBKnRf2C7ENJtQQjcAVg1fRHz0n5Xo=;
        b=araN5DeJd76hR2BmjCmGEsPaFcxzQTlQU7UIQjmajpGNjph+tgmISTAWYo/00XTS8s
         IJRBauqUtYGjJQUZU8A7oqQ8inl8Wf3mY9Zm83wJrL+gWJ0Exno6BOStMb52FrrJtxCY
         MTk2+LZoxTP73hrcyDP0Qb64H1w4DkYw1ikCjfc23o4D1Ikm1hXQUpAHQHAbtLnri9nV
         j8Cp0m3URN01ejn6Vos4FoVc6Qv2uwSUaLRkK2BVH0a41nm1bD5FJanoRxVAEnpj3HHa
         aK6YyPJQ0HD6JvhtxTBVXKyqcRzEjoSRtmaq95h3kaes+eCEV2nzOoCA0eQ6OlCsZXrs
         V52A==
X-Forwarded-Encrypted: i=1; AJvYcCWDaisRGHapo52QqsIVBpwqhshibOuu5K+QseJAQXq6MN13fillQeGhDQWoW5bbXe8hxMYkN7yH7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZQhked4eLz8ic4G2uUtaK/DwqU34rq7gqKXHDF7rQZi3fU1gp
	4UQnvBFojS8WbJu+Eq/0Fd/P6Uzalk8Z49+riGEIdXzRq96S2xlO2025GkDO67b8jK8DSxTF5xy
	MbQLTCcLDPU2YWmzS5rKMX53YC0iipyvnaSyZknGkUrQwJUYP8GqyygbBtjpXOw==
X-Gm-Gg: ATEYQzx/tSBy6K9q6RfrFdt/K08tjNwi3wROukarKwn/LfXf22GfgfLjHYwiwNuGOSn
	CvTdOMIPCBkqsQo+EP8m1chELolToBmYwgjwNyU1h+8jlJSbKX8r+vufWUodCI5laTAgZDTWK/C
	bQBb6fk22HAS95A2JTFxIkfieCfzybJVfLmE2L0jxa1fj+6z+JyfDSMUG9gDBzKnEBi/mEiCfR6
	dO08Fjhc47fdd+z+u5G1GlaimYvuwltu+m4vKQyHfLIMdg74tr8UFFAP47O8/KCSYe/oqZLO914
	dVmFPjgKAk8leyTgv936JGOQgChMHT+dKsnZQQieMwnBZlH+RUc0v/KSsL5b4ptp0jz3yr336Xo
	De6J+P8UxzcYl4HoPSTwXqt0xsRiCpgcIQSlND+yPoG34DDxCXJfQx11zM4n/MEKeFyQWQHbKW8
	pfK+JX1kT6Bx1tiHpO/pnwxSAQguyGtQEGMA8=
X-Received: by 2002:ac8:5744:0:b0:50b:42fe:d2a2 with SMTP id d75a77b69052e-50ba3836e2dmr130217341cf.18.1774781067536;
        Sun, 29 Mar 2026 03:44:27 -0700 (PDT)
X-Received: by 2002:ac8:5744:0:b0:50b:42fe:d2a2 with SMTP id d75a77b69052e-50ba3836e2dmr130217151cf.18.1774781066997;
        Sun, 29 Mar 2026 03:44:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2b1455de4sm959136e87.63.2026.03.29.03.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 03:44:25 -0700 (PDT)
Date: Sun, 29 Mar 2026 13:44:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Richard Acayan <mailingradian@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/4] thermal/qcom/lmh: support SDM670 and its CPU
 clusters
Message-ID: <a3rrkgvkc4zxcq5oqvws23lyjy6dinlmfgp34wzguvdxdxig5f@25atyxc7zabm>
References: <20260328014041.83777-1-mailingradian@gmail.com>
 <20260328014041.83777-4-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260328014041.83777-4-mailingradian@gmail.com>
X-Proofpoint-GUID: EbiLG8F52OJ_imO6dBu-3P4nJRG-jVJe
X-Authority-Analysis: v=2.4 cv=efYwvrEH c=1 sm=1 tr=0 ts=69c9028c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8
 a=innpfZUmd6CVFKDc9A8A:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: EbiLG8F52OJ_imO6dBu-3P4nJRG-jVJe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI5MDA4MiBTYWx0ZWRfX5lbZE1okUcEX
 w+rRPlYKplHaoiHM5OXApmI7oGt57Pl4N1OXVdg2CsgEAjZHLtST2Hu0p3LbuQQr34bSWbOadSy
 /jnweP5JkLzQvYymO9AFxBo8d/GaRibfHnOgx3f4e353U+jsZzydAF/6lLKKXN/mxTlt8bSyFuQ
 W8MeeBue+MV2BLThjzLbTCK3+Zi9svt+U7YMAsLHmmNJ/xm1PveMfhSZgphs3hiBbEkb11+MLa+
 4rMhe23wHbN2o7JESzZtmD5Ddz8s4C0GQUMQ1TtvJf9WXZ4gjR6RqKT1PlaeYK2KJUoAlyzVOVa
 4hbyXSFjrjprGNYqh4uPBfiMEbct3zP7QP0m5ojxRmwtK2gVQLPuwIYg4leQaThQePmy3zo1FKX
 fA0TbG1AvngzFOjO+0elkbs/QHUNqczLhRS0IPzac4uhMh7gtuswqQQjYRl1fVwRc5km+5xgO0i
 uh8e9hGkLvUXsCfCzkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603290082

On Fri, Mar 27, 2026 at 09:40:40PM -0400, Richard Acayan wrote:
> The LMh driver was made for Qualcomm SoCs with clusters of 4 CPUs, but
> some SoCs divide the CPUs into different sizes of clusters. In SDM670,
> the first 6 CPUs are in the little cluster and the next 2 are in the big
> cluster. Define the clusters in the match data and define the different
> cluster configuration for SDM670.
> 
> Currently, this only supports 8 CPUs and tolerates linking to any CPU in
> the cluster.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  drivers/thermal/qcom/lmh.c | 69 +++++++++++++++++++++++++++++++-------
>  1 file changed, 56 insertions(+), 13 deletions(-)
> 
> +static const struct lmh_soc_data sdm670_lmh_data = {
> +	.enable_algos = true,
> +	.node_ids = {
> +		LMH_CLUSTER0_NODE_ID,
> +		LMH_CLUSTER0_NODE_ID,
> +		LMH_CLUSTER0_NODE_ID,
> +		LMH_CLUSTER0_NODE_ID,
> +		LMH_CLUSTER0_NODE_ID,
> +		LMH_CLUSTER0_NODE_ID,
> +		LMH_CLUSTER1_NODE_ID,
> +		LMH_CLUSTER1_NODE_ID,
> +	},
> +};
> +
> +static const struct lmh_soc_data sdm845_lmh_data = {
> +	.enable_algos = true,
> +	.node_ids = {
> +		LMH_CLUSTER0_NODE_ID,
> +		LMH_CLUSTER0_NODE_ID,
> +		LMH_CLUSTER0_NODE_ID,
> +		LMH_CLUSTER0_NODE_ID,
> +		LMH_CLUSTER1_NODE_ID,
> +		LMH_CLUSTER1_NODE_ID,
> +		LMH_CLUSTER1_NODE_ID,
> +		LMH_CLUSTER1_NODE_ID,
> +	},
> +};

These tables made me wonder, can we determine this information from the
DT? For example, by reading the qcom,freq-domain property. But...

> +
> +static const struct lmh_soc_data sm8150_lmh_data = {
> +	.enable_algos = false,
> +	.node_ids = {
> +		LMH_CLUSTER0_NODE_ID,
> +		LMH_CLUSTER0_NODE_ID,
> +		LMH_CLUSTER0_NODE_ID,
> +		LMH_CLUSTER0_NODE_ID,
> +		LMH_CLUSTER1_NODE_ID,
> +		LMH_CLUSTER1_NODE_ID,
> +		LMH_CLUSTER1_NODE_ID,
> +		LMH_CLUSTER1_NODE_ID,
> +	},
> +};

... this might be problematic, unless this entry is broken. On SM8150 we
have three freq domains, but up to now we were programming two clustern
nodes. Of course it is possible to define that node_id is 0 for freq
domain 0 and 1 for domains 1 and 2.

> +
>  static const struct of_device_id lmh_table[] = {
> -	{ .compatible = "qcom,sc8180x-lmh", },
> -	{ .compatible = "qcom,sdm845-lmh", .data = (void *)LMH_ENABLE_ALGOS},
> -	{ .compatible = "qcom,sm8150-lmh", },
> +	{ .compatible = "qcom,sc8180x-lmh", .data = &sm8150_lmh_data },
> +	{ .compatible = "qcom,sdm670-lmh", .data = &sdm670_lmh_data },
> +	{ .compatible = "qcom,sdm845-lmh", .data = &sdm845_lmh_data },
> +	{ .compatible = "qcom,sm8150-lmh", .data = &sm8150_lmh_data },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, lmh_table);
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
