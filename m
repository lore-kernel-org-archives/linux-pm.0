Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795692796;
	b=LAFVasEUwfkE6ZA1mRfebADSDfqcxgrU8G+zOkUuzLr70313Ao1rU7j6wUUaJYC8NOXP
	 ZIU0XtL/e0mC3s6myVmbtoJfK2El+Br9UAQLuphZK5vWi0dPsWEzDa5yWI3s76D3ebDlN
	 QTUQHqB8L/p3RpaliL06l1OXG+CDPxieq9fzOJM3oZC9XKbvD+2TthTFlGdCaV+0yoK+G
	 wJCVUAXGxz5Y4IRa/fzRpZpXTi4KAKKBbpnISaXYEPANfdOuLI7989wjHtxbcEEv7Lk5Z
	 CRZzJLxt2czmDhHRhwsAu+Fcn1sQlp/DvRROMiP1Fr3dUVtQaCdInFVZjq3oLT7T9zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692796;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=yzojCckQ+xllk0Py6ZM8C/6T/sfzNuCOCrHEJWMWxtE=;
	b=WbAnEg9lI0XFukFABQN1Ty0qwq2Fry1PRtr405wahSW8Yka65uyBg5Z+BeTWJ1mmzcsb
	 b4h49OgGo6nKP+0oF02MVkge1J8pL2PLDPHTAHI9M/H1M9JuZUM50X5OfNSU/dgZt+GWe
	 tuFNHzGbGjqpupQcEqM9e7Pk+fPnFX7phSnmPt5GqJ9CzB84ERDBVFHOx6yHryj5LJ65E
	 Q/pOuKzAdyRN+fzEsHXHJczIcyEIfJObU8xtnQQ/XaSpEqbVcv4BrT8tT9PyWK0pVWu8s
	 usYWIlXYWf+OdXN5k2GBLATXU1HjlrKnTDUHhRcD+7a9dfz8LcT/PjeiPRWcNZ6wlVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PqVJGybq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C6990AdE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6381F606A339
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 11:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6381F606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PqVJGybq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C6990AdE
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBVNGA4128231
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 11:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yzojCckQ+xllk0Py6ZM8C/6T/sfzNuCOCrHEJWMWxtE=; b=PqVJGybqKLFI6hDt
	VO4m5YKjtmV1AzjsX3B1Zbr9cjc5CS7Ow6DYPvnEVAzENBwwDXshzJQOcnhxuN/C
	KzwV50fP+KHiMsjc/KnSV2EupXcI1r2Ny+HFyPGaFUo5/EQOKfaU+Ks0E8Otugnv
	GOoz8Dx9RJ3u3yRwwJkuDKjRL5RK8FIo6hRq9kEVWl0OdbPl/fZZn6IfAepdbGry
	6X0s78HPuoUn04bPTlUTfXlgKCJJEKhC8MAzEAPn+PYva0FkeXZw2UjIxkapLyGD
	k7Vl/+z4d/VZdCKoU8GKPUlKQIG6vBI3jx4phqEcC8yATegHOf+X3Ogax/ckd1w/
	aS1L1Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j62vaur03-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 11:33:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b42c3dba96so8011254a91.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 03:33:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795692794; cv=none;
        d=google.com; s=arc-20260327;
        b=qRjyPm4XuxaTJbM80voY/s1XtgyjXvuHDN788kZRpRC24Fmj04iPUDo9HNNg+7soV4
         w2wDzcd8AQ6/uj47xO5QvFdIFHlv4n1kawKYkqWdOo7a+KkrP6sjT/VsECtXqyycj03A
         chyfffeUBrZn28ynuRH6+6p3p0EsrDyB+zB1DDyaqB50V5eKWygHB7RFLOAOghBB+DuF
         +DOnVnzWyV+4S6lF+y2mWm/WAPjhypdR5BdeZq+vOkdDG5Rlfr/hW7wSjXYH/i4s0Ve7
         PL5AOXtDsJPtitiQp3muubRsmgptF/jLWwfkA9o4JwfVqfMGwi5UYVD8EYSrCl51ollt
         WIEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yzojCckQ+xllk0Py6ZM8C/6T/sfzNuCOCrHEJWMWxtE=;
        fh=g93N5lfcmt4cNm7vypkuviD2CIbslzs3gy/PSpOz9xs=;
        b=G92nHhI0oIiH0p9sVP7P4VACrNko0vYIdK5WX9H6N/1IC+wGVv8bdKiGbje1wlcebQ
         IWIkNCjr8zLPdAVb5Xqfasr+jO8TUiSsTtFCmRNFCTTlaiE5SQmvtT8qgq+ttC5WM5+o
         OSn9hwcrBv2faN2+C5UCjvavMt//UVbro5Wogy5LcKw8lD4I1frlBwrYinOaEhqNKHoz
         /6EqZk+khrLWX4OCbNxlFJen2z3xrbmBIqP+NZck4XkATDLM9LvUB4y3x+FrmmpC19JQ
         754U3zOxC+5fv1IwQUDyhEmzwIfBlGmCqSgOVCa5JA8N3VATxKioj9BNsdfd720/UkmP
         LVOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795692794; x=1796297594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yzojCckQ+xllk0Py6ZM8C/6T/sfzNuCOCrHEJWMWxtE=;
        b=C6990AdE7M41+gy5+Dmo6JtLpOGdmmpVEyQtfs+vV6/PtktLqS7V/6ttpFrrrpZiOO
         AvspAopmgRwdUJzvcZ2V04yOX+T9j6SlvSG8D2zlvsnTfr3VDjDnBdmBGgKkQwE+SVkj
         pSz/jcnMu4FZqhboSBvnksaNZ/Cn9F5BoFt7u5FLBB/LtmG+FbZEKp/rnFL616Y9fPGQ
         v90EDvv1+l/PR+NZYazPmWFcCfyoF6lxlH8IRnPv1au4brzgozJtN0LQvn+Cp0xXuNVh
         wjc4yBlbzIHhtiLuuMb/PtvWcAHYDbGwi2UwSRmtsP0WhZx6/u7EXQ/FWrO7VEBJJVlt
         dLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795692794; x=1796297594;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yzojCckQ+xllk0Py6ZM8C/6T/sfzNuCOCrHEJWMWxtE=;
        b=kWt0rQz/Gz+4dfZy3BHkMb7Pcl/49nwUdObsAYEH+tjNs1fOHZ27bhdaw5s7JZlDe4
         XvA0vt6niL+NhzhNvKuA+KF5/MtMZdNR/aLOb+GzFKPYl+6EM01gigTMp0XMPbaPZe2r
         T6Q3E5Xhqc0gTxbEH80HZPqYPxwiSlW5uBlPsS/QyD5vZo5yepig5qfca9e0By3JXyAt
         MNUjrrnsmrhfmIK2FfIJWdBqDv4Wq+F93mwE+GFSfV2h00XrGS3nqgOSkW2z/4GFA/G6
         kB/wSZouwZYMY8eMOs4QvkJsWYG26y7kHJJkMBnNFv7Zfu3G6tFI+Q7sfAsfaRmKaa4u
         /1WA==
X-Gm-Message-State: APuU4Z81DBT3fZY+HDeDQTdBltPJa4DiDnB4yP66eK++C/chvE4icf8W
	0ve/ZRA/D/jZQ++VLtOKLNVMt2BxQeuBk4LGSDetxRh+QS9srDfZpDlfP6JmWUHzLXmqvCPljaO
	m5cSwOfXOijBH+04mU3Md7UkXLkCuXbfz1n5gLPERL704VUZ+DPY7GjTcGSthzEcxl2/WOGTF85
	/+dag4wRQCrXWMScM5uTuvf6/BKtnCmmL3UfR8
X-Gm-Gg: AZFdTZdwPJOxl2WwyoZTovo1bhoEQGqsNt256arPvMmyKab7hVKj3T/bdqy5llMO49f
	V7WQs20Y9MC5WuYZWDNv+vbOjmUB4QP2PIMf5p/QCGZbWk9N1gH5kibLJgPc6DkmlSvmRmHbzH7
	Ur1rJOQKzxMqteFzrH6Rv578yZDYGcKdTdlRuwqfUSb7D3eMsDu4jchBHhxw==
X-Received: by 2002:a17:90b:5287:b0:3b4:d22:8601 with SMTP id 98e67ed59e1d1-3b41c8fa9c8mr18812571a91.23.1795692794040;
        Thu, 26 Nov 2026 03:33:14 -0800 (PST)
X-Received: by 2002:a17:90b:5287:b0:3b4:d22:8601 with SMTP id
 98e67ed59e1d1-3b41c8fa9c8mr18812543a91.23.1795692793515; Thu, 26 Nov 2026
 03:33:13 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <13014755.O9o76ZdvQC@rafael.j.wysocki>
In-Reply-To: <13014755.O9o76ZdvQC@rafael.j.wysocki>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 12:33:02 +0100
X-Gm-Features: Aa3M54ph000dT0mgXrbi9kmWLblkGU9R39SHDDhIoTh294IoF-r8S4DLc94NZLc
Message-ID: <CAPx+jO-zXL2W1qnmbaCUNmTojNoUhymbZCXV8Lsw2jz-LT9vxw@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Eliminate __pm_runtime_put_autosuspend()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Linux Driver Core Development <driver-core@lists.linux.dev>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, iommu@lists.linux.dev,
        Brian Norris <briannorris@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA0NCBTYWx0ZWRfXwnnR3Xwkiy8i
 E6VwmQLgklaPGXmKm41i1iBKOBctBfb/qb2Jfu1Dv8swVsPPHxUwGMcHXn7aGIYYqPA5QTeIllD
 XDnhLtotE8F9B+pPHw4g+R1vStFrPtw=
X-Proofpoint-ORIG-GUID: MIhBwXfmvgXCn0_ez0hanXwThO7a-IZy
X-Proofpoint-GUID: MIhBwXfmvgXCn0_ez0hanXwThO7a-IZy
X-Authority-Analysis: v=2.4 cv=QZPzLcbv c=1 sm=1 tr=0 ts=6b0818fb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=wRRl36yi_DWTeFIZz0kA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA0NCBTYWx0ZWRfX7FaDsEcO0sxn
 4Z05ihH9zgodm3ylBAXgBOI0DLKxdhIeR6qvm2GSOLcstvONTHQB7mwZ1QKD9ss/ENKgk36mecS
 3bpj48yVgDY6Zd9NjCd7v3WzVUsXfZB8vxxLYZFpro845CkxjRrg8m5YfrBuB/sosLUx2IqCGUd
 tir7s2yUL0meFabwc3K5MQst8+aIRrdszyiLrJErN7t1mWEEw7aNAK/dAIybKQ2kJlNhQNWBMI6
 AU9QqXesVyteXSfdG68B0cKb5YsLKQYXjdzwXpG8G/1XKqbmbYGBQbxZFqGrg+N0UqMvQ69cYSA
 dN0n0lQPKC2ElRw7tDzxnES0v4+f8usU3NkuyO1RrERI3e8veF4B1ZdsfsJc9DqcX08HzT4oFn5
 uzU+SMMUNy/EAjlxvn6O2Im+3XlBalv8UdhWdDV4LvaHn9PSZP/ft8Sa4bDdOZYYZ9sGXTjPW4Y
 httXSkJU6yazGg2dObA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260044

On Tue, Nov 24, 2026 at 5:36=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> There are two users of __pm_runtime_put_autosuspend(),
> pm_runtime_put_autosuspend() and arm_smmu_rpm_put(), but
> the latter duplicates the code from the former.
>
> Fold __pm_runtime_put_autosuspend() into pm_runtime_put_autosuspend()
> and make arm_smmu_rpm_put() call the latter.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe

> ---
>  Documentation/power/runtime_pm.rst    |    1 -
>  drivers/iommu/arm/arm-smmu/arm-smmu.c |    7 ++-----
>  include/linux/pm_runtime.h            |   26 +-------------------------
>  3 files changed, 3 insertions(+), 31 deletions(-)
>
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -338,7 +338,6 @@ It is safe to execute the following help
>  - pm_runtime_put_noidle()
>  - pm_runtime_put()
>  - pm_runtime_put_autosuspend()
> -- __pm_runtime_put_autosuspend()
>  - pm_runtime_enable()
>  - pm_suspend_ignore_children()
>  - pm_runtime_set_active()
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -79,11 +79,8 @@ static inline int arm_smmu_rpm_get(struc
>
>  static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
>  {
> -       if (pm_runtime_enabled(smmu->dev)) {
> -               pm_runtime_mark_last_busy(smmu->dev);
> -               __pm_runtime_put_autosuspend(smmu->dev);
> -
> -       }
> +       if (pm_runtime_enabled(smmu->dev))
> +               pm_runtime_put_autosuspend(smmu->dev);
>  }
>
>  static void arm_smmu_rpm_use_autosuspend(struct arm_smmu_device *smmu)
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -588,30 +588,6 @@ static inline void pm_runtime_put(struct
>  }
>
>  /**
> - * __pm_runtime_put_autosuspend - Drop device usage counter and queue au=
tosuspend if 0.
> - * @dev: Target device.
> - *
> - * Decrement the runtime PM usage counter of @dev and if it turns out to=
 be
> - * equal to 0, queue up a work item for @dev like in pm_request_autosusp=
end().
> - *
> - * Return:
> - * * %1: Success. Usage counter dropped to zero, but device was already =
suspended.
> - * * %0: Success.
> - * * %-EINVAL: Runtime PM error.
> - * * %-EACCES: Runtime PM disabled.
> - * * %-EAGAIN: Runtime PM usage counter became non-zero or Runtime PM st=
atus
> - *   change ongoing.
> - * * %-EBUSY: Runtime PM child_count non-zero.
> - * * %-EPERM: Device PM QoS resume latency 0.
> - * * %-EINPROGRESS: Suspend already in progress.
> - * * %-ENOSYS: %CONFIG_PM not enabled.
> - */
> -static inline int __pm_runtime_put_autosuspend(struct device *dev)
> -{
> -       return __pm_runtime_suspend(dev, RPM_GET_PUT | RPM_ASYNC | RPM_AU=
TO);
> -}
> -
> -/**
>   * pm_runtime_put_autosuspend - Update the last access time, drop usage =
counter
>   * and request autosuspend.
>   * @dev: Target device.
> @@ -635,7 +611,7 @@ static inline int __pm_runtime_put_autos
>  static inline int pm_runtime_put_autosuspend(struct device *dev)
>  {
>         pm_runtime_mark_last_busy(dev);
> -       return __pm_runtime_put_autosuspend(dev);
> +       return __pm_runtime_suspend(dev, RPM_GET_PUT | RPM_ASYNC | RPM_AU=
TO);
>  }
>
>  DEFINE_GUARD(pm_runtime_noresume, struct device *,
>
>
>
