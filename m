Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADA739A7FD
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983032; cv=none; b=EukLHWtn5IMObJou58ZiQMHenAiyqyD9JPjxGK59tzdzInGzeceb4AKVhaiDnrvHUSKDQB1u30gKzY72YpuU8ykz+5zXy9U5Rd3/aj6gldU7PTkQ2g2hwYvvsoFujxMQkJ6vsMe70RqYXCOHkFtTf2vocmtmd4lwpKTXGNMYeag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983032; c=relaxed/simple;
	bh=m+OmXuXGMU6wUk+WZ1RB6GmPxqyzm9AXjy954KVhZ80=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=crQBylHNDIuz3dWIaKwCei8AR8VSmfovnYJqRJib2fUEiO7akatWJsZ4F9lVxzAkRD050Kl25HwsaV3okzmlysRukxdwQmkhTvNkgPs1KkBkUCsfH+cGMV2Trm3aNUQgzs3W898cUxZPmLXwzWJN2sZG5BkXvfs0mRsRUf5Tm08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JhI6/+dm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=akrP1jbO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JhI6/+dm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="akrP1jbO"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6457oEkg1960741
	for <linux-pm@vger.kernel.org>; Tue, 5 May 2026 12:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YJDA9Dw9DQRR6r6ZVUHzUEY6axXFWifKuuHs5zUrzRI=; b=JhI6/+dmrPEccOCg
	tYg6BDsttRs89uzgbwa/6JVgnQGpIEsFnyxrz46yINXWj1+O06G4/bXWrjML+BDs
	exLUELVYWW1cSAzbA0grX/Yip7KkVddkeeRxEn50uGINmO6QJn+pqUzsi7VU9w9F
	PkRv1hq+90j1eLaWAmaxOaJs8g9csJ2eUSk7bakk15X81kp9Z75G0XWv9Os5YIni
	q4t25xRwgH2ir+8X8zxPseRqN93aaToUq5gYNn3FxssOJvREsBm7yIwVVt25ru+6
	2yhS1qJUGQHMERAdLp81MOvbMzltd/5V6O1xaz9+ILuA9gmC7yBjsja/DZV/fJrz
	eRGBRg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxw5dv8n9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 12:10:30 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-56f6c90b142so9669908e0c.0
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 05:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777983029; x=1778587829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YJDA9Dw9DQRR6r6ZVUHzUEY6axXFWifKuuHs5zUrzRI=;
        b=akrP1jbOOaToUc2g0r/0/Gtel4mJLnCGg6otWof1jTKmZfi79MupLa+YgdTljIo0vN
         OF/TLcAJgPNy7kpOBgCWGPEvNXy52MgcqEdnfB33hWBONo6xbeGL5mj6jMSfpJyUwBCL
         5QQVYAs2j9Rz+688AysEPc+XI37DqfFbkZ2sjoul6d1RPmg0MvPbnhLKRePpGsoPo67Q
         q+HxwdvB3FAIhoZzfUmal9hXKPNVAMMz2S4nkx8mzoHF2duVzBoqdU/I2JpDkqTQ65Ik
         xCnpCHM2LcDU5D9lPDthxPQsdm+tl8gLHSNt7+1WtbKHcLZyHgcvHcg22cS4HpKCRHBw
         ZvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777983029; x=1778587829;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJDA9Dw9DQRR6r6ZVUHzUEY6axXFWifKuuHs5zUrzRI=;
        b=QY9YAjqacdUbAcg+DJGDMb2gfLorgf+EXhpRKL0M7XVuaowTOIxiD678Ggu7mgDGRf
         cSVJ1EMgkfxJBXIYLqc2RfQjo7RfuOC0rfcuknK4ifWRv1Q3Ip6rQWRANo0C+57UxxYS
         kbWUlbfC8Q2qaIVrm2KSqNGAYRA93MMqibP+uIlFiIVcidcRVA+yibsdQd3pIuVuNdDK
         kiiOMenU52CEGpZy6KUrhGt3XuXQw3F83zH2rjaTnYT15eBdcvEC+QgwoUvT7u19MXsw
         B3rEtJaTnOKI3CVHCKU5Shwx4mAozvlZqQijfuUhvC9NseuuBIyWI4j446zSP9XG4b6x
         MUaQ==
X-Forwarded-Encrypted: i=1; AFNElJ9u9YfKGfVBWJaubrmRdtQza35A0AQ5WIqwCaiftP7BK8eyBXfp5sAGrCSI61ChoHAM1PAgJLWm3g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3yXT/xCHC7jN+YNWtaDPrsm8i+fuVKBIL5D6Fb7goNO/I4nG5
	VRhLVxBNw+37nDhXw2HGO+5v+PinFehmW5jpZy3ZjBFrq9nJhme0V8O9AEDnZswHqqL/qi+oFtE
	hWWd5/J2D35mKwxlDe9XJuvvPya7CkUgFjytY3tL/Med6wQEH13kT6037KtSdEw==
X-Gm-Gg: AeBDies7YgICeaMuHkclvie5XAiw8ik7jI99C/+isdTKzoPkXj3zBRNpRm1Jbu+Mhat
	ilx7J/MMvheck5vvFubnixAXim/gJO4ApSJuVLc3mOqhyW/5uoqvSb9jca2xgTEtbTAwvX6mfxp
	/lydmCPXAIONTXTOg2WF5ALIT042TafHnxchlsoetmfUX7MWqjmEwwZbqFOpGuTGoRVZjVZK1Fa
	y2TcufTwrRRdoGYSWmktUKgATmaoeZtjbdBezHDQEiGP47fSx42y5E230z9gCwR4oK0cqKIUMiy
	9lSGe6HPEfWf0YYi98uOn5NujqlWIJYhWoYVTfEC31ZsX9KS9ndJmubzMswXuWJL8PdGrveK3XC
	IjERX9wmrEFfIlt+7beB3xNDm4YfteXgEhVVwowoC4OcHjpVjE9qpcnBywGXCfgY9w6uGcwsUAC
	pK+2/eNaHqcBVIUzPe
X-Received: by 2002:a05:6122:3c44:b0:56f:7c7e:f33a with SMTP id 71dfb90a1353d-57547fd53a0mr1224774e0c.0.1777983029115;
        Tue, 05 May 2026 05:10:29 -0700 (PDT)
X-Received: by 2002:a05:6122:3c44:b0:56f:7c7e:f33a with SMTP id 71dfb90a1353d-57547fd53a0mr1224731e0c.0.1777983028778;
        Tue, 05 May 2026 05:10:28 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:3d0:c2e8:9f02:5c9d? ([2a05:6e02:1041:c10:3d0:c2e8:9f02:5c9d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eba865fsm312206105e9.10.2026.05.05.05.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 05:10:27 -0700 (PDT)
Message-ID: <3075fe5c-e8c3-4439-be5c-0f6eb2fb6e48@oss.qualcomm.com>
Date: Tue, 5 May 2026 14:10:27 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drivers/thermal/tegra/soctherm: Use
 devm_add_action_or_reset() for clock disable
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org, daniel.lezcano@kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20260424160019.41710-1-daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424160019.41710-1-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDExNCBTYWx0ZWRfXwt7sq4gq/Tvw
 Mb1tK5iBK8Q5/yHUW2wSrMOY5F0fyzEbrhNFKtZrt2lEmWJfYij2bZuVjaYU46cND+1bC94rItl
 UJUzcgvIQzBbNI4HGdqahnRRRYW3jIbNPu7ZcE2kYn9stUo1hOG+zpm3cqpoYIENPwsu0mFpsbi
 VUWpycTIh60hIZ8xoHrg4DIEsIwVdxmgP6rcVxtfbQDkyApphKqFq/QmTu3I/ozTcVpveKk/zy+
 CsuOI3Qh0ie4ov969O9XKmyCWogcGVHvSyNPaqYYeev/9DpPxpFVekQv3xr5usTQa3Ns1tIIj9B
 PTAZ50dL71euBaFjC1o8fC4u4oMB85YEERvuJKwA6TrleE0MFoul3ohGjQxOOa50eRFA1bDDFIm
 HUj8Gg0K5EPQRLHWROZBA07lr12AAxzi97ozC6mVD2tOfYJs/QfI2++8dCl5nw4rnaVPUCXMDkB
 7AbtZrRwbzzjAZzkxVw==
X-Proofpoint-GUID: HyttPb3-jCzIvjZvIc9Kc2pb_DXKEYSL
X-Proofpoint-ORIG-GUID: HyttPb3-jCzIvjZvIc9Kc2pb_DXKEYSL
X-Authority-Analysis: v=2.4 cv=HpJG3UTS c=1 sm=1 tr=0 ts=69f9de36 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=TJ0kvanGE02mnE8zDPUA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050114

On 4/24/26 18:00, Daniel Lezcano wrote:
> Replace the manual error handling paths disabling the clocks with
> devm_add_action_or_reset(). This ensures the clocks are properly
> disabled on probe failure and driver removal, while simplifying the
> code by removing the explicit error paths.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---

If nobody is against these two changes, I'll apply them

Thanks

   -- Daniel

