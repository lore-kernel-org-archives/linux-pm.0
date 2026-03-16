Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAE92BE630
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669022; cv=none; b=oNlJTb4KdqUKl0zTgLwvJQ4M+d7/mXqYXX42UnTfcG5KBEyA4Q6aBvehwOCmn5+f0zA7TikVooim4P8MVAShiAx6Z2LpzmcJA/5ce32aq3FmsnbLZqchMT72IxgosgCxVhhz6tCGqIlXW+QG3WTkhdYq9JLtFhEyaAKDYhFphK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669022; c=relaxed/simple;
	bh=YD94EvCpPG2eq8uDf2SS8FdQPIaR4Uiz9n2gqkCJlVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOaYE0EFe23OIZWBDDUPHMqX7gz0np5luhu2oJLKnDIdmMhHV48fAdrbYvO5oExeTi1fPxxVfSDjf7P/deuiw+xjKIGpU/7UlJAqcEHVVdDcm9HG+bL+eryPdoKhyCuljtNOmAsK/p7y0MMf8yeoBkaH0Rw3U7m2NlFCK9eGu9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SAqSr9KL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MMG5Wlyx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SAqSr9KL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MMG5Wlyx"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GCXQ4A1622547
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 13:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IT+TYjjfVWdlPgCtwind5gio
	QLytQt0ar7UUb+shxsE=; b=SAqSr9KLwsz+k5TuQC0EK3zYCn5Q1eFEi5Ax89J7
	CGwdWI+14oCYp9id6DR11UJXoTCopFVGkdxyql7t6rBRQnfyivHOEQrEPuoimYfb
	2vKrSL2RE37ObqPDblaAdft9wbN4bmc/EkdjtwfTPku4K4NFGJwDWY4fHqDORP9A
	4lnSZhZvMO2bH3VskEf2WaD53bH5XI756lxGKD6lGVIy7Ks18eBasUi6zr04qNkm
	JwqzNXM1JNdONLKmkQfauRw83HvlW2AGM68B4r161epJHEyZ4K+ErTsQxE74dri7
	3OPe/QOmLAk1osPg+3Vx36L/aohr3eBCsm8T17tizpxHRg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxhyeg945-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 13:50:20 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd84943c76so4091244485a.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773669020; x=1774273820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IT+TYjjfVWdlPgCtwind5gioQLytQt0ar7UUb+shxsE=;
        b=MMG5WlyxBILis2cAwsBFc+VkC5k30Ej0WN49SJJmRUWV+dZuTWGnSEa+rJcj8LpR28
         0FaF8TsoYQeJu8Ad8+hua24f0g3t7fG4RwIGiRLRYoo3bWzVJgwJgMAyeL/cbQN7Wb0z
         PReEDogG8X1OqxPJTWUMvealtzvnPpyxVbryLCUZ7D3R+URXsem3cQCpg3RvII3+pjDI
         kR0rk251hpCwvUZ87ws3aAlwdJ49ImFeFQnGIymVvBW8tBWoAjB1uAW9XVggKemTPTZ3
         Yps7UMTvATyLzL+r7whqdny5C56AduXeAMLLT7sQpYUk3Dkd7xviUkRrO/vV8ybvA6wt
         yiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773669020; x=1774273820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IT+TYjjfVWdlPgCtwind5gioQLytQt0ar7UUb+shxsE=;
        b=Kr31vKYy88ZDYLBSmY+AtWPpy1m3ttcC7ZexjfnaAtjlJN7/zLiZBltcyu3lezg4c5
         MNCoGQdhvcR2+IW7d1rilfPDpzUwL7DTnH4XDyqxdkcrXBgBvii1HkHMHO2YGsYj90Zz
         kN962LlGaWWfrsWkrn11N7Sz9BJFWE49e1u9tfD85sU97bTU6SAlUWOqWjy5pi5TEHWy
         wSde9dVGh6jnSDLrLyOOMjIzoF7tJOpJxNhAPgu6eKNrZS1+m1D/By/dfM4Bt9d79R0e
         Vj8OSA4lghvio1XxE2VyJAYj5y6/DMvjaNmmX2drKtb20rWnJnUVjwdb5Q/4pvUnazGr
         8PGw==
X-Forwarded-Encrypted: i=1; AJvYcCV+X/gJm296S0el0icLTkVtFSyrCnuKke1L2M9ss9AsRzEbndY0jl9KAy9nwjZXj8K3YSKGtXHeQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc3aiHaRQTTmYpO5LUjAcI7EyMgxpSUW3j1t50+prFvoIb/I8N
	cpmCYN4MFth+gBzLEOc8TV8gHhPCSHoiL6B60l+HXhVVxB3U5C/qbTJC3nx95kE2kQJb4BNcxGb
	koVMuVnskT+MMsmbhjTKjKSn3jnYLEBUPkhphU7cunylg1ACHoxGRdverK3cGRw==
X-Gm-Gg: ATEYQzzkPyGheMBaVvNDEmC0Bo+POvjNErDrB6OEBa6CRYC2DrvbM6fPafIT9Rs9c6Q
	D2O2dI6fA+d917C36cRvNDBkwEhNYzUN7B8wc7AW13Br9TQH6uECMHQ0OCCOfqDTDmo9JLwMxGl
	PLmC0SwXg5IdOaW3FbLryuzh7ngkTYbd7Uq7Lcg6GYEyubamwvZZh0EdAiqt5hCgSLam/fYBJMq
	3qs9RQadmFRBnu2YhVxh0dL1CNFbh70CbPrXJSTyjALD0qPecgmhPTKBIx5Sh2Bz275TKBMZ51+
	VgxfgdPvML+5v2Y3tq8VvVrgWY0FedckEMhevfK8yW35KOEbrRhWeN0e2BPDwu1V3MtXXlxxog1
	+/QEYPJm10jrg4NFYzans7qkAtD2DFxFjI+rCuSqEH40mgOCHThkVYlh8dHaGbpOLVGf4BeMXon
	ZuNtslfzDJ4Fi/lYMtcYPutsdHBDu1UPTyeXY=
X-Received: by 2002:a05:620a:4056:b0:8cd:7cea:aea0 with SMTP id af79cd13be357-8cdaa895609mr2091274885a.39.1773669019606;
        Mon, 16 Mar 2026 06:50:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4056:b0:8cd:7cea:aea0 with SMTP id af79cd13be357-8cdaa895609mr2091270685a.39.1773669019128;
        Mon, 16 Mar 2026 06:50:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a155f33e51sm3381010e87.14.2026.03.16.06.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 06:50:18 -0700 (PDT)
Date: Mon, 16 Mar 2026 15:50:16 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Cc: viresh.kumar@linaro.org, rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, umang.chheda@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Add QCS8300 to cpufreq-dt-platdev blocklist
Message-ID: <uf4rqdqgj6ll54didnyajtsruyex4ghubgrd4sc3qio7vtumef@yfxedf6zj4rf>
References: <20260316103752.289324-1-faruque.ansari@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316103752.289324-1-faruque.ansari@oss.qualcomm.com>
X-Proofpoint-GUID: 5k8XqF9CgTm3VaVGW94mwvedVN6-ioVP
X-Proofpoint-ORIG-GUID: 5k8XqF9CgTm3VaVGW94mwvedVN6-ioVP
X-Authority-Analysis: v=2.4 cv=KLxXzVFo c=1 sm=1 tr=0 ts=69b80a9c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=UzGNXosDaVyU3g9DD2AA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwNCBTYWx0ZWRfX2qSYQ7Y4HHLs
 GQOdBOsuUt+jgKIM1rN0ZOOOyzIDVaTf5iyrQLgEugFZ3jGeezL0DXkhI1m6XPEbfFnEMmyDqrR
 0wb9EPh+BvAy6BN6bL0z6+Rou5FKusbcB0nAVGWGjvlvVz0mKUBqPnJU78ULh1TAEzsYW1kyepg
 8FmJqOVwOjpbXBA9vbfugnYmSTLaC6eetjYtidTtiIWQrFS5adxpXAtX49C1KSwzbjn+m8KYhTk
 e9ukSYMhyL/p3iBbDzc//C8KesWDLpdJAnaBUfAOt1QFfuA40rJ0o67k0tbea37b+vBOEnfyaTT
 r2qPgf92+UYAZ0rGu6hNwFGcAyoPXpc1wVbkrosLfy7+Bvz0zBrPGTvhrMrxaf20ly7ngtZle1O
 MtXlxYu2Alp6t+4gBqTlJ4Iymagc6VH7oCQSb0KlqnDyVK0lJbBOUP4lqkgOfu91/+o89MiWnoi
 59UAfwu3AgjeFtQIjUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160104

On Mon, Mar 16, 2026 at 04:07:52PM +0530, Faruque Ansari wrote:
> The Qualcomm QCS8300 platform uses the qcom-cpufreq-hw
> driver, so add it to the cpufreq-dt-platdev driver's blocklist.
> 
> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
