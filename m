Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DB63D4138
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774879505; cv=none; b=SJiqawyutUIje+e1j7SaA2VLTNLD/N+cbS09LpzJGsFrGHKnRIFCEiD0W+vF7t9co+gwAszeufx++0+J78bEwxTwFSg5HDHw3/NqOCLF1NrL7taVGOfrzjc2RCM5W7Da3BC8gxsmrYziYZZIJQD0LtrVsurBzxS4hLM+qIq7vQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774879505; c=relaxed/simple;
	bh=48/qrQs61V8fjBPqUdLGA6lQrMANhT9CD90vSe0REr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOq0kT/oj/oNlmWnF76rIOn3pQolvg6RfuS++Q6rzpPWOeiWLeUbrhRXLTSFy54UF/hUTiQJ8iW5TAL6mptMfHjLPgKgJGS3vGGJRUUty/f9eYyh0X4W6n8cOH0eyIgjM8nms9sBvmwf19l4tEEVkPfHElZpvmDC92pR0VQbQ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FwnYT7DE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W8dQUc9y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FwnYT7DE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W8dQUc9y"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UDlENN2458439
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 14:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8syFKyi3bpTnjZ19/6UIlpN5
	2L3dCeVxpSJlcpbfkkI=; b=FwnYT7DEFc1hXi9pfrt84Ielx2ucLFOP/oxSHEeB
	093up/12r65sm8MpRYvgWnx5+PJcQB/6CFWxyt8R5B5QtYFXmElN/qALyOAJHZim
	GeY9CZ8CrZPnpedp/Um+t44ifIyXXDDXLKjyprvsZocllOjrZcXOqDC5ZD37OJTh
	zzpTbODoCwhGGJJ6g2OqaRVhfgnSLB/hJKX0i3E5GAnws/fXn/z1V07tsST81oEO
	StL1ZBiUqgL6aG8FvtKejEaz7mva/sMPEG0LZHsqwDNDbLBCkTQOZk6xXVTbO42c
	03tf+68EeLMRhp3FyVEbHd9vh4OhsVk95VadCHkvLs/3JA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7nnmsd01-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 14:05:02 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6052a9f1901so2623275137.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 07:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774879501; x=1775484301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8syFKyi3bpTnjZ19/6UIlpN52L3dCeVxpSJlcpbfkkI=;
        b=W8dQUc9yA3Z38VkeopdxWvaKlGqneDrgS2cKpR8ty8fie8/USllfn67wh6FKCOYq+z
         M971uEeB07hOUrx2Tu9dhAZNA4PlRG80yg9gr22a85oXcjpaHUUTqebboZAtV4ZxyRyB
         AHGHn4SPfhmmtt22y540dMS25HrL6bBhosa2MPXKULeIl6DT74I4Q1rBFyxupsmv66z2
         /ThCeiwIogklbBwOy5UAukulBVMayd7ZeWvPH6hDQssQ1Em4q906Ga6Jmt5xaJdCSdoL
         xxYLP78rcARUWTwpfr4WnLvYbA/K0/MnURQnutMBSaitKkM/NTo4b8c4b/qiEyPhIoN3
         eumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774879501; x=1775484301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8syFKyi3bpTnjZ19/6UIlpN52L3dCeVxpSJlcpbfkkI=;
        b=d05alJLXOAR8E7zDRWfopLni+mbUT5Q4jAorjfrPwxOjSlAXbsTs9cV+z7pN2ogtAX
         rKNQ9fITcG1DAzr5+dUzLQeO2zbgh11K89pexNAAOS+DPHCnPJ/HobBdZSOpvH2iNJHt
         BYbvrhHMPW0K+EEHyHEq8M3VuLCZDm51U8gebQ6Dd38LNUBRZ+GFx3yn6on8tN45wl2c
         8sYeCSzCsz1OaW8N8sDdIWU351pTNArnKUx1NUnau7H+QUgF+Hr/8qJfuiF+eGohXBqb
         WHUctuEWkCQIj5N6GWZDNricDqNCbYVoYankT1XQRgOP7+yrzhWGOc8qJmYT5spQh54p
         r5+w==
X-Forwarded-Encrypted: i=1; AJvYcCW5KooXHwaFGPznsW96Ycm9h74P39rntBG4DHhf1XhlbhJiMHybA7dkFC5gsSeO8UMcYTk2tnsiEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwY67YK4R6rRzXSMPWDRaahHMAantmnPQGSRL9n+QEBCEDmLPb2
	zr+pIlzHb4x//uLkQxSJbVvONWkMUYKLHrXWntebWeWd7vcSm4DUPJ+r6N5cyAyBsJwwW3CEor2
	zIeQkJ1dxTxMzmIFAIm9wod9T5LMJy3yHxuWjp5dHUr4jxbZVON7jgC64jKJBFw==
X-Gm-Gg: ATEYQzyjHogyM2y3MXRfDEEWVLm5OqP2aDsgqhsyOhesG8GWpZvSrYkzcAigMwQFAbE
	a7Ly09Tv/ysRMjbi7oZcOUdhPa+KDCJBjkYQ0lXMJSF0bAHmoqiRDTgkRQIzh11vb5/6XnIKgKw
	vw5GKZg/jPmtDax7X1uqxD4g29JRW++C/VVAIqAIqHxDi0hyIelLm939SnZhQWMdBppOjzrjFOC
	mqT8zeshK1vsKsI0wxIoGUCXwI/LB6mvBdx4WMPQwghKde1zvR3IGYzUChPn4rQiDOryvy8e+ST
	8W7Fu0EfJsTNHomzx8cf9HOiEgOWxp+q7SIFShxQtJhvnvbSPR+dQ9KgsWsOilTwSm62BvmQXi7
	59ybeLQACvBFNnH/3XOjLof94AQlkW8Or7Vb6HCRbmAiq733rwxqCifhTAT5H5ayPcPqDgBQ1xf
	SVVrs4SI2LdLOUKsFRu3YWKwi3oqzX//eNUO0=
X-Received: by 2002:a05:6102:3048:b0:5f5:3739:100d with SMTP id ada2fe7eead31-604e43bcd92mr5222506137.0.1774879500936;
        Mon, 30 Mar 2026 07:05:00 -0700 (PDT)
X-Received: by 2002:a05:6102:3048:b0:5f5:3739:100d with SMTP id ada2fe7eead31-604e43bcd92mr5222429137.0.1774879500367;
        Mon, 30 Mar 2026 07:05:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38c838e02c5sm15252301fa.36.2026.03.30.07.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:04:58 -0700 (PDT)
Date: Mon, 30 Mar 2026 17:04:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Richard Acayan <mailingradian@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
Message-ID: <tvbooogbe2vsosyvhvowain3lon2t72kbesszvf2lqceur5gaa@e2gfyc4447dx>
References: <20260328014041.83777-1-mailingradian@gmail.com>
 <20260328014041.83777-4-mailingradian@gmail.com>
 <a3rrkgvkc4zxcq5oqvws23lyjy6dinlmfgp34wzguvdxdxig5f@25atyxc7zabm>
 <91af3fa3-85ba-44b8-8725-032f77c846de@oss.qualcomm.com>
 <lnumerwlyvmbdkwum64js46tbnvpxjrdrouhq3vybuwto4st3g@7xzr52e3samd>
 <1fcecede-16f0-4ce1-b76c-32f569cb5e41@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fcecede-16f0-4ce1-b76c-32f569cb5e41@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDEwOSBTYWx0ZWRfXzMDKtAPMhmPh
 bU37QuDC4rOVCVMzbwx2SsDLu+VLFOZQyrMjl9eLrN2iq1G7AQDg2QAM5WkOZm8VlUMEMGvO22W
 zXozSVEqLFOvTtBWk1SaEIsNCoCvgYfr1MkqSERhSwLeEf/OhFak9+qcT1PpbTBQ0jcEZv6OOgN
 d2jfhtgZGZXoTI/UBnFjv6HtiiytC9NcbEHCoa9QynBcwYUO/QFmyHTkbwbLCbfmQkZrPn7aELI
 CFknPljZOrco75Hk9potDXrc6oHCcUCq0tta9CpWPRANSaKD7RtMN1JPZcWDxkEYSEgs0YrfvBI
 1Wc0JV0ql2jfTxmk2bLMe/cI6LJ8Mi9vRkp+jQIpgMTgUCYSFqnVLAn06D22gdFmNAkTY0yjTZo
 QD/tTDQsLBa/CM9FMp3dojunA4aEtdCl7k4hoxCVXctG/izWcZOa/Ux0M/pFblBYOJvJYhuHFkd
 k85+q3oc9pn4A9+9fqA==
X-Authority-Analysis: v=2.4 cv=M4FA6iws c=1 sm=1 tr=0 ts=69ca830e cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8
 a=khJxtxLVEzNENsewWo0A:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: DRHI_hnB2xWAy5ruJihl3N4NroigfpuY
X-Proofpoint-ORIG-GUID: DRHI_hnB2xWAy5ruJihl3N4NroigfpuY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300109

On Mon, Mar 30, 2026 at 03:50:12PM +0200, Konrad Dybcio wrote:
> On 3/30/26 12:59 PM, Dmitry Baryshkov wrote:
> > On Mon, Mar 30, 2026 at 12:32:29PM +0200, Konrad Dybcio wrote:
> >> On 3/29/26 12:44 PM, Dmitry Baryshkov wrote:
> >>> On Fri, Mar 27, 2026 at 09:40:40PM -0400, Richard Acayan wrote:
> >>>> The LMh driver was made for Qualcomm SoCs with clusters of 4 CPUs, but
> >>>> some SoCs divide the CPUs into different sizes of clusters. In SDM670,
> >>>> the first 6 CPUs are in the little cluster and the next 2 are in the big
> >>>> cluster. Define the clusters in the match data and define the different
> >>>> cluster configuration for SDM670.
> >>>>
> >>>> Currently, this only supports 8 CPUs and tolerates linking to any CPU in
> >>>> the cluster.
> >>>>
> >>>> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> >>>> ---
> >>>>  drivers/thermal/qcom/lmh.c | 69 +++++++++++++++++++++++++++++++-------
> >>>>  1 file changed, 56 insertions(+), 13 deletions(-)
> >>>>
> >>>> +static const struct lmh_soc_data sdm670_lmh_data = {
> >>>> +	.enable_algos = true,
> >>>> +	.node_ids = {
> >>>> +		LMH_CLUSTER0_NODE_ID,
> >>>> +		LMH_CLUSTER0_NODE_ID,
> >>>> +		LMH_CLUSTER0_NODE_ID,
> >>>> +		LMH_CLUSTER0_NODE_ID,
> >>>> +		LMH_CLUSTER0_NODE_ID,
> >>>> +		LMH_CLUSTER0_NODE_ID,
> >>>> +		LMH_CLUSTER1_NODE_ID,
> >>>> +		LMH_CLUSTER1_NODE_ID,
> >>>> +	},
> >>>> +};
> >>>> +
> >>>> +static const struct lmh_soc_data sdm845_lmh_data = {
> >>>> +	.enable_algos = true,
> >>>> +	.node_ids = {
> >>>> +		LMH_CLUSTER0_NODE_ID,
> >>>> +		LMH_CLUSTER0_NODE_ID,
> >>>> +		LMH_CLUSTER0_NODE_ID,
> >>>> +		LMH_CLUSTER0_NODE_ID,
> >>>> +		LMH_CLUSTER1_NODE_ID,
> >>>> +		LMH_CLUSTER1_NODE_ID,
> >>>> +		LMH_CLUSTER1_NODE_ID,
> >>>> +		LMH_CLUSTER1_NODE_ID,
> >>>> +	},
> >>>> +};
> >>>
> >>> These tables made me wonder, can we determine this information from the
> >>> DT? For example, by reading the qcom,freq-domain property. But...
> >>>
> >>>> +
> >>>> +static const struct lmh_soc_data sm8150_lmh_data = {
> >>>> +	.enable_algos = false,
> >>>> +	.node_ids = {
> >>>> +		LMH_CLUSTER0_NODE_ID,
> >>>> +		LMH_CLUSTER0_NODE_ID,
> >>>> +		LMH_CLUSTER0_NODE_ID,
> >>>> +		LMH_CLUSTER0_NODE_ID,
> >>>> +		LMH_CLUSTER1_NODE_ID,
> >>>> +		LMH_CLUSTER1_NODE_ID,
> >>>> +		LMH_CLUSTER1_NODE_ID,
> >>>> +		LMH_CLUSTER1_NODE_ID,
> >>>> +	},
> >>>> +};
> >>>
> >>> ... this might be problematic, unless this entry is broken. On SM8150 we
> >>> have three freq domains, but up to now we were programming two clustern
> >>> nodes. Of course it is possible to define that node_id is 0 for freq
> >>> domain 0 and 1 for domains 1 and 2.
> >>
> >> The third cluster situation on 8150 is not super good - we e.g. only have
> >> a single LMH irq that's shared between the big and prime cores. That
> >> was fixed with later SoCs (which is why it's not wired up in the DT today)
> > 
> > Thanks!
> > 
> > Anyway, from your point of view, would it be better to define mappings
> > in the driver (like it's done with this patch) or parse the DT?
> 
> Well, we can spend a lot of time trying to be smart about it and handle
> the odd edge case, or add a simple comparison!

:-)

Then let's go with your suggestion of 'first core from second cluster'.

-- 
With best wishes
Dmitry
