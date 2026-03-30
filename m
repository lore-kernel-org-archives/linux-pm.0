Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00B23C1987
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868378; cv=none; b=QUoR/egDN5iJPAoEve/x9fqDsvt3dsIMGBOHS3aPNrlhOzAIMxAUC1Z8pEkCOA//BjV/AP1qVWA4JJ9ESD2mEfALQokBTgh/6jWgyzZlanst2vlUZqIVmPbUQTUJYxTnEmB+4uEZd5QNmVRiGv1QbUMo51MF2LTD2SIt5COenvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868378; c=relaxed/simple;
	bh=/UGje8GaqCfl8s3Nl18ShChaEnq8MiVcJhmu0ystF/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFf4h8/33wt5nG8LMh3nRNpsfznphCW2Rx5B/eyLZqMHaWMvEm/GTRkLHF9/0mbgAZbcgTBjlmptk2M4wQOkowXLY1qWTYFz9wwipwVvo1ehhD/hVW1E0x3fwjnWw+lZcxaPK5SBWNz5F9eXyD+oLp+glP2hSpCXnlM8ikF32V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ajAQIgeV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GIPO+lK0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ajAQIgeV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GIPO+lK0"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U78VWc4162050
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 10:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=naBSUHkKAKCMACXZFT6FV1ed
	GEHeKeWVrcQ1JFKftqU=; b=ajAQIgeVk54tpKrVTtaTHTpA2b+yyVcwJS7UnNjN
	ETsebGRvDrcc6Faodf/+54heyruYGhsoCGlkrNxgBk2rzxaslRjChcXEhhOxjpAe
	lyCkprvZ4+T7SUcNGVhP0vLxGWIB6VCtuuZHigz5y0dlKl7R8Qx5RDTPYmJBj3a3
	bracxCN8h0xDGxYzd/L56IKV1oAEjP2x1e9uxOvAtRTnTtCZGH05Vprd4a1gjtiH
	r7eOq/OVxXSTKrUXfGZcROrQh8/YuJwwMcFwcp07O+gMNP+vSLqUaDHZGTTAlFaM
	QMlq8oIfpm1orc+HFgsOn/eQ+YNktr/eYU2xtmfyFpPNNQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7mharw0v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 10:59:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-509044f54aaso137755301cf.1
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 03:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774868374; x=1775473174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=naBSUHkKAKCMACXZFT6FV1edGEHeKeWVrcQ1JFKftqU=;
        b=GIPO+lK0n8EKTBxnflrE0M7sSmqpL/rOY7QG2M6J+JC1X/SeT53ToKZUTXEx6nukYv
         8tkILfkU11ykFx36o0s7pc0RYoL23uTNo1KEMBs9sEHatseWmsNgE8YdghiEzP4OZQaS
         YuTksqWn50Mviv+OvV+2HQOUGQY1H5UZoTNqWYxkE/6ANXw2fsP7aK0jvsJiQ0MboI2I
         4BqTDBC/fquQ/rdvvV+Awfhw0owhdyg1bZGsegOX12yKw3XHBr6zwKG0lDwZVM17VXor
         mQI/AA/ChEHHYLXt02jzeSO1gxWJY2ldThltWj5LYgZ9UA/hmYaFx5+6yXVsOAnOisQE
         /tIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774868374; x=1775473174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naBSUHkKAKCMACXZFT6FV1edGEHeKeWVrcQ1JFKftqU=;
        b=G5s/OIQpBJKWoxBUu6JvHZA2HTjeRPxz7j2KT8ZPrf5fNVy2q0iikaii+L1e1bjlbL
         EeogntDZ7uZiWNkfT6bpdlQ0NeA1W9a70V3fCI9UYf8XEVdQu2NCeLuMv6s9kkrgWeeh
         941Lc2pWLkKAKcIKHaVUrGE330cTYKko8DV8baAN1PN63iQyjM/tUJAzX9MXo3n2R5LJ
         9xMP24kuxKN6A2Hi8IQlZwTnklOqzKBHTkR95Ht7lmMXeOV3bQcMVTydxYTJ2bDYOsOH
         JhZuCmL+8J501CVpHAPneRLLmcyG4BC5RBCDb4k19hjwenbv8oe+h3+Ho6NLIH2izMSB
         KHhw==
X-Forwarded-Encrypted: i=1; AJvYcCUe4UsymBKKFAZF+UxkLUqQTNOG8humvQ6hSvLwmt/Evft2IHJTPhDixpQwPbBDk+g1oLP4AjSt8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvY6Hqu5pEl4iwxoSCwvZBcxW8gTlt2ZthhMAVyK2Pu9TxWy+D
	dYOAcLeqddCRrokaXmgRG76UmdoLZ4w8oQKQlucrR18Rviqqq6RveMK8U74O7AzBCBM4oR5xlpp
	o9v0OoiLWYBg2efGndA3IXB8vFZEPRRo5iri3gtdB9MdC47Vt0PWg81Me50Qpwg==
X-Gm-Gg: ATEYQzxhXy4wXKNX17P73p4CBIHRUbXu5FCwcwQIBlH8mEuxOtLHrL7sEGnv4dPSic+
	B5YO1gwEroennFMg8XEh6WGeLjSbTmrRAWnr8FQ2US55Shngfpe7rs4vfpmDimGzNbOzSX5sJCd
	Yg2qS5B+pZzBP4SIWsF15SNQi8Yz9f21JSAQ3FqgvKwG+XvjXEWnwUFBg0PxtEzOfhhceFJkqHh
	thucVEftSZtsnPtzbPpU8A/UsTRrPPI0NKHsDePEf2qF2sKWa977SYcPICxfoVZ/6lc/91JHGX1
	hEVlMmZFJN1Z/dq/OxdCTgzAtMEKiLJeS9VdbhYrhjdgh0tTELBxRdXj7n/sChj9qITaM5AG/QC
	V6IafOTa0CPvH57V0cgo+zioAXLT/v8vEoRn6m1fXWCb02QEwK5rW/N2ZsYh+Uw0XjMlhIgoQ6m
	vcrdeO4MJcWd/5/4rvftoCa8mfP31xNy9/obg=
X-Received: by 2002:ac8:5f12:0:b0:50b:1932:c9c with SMTP id d75a77b69052e-50ba38f1d37mr161734321cf.40.1774868374092;
        Mon, 30 Mar 2026 03:59:34 -0700 (PDT)
X-Received: by 2002:ac8:5f12:0:b0:50b:1932:c9c with SMTP id d75a77b69052e-50ba38f1d37mr161734041cf.40.1774868373645;
        Mon, 30 Mar 2026 03:59:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2b144f16asm1625621e87.55.2026.03.30.03.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 03:59:32 -0700 (PDT)
Date: Mon, 30 Mar 2026 13:59:30 +0300
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
Message-ID: <lnumerwlyvmbdkwum64js46tbnvpxjrdrouhq3vybuwto4st3g@7xzr52e3samd>
References: <20260328014041.83777-1-mailingradian@gmail.com>
 <20260328014041.83777-4-mailingradian@gmail.com>
 <a3rrkgvkc4zxcq5oqvws23lyjy6dinlmfgp34wzguvdxdxig5f@25atyxc7zabm>
 <91af3fa3-85ba-44b8-8725-032f77c846de@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91af3fa3-85ba-44b8-8725-032f77c846de@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4NiBTYWx0ZWRfX0uzBaEgzVlZL
 gfvn1b7dRtk/qu3R8D1oLe2R7y9nyZxjZER9O8xYStaensjPV/rJlgmHMBvzngymoyvhbN+R+Yg
 Pp5AGq3AsCJNWHv9MAwLw5fAakqy7wIHxus2qkhlN/utjs5vghOTTvlXWXUz86a1rrn2kIEdLGA
 yq9UHWPDALuLPEB+JoOQkK9mrEEqgxG2J0md0b6oYD4nQ5N3zSnwzHRY3CaHAAr7ozZXrqaeqK4
 r7IaRdd5TvEaJkjSRqXmPnxgS+fifD6GHwxuJOYXQSAi813Ma7EwGEVmSowLTa24aYBGzb+Tpoa
 /RnWO85xn+oz5qhrehhNRqYe4DSp641bhu7+rr6oPxZkP3D+TcE5lokaRWc7kXKxA0gt+iLafn1
 mq7eOflNrxik8mm3hnGgq3OZsq2fEqFfGiJn8bZqdD2b0RtqXpPkX2Q2gCyNXuNrIxQMj0bVt57
 /IKPxBpStPPKdVldwnw==
X-Authority-Analysis: v=2.4 cv=Fbw6BZ+6 c=1 sm=1 tr=0 ts=69ca5796 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8
 a=5ehM0snh6k5ecHPHWgwA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: S_hb9P-S02wlxQrHN0rVxsSH_XB5WtBL
X-Proofpoint-GUID: S_hb9P-S02wlxQrHN0rVxsSH_XB5WtBL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015
 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300086

On Mon, Mar 30, 2026 at 12:32:29PM +0200, Konrad Dybcio wrote:
> On 3/29/26 12:44 PM, Dmitry Baryshkov wrote:
> > On Fri, Mar 27, 2026 at 09:40:40PM -0400, Richard Acayan wrote:
> >> The LMh driver was made for Qualcomm SoCs with clusters of 4 CPUs, but
> >> some SoCs divide the CPUs into different sizes of clusters. In SDM670,
> >> the first 6 CPUs are in the little cluster and the next 2 are in the big
> >> cluster. Define the clusters in the match data and define the different
> >> cluster configuration for SDM670.
> >>
> >> Currently, this only supports 8 CPUs and tolerates linking to any CPU in
> >> the cluster.
> >>
> >> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> >> ---
> >>  drivers/thermal/qcom/lmh.c | 69 +++++++++++++++++++++++++++++++-------
> >>  1 file changed, 56 insertions(+), 13 deletions(-)
> >>
> >> +static const struct lmh_soc_data sdm670_lmh_data = {
> >> +	.enable_algos = true,
> >> +	.node_ids = {
> >> +		LMH_CLUSTER0_NODE_ID,
> >> +		LMH_CLUSTER0_NODE_ID,
> >> +		LMH_CLUSTER0_NODE_ID,
> >> +		LMH_CLUSTER0_NODE_ID,
> >> +		LMH_CLUSTER0_NODE_ID,
> >> +		LMH_CLUSTER0_NODE_ID,
> >> +		LMH_CLUSTER1_NODE_ID,
> >> +		LMH_CLUSTER1_NODE_ID,
> >> +	},
> >> +};
> >> +
> >> +static const struct lmh_soc_data sdm845_lmh_data = {
> >> +	.enable_algos = true,
> >> +	.node_ids = {
> >> +		LMH_CLUSTER0_NODE_ID,
> >> +		LMH_CLUSTER0_NODE_ID,
> >> +		LMH_CLUSTER0_NODE_ID,
> >> +		LMH_CLUSTER0_NODE_ID,
> >> +		LMH_CLUSTER1_NODE_ID,
> >> +		LMH_CLUSTER1_NODE_ID,
> >> +		LMH_CLUSTER1_NODE_ID,
> >> +		LMH_CLUSTER1_NODE_ID,
> >> +	},
> >> +};
> > 
> > These tables made me wonder, can we determine this information from the
> > DT? For example, by reading the qcom,freq-domain property. But...
> > 
> >> +
> >> +static const struct lmh_soc_data sm8150_lmh_data = {
> >> +	.enable_algos = false,
> >> +	.node_ids = {
> >> +		LMH_CLUSTER0_NODE_ID,
> >> +		LMH_CLUSTER0_NODE_ID,
> >> +		LMH_CLUSTER0_NODE_ID,
> >> +		LMH_CLUSTER0_NODE_ID,
> >> +		LMH_CLUSTER1_NODE_ID,
> >> +		LMH_CLUSTER1_NODE_ID,
> >> +		LMH_CLUSTER1_NODE_ID,
> >> +		LMH_CLUSTER1_NODE_ID,
> >> +	},
> >> +};
> > 
> > ... this might be problematic, unless this entry is broken. On SM8150 we
> > have three freq domains, but up to now we were programming two clustern
> > nodes. Of course it is possible to define that node_id is 0 for freq
> > domain 0 and 1 for domains 1 and 2.
> 
> The third cluster situation on 8150 is not super good - we e.g. only have
> a single LMH irq that's shared between the big and prime cores. That
> was fixed with later SoCs (which is why it's not wired up in the DT today)

Thanks!

Anyway, from your point of view, would it be better to define mappings
in the driver (like it's done with this patch) or parse the DT?

> Funnily enough the bigger 8180 didn't have that problem because it only had
> 2 freq domains

Yep.

-- 
With best wishes
Dmitry
