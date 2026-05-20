Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39AE36CE19
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300480; cv=none; b=UEeVlv2bvHYi4Sxf1e/i39IWdQToP+7jw2ahEIN6Oen3s/gchYzldSt9g6voPbznb7hFaYWDozC+HDkNrQEYCK2h9aOzFOm7EbCRlVdkGIO3bcZhYpVGfC0W7bLhAg62l4Vtf8ZMIVoD/XmICPC1OHBukQ5MDwB2itwH0etfDG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300480; c=relaxed/simple;
	bh=IjgZP/vjbzpXFqmw7OL7UbbycV58kQPVjy/2QuWw9KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abJYUDj2bL9SQYCyh07SAIzAm5w6NYjzYFTKRS8crkI6WwEWlkXjxjZedyVttdJqKEQOuZaD4T3r702YMmRAEoxINLMMQcUzXK5uSi/RWRqdAIzaspyErWk82yuDHFcdz4DaSCuyVK3OLnOl58Q/zXJ3pbSnDCRbJHiLwwYqmng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QwLB0chS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YuwlwBZL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QwLB0chS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YuwlwBZL"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KBZR0x3084892
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 18:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MBPTNFgE16MfzqrPZasg1ybw7G7sGak71zTSDr4bCjU=; b=QwLB0chSGVyS6HgO
	prVe97eaLlvnmy/cVyHw8UwxjDk35CRelqxuYjwWdGc8t/uStSHwFsWzaaqmmv5+
	zUS7Csx64iG48CpiS+FvsJVQJtiHaVIpB9DJf9flGXA8Roe9aJEVSggFG285Gp2s
	ZynMcP2fZIZsLYxthy9fzuaGM2HrEwI1qulI4AqszqWpK3j+9VsUGJ0JYMPAYGmR
	uRWcsDqfliiBzrBdtVxcsvbhELvAESMYPQjJWgRoZPwFLwcSAuA301wswADTiim6
	eI5h0A/GnJIZOlPBO8W7zNSqH9ZnrsN/66Az7v3l0ljdWatIEYFvdWZJYnRhO/SL
	ZCVhjw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9c7f1n67-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 18:07:57 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-95fc8572552so8599859241.1
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 11:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779300477; x=1779905277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MBPTNFgE16MfzqrPZasg1ybw7G7sGak71zTSDr4bCjU=;
        b=YuwlwBZLnLXegUzf5J8JTr0Gd/ZddAy9AcrOh9Ao0rrgJyJ98rBrXycclzkW5jKJUE
         ug1qksXd8i0y3zNNHhKZJx/iyskFKeQhoqDGmEBIcwgH7mbzlSkNmC0ZWDS9XDdF68Em
         KCYmU1cYFbucqsni9bvC2f5FXdhgUr6Il5OIzCq8S9Vk9EY0dayGyxvgYADPCoMhd48c
         OPd6zTrc/0JywK54yIqpHpwU+91tI7GqlZAPaafxbvGyA0Agzjr6ogUv3SUchdodsPLm
         NUfasV7Jhio34ykhby5obuXa3llEeMPNMU1FozsKWhZ8jc6Ew2tViqKDpLuLZH6mnFZO
         M2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779300477; x=1779905277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBPTNFgE16MfzqrPZasg1ybw7G7sGak71zTSDr4bCjU=;
        b=Id2FbsrlqL9JQ9DNSV1fvj13i3wTFMgOuAaO/MbY61lSejT4hD8mvlJXsPsRxOL5uc
         w4xWsutRaeHtIk1f0gCxOS7gFWWFyeRo2TTF0rNpf5kgfZwveBzhoaB5vmKyomIqwVhK
         lqtFV6n/P5YjHrEcvdF6+9dMEG7ApLjDDQ9d6cnamCLapX5mCZDgzOX83LpUTiUnwpCt
         gWv34QdWpCKarWIoN7Z4pDTzoL5q7iCaL5ENYd6Fdeht42dmTLhixBBqOoRCiDDO2RYh
         qa4EuZYeVDLrpb/ZqwuoTGIoxQFQZCzZAPJ/zbiNuBgEoTL+6T3m+J1Ih18JdYXUu09x
         ti6A==
X-Gm-Message-State: AOJu0YyKWfbiEfjswcBJar/tlReHr96F6wtNOm/aTn5PqeiHGfup9r3R
	dG043Rvhx+UMD9xcDnQB7gDwxhztBzi/vSufNvBgsxK+HgyOmCrScUnlciavv8nn0d+5MgJUKUl
	CnRPC+mO1MKxreluk+2Nur1mOhpRp/MoSBoXoTVuIhxiIbGpMwAdTUxU7od/juQ==
X-Gm-Gg: Acq92OFd3ZzOi2/378jxXXu30BZzgopulGJUgPDrcLnmoY7E+WzTa+wFapiznZNRCqd
	j9vB08VzeLdl2pAlNPmbKSK7TdWXXzY1iJOtrQcADh7gejqlWMCJPwTAx6B7KYc/50UP9nqRIFE
	YzsmvhEIM8BawbjiTxgu2RpAPOyMpZtTqabxrC3DwF5bQmsThnsb44g1dYpvClJYBOx6lAQMvoC
	WMju7TigEKoS9tsNbEKUtPScQUVxC2AWwqEVW6Dsa84ecU1tHNDFMwlD8ZBl2UmVY2bR+4v0g/p
	Scz8Unzw7vDGtx7dmdGPU0f5qxBAPcAyK8V4igtHRlzOZOGQahDgLfzUT7I/wu2apkhqzumIik6
	5c4lynlFuZ30DOGYn63w7x+T911ca+Az27DGL+EZFy168d2qvjeA8ZfXdRyOMM2pVwmogR00LSu
	SKW589POnOsllzaecWmrc=
X-Received: by 2002:a05:6102:5e86:b0:636:46ee:2f10 with SMTP id ada2fe7eead31-63a3d329d9emr14299413137.9.1779300477182;
        Wed, 20 May 2026 11:07:57 -0700 (PDT)
X-Received: by 2002:a05:6102:5e86:b0:636:46ee:2f10 with SMTP id ada2fe7eead31-63a3d329d9emr14299362137.9.1779300476709;
        Wed, 20 May 2026 11:07:56 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ed59:2b99:54ea:b713? ([2a05:6e02:1041:c10:ed59:2b99:54ea:b713])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48ffed60c8esm102864415e9.10.2026.05.20.11.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 11:07:55 -0700 (PDT)
Message-ID: <c332d7e5-e201-46ac-b245-a678b85c6633@oss.qualcomm.com>
Date: Wed, 20 May 2026 20:07:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mainline-linux] thermal/core: Populate max_state before
 setting up cooling dev sysfs
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, rafael@kernel.org,
        daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260520165835.90974-1-ovidiu.panait.rb@renesas.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260520165835.90974-1-ovidiu.panait.rb@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=c/ibhx9l c=1 sm=1 tr=0 ts=6a0df87d cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=yC-0_ovQAAAA:8
 a=EUspDBNiAAAA:8 a=lb29jLpX-CCDl1hyMzEA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: 2dVd0VtSqXTrDqtAGqgohtj1OOmNZkco
X-Proofpoint-ORIG-GUID: 2dVd0VtSqXTrDqtAGqgohtj1OOmNZkco
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE3NyBTYWx0ZWRfXwh5+0tvuZFwZ
 UqHVozazWPvdlNiatbeBlPyW6qXjfvjZ6AcEOTDASUyAas88O4t7MKQAP1/Xh/H763vwqPMqu5y
 NUtmfuMvE4teyi8ynOjsxDZiGQTZJfqFtFixYFCJ0QTTsQ5KliC6Ynj8T4dgkiCRKp/lnRcJ1yx
 aC8aNRopzpF2AXu3LW8pWFpZrvShQJjFu9/VTxSXbIuuVbLyZBSkPFDrK/D0qunhjYP7h8pR37i
 t0b9UypuKSLJivRo7JHxrthwOxwZzVVRIKW12xVK7pFRGvCJOLvteAL2PZbB4wyIb9MKs4/CdBy
 q4BFMz9Vtc6dyPuNsmFoOb4la+v3n5yxkLDkfaOLL4Lo9sJTaA1D6wQ9CLGzWI4wRqqNYKNWXLY
 q0Ps/ftxpLBhkA/RMu48nQtsqb6gK9pAOiy8PrrTNux+4NOjW+k4/EORSjH37TWirgcWIuWjjxw
 GUn87rbs7eXPPMmeS4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200177

On 5/20/26 18:58, Ovidiu Panait wrote:
> Since commit 13f4e660a126 ("thermal/core:
> Split __thermal_cooling_device_register() into two functions"),
> thermal_cooling_device_setup_sysfs() is called before the
> ->get_max_state() callback in thermal_cooling_device_add().
> However, cooling_device_stats_setup() allocates space based on
> cdev->max_state, which is not initialized at that point.
> 
> With CONFIG_THERMAL_STATISTICS=y, an out of bounds access happens
> inside thermal_cooling_device_stats_update(), followed by a kernel
> crash:
> 
> Unable to handle kernel paging request at virtual address ffff800081329e60
> Call trace:
>   queued_spin_lock_slowpath+0x1cc/0x320 (P)
>   thermal_cooling_device_stats_update+0x28/0xa4
>   __thermal_cdev_update+0x74/0x88
>   thermal_cdev_update+0x44/0x58
>   step_wise_manage+0x1b8/0x300
>   __thermal_zone_device_update+0x270/0x414
>   thermal_zone_device_check+0x28/0x40
>   process_one_work+0x150/0x290
>   worker_thread+0x18c/0x300
>   kthread+0x114/0x120
>   ret_from_fork+0x10/0x20
> 
> To fix this, restore the original ordering of ->get_max_state() and
> thermal_cooling_device_setup_sysfs(). Note that with this reordering,
> the dev_set_name() and ->get_max_state() error paths now reach
> thermal_cdev_release() without setup_sysfs() having run. This is safe
> because cdev->stats is NULL in that case and destroy_sysfs() is a no-op.
> 
> Fixes: 13f4e660a126 ("thermal/core: Split __thermal_cooling_device_register() into two functions")
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> ---

Thanks for fixing this !

Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
