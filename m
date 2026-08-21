Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AA244C64E
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307262; cv=none; b=epi/295fuHSQJzyrjb/0EqVwc85JFD2xR12bU6ApZ94Hh23KsNy4d6cbKNytz3XNiacbeIFNC1YahV++L5V28zOF0nmAaqey+pcUlcVp7CVgD5kHMBfUi3q19mmKyqbboORWolv9uGMLQYVoycyvN3kjj0orNEq7nUc6TkMLYVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307262; c=relaxed/simple;
	bh=ogCP2A4PXSgYixCatTUIw3PNEyUgcCxbSFOAxmJM2mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSjm4QToVcMU7gt3WZw+c83EU8fjSlkJ3FiIpFWWGl1mMGvpQ+jCNEGGhekIKq5ifYfg+CxB8hTvqoZbncLwfkXw/lhQZJc1IWr0Baq5rLLFNfdABdmjsG3qDG07e9/k6rVMyw45INhEKRWKqQUlCTGX7wvFV81Jw07HG1lzPkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ah5FHfDf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PDKR5UlW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ah5FHfDf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PDKR5UlW"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9MjxU791502
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 10:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UnYVTMkS+WWlkVK3zBqZDkx8
	gQZG7fuc4gpwBwK4/PM=; b=ah5FHfDfgf5DXF/hSIAUdVtDDBG7XH2AHqlBaQ9x
	3i84OwumBXM/po6PlTt2oZXDe8OGtrJoVZSMsJ8V9/zjS5qVavqt7al6CZoEemN4
	+8qey16CJ52DEx2uYWF97GdrNR2eO+LUjzq7/gZ/2M+w+ac1h9doRgN+n7fTGFIf
	+NADrnQRX9PSIOA9s7HDvhnQMIXiLnyzbRq96g46vQdyeh8oFi4QXF4k281ztgLp
	uHaIOgjkAMKzJTOOx4BlA2MSO+3Ntn1p9IJwtHySRCrVnae155PFaLO2nYcy0FWs
	Sid8pUfKrupwJdMnKmPQLQVeFckXf7z4c7Aj0kksOOY42Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6ebuseq4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 10:14:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52ce64c41efso14346891cf.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 03:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787307243; x=1787912043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UnYVTMkS+WWlkVK3zBqZDkx8gQZG7fuc4gpwBwK4/PM=;
        b=PDKR5UlWjD+txUMGZXYxg/InNRardcHb0CPhtYcoUvw0wcYrYgyClIMrmhLVo06WqZ
         qyNmaLFGA7+uSVRnXxY2aCUYYoZa/dn1ez/E0c3BjrIDfOvNb3aev2NaXl0RoA1h60Mj
         FD4QKfq7zAvpaL4tR37jYGopfGgWpAT7jEHwJHNyblUTmrnT2DNkccg0eLluUZSLgdKt
         mgtDZHBkqJWdBRO4bsGimhXEnZ3P/CdjTFtT0NV3iloAzecu/oZwDsZhisMAOhTCxS+k
         b7IUJYixyq9qNqu2sjXDmdEWS8WjXALXsOJOt0a81GhuA0YWLQW1Fq339p2E2KMD1B+0
         ap3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787307243; x=1787912043;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UnYVTMkS+WWlkVK3zBqZDkx8gQZG7fuc4gpwBwK4/PM=;
        b=TfxJnVvxbO9PL5Y44l6WewV9pXHtjio5k1C0fViFIx3e0nsKva/IUwd9ezJ4sLvzon
         T8RGmBZKZCzbuO712YITE4A2CER1je0AsG7jADAWWRZtHhgmagObno3POqRV1QrdS8Ms
         5U4E9YUstDOGy+lb792OpMQ8i1X9bW+wLD04QSZTs9aoHzkdLCf/i8N2YLpg3u5//PSR
         T9fpX3AMFU3uvYoJYt2GdG8F2njNIegs9fOJjaVuCyMZoF9UKYjQeicMOljTz8QdM3Ln
         jI8mi2O92o+go2H8xPx4uraBeCov3s2w95h7eGroVgOGfudbqAnkKRW9N/48s6XcrYn7
         MYaQ==
X-Forwarded-Encrypted: i=1; AHgh+RrV02rSRPFcRRCIFCOg+92vO6gFnuOKR0j7x6Mzwh8NqX9F7wyfEh9PwILIhHLeI5OG75pB5E40eQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyn3YlUUvIUbNvaEijD47iR5+SCIqYinyOzFwz4tO/UI1DX40m
	CON0eytRCuthrLJE0MClCVOQcR7xtaIYapV/zx9IQh+SWXunWTu4BJ27a8bJj5m3Gnv7rgZ+BGG
	cdPnrHYEF7lCUovBCdstUydcMA4gBir50WGq8MC5+muRVaGAy+AEXmWKNbjK/fw==
X-Gm-Gg: AR+sD11OD1XJ+c2gY8o7fV1c58IKcbVJtS0c1DoIB1qu/lmeXfI/oVXJU4VrYi1FIcl
	Ga1B/0ubkiPyWYEmRNswGAbUdLAk8xHDRAf68jb1Dkf0hurd2qCNDkIhS16vIdcDihhDhGuiLSm
	HL6bq/I12kbNJJwZj4/u9CWo04WMU1szpw30peMqms5SkMFEfNCGBIc97QUI1CA9DHuSgHyoPPk
	odkrfCcvk4CqXNAySAauZCqjc5y98+u6n6wy6dL8BMrXpbf9WRyZtCEzTmTkudwq3BbEEEkaHFV
	qDx6jZS+9hOOHe5EKW31aQatgDxU+HnXRElM0SAPOPWtOYaiyNSq+qObSzUsG/eYFqK82h2yTA4
	jevmv+duIZcjOgNA=
X-Received: by 2002:a05:622a:1452:b0:52c:cc14:ff63 with SMTP id d75a77b69052e-52df5a7ae3amr44018401cf.37.1787307242922;
        Fri, 21 Aug 2026 03:14:02 -0700 (PDT)
X-Received: by 2002:a05:622a:1452:b0:52c:cc14:ff63 with SMTP id d75a77b69052e-52df5a7ae3amr44017741cf.37.1787307242360;
        Fri, 21 Aug 2026 03:14:02 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2458b096d9sm466632966b.20.2026.08.21.03.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 03:14:01 -0700 (PDT)
Date: Fri, 21 Aug 2026 13:13:58 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Sreeshankar K <sreeshankar0910@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, konradybcio@kernel.org,
        tglx@kernel.org, ulfh@kernel.org, bmasney@redhat.com, radu@rendec.net,
        lpieralisi@kernel.org, quic_tdas@quicinc.com, danila@mainlining.org,
        davidwronek@gmail.com, mani@kernel.org, robimarko@gmail.com,
        linux@gurudas.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v3 02/13] soc: qcom: socinfo: Add SM7250 SoC ID
Message-ID: <ftucic3bz5kxsamuzryt2l7xeikbbefetslatnx5xvbtvnle6t@adhwu7nxzabd>
References: <20260821081125.4522-1-sreeshankar0910@gmail.com>
 <20260821081125.4522-3-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821081125.4522-3-sreeshankar0910@gmail.com>
X-Proofpoint-GUID: DZlC9a9NrRdsukwAzAMAz4Qkw6G-AuHn
X-Proofpoint-ORIG-GUID: DZlC9a9NrRdsukwAzAMAz4Qkw6G-AuHn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA3NiBTYWx0ZWRfXzZGUL8fXVH+l
 jnSchQHnHNDD7q2MoOn8BKaJbiMxdcbpnTdaws4eR7PE8lGH9RZPj0Gqf9tz4PVFmpeGQrz6+GA
 4FDpb2H8Rf8NiWYwPtTSfbSJ9sCVcJU=
X-Authority-Analysis: v=2.4 cv=QJlYgALL c=1 sm=1 tr=0 ts=6a8824eb cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=rSoAExJED0QYgwLJ6goA:9 a=CjuIK1q_8ugA:10
 a=Z0LeWUw4VpMA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA3NiBTYWx0ZWRfXwysO9RLLf3cA
 h5U3j7z5N88JWUzhB4Cs5xp6ROZc/4Uspyr87AMVrIgHA67pmvnOqzWinvl4a/8Jbyfc8K3VL/l
 qiMcUfGRczlGzDzyOxo8abXBHfPXvxJm8wmiZuVIKsq88o1EgHlcNLM/RbrBG8ppNJOfCd7UZgy
 8DAeDHdE+FAMgqst/lQ+GxaJPVKXNADZk0Wzdr22MvpXoOYDODkvEYMoKkbkdDom4OY9fizVYUt
 ynGh5vIYvKnO535HECBYHi9VZrIfEUJGca9ZBEGBMtbQtBUjpEd9+Zeo97aE4NLke2F09N4xPF+
 qQpClOrqejzQJjYwLSdJ4To1dVTQWWcven0vBJymmABIoti++fJJBO813sK7MK2/BPyqed6Aj7q
 dAcfcuiAN9MuQYSBeQiBmktTQbtF2nKjZZ6n7cayYPC1GOSrtazvt753hGl6Qu/WfCu8K8oVBaQ
 tY92Cn2jOxB/rgaehLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210076

On 26-08-21 08:11:14, Sreeshankar K wrote:
> Add SoC ID for Qualcomm SM7250 SoC.
> 
> Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
