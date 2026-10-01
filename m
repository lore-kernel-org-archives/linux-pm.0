Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791E337C0EB
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 01:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790819847; cv=none; b=raJBGoWqGccHuxQ537rlg/nIpkvm82/mz3FFEpnOHeMuihjrwBc22t5N10BiUvM0KVI+Y+0gAiKq5LThRnKW+8t6kNKBHsCmzHeh57u/B98K+wA7+NeXkICSRSIOHJ/yvPuz50kPVc5Dkxb6oU3986YCP78+QHqYY8Fc1l3AdnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790819847; c=relaxed/simple;
	bh=dc23h0DAzeahU2YQjWsf1UtM8H72KH4uKWQYNEb1GJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKfjk2fqfHTrndV1i++/ZFE+GxzpjR9F8tET4dZs11I0wEApi5dG5JTLt7wl9WGc0UtQyxhB1xrUm8WUEtQIgkhuGVZuu2XBFWn7hXS9s42M1jdrCuSsLIVFz87gFOSPrx3rA/6mz08Pa8o3Qmjt1GI9zA+q1slcrp5dp2bdMwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S50noS3a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RdTtCf8Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S50noS3a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RdTtCf8Y"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6910k1vB2012358
	for <linux-pm@vger.kernel.org>; Thu, 1 Oct 2026 01:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uoVV9AMom/z0Z5MeMxOVZrJn
	fnZMhEF3YGoQPtJPVgc=; b=S50noS3aCk+5o+zo395zaz85DH4dKB/5pNEcwflo
	sOOZu7Jf9Zf4L6f2HIIt2NIOJgaC39THUFZ5YJQLhQ4ZIA/9usI4JfGvnfqc0Asx
	0xG7xi6Lyw8j7eoN2QXXDGurmww8SjMNhIrwf1pzzU6/MY9DDL0mYa/WUwzLZHFG
	g4UtuhHxGQaXLZgYMOuLaVke4M013uQinV4XXShCcGSj49b9X216TkJlJfrLcDEf
	RYCTetkmOpdbhFL5iw41bl7O5SOFH9aLRSRNyUAwQctTN9BoBgAK6UMluDs70FK+
	CdnQXuFv/CLkLPfdszF6bWnckNNhN3iGN6k+73VZ+TnnsQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0yh83xf5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 01 Oct 2026 01:57:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93a082c014aso95960985a.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 18:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790819844; x=1791424644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uoVV9AMom/z0Z5MeMxOVZrJnfnZMhEF3YGoQPtJPVgc=;
        b=RdTtCf8Y0gCMTi3CCOhxajajy9HPxQ81IvqKEpyi/4EMVmf05cFaYCSS57aQpREdq2
         gLzTB9sftrV+A+D/S1MEbNh5vHAPSWv1QQt9Ig99eGu27ueQbguFfCvmheJ6oIN1UrkL
         c5/V6cpQNgKTlyS1cUwHQvliJItUpIhxJYR9+zHPVg8gl7WrrU07q3n4UpGFkna42/7M
         h1Undrdr3mRwz2K4Jf1T0UgjTMEP6PAHk3fy7dZv5Q5ZWLnUIBzHli/6elPN//XmtfQR
         UP4WSc+GgGje/JPODj+wSDAJZAx1ntMB0V9q4lR6PaFYWS9PQVYXwOm5y/rR4g/GKxdG
         qBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790819844; x=1791424644;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uoVV9AMom/z0Z5MeMxOVZrJnfnZMhEF3YGoQPtJPVgc=;
        b=GVAL2rPpMsU6k2vZxCBduvVGNeqhFXsg1GNTLqCH4OlrXIZlH3m7enZYLoSEh1XSYi
         DPiiWtulMrtm4Ok3LUosuRqG2+9+DG7UgYejL6pMzmw51qwjfHybnyfWBqtj+mO6c8bw
         1AS+aVt2kAAOrUA2OEhaZ0SNQ1F9SLWcXI2tVBIdxkj+xgZB/pvuRO21NWCkOwdE2Mj1
         zFxgqS4P1vY2EU5XOArHApvsxlHlqdvMz+q6OldnsNwfS/DM02zCrCIYiWNPmoh7iZAN
         oxXf6wcHO9BO33Xvo/5YCE6Bncx8vUh+VZzptdbn2wKpSrBJ3/I9EBlZf10vG7qi2u6i
         PI+w==
X-Forwarded-Encrypted: i=1; AKwUvByGQBVZFkqB6wElZpdcjIcF1/TFkF+X61CTA8ncryZ5E2IqyXXOhalMQ4iBPUXW4W/R+WC+Cphu2g==@vger.kernel.org
X-Gm-Message-State: AFuF++ll0C7RsIGUxTXHSicxt9J5gMgCYkXyG9oJQXmHNVMAZ+THp1No
	+XJ8VHFIkkhjF4woxKlvm3xnx0mhlwLB2o/On4tD4GVAR5Qf41oXyH4RgteqkzfZCRuJk8gf9tX
	U3j6KTPeXa987P1W2e7CBPIV+VAKpiitNTQ2Z5eku1ApvN2MnTfEdrnGvrQncFQ==
X-Gm-Gg: AYBFou1x5M1bojL2KnPhmf9gaMwGaQNwDjhLYL8BlSpPATT8M3Z+6RXLkOrSW0yJ1L9
	fa5w/5TiIw/crf5Jp66c9smVNqT5YXfN9Apa0rUw4fgjKYcrUXRIxA1h9GNk7QnLdZy9csAa6Mb
	tfGX6RWBi9OZjKPhUTU9tgdTUjWo+94CyS5/LZZYR4Q1C2M7Fa1zEVP8k7gBmDu2nzOSf+9KDJO
	97GVMMzXS6oqmdMhzJWfICpwy901WnltA+87glyXLiBAjpio0iFy451Db0e0fo2gQafJMeD4JjQ
	fB3wTkB2qVl7W78ddgqVDka21nrbJvo0rvlvETb0qaeNMv3ZUpt2PRHm4KUwLOBhXeGm42XH9XA
	0tHwxcVDio+ODFf8YWO4UxtzGQxkil00L3pyWoDAKY2X6qBHd4mPwd2pzxnxXissuwr716XYaQ/
	HhelR2z+Kd1IM8
X-Received: by 2002:a05:620a:269a:b0:93b:d7a4:9d49 with SMTP id af79cd13be357-93cb5a1468amr287210085a.28.1790819843409;
        Wed, 30 Sep 2026 18:57:23 -0700 (PDT)
X-Received: by 2002:a05:620a:269a:b0:93b:d7a4:9d49 with SMTP id af79cd13be357-93cb5a1468amr287207785a.28.1790819842965;
        Wed, 30 Sep 2026 18:57:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a77192ee13sm12526111fa.30.2026.09.30.18.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 18:57:21 -0700 (PDT)
Date: Thu, 1 Oct 2026 04:57:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: muzafferkadir@mainlining.org
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v3 13/19] drm: msm: mdp5: Add MDP5 configuration for
 MSM8952
Message-ID: <diibislcaubtwwazmkjsv4y732har2eskayle5mxpdkr5npana@uckh2yzblzxp>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-13-b96fd3fe298b@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-msm8952-initial-support-v3-13-b96fd3fe298b@mainlining.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAwNyBTYWx0ZWRfX/QeLp/XeQXSd
 989c1/Y57ddX0LFs2XZG8pzvceMcRJCqZUoag064H5zPgZPdR7K5wgp6lDIimn8rgAcvKKU8lKT
 4ds58wmdieDlOGlj8dfHOWj2/Vg9YKDzLwn31/fzIxfHcQwoISyYYu/5xdanELEIRoubp4d4Me3
 Jq9ZMbf1Sb3G5aX1/3gQxE1efkrPIetkAIhh2X/QLsnLBGWNetu2xNvyp+yVLjxsH4MZAtGP3LE
 ZVITxqxkCBcZb+QyEKCxzeCYG7fuhU6py6Zv4B8Jr8wSt/ThbWWlWCUB/RLhR8dZznlnz8tF/e9
 Oo2GMmUYHCwYN8uK4i7mP9YsdA86eZSKW5qyNYqMHvVDQv+GfebcFsSpJTblojFo8ac+JmPLLnj
 e9KO4+HVKqYi5K6wHIgl2LkNKSvTNDlOMZpYeQRYX0qS/8gGV+BcuK9twIUjphFRVmmkiAQm9oG
 X3k3jkmEuW7G1ymJoWA==
X-Proofpoint-ORIG-GUID: G_OI80cdgeu9Nykp3xQIwGR4Gj_G24Q7
X-Authority-Analysis: v=2.4 cv=NedzRGD4 c=1 sm=1 tr=0 ts=6abdbe04 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=OuZLqq7tAAAA:8
 a=EUspDBNiAAAA:8 a=YvXxkWmvim7rQlE-Do8A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: G_OI80cdgeu9Nykp3xQIwGR4Gj_G24Q7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAwNyBTYWx0ZWRfX6f3Z+J5D5glX
 tQYnLHvl5wIm4CQAHE520ly0v3WwFipjCN9oMTJ+Z0XRjbN6pQq/huVnRNyRA7eRBseYgj7XpyJ
 UG+x8Gf84C91nesRdbiZh5Iyj/XN6VY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010007

On Mon, Sep 21, 2026 at 09:19:04PM +0300, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add the mdp5_cfg_hw entry for MDP5 version v1.12 found on MSM8952.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c | 81 ++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> +	.pipe_cursor = {
> +		.count = 1,
> +		.base = { 0x440DC },
> +		.caps = MDP_PIPE_CAP_HFLIP	|
> +			MDP_PIPE_CAP_VFLIP	|
> +			MDP_PIPE_CAP_SW_PIX_EXT	|
> +			MDP_PIPE_CAP_CURSOR	|
> +			0,
> +	},

PIPE_CURSOR is invalid and should be dropped. I'll do it while applying.

With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry
