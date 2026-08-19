Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D173148F856
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160163; cv=none; b=OHHFF669jn7xw/UBlWnNhfyFKE0P7HBjV4FCJQMuYL+lUj29CwObVpKb/8etJZLXlm5mWCqbnaa6GCqe5goLsPM1/U2ZgJC+bOK8N0EufvJApBZri9tOZQfUaqq8DeCxo54VOPQAQKm7tEkA9tLKUPWoPGFs9eQ4wjRKpE1sPqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160163; c=relaxed/simple;
	bh=EY7RSwNSeIT7mH4disIxvPAUHycExqR6LMhi8P3Jk+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUmsFsKTpUj5kq66gfMMcaaWwNuiU9A6sYoN/fu7M6F9kSNgV1AcB29omICn+GlHa4cWnq3+5Wcd+dzBvEG3GNVEtsG4SFasaRy3Zd1A/gZkH3rC3yh7+UdyzPOLraCtkAk2e5BfzVtevWBKpLmbDdbu3NS8AafHnxfSKIxJ2iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cZ0F1/By; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ctPJnref; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cZ0F1/By";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ctPJnref"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JF1iwZ963741
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 17:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jO6s6YGETHqwguCbYVPIx8R+
	l5bNUFBH5w4gTE3He1A=; b=cZ0F1/ByNwr4WLboIBPzOoQrbAhqn6idiUHbz00A
	UGlOMHFd4shQX9MAaFiLJPHuLcSUgeutjnIsmzrHkvwWx8OP2eRhkfCe6ATq8cm4
	+xjpS362J7lhwf6pNT9j4Zv34y/bhsMWN1DAnbLNxUQR5BcJTCuf4KDxUTdn0an4
	hTdDLW9dBMjFD7u7vP7hYCeFJLJEjM2zhu8e/0HMydKLrYTCbhuVRGye0WB639Xd
	tE9lx0U9xh3QnJHpBEtb4B4Zj3uGuHwBTsA+T5xNfe4fpm8kPbqF9WwsAwEafPO3
	i/OoLtEtQq4Zh+Y2Gj+bn0uvVcPcMIvG9jUqJ/GCxXJSWA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5es3grn2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 17:22:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-936cadb0e8bso114280685a.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 10:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787160140; x=1787764940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jO6s6YGETHqwguCbYVPIx8R+l5bNUFBH5w4gTE3He1A=;
        b=ctPJnrefo7bNaOVeV5qBBw1zguiR6lGWCTrQUyi07ul16RdvlUt4mznfKT0icfipTB
         h60sjFQjg/vS0MXEYLktmhj427sTIOsGF3fW2BpxK4OU759M+alsgNi60Vb1zjS/VVbG
         F+60tfNF/LFk5FxMs1EJ4bnnzQqZ1a/zWjJkeyYxJuFnG3tfZWcbdk1UlRHYWXOx0un1
         15KdsuwxC9pvzsKNYPJZH2wy9TI7VwcI0jzeQy557VuKvzR1STygXbgI4DvqB5SyXKC2
         V01bCHwx4gB9/oxC4ffLRkMbPPHjhPzEx9i4ZVXuWF1jPfTGFOt3NylBFmbD5CsoqP0W
         K89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787160140; x=1787764940;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jO6s6YGETHqwguCbYVPIx8R+l5bNUFBH5w4gTE3He1A=;
        b=l4zfwfQTZpcCdNLWkak2BXbhjFn1ZyUa5B99f51+vPYRs0nlO8/HL0ShbqB1Ichr+u
         XuEW2DE3VuRLrRecOGEIR89JHTXbzmh2dQRcdZt2xaMjVttIL3MuhEqfZQGoXa/BYBOt
         MK7eBZw7QYO0K6kccLxVc5rPIqCoWe9UvKcKA4JGiWtKQbDw4E750Hu0YWdekEOP9bdF
         EtIa2NhIgLrK553OXRTWUAcProRP0AkNqD6TXgXbNOZ+SDivuRz9m2L3Kvg3lpyDkSe9
         I6fiM8tXfCrQrC6JayF3VuT8bt8UFMWP4m8j4d8kKWIVAxUfupj0YB5ChraqQ8a6CGc0
         Np6w==
X-Forwarded-Encrypted: i=1; AHgh+Rq5PKFl7hWz4pfv72QGTw/MvrAhepU+RpERKYl3FvWJXb59RIvtwOOLJZqBY7auRT1S+aiBFzzL2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ2YY50jA0XJyaRa8x1zLkGflI1jce57OJ2LD2eSE5lqXWqIxz
	ATAYIlzW7zY9ACiUSURtswCJlkD75XKVKLopCIHSAUI1iD1E1q36gZ8A8VJ4nynuInPDim9rfNn
	xBfwu3y0A8yh6eZZGw/oUXBrKa+6h4i8Vc80q2wSTDhdym6APVEDeSWjEKXAvNg==
X-Gm-Gg: AR+sD11lEUrRylDYgDygQGzEyKUZT90v2PAqLF7QFj2Uefd9yvBWnDAZeiYgr8MUIOr
	JymB0ldjXe5HpIBUJLKS8jwRAdUgrsBAm3O3ABG4nQgbqa8nI86TnFcuLLbML3+CTyjwtZzjIzE
	3dlYZDoawpafRN+haSXZkn58lKlMRGVFIobEncysSCwd91+vUmCSkcYsA0YF3JShy9cZUTiI2bq
	2MiH6GVWrRk/Xy6UrBengzJamcIVWk7LELji+g1d02/5PLMShuqwybUqx0XAd0ec8Hi+/vyETIW
	qxcAjCS3FAZLu/xtdL/MGH6np9HPBo2IaTGzh51aAHXs98dOHJ5EROSCPr1/i3xQ/9Jf1nHEQ9j
	CL/Ls/gY9DuL3Z68=
X-Received: by 2002:a05:620a:29d4:b0:930:f2c8:d9ea with SMTP id af79cd13be357-9371e701145mr583461885a.41.1787160140294;
        Wed, 19 Aug 2026 10:22:20 -0700 (PDT)
X-Received: by 2002:a05:620a:29d4:b0:930:f2c8:d9ea with SMTP id af79cd13be357-9371e701145mr583454085a.41.1787160139537;
        Wed, 19 Aug 2026 10:22:19 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14514d5sm7119427f8f.10.2026.08.19.10.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 10:22:18 -0700 (PDT)
Date: Wed, 19 Aug 2026 20:22:17 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Ulf Hansson <ulfh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] pmdomain: core: add genpd_for_each_child() helper
Message-ID: <ii3gxwilznalii332hlaztbevzyegoeqfq4nugpuzs6gqyq3ms@rv4x3qdlj6i7>
References: <20260819-topic-lpm-pmdomain-device-constraints-v4-0-7ceb095f5474@baylibre.com>
 <20260819-topic-lpm-pmdomain-device-constraints-v4-3-7ceb095f5474@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819-topic-lpm-pmdomain-device-constraints-v4-3-7ceb095f5474@baylibre.com>
X-Authority-Analysis: v=2.4 cv=UIrt2ify c=1 sm=1 tr=0 ts=6a85e64d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=0vb0xtBZJQso0sRTBO4A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEzNSBTYWx0ZWRfX82Sd9hSEDA2Y
 JcmeAggCryc3vfcSeiI2FiHjooC6J7adeCuXFSwIZzPG7gMui96odEb/W2acNVUyBpcNc6/ZPwi
 XuX4fnK5hE9zbKht3Y+un9BwGM02mHC8LMtaTuShLH1ADQ7SRM4MGX0kVCE5niIFD0CPqNLCIdg
 XVK7CKNJ4hWXm8bVKQ4QfWYGIj4CrmCgjyE6s+/6Pc2lPqxrDJkc9fembcKJreTp0d+yjzKn27H
 AOhO9CKC6S+GnywYGHRBfHQdj5LADjzpTF1g1cgzgQq6XSG3eHMaiAFK7D/BK967PnGch8Z8pyn
 W+RfiJrCjvxqboH1Jmr8Mmeoqgpct3tJGU8QhH2x5eSZO5nalt0Y9hCIxcCDQT8utMutJre3CRu
 RCLK27kXQiVR3I+yYg/B47cTtGJP9vAJ8exASO32b7lfL9Ms6507TTOiKKWFmENM6+klP0sZVHk
 FZ0lm5Jxk5HYF3Qv+zw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEzNSBTYWx0ZWRfXxzjpw6FomUZK
 t2tGufQJ95c0EE5lWH3GoFivMFACHVpMZc/KGv0uPkRr/opY2B7cYPO4rsp2444i2ct4fED3rIV
 EvX/7/toDku6X1eNs9qyqDX034vQ2oA=
X-Proofpoint-ORIG-GUID: UUDinA_P092vpJWwgL3NGJl0Y4eZk-aO
X-Proofpoint-GUID: UUDinA_P092vpJWwgL3NGJl0Y4eZk-aO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190135

On 26-08-19 10:08:38, Kevin Hilman (TI) wrote:
> Add a new internal helper function genpd_for_each_child() that recursively
> iterates over all devices in a PM domain and its child domains (subdomains).
> This helper is useful for governors and other core PM domain code that needs
> to examine or apply operations to all devices within a domain hierarchy.
> 
> The function takes a callback that is invoked for each device, and supports
> early termination if the callback returns a non-zero value.
> 
> The helper is defined in a new internal header drivers/pmdomain/core.h and
> implemented in drivers/pmdomain/core.c, making it available to other PM
> domain subsystem components.
> 
> The first user of this helper is the cpu_system_power_down_ok() governor
> function, which uses it to check device QoS latency constraints across the
> entire domain hierarchy.
> 
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
> ---
>  drivers/pmdomain/core.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pmdomain/core.h | 17 +++++++++++++++++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 842c4169e290..ff27369d9a97 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -24,6 +24,8 @@
>  #include <linux/cpu.h>
>  #include <linux/debugfs.h>
>  
> +#include "core.h"
> +
>  /* Provides a unique ID for each genpd device */
>  static DEFINE_IDA(genpd_ida);
>  
> @@ -276,6 +278,49 @@ static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
>  	smp_mb__after_atomic();
>  }
>  
> +/**
> + * genpd_for_each_child - Recursively iterate over all devices
> + *                        in a PM domain and its subdomains.
> + * @genpd: PM domain to iterate over.
> + * @fn: Callback function to invoke for each device.
> + * @data: Data to pass to the callback function.
> + *
> + * This function recursively walks through all devices in the given PM domain
> + * and all devices in its child PM domains (subdomains). For each device found,
> + * the callback function @fn is invoked with the device and @data as arguments.
> + *
> + * Note: this function is inteded for use by the core and governors,
> + * not for pmdomain providers.
> + *
> + * Returns: 0 on success, or the first non-zero value returned by @fn.
> + */
> +int genpd_for_each_child(struct generic_pm_domain *genpd,
> +			 int (*fn)(struct device *dev, void *data),
> +			 void *data)
> +{
> +	struct pm_domain_data *pdd;
> +	struct gpd_link *link;
> +	int ret;
> +
> +	/* First, iterate over all devices in this domain */
> +	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
> +		ret = fn(pdd->dev, data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Then, recursively iterate over all child domains (subdomains) */
> +	list_for_each_entry(link, &genpd->parent_links, parent_node) {
> +		struct generic_pm_domain *child_pd = link->child;
> +
> +		ret = genpd_for_each_child(child_pd, fn, data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

This is usefull, I like it.

> +
>  #ifdef CONFIG_DEBUG_FS
>  static struct dentry *genpd_debugfs_dir;
>  
> diff --git a/drivers/pmdomain/core.h b/drivers/pmdomain/core.h
> new file mode 100644
> index 000000000000..7061891d31fb
> --- /dev/null
> +++ b/drivers/pmdomain/core.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Internal header for PM domain core
> + *
> + * Copyright (C) 2011 Rafael J. Wysocki <rjw@sisk.pl>, Renesas Electronics Corp.
> + */

Year and author are wrong.

With this addressed:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
