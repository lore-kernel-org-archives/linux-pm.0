Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932F7481FDF
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787161924; cv=none; b=GoQO3eS6Vk4VphLebCw8bqMzt9ZoggX/Jl/Tz4IuALPbVafYCwoV1QE/1d4z7bVhKfRl9B5LM46ByW+K69QI4iTMwAhlf+vxAaCIT2GKQLgxM3feFKcE09ewGpQ7hwNUb7MPb0LEFOP1ZRzd6WPB2n5DdqfjJu/GGrxBwXtf4ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787161924; c=relaxed/simple;
	bh=+ye0fbf2jaEySpBT5AxCjqcY1JeeNCmPBWPyZEfpvOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izL/BYjVU9IM0mxYmX2BXmBH2fC7Vsz6K8kxGHz2a2tOcqJWCesKp1hOtVUvSoOGbtGA4i6qISNJhzVRCtao0nnd67exbMf3g89w0LDAhIFqOCUsd13kfHaeUV+iieGFKFtQjtTG2gO7TSICwpm7NBIuSmWLaQRs7XC9o+dq9K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PdFf05gO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ORInZjWj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PdFf05gO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ORInZjWj"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JF1loQ537272
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 17:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=r46oSPj/cje0TXqWu8AeKdhG
	VBdwzC0IRLo83jjaZco=; b=PdFf05gOrAZ9aW4YQUfvTmE9gfefoyctjkRJz1Jk
	Rs0Ovtnik4hRzgJVLW1u3X9PicY1Ezxx1MEJGx8OoHT7xq7sCa42uNQG3ajfrn0e
	U+eGXKzGz8RGznYC93NLHzrptZLTsWyP21FE+c4FzT1ngcDAnHZiZt1rCeoIbJVU
	DxKCWha4YupZnradZHaP3bJyD+pA9JHS6ypP+t7OPaSv2ZHulqsf6HnzdeTjcZyr
	hmEPt13+WBoWkbj+dq+wIcYzOpfWYuZWUOGMHlhkVJRDNaqtMZIGKNlvyc+BM9fo
	OQSafZd10pckbkXg0Y/N2br3bO0GvIp+pPHcet0uMkSeHQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5es58vuq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 17:52:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9308eafb465so270443285a.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 10:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787161920; x=1787766720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r46oSPj/cje0TXqWu8AeKdhGVBdwzC0IRLo83jjaZco=;
        b=ORInZjWjLJoUrbbKs8kqfviIaGzx/tFJCu14J1wTfWeCer1DMWkRl37NxhwdwzanTk
         N51VpH6flJLUciOcf1oV5UedUzKxl8i8VD+mOaw8UzIS17PojZatML3IIM19nHhDka3o
         yzYs5R7wUf+3bfxJ1GgpYfS+v+7l4nweBnMUvIGEQJSA9oVtlgleHXEiR/7/2c9FOaw0
         R4MdWQheXtdRWmsATpq/vuEnejA5v1dZjg456CTog4eEcS51u6la/wHF+dXvsq83Qb7K
         gKQ3pChVLr+6taxQE9WX3qAaStk9U6rjQBVRPmTpHjhDXLSko90VSocRteKfZl7f4xNM
         X3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787161920; x=1787766720;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r46oSPj/cje0TXqWu8AeKdhGVBdwzC0IRLo83jjaZco=;
        b=bAMPOT7V9fw+PvevciC5KqgY7xMMLFWwPuh4TwUSCfGSopNHmzBXHxkOJVXdZlMdfu
         VDOdVzs/NB4ObQ8nEMnO6yboRTl1qxUekRReNIkgqMUYwbbulyCeVVDEbO6b0W0ZHjb2
         S4PEsH0n/rDaLw0trcoSNFcbXyKHauA4XZ2VmyUL8xMmyMB1hJgNUwexzsXIvn48RHZN
         hey40+wwn6T3AZ/IR0nvI43ErLpbRG5eQ3gncjdyuyhevQ/Rm7aTpSIZ3zbLaFw9pY1K
         eccwXhHFE6+5vRzAEpmMdWwe/iBNYTni0V8aYc8mFH3GAPdBEDg+jTOKE97KZoe1Ddjw
         ZIxg==
X-Forwarded-Encrypted: i=1; AHgh+RobMk3xisFfhU5xAxQJ7WK9ORIlE9+CjkB++VqBOjG/23Ws9oGYvTkxy6x6oVXZMUTeGmVOFFqiqA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8hEdofIXzc875BvohosKpeRgdb6p98qjOeHG3P6art/sYtFeB
	SSbC3kymHDrfpfv7RvQrhXc3B4gAJrezJc2TM8eAXg5mRTLRj6GnbW63NW4K1ak9gTUhs6Oyf0I
	yDg+C4cWHnbwTUbOmPiSvLZxEkLqLv0h4NfjdlCVC9BT/UQsV0jgf2nsleyo36Q==
X-Gm-Gg: AR+sD10cnhZKLzTRfcJU7SOXdNKW0Njeh2JdIAqkeid+TOeaE8gZON5AnlPRg0y3/Ze
	WcTSuESZU2+/OMGzH/4myyFXaUwnMT8a/UV8myZOXfSRL0GmnoI26GgWdJIlqyo6VxgE/Fic5YT
	kFklgP+hgnwHNCwoA4TzqlJky8GRFzHt5Qy/xTwQ+wZcUj/BO2LhPCYxhxsa6Kx4Xx34E2wreZJ
	2QljLVyZ7dbG5YEUeykPVMs4a7CuEj/jalQzluzVsUXYaVplnVrB08edgXM3ofG7dEtMOmh43vZ
	rcLsKCyfef8IGlKw4/GJ9vkjY/bmMImQoTyYZb5f/3eBzyFhQcCJyk2ZniRwJqxJ3KWUG7lWdZM
	OK6I8YwMlhOfO9IE=
X-Received: by 2002:a05:620a:408c:b0:930:b5e8:a40e with SMTP id af79cd13be357-9371e2cbda0mr630361485a.23.1787161920217;
        Wed, 19 Aug 2026 10:52:00 -0700 (PDT)
X-Received: by 2002:a05:620a:408c:b0:930:b5e8:a40e with SMTP id af79cd13be357-9371e2cbda0mr630353085a.23.1787161919507;
        Wed, 19 Aug 2026 10:51:59 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9e805a4sm84320805e9.4.2026.08.19.10.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 10:51:58 -0700 (PDT)
Date: Wed, 19 Aug 2026 20:51:56 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulfh@kernel.org>
Subject: Re: [RFC PATCH 1/3] pmdomain: core: Allow a non-CPU device in a CPU
 PM domain to do power on
Message-ID: <gkeug6e7thc4j4drwjreirzgtdq747vj3u7jsulslbhru6qjjb@s6ypnqwi3szh>
References: <20260819151457.256959-1-ulf.hansson@oss.qualcomm.com>
 <20260819151457.256959-2-ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819151457.256959-2-ulf.hansson@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: UzFOGJJmkKoZ5fgX_qX8XZe45j3jtGQJ
X-Proofpoint-GUID: UzFOGJJmkKoZ5fgX_qX8XZe45j3jtGQJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEzOCBTYWx0ZWRfX0jys0VwejMhC
 mr1ax/ub5j8GmljdEEN7MTUf8WN+gxpJOMLq6mM46Q5EjuQIKod9lsG7Ljs3O0ZMr3E9swfJO1F
 t8yExRW6wQwmT9nnLK/n9G5bXTMEwFM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEzOCBTYWx0ZWRfX9tjtTcxwU9R4
 /aI9dxayPAHDyPIOuYVTcWGVWpeWYlMUm72j+netu08yrhhz+iOp6wuzvQBM+VqcHsMybTqVdR0
 mxC7RguJy0x2eJkI93IbaaCIZzVUYC/dIdvjKzlwJmusduwSzyvWrfcNIJhc/ZppR9/L7ol4jJJ
 RdIuOQGs9rKE1r/P9U+0EYJCXF35vEn1Ou9bUdFOEPaPovCYsMUfwHnmdKOr8EfA6QK0DcM9jp3
 OrTTENI+TX9I8H1ns7yxLbQ+39OLG5dfk6jNMudNgqu/0eVkV56pQeI/1zolkfcjh7Bn/rmwSH5
 ZDX77gUPvILcpr02Wav2HlyJ4q0r8++dFtJJSMnvxN8ozZBkmblCvskCjCX3VqHu8C3NZOaYYnm
 V2feGc6BgVySnkNHSoHZZsYlGT15HnuAIadojWrM/zVv2ycGhRzQBXsWQJuAoNh6a2lEL64g5Fa
 OC+OCVunDpkY2njPZJA==
X-Authority-Analysis: v=2.4 cv=Oc+oyBTY c=1 sm=1 tr=0 ts=6a85ed40 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=u8BtVuMVLpZXKRMe:21 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=3nN8jbBxjk3cumxNoKQA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190138

On 26-08-19 17:14:51, Ulf Hansson wrote:
> From: Ulf Hansson <ulfh@kernel.org>
> 
> A driver for a non-CPU device that is attached to a CPU PM domain (the
> genpd has the GENPD_FLAG_CPU_DOMAIN configuration set), is currently not
> able to power on the PM domain. More precisely, to power on a CPU PM domain
> one of its corresponding CPUs needs to be woken up if they are idle.
> 
> The current support for a non-CPU device is that its driver can only
> prevent an already powered on CPU PM domain from being powered off. This
> leads to problems for a driver while probing its device or when it needs to
> call pm_runtime_get_sync() to turn on the power for it. From the driver
> point of view it looks like it all works fine, but when accessing the
> device it may end up with various errors as the device may not be fully
> powered on.
> 
> To fix the behavior for these types of devices, let's adjust the behaviour
> in genpd_power_on() to wake up an idle CPU that belongs to it, in cases
> when it's needed.
> 
> Link: https://lore.kernel.org/all/CAPx+jO-sCierYj8jnoKQHckJG16dOBxnNrsZVYO=38R2cLV8nw@mail.gmail.com/
> Signed-off-by: Ulf Hansson <ulfh@kernel.org>
> ---
>  drivers/pmdomain/core.c | 80 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 75 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 842c4169e290..7345c06f1d55 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -10,6 +10,7 @@
>  #include <linux/idr.h>
>  #include <linux/kernel.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
> @@ -19,11 +20,14 @@
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/sched.h>
> +#include <linux/smp.h>
>  #include <linux/suspend.h>
>  #include <linux/export.h>
>  #include <linux/cpu.h>
>  #include <linux/debugfs.h>
>  
> +#include <trace/events/ipi.h>
> +
>  /* Provides a unique ID for each genpd device */
>  static DEFINE_IDA(genpd_ida);
>  
> @@ -32,7 +36,9 @@ static const struct bus_type genpd_provider_bus_type = {
>  	.name		= "genpd_provider",
>  };
>  
> -#define GENPD_RETRY_MAX_MS	250		/* Approximate */
> +#define GENPD_RETRY_MAX_MS		250		/* Approximate */
> +#define GENPD_CPU_ON_POLL_PERIOD_US	100		/* 100us */
> +#define GENPD_CPU_ON_TIMEOUT_US		5000000		/* 5s */
>  
>  #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)		\
>  ({								\
> @@ -1027,15 +1033,75 @@ static void genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>  	}
>  }
>  
> +static bool genpd_check_status_on(struct generic_pm_domain *genpd)
> +{
> +	bool is_on;
> +
> +	genpd_lock(genpd);
> +	is_on = genpd_status_on(genpd);
> +	genpd_unlock(genpd);
> +
> +	return is_on;
> +}

I'd change the genpd_status_on() to genpd_is_on_unlocked().

And then this one would be just genpd_is_on().

The rest looks good, so:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
