Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E1A49B203
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354063; cv=none; b=O9IN+ZTRResJrxXrfFcHc3knKDKqC/EcWJgjDB5C8/jWvAvvgbj+KHsyl8t58EYKIcDfnzFjWIugrsMMtApmK1G4mzXyWGJ+Iekdmd4vjxg1NN7im+n4t+QW4IWQRuOeBww20w/WOGHBqPt/h561TETwjS+7RlVZikpK9LN/h1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354063; c=relaxed/simple;
	bh=/QUngLdTNOOtgIoxZ7KDZT/Plou2zn5gNq8KePZMQ9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbp7gJVD0u1ailGgXYrNDtdY9PC9TTheXShZb3K5NZbWjGiDCOaJL/tXxFS79XgHO6i4Kk/EhMPr3fkdxGFxwk80exRjoXQ8lb3CSf6xGjjPUFq6EktsSPcjzjBUu3uhH3eCPNvBcWhjsRL8zDnrCNwkttAAqBmn6FSmW/O8arY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FeChHK68; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FeChHK68"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a5d8fd8d88so2215a12.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 06:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788354058; x=1788958858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yEZ5d2KkOrNmxmBhM5oZSL6QJl8W6QA5iE4fo15Znbo=;
        b=FeChHK68jrX2fy0/RHAB8iM/4G3lmGcUotOgDNHtCe0DUCPiCSV+nflbVs5S9Eum2f
         Js5/3C24gPP7zOrksPR+HWWJfym00ly4ekrBGidYXBkOQ8ypIOrGnh8PwKeJrYSv/mFz
         dAnrKV21DNi+l8zWALiaTUcH+M7whcrGwS40/18WLHk4bNFGkUNWCBWUTEf/UwP/9k+5
         4WMTrWO9tgOuyMawcyZKQdiwpWPAjRIg7Yeiolp6mieSw2EdTRoMrWjHsw43HeCKqvIe
         Au5BPLeYFJOZl+QKgiDYnKvLGuhdSgVxgntYxWWmezZu3Z6FK8gxALfZ1pXk8dqu6Caq
         NWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788354058; x=1788958858;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yEZ5d2KkOrNmxmBhM5oZSL6QJl8W6QA5iE4fo15Znbo=;
        b=AvmPXth0fW017QYnvHQIU8OPY3KTt0QwmojS72L019T1V8s8ke1FbA8NhJLBvT/uhG
         CsYahmzazyB+dZn1zR7ZHEdPz1P3xRH/C8ilEuS5DWwN37DUwTdIzfisQ+2Xrhzp3iAa
         1x0PHW3i0sCPafYqeUVHc8k8iNXnxECEOeG+mfFJNSCbZZvQupoqaI9Ry4rPLZgC4CU3
         w+dLheG3OJM0O5cKPL4GJ2ZCQ++oBdevxkgCrERJSModM9UyCyXzg0diFOGfc59surAV
         fcHjn9/831sccR+5SOn1kgeG6NV3HbRiJJYH1NcEQhRXjoKzscY8LQRVdVk4/xWeYDBZ
         Z2AQ==
X-Forwarded-Encrypted: i=1; AKwUvBwU/57UgZ42PJy8ND/IoMEL5byqZ0xW6jOs1VGXttQcy9e0jgybID7kefdWZ7z5yfWCXDxdGhsqzA==@vger.kernel.org
X-Gm-Message-State: AFuF++mKJT9Ff4ePblwxeWg8ck7ZOPP9C/u+oosJYBEPGH/T6W1+AlZ3
	6ETwcGS6ZuUdjPcOJIvGvyprn1WgP7dWKutNkcgd6X/50OorfJY/gM+P9CcFZBabPA==
X-Gm-Gg: AYBFou3Nw7NkiC/5/dhm9bwPGfgvuQxsNrrpWqd3Q+EFvEb22o9bxHF2HyTyrfPmPuO
	WZI4V3PhJ26gwzdxJpFTzKKlENw5nLRgzKrePgbiO7ZV+MYfDLd16S23OxZtrewuhmtBkBzSKvw
	/oXQbcItWsuA1EeRBRujZSBJY1AkMV/2/qViMOxyClSEurBbkedWljGkmGg9JeH9p1qzZL531/d
	SQDRbHAQcSklKrBUaCMsnfYIYtSH4Lq+0Xt3p0dNR+wJvp5XfSSHQSMoTQvhm1cg8A8w/cSewOf
	HfmItyBbL9/sjxlO3JwYiHgiostRhrBm4XY1Z1Ab+9Z/BVz8xVo61ZnoeloVsiTWBJE/p5w/jQg
	Ggg0GwPeK6YIP5QwXyLMNpIUsokoJ60ggIWWXL+Pu4d6ctC0nk5SOORR0yygwW+4kLcbFC/WBXa
	w6VIIdPBsennh8UToPrKCbGXDg9By2hkrfPUw5bTTyfH92uuIEj5BFb05863HQxdHlEvY8yWvL9
	3Gwk5VX1bLW3ekdJVYLl1KlluxbiQ==
X-Received: by 2002:aa7:cfcb:0:b0:6a6:8513:7e14 with SMTP id 4fb4d7f45d1cf-6a68db9c240mr6238a12.9.1788354057488;
        Wed, 02 Sep 2026 06:00:57 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d039c8d3sm129722866b.36.2026.09.02.06.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 06:00:55 -0700 (PDT)
Date: Wed, 2 Sep 2026 13:00:52 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/3] interconnect: qcom: x1e80100: enable QoS
 configuration
Message-ID: <apgeBNSiP01YfNcs@google.com>
References: <20260527-x1e80100_qos-v2-0-305c6539e6d2@oss.qualcomm.com>
 <20260527-x1e80100_qos-v2-2-305c6539e6d2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527-x1e80100_qos-v2-2-305c6539e6d2@oss.qualcomm.com>

On Wed, May 27, 2026 at 05:37:10AM +0000, Raviteja Laggyshetty wrote:
> Enable QoS configuration for master ports with predefined priority
> and urgency forwarding.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>

Testing with Linus's tree, this patch broke my Lenovo IdeaCenter Mini X
booting, the board resets very early during boot.
I see that the last patch (device tree) is missing from the tree, I
included it, but that doesn't fix it, disabling the driver also
doesn't help. I can boot again by reverting this patch.

I have my own device tree as my device is Purwa based [1]

[1] https://lore.kernel.org/all/20260429141815.827157-1-smostafa@google.com/

Thanks,
Mostafa

> ---
>  drivers/interconnect/qcom/x1e80100.c | 485 +++++++++++++++++++++++++++++++++++
>  1 file changed, 485 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/x1e80100.c b/drivers/interconnect/qcom/x1e80100.c
> index 2ba2823c7860..8075e0ff2059 100644
> --- a/drivers/interconnect/qcom/x1e80100.c
> +++ b/drivers/interconnect/qcom/x1e80100.c
> @@ -173,6 +173,13 @@ static struct qcom_icc_node qhm_qspi = {
>  	.name = "qhm_qspi",
>  	.channels = 1,
>  	.buswidth = 4,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0xb000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_a1noc_snoc },
>  };
> @@ -181,6 +188,13 @@ static struct qcom_icc_node qhm_qup1 = {
>  	.name = "qhm_qup1",
>  	.channels = 1,
>  	.buswidth = 4,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0xc000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_a1noc_snoc },
>  };
> @@ -189,6 +203,13 @@ static struct qcom_icc_node xm_sdc4 = {
>  	.name = "xm_sdc4",
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0xd000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_a1noc_snoc },
>  };
> @@ -197,6 +218,13 @@ static struct qcom_icc_node xm_ufs_mem = {
>  	.name = "xm_ufs_mem",
>  	.channels = 1,
>  	.buswidth = 16,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0xe000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_a1noc_snoc },
>  };
> @@ -205,6 +233,13 @@ static struct qcom_icc_node qhm_qup0 = {
>  	.name = "qhm_qup0",
>  	.channels = 1,
>  	.buswidth = 4,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x16000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_a2noc_snoc },
>  };
> @@ -213,6 +248,13 @@ static struct qcom_icc_node qhm_qup2 = {
>  	.name = "qhm_qup2",
>  	.channels = 1,
>  	.buswidth = 4,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x11000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_a2noc_snoc },
>  };
> @@ -221,6 +263,13 @@ static struct qcom_icc_node qxm_crypto = {
>  	.name = "qxm_crypto",
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x12000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_a2noc_snoc },
>  };
> @@ -237,6 +286,13 @@ static struct qcom_icc_node xm_qdss_etr_0 = {
>  	.name = "xm_qdss_etr_0",
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x13000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_a2noc_snoc },
>  };
> @@ -245,6 +301,13 @@ static struct qcom_icc_node xm_qdss_etr_1 = {
>  	.name = "xm_qdss_etr_1",
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x14000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_a2noc_snoc },
>  };
> @@ -253,6 +316,13 @@ static struct qcom_icc_node xm_sdc2 = {
>  	.name = "xm_sdc2",
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x15000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_a2noc_snoc },
>  };
> @@ -337,6 +407,13 @@ static struct qcom_icc_node alm_gpu_tcu = {
>  	.name = "alm_gpu_tcu",
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x271000 },
> +		.prio = 1,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 2,
>  	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
>  };
> @@ -345,6 +422,13 @@ static struct qcom_icc_node alm_pcie_tcu = {
>  	.name = "alm_pcie_tcu",
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x27d000 },
> +		.prio = 3,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 2,
>  	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
>  };
> @@ -353,6 +437,13 @@ static struct qcom_icc_node alm_sys_tcu = {
>  	.name = "alm_sys_tcu",
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x273000 },
> +		.prio = 6,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 2,
>  	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
>  };
> @@ -370,6 +461,13 @@ static struct qcom_icc_node qnm_gpu = {
>  	.name = "qnm_gpu",
>  	.channels = 4,
>  	.buswidth = 32,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 4,
> +		.port_offsets = { 0x51000, 0x58000, 0xd1000, 0xd8000 },
> +		.prio = 0,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 2,
>  	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
>  };
> @@ -378,6 +476,13 @@ static struct qcom_icc_node qnm_lpass = {
>  	.name = "qnm_lpass",
>  	.channels = 1,
>  	.buswidth = 16,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x275000 },
> +		.prio = 0,
> +		.urg_fwd = 1,
> +		.prio_fwd_disable = 0,
> +	},
>  	.num_links = 3,
>  	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
>  			&qns_pcie },
> @@ -387,6 +492,13 @@ static struct qcom_icc_node qnm_mnoc_hf = {
>  	.name = "qnm_mnoc_hf",
>  	.channels = 2,
>  	.buswidth = 32,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 2,
> +		.port_offsets = { 0x53000, 0xd3000 },
> +		.prio = 0,
> +		.urg_fwd = 1,
> +		.prio_fwd_disable = 0,
> +	},
>  	.num_links = 2,
>  	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
>  };
> @@ -395,6 +507,13 @@ static struct qcom_icc_node qnm_mnoc_sf = {
>  	.name = "qnm_mnoc_sf",
>  	.channels = 2,
>  	.buswidth = 32,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 2,
> +		.port_offsets = { 0x55000, 0xd5000 },
> +		.prio = 0,
> +		.urg_fwd = 1,
> +		.prio_fwd_disable = 0,
> +	},
>  	.num_links = 2,
>  	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
>  };
> @@ -403,6 +522,13 @@ static struct qcom_icc_node qnm_nsp_noc = {
>  	.name = "qnm_nsp_noc",
>  	.channels = 2,
>  	.buswidth = 32,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 2,
> +		.port_offsets = { 0x57000, 0xd7000 },
> +		.prio = 0,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 3,
>  	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
>  			&qns_pcie },
> @@ -412,6 +538,13 @@ static struct qcom_icc_node qnm_pcie = {
>  	.name = "qnm_pcie",
>  	.channels = 1,
>  	.buswidth = 64,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x277000 },
> +		.prio = 0,
> +		.urg_fwd = 1,
> +		.prio_fwd_disable = 0,
> +	},
>  	.num_links = 2,
>  	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
>  };
> @@ -420,6 +553,13 @@ static struct qcom_icc_node qnm_snoc_sf = {
>  	.name = "qnm_snoc_sf",
>  	.channels = 1,
>  	.buswidth = 64,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x27b000 },
> +		.prio = 2,
> +		.urg_fwd = 1,
> +		.prio_fwd_disable = 0,
> +	},
>  	.num_links = 3,
>  	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
>  			&qns_pcie },
> @@ -429,6 +569,13 @@ static struct qcom_icc_node xm_gic = {
>  	.name = "xm_gic",
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x27f000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_llcc },
>  };
> @@ -469,6 +616,13 @@ static struct qcom_icc_node qnm_av1_enc = {
>  	.name = "qnm_av1_enc",
>  	.channels = 1,
>  	.buswidth = 32,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x2f000 },
> +		.prio = 4,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_mem_noc_sf },
>  };
> @@ -477,6 +631,13 @@ static struct qcom_icc_node qnm_camnoc_hf = {
>  	.name = "qnm_camnoc_hf",
>  	.channels = 2,
>  	.buswidth = 32,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 2,
> +		.port_offsets = { 0x28000, 0x29000 },
> +		.prio = 0,
> +		.urg_fwd = 1,
> +		.prio_fwd_disable = 0,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_mem_noc_hf },
>  };
> @@ -485,6 +646,13 @@ static struct qcom_icc_node qnm_camnoc_icp = {
>  	.name = "qnm_camnoc_icp",
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x2a000 },
> +		.prio = 4,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_mem_noc_sf },
>  };
> @@ -493,6 +661,13 @@ static struct qcom_icc_node qnm_camnoc_sf = {
>  	.name = "qnm_camnoc_sf",
>  	.channels = 2,
>  	.buswidth = 32,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 2,
> +		.port_offsets = { 0x2b000, 0x2c000 },
> +		.prio = 0,
> +		.urg_fwd = 1,
> +		.prio_fwd_disable = 0,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_mem_noc_sf },
>  };
> @@ -501,6 +676,13 @@ static struct qcom_icc_node qnm_eva = {
>  	.name = "qnm_eva",
>  	.channels = 1,
>  	.buswidth = 32,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x33000 },
> +		.prio = 0,
> +		.urg_fwd = 1,
> +		.prio_fwd_disable = 0,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_mem_noc_sf },
>  };
> @@ -509,6 +691,13 @@ static struct qcom_icc_node qnm_mdp = {
>  	.name = "qnm_mdp",
>  	.channels = 2,
>  	.buswidth = 32,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 2,
> +		.port_offsets = { 0x2d000, 0x2e000 },
> +		.prio = 0,
> +		.urg_fwd = 1,
> +		.prio_fwd_disable = 0,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_mem_noc_hf },
>  };
> @@ -517,6 +706,13 @@ static struct qcom_icc_node qnm_video = {
>  	.name = "qnm_video",
>  	.channels = 2,
>  	.buswidth = 32,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 2,
> +		.port_offsets = { 0x30000, 0x31000 },
> +		.prio = 0,
> +		.urg_fwd = 1,
> +		.prio_fwd_disable = 0,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_mem_noc_sf },
>  };
> @@ -525,6 +721,13 @@ static struct qcom_icc_node qnm_video_cv_cpu = {
>  	.name = "qnm_video_cv_cpu",
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x32000 },
> +		.prio = 4,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_mem_noc_sf },
>  };
> @@ -533,6 +736,13 @@ static struct qcom_icc_node qnm_video_v_cpu = {
>  	.name = "qnm_video_v_cpu",
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x34000 },
> +		.prio = 4,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_mem_noc_sf },
>  };
> @@ -573,6 +783,13 @@ static struct qcom_icc_node xm_pcie_3 = {
>  	.name = "xm_pcie_3",
>  	.channels = 1,
>  	.buswidth = 64,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x7000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_pcie_north_gem_noc },
>  };
> @@ -581,6 +798,13 @@ static struct qcom_icc_node xm_pcie_4 = {
>  	.name = "xm_pcie_4",
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x8000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_pcie_north_gem_noc },
>  };
> @@ -589,6 +813,13 @@ static struct qcom_icc_node xm_pcie_5 = {
>  	.name = "xm_pcie_5",
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x9000 },
> +		.prio = 3,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_pcie_north_gem_noc },
>  };
> @@ -597,6 +828,13 @@ static struct qcom_icc_node xm_pcie_0 = {
>  	.name = "xm_pcie_0",
>  	.channels = 1,
>  	.buswidth = 16,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x9000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_pcie_south_gem_noc },
>  };
> @@ -605,6 +843,13 @@ static struct qcom_icc_node xm_pcie_1 = {
>  	.name = "xm_pcie_1",
>  	.channels = 1,
>  	.buswidth = 16,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0xa000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_pcie_south_gem_noc },
>  };
> @@ -613,6 +858,13 @@ static struct qcom_icc_node xm_pcie_2 = {
>  	.name = "xm_pcie_2",
>  	.channels = 1,
>  	.buswidth = 16,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0xb000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_pcie_south_gem_noc },
>  };
> @@ -621,6 +873,13 @@ static struct qcom_icc_node xm_pcie_6a = {
>  	.name = "xm_pcie_6a",
>  	.channels = 1,
>  	.buswidth = 32,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0xc000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_pcie_south_gem_noc },
>  };
> @@ -629,6 +888,13 @@ static struct qcom_icc_node xm_pcie_6b = {
>  	.name = "xm_pcie_6b",
>  	.channels = 1,
>  	.buswidth = 16,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0xd000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_pcie_south_gem_noc },
>  };
> @@ -653,6 +919,13 @@ static struct qcom_icc_node qnm_gic = {
>  	.name = "qnm_gic",
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x1c000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_gemnoc_sf },
>  };
> @@ -685,6 +958,13 @@ static struct qcom_icc_node xm_usb2_0 = {
>  	.name = "xm_usb2_0",
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x6000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_aggre_usb_north_snoc },
>  };
> @@ -693,6 +973,13 @@ static struct qcom_icc_node xm_usb3_mp = {
>  	.name = "xm_usb3_mp",
>  	.channels = 1,
>  	.buswidth = 16,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x7000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_aggre_usb_north_snoc },
>  };
> @@ -701,6 +988,13 @@ static struct qcom_icc_node xm_usb3_0 = {
>  	.name = "xm_usb3_0",
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0xa000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_aggre_usb_south_snoc },
>  };
> @@ -709,6 +1003,13 @@ static struct qcom_icc_node xm_usb3_1 = {
>  	.name = "xm_usb3_1",
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0xb000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_aggre_usb_south_snoc },
>  };
> @@ -717,6 +1018,13 @@ static struct qcom_icc_node xm_usb3_2 = {
>  	.name = "xm_usb3_2",
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0xc000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_aggre_usb_south_snoc },
>  };
> @@ -725,6 +1033,13 @@ static struct qcom_icc_node xm_usb4_0 = {
>  	.name = "xm_usb4_0",
>  	.channels = 1,
>  	.buswidth = 16,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0xd000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_aggre_usb_south_snoc },
>  };
> @@ -733,6 +1048,13 @@ static struct qcom_icc_node xm_usb4_1 = {
>  	.name = "xm_usb4_1",
>  	.channels = 1,
>  	.buswidth = 16,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0xe000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_aggre_usb_south_snoc },
>  };
> @@ -741,6 +1063,13 @@ static struct qcom_icc_node xm_usb4_2 = {
>  	.name = "xm_usb4_2",
>  	.channels = 1,
>  	.buswidth = 16,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0xf000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +		.prio_fwd_disable = 1,
> +	},
>  	.num_links = 1,
>  	.link_nodes = { &qns_aggre_usb_south_snoc },
>  };
> @@ -1466,11 +1795,21 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
>  	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
>  };
>  
> +static const struct regmap_config x1e80100_aggre1_noc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x14400,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc x1e80100_aggre1_noc = {
> +	.config = &x1e80100_aggre1_noc_regmap_config,
>  	.nodes = aggre1_noc_nodes,
>  	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
>  	.bcms = aggre1_noc_bcms,
>  	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
> +	.qos_requires_clocks = true,
>  };
>  
>  static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
> @@ -1488,7 +1827,16 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
>  	[SLAVE_A2NOC_SNOC] = &qns_a2noc_snoc,
>  };
>  
> +static const struct regmap_config x1e80100_aggre2_noc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x1c400,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc x1e80100_aggre2_noc = {
> +	.config = &x1e80100_aggre2_noc_regmap_config,
>  	.nodes = aggre2_noc_nodes,
>  	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
>  	.bcms = aggre2_noc_bcms,
> @@ -1573,7 +1921,16 @@ static struct qcom_icc_node * const cnoc_cfg_nodes[] = {
>  	[SLAVE_TCU] = &xs_sys_tcu_cfg,
>  };
>  
> +static const struct regmap_config x1e80100_cnoc_cfg_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x6600,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc x1e80100_cnoc_cfg = {
> +	.config = &x1e80100_cnoc_cfg_regmap_config,
>  	.nodes = cnoc_cfg_nodes,
>  	.num_nodes = ARRAY_SIZE(cnoc_cfg_nodes),
>  	.bcms = cnoc_cfg_bcms,
> @@ -1603,7 +1960,16 @@ static struct qcom_icc_node * const cnoc_main_nodes[] = {
>  	[SLAVE_PCIE_6B] = &xs_pcie_6b,
>  };
>  
> +static const struct regmap_config x1e80100_cnoc_main_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x14400,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc x1e80100_cnoc_main = {
> +	.config = &x1e80100_cnoc_main_regmap_config,
>  	.nodes = cnoc_main_nodes,
>  	.num_nodes = ARRAY_SIZE(cnoc_main_nodes),
>  	.bcms = cnoc_main_bcms,
> @@ -1633,7 +1999,16 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
>  	[SLAVE_MEM_NOC_PCIE_SNOC] = &qns_pcie,
>  };
>  
> +static const struct regmap_config x1e80100_gem_noc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x311200,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc x1e80100_gem_noc = {
> +	.config = &x1e80100_gem_noc_regmap_config,
>  	.nodes = gem_noc_nodes,
>  	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
>  	.bcms = gem_noc_bcms,
> @@ -1648,7 +2023,16 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
>  	[SLAVE_LPASS_GEM_NOC] = &qns_lpass_ag_noc_gemnoc,
>  };
>  
> +static const struct regmap_config x1e80100_lpass_ag_noc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0xe080,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc x1e80100_lpass_ag_noc = {
> +	.config = &x1e80100_lpass_ag_noc_regmap_config,
>  	.nodes = lpass_ag_noc_nodes,
>  	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
>  	.bcms = lpass_ag_noc_bcms,
> @@ -1664,7 +2048,16 @@ static struct qcom_icc_node * const lpass_lpiaon_noc_nodes[] = {
>  	[SLAVE_LPIAON_NOC_LPASS_AG_NOC] = &qns_lpass_aggnoc,
>  };
>  
> +static const struct regmap_config x1e80100_lpass_lpiaon_noc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x19080,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc x1e80100_lpass_lpiaon_noc = {
> +	.config = &x1e80100_lpass_lpiaon_noc_regmap_config,
>  	.nodes = lpass_lpiaon_noc_nodes,
>  	.num_nodes = ARRAY_SIZE(lpass_lpiaon_noc_nodes),
>  	.bcms = lpass_lpiaon_noc_bcms,
> @@ -1679,7 +2072,16 @@ static struct qcom_icc_node * const lpass_lpicx_noc_nodes[] = {
>  	[SLAVE_LPICX_NOC_LPIAON_NOC] = &qns_lpi_aon_noc,
>  };
>  
> +static const struct regmap_config x1e80100_lpass_lpicx_noc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x3a200,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc x1e80100_lpass_lpicx_noc = {
> +	.config = &x1e80100_lpass_lpicx_noc_regmap_config,
>  	.nodes = lpass_lpicx_noc_nodes,
>  	.num_nodes = ARRAY_SIZE(lpass_lpicx_noc_nodes),
>  	.bcms = lpass_lpicx_noc_bcms,
> @@ -1724,7 +2126,16 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
>  	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
>  };
>  
> +static const struct regmap_config x1e80100_mmss_noc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x5b800,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc x1e80100_mmss_noc = {
> +	.config = &x1e80100_mmss_noc_regmap_config,
>  	.nodes = mmss_noc_nodes,
>  	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
>  	.bcms = mmss_noc_bcms,
> @@ -1740,7 +2151,16 @@ static struct qcom_icc_node * const nsp_noc_nodes[] = {
>  	[SLAVE_CDSP_MEM_NOC] = &qns_nsp_gemnoc,
>  };
>  
> +static const struct regmap_config x1e80100_nsp_noc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0xe080,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc x1e80100_nsp_noc = {
> +	.config = &x1e80100_nsp_noc_regmap_config,
>  	.nodes = nsp_noc_nodes,
>  	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
>  	.bcms = nsp_noc_bcms,
> @@ -1757,7 +2177,16 @@ static struct qcom_icc_node * const pcie_center_anoc_nodes[] = {
>  	[SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_mem_noc,
>  };
>  
> +static const struct regmap_config x1e80100_pcie_center_anoc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x7000,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc x1e80100_pcie_center_anoc = {
> +	.config = &x1e80100_pcie_center_anoc_regmap_config,
>  	.nodes = pcie_center_anoc_nodes,
>  	.num_nodes = ARRAY_SIZE(pcie_center_anoc_nodes),
>  	.bcms = pcie_center_anoc_bcms,
> @@ -1774,7 +2203,16 @@ static struct qcom_icc_node * const pcie_north_anoc_nodes[] = {
>  	[SLAVE_PCIE_NORTH] = &qns_pcie_north_gem_noc,
>  };
>  
> +static const struct regmap_config x1e80100_pcie_north_anoc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x9080,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc x1e80100_pcie_north_anoc = {
> +	.config = &x1e80100_pcie_north_anoc_regmap_config,
>  	.nodes = pcie_north_anoc_nodes,
>  	.num_nodes = ARRAY_SIZE(pcie_north_anoc_nodes),
>  	.bcms = pcie_north_anoc_bcms,
> @@ -1793,7 +2231,16 @@ static struct qcom_icc_node * const pcie_south_anoc_nodes[] = {
>  	[SLAVE_PCIE_SOUTH] = &qns_pcie_south_gem_noc,
>  };
>  
> +static const struct regmap_config x1e80100_pcie_south_anoc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0xd080,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc x1e80100_pcie_south_anoc = {
> +	.config = &x1e80100_pcie_south_anoc_regmap_config,
>  	.nodes = pcie_south_anoc_nodes,
>  	.num_nodes = ARRAY_SIZE(pcie_south_anoc_nodes),
>  	.bcms = pcie_south_anoc_bcms,
> @@ -1815,7 +2262,16 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
>  	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
>  };
>  
> +static const struct regmap_config x1e80100_system_noc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x1c080,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc x1e80100_system_noc = {
> +	.config = &x1e80100_system_noc_regmap_config,
>  	.nodes = system_noc_nodes,
>  	.num_nodes = ARRAY_SIZE(system_noc_nodes),
>  	.bcms = system_noc_bcms,
> @@ -1831,7 +2287,16 @@ static struct qcom_icc_node * const usb_center_anoc_nodes[] = {
>  	[SLAVE_USB_NOC_SNOC] = &qns_aggre_usb_snoc,
>  };
>  
> +static const struct regmap_config x1e80100_usb_center_anoc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x8800,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc x1e80100_usb_center_anoc = {
> +	.config = &x1e80100_usb_center_anoc_regmap_config,
>  	.nodes = usb_center_anoc_nodes,
>  	.num_nodes = ARRAY_SIZE(usb_center_anoc_nodes),
>  	.bcms = usb_center_anoc_bcms,
> @@ -1847,11 +2312,21 @@ static struct qcom_icc_node * const usb_north_anoc_nodes[] = {
>  	[SLAVE_AGGRE_USB_NORTH] = &qns_aggre_usb_north_snoc,
>  };
>  
> +static const struct regmap_config x1e80100_usb_north_anoc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x7080,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc x1e80100_usb_north_anoc = {
> +	.config = &x1e80100_usb_north_anoc_regmap_config,
>  	.nodes = usb_north_anoc_nodes,
>  	.num_nodes = ARRAY_SIZE(usb_north_anoc_nodes),
>  	.bcms = usb_north_anoc_bcms,
>  	.num_bcms = ARRAY_SIZE(usb_north_anoc_bcms),
> +	.qos_requires_clocks = true,
>  };
>  
>  static struct qcom_icc_bcm * const usb_south_anoc_bcms[] = {
> @@ -1867,11 +2342,21 @@ static struct qcom_icc_node * const usb_south_anoc_nodes[] = {
>  	[SLAVE_AGGRE_USB_SOUTH] = &qns_aggre_usb_south_snoc,
>  };
>  
> +static const struct regmap_config x1e80100_usb_south_anoc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0xf080,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc x1e80100_usb_south_anoc = {
> +	.config = &x1e80100_usb_south_anoc_regmap_config,
>  	.nodes = usb_south_anoc_nodes,
>  	.num_nodes = ARRAY_SIZE(usb_south_anoc_nodes),
>  	.bcms = usb_south_anoc_bcms,
>  	.num_bcms = ARRAY_SIZE(usb_south_anoc_bcms),
> +	.qos_requires_clocks = true,
>  };
>  
>  static const struct of_device_id qnoc_of_match[] = {
> 
> -- 
> 2.43.0
> 
