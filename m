Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4203ACA52
	for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774607276; cv=none; b=spM9kmN/+06+WhUyV8LtDQ54tkDtGDNArnvC0uy2gHg3X08bmdn7oZcVj2KjMnefGEoFH3z0iOiOx7ACXMCL5T96pstW8pVU/NJ4Yp+yv9tVIIyiouBWy3HOuYkZ0KzfrMltW7B79xcStfdxPojnEWJRey5OOpSSuZY40bIXZn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774607276; c=relaxed/simple;
	bh=hczkyq1Z0Cmb5UFUuhiSqB2G+okw/40DjLip2hZqg0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCatuzMggz49Ur1Yu8VR7cqKwdQ68+eqXIRSqycaklMOwlMNhbzvQAfxIiOs5b09MpEXZR+6I+pkAqu9e34KgZs2OOOk0ctKS0uFuntvYwrEloiZhiSFhoNyIPE1H7zdJJmAKE6pUV45lK9h9jBbkaORsMMGwMPwUqWUA6CXAZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J0auL5Hu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LICgAFkt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J0auL5Hu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LICgAFkt"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R6wvx92846379
	for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 10:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3cl5BrM2CLM613ebLhk8oT8pQ9yMV+of2cphHRUa3Z4=; b=J0auL5HuhoT5yM8B
	hFGgwhNn+am4wiXgv8h1YoB30rc8jtSmik/CvHvFPb1SB2uIYZV2kKrh6gjvsG10
	ivyxvGDrQT3RmsME86fEW3+sLBLok7dSG3WaNwRGcpf0f6gP4KkaaYz5SjmSlf2p
	/XSmFhXXDvce69JpiqvX41navEpZbYpNcMXZcQ5HRPnGcgOe/E00rwxgUr6XLfHI
	vAiYV9/9x1LXV1JvVDgWZN7t3+NhY24T+kLQCPXHm0shuRq9NFZJbKoXEfPtUGnr
	FCNo8Awecs8vqTcVjjHNtr4EpKRaGfXm3PNzZXHb1e58xp6BQ3+19ls4vSb3Q5V/
	ZypBcQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d53eqmmgp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 10:27:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50917996cfaso4934541cf.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 03:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774607269; x=1775212069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3cl5BrM2CLM613ebLhk8oT8pQ9yMV+of2cphHRUa3Z4=;
        b=LICgAFktk8ZikTevhiEUgr/dnIjVGHqSJehtE7Omv9EPe5nssMTXyA502jSEdJqp+/
         L1tTE//5xrl0Y7u/YKevsy3Sl9CKV+B5jB+0MHwVVjrfaJLq7ZCSaIQWiJluSU0MsNJB
         Jx+zrQVa6nBm/f0k3jNPEW647Tt2yk3mPNHPVmjAs8H6uYVeEBSDPindjEZGOb55MZ+w
         Dy71SiuXcJXSYtG5Y40TolFNoOz3p+Y5eM0MleUw8B2T79WGoSwy6CDWvSP0IHJEYaK+
         s+CqqMNoX0IXWxyZ2NAS4lzmrq8JE80bRW70iRe/ywLgJoZn3liyO02RV8Rt3iLJRkdS
         5CNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774607269; x=1775212069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3cl5BrM2CLM613ebLhk8oT8pQ9yMV+of2cphHRUa3Z4=;
        b=cnW4zMhDWDKGKKRbbDqZ0PjsSJdl8B/zKdetFONAAnNvSHTAT3+vrjw8t8197dgQZp
         /gaJQmEcve/ru21dmsutMorGwzpbeBihDhw8Hj6VCGy6IA1AVegZFpwqQUQK57Mkl0In
         e3SIgw2ZPFg4iej8+iqIVAUrD1iyPTkjqSwKt/PR1vG3TmqiQLn+zkyuyeBo3QIHQymN
         l6TieOKlBsPWxPl2OFxjgB3ZPp+cNaZW1Zj4x7pT6D7U3IFZXaAGk9n4uSZrIEAvhmr6
         Zg4aLAYyV0MKPBFjM+i1aP+cZMzbLvrzNwOjw8+lQ9eiDkjFKyx2wgU82Eqakz+o+EFJ
         g+PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyUVxP7/TNPc4r/9DHatHPdTpom/4gjKL202z3sI7MwcGi87oXlycokqSIA+eR3wHChBPg/OsPOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwscbUWH2ghgU60q1phHOLnQqTizA2sRUBl+kZu38OIH4KRMxPG
	MhPE/Gqxi2/Sjy2IVFxc0D3DBNBTwdByT1DVkUjafSNRa5iuRU+Lew4m8kXEVjyady52tJ97N76
	oqRySdK4NsrCYZjhXVpfXf/TZbFfSoYKueHb1T4Msgzzecge0jfyNl3X8DZTzCw==
X-Gm-Gg: ATEYQzxA+yGlGDk78JJBvhw7fRFdc/32Dlz76t39Fb3b2Zvo5WoKAg2TOh7oy+qsyUg
	k6WyjXwUyjLgz3u822N1OuF+WQbLxPWLeoz9V8cgQPFgDNi3TQ4Qeq6qiqpidFj4lXa7qU3TS4Q
	6lbCBiX6H4LMYpwDdDHKVbYQD3n9m8YSBLlegK/DYL9+Ck5V3q5Dg/Eg7oQIPN8g18o7ar1X417
	4kAFHs04+zNyaZjVB0XEX9CaOXTDMDh7dusqRxpW4fYpDtLOvyLBTw8FytU4R5PdSKZ9zzsxbRI
	chPc5UEfFr+N8be92PmKAJoKgYC5Krkd+yeIfwkO3SEaEGXYFtK1nhDj6CO0ERrjQNrfkPC7tbN
	CHAoc9M5LFl/i3Z+O6ZAtuJXRwS/g16IoS0rUHd1VbC3uXvTJkDUG2Rl7Ubh6s9WwlWTL/8mW+h
	UwYHHkiy/X
X-Received: by 2002:a05:622a:1993:b0:50b:2e8c:6ae0 with SMTP id d75a77b69052e-50ba38bc54dmr23120021cf.45.1774607269242;
        Fri, 27 Mar 2026 03:27:49 -0700 (PDT)
X-Received: by 2002:a05:622a:1993:b0:50b:2e8c:6ae0 with SMTP id d75a77b69052e-50ba38bc54dmr23119721cf.45.1774607268757;
        Fri, 27 Mar 2026 03:27:48 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b656:6dd8:ce4d:18d5? ([2a05:6e02:1041:c10:b656:6dd8:ce4d:18d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725fca5f2sm15199245e9.12.2026.03.27.03.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 03:27:48 -0700 (PDT)
Message-ID: <3f7c9daa-ebf6-4871-8496-0e080afc3322@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 11:27:47 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: fix error condition for reading
 st,thermal-flags
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rafael@kernel.org,
        daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com,
        m-chawdhry@ti.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260327090526.59330-1-krishnagopi487@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260327090526.59330-1-krishnagopi487@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA3NSBTYWx0ZWRfX4qEqm8t1THr1
 zmb2hNCPL3iogky/pRvyaBfkkv+8oANvRUlYEiUa/wTgVhQ/SNqyZlQEZ7rPqgfBH9rk2ofpnNt
 lRmaVhu3Udzn7ooJq8ElXwI+H1DiwClN75PqV7A+22+EPBwKwVmHLQ8TOzctfS7/MzSCMZVtx6K
 zpyU2pSGkyRW2jRJVJSjnrDzSsfSpRB+919IyNsZXw+4tBhzzxpFWxVErqERWSgVYaTAvOjsJxe
 GwK1TMjGUdH8IIxzfWXCmSmhvdzWSZq5t9K0WmxclYznpi12kP5KXO265kb9nUi5PRVr+85ycvz
 dnA9+hBtE4qfL56hV8D/ZVQXxqIjWz3C7tu1UYrLCmrEWM7Y48Y9jTPEp6geOYAYmuDSRbCCZpa
 znS7fYCpLnLwIqfJzl9yDE2rnrx8jCmcDoQ1q7Tc7u1nhLua+jwuuAL3epFt0zQ7/PVDgtEK8kx
 Ve97H/MfhB7pfVLXrzg==
X-Proofpoint-GUID: q8oNEIICl4KqMh4Ggrc5W7IYW0JWU98_
X-Authority-Analysis: v=2.4 cv=S4bUAYsP c=1 sm=1 tr=0 ts=69c65ba6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=7CQSdrXTAAAA:8
 a=8AirrxEcAAAA:8 a=pGLkceISAAAA:8 a=EUd0EORqmQtM46NuxkEA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: q8oNEIICl4KqMh4Ggrc5W7IYW0JWU98_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270075

On 3/27/26 10:05, Gopi Krishna Menon wrote:
> of_property_read_u32 returns 0 on success. The current check returns
> -EINVAL if the property is read successfully.
> 
> Fix the check by removing ! from of_property_read_u32
> 
> Fixes: b9c7aff481f1 ("drivers/thermal/spear_thermal.c: add Device Tree probing capability")
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Suggested-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> ---
> Changes since v1:
> - Add Fixes and Reviewed-by tags

Applied, thanks
