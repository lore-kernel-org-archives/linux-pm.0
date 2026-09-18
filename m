Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1813AC0D3
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723464; cv=none; b=a6AdVqRIriBBdCJwe8hhtkEZkNv8a2DLjYeeb8zpzfQP9YUZzZ22kAWYDV4ZRkudSTo8GM3zp8QlH4i+G1kV8v/NM0n0RYhq3CsbY9pDHjTtrQByC3sXBkX4ehrvdN5PVbYZyV73hHR95Vx1Zh9hbx3xBIBu851JClXjUNwZIVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723464; c=relaxed/simple;
	bh=LpQq1ER0K8tCtE25EdHEw4yx5qLU89BqRvZlO4beaAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XohsaNxTxYyetHwZIhF3W7i5PVfhngPcGuQlyUuXhfwgyriuc4FC+wOOM87F0RvRbdzFkZpWoS4zT3B58IBoP9tQOBg9GG0iBLFGozTSU1Su5RhN14pwub8rLe4p3sCSijcOL1RBZmJwV+nz1TW/BG2LTF215FbXWKCALkx4lmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o21yi6Gz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZDoV/I2/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o21yi6Gz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZDoV/I2/"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I5xu8h204107
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 09:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sb1Vub//2FmjjK1XjawIHRbF0b2ZqywCKbgFVQLXFQs=; b=o21yi6GzpreRZH9j
	CmG+CyiFVJsMq4+L4Noixv4miLh+lDVAU7L8O6z4cK1lFMx7NHrI6UBU00VemV/H
	DRLgeD96It1iFOOKDqA7P23bG6KsTgy1Q1aTTEDcJPN0y0W5nZDKET056Ibm2hO5
	8/4KTfroUtYkdjBw1QDyR9rrdk7yFSzJEBmTXgT3Ck+DKhhudktIhnvJx345WUzK
	9zA1isFUZ6ZAOvLnQDEiKX83ONc99MdnoY4JSzf/4ZFjLbDxEGmxzl6tu1enSrCg
	mRFlPTvJEe39eqjPhOodkKKjwc54sMMb7x66816UrC0WJ3KR39xM7a4mSUt5CKGy
	lHVfSw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grxp2s21w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 09:24:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-939f3426a7cso101983885a.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 02:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789723461; x=1790328261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sb1Vub//2FmjjK1XjawIHRbF0b2ZqywCKbgFVQLXFQs=;
        b=ZDoV/I2/NYibXTvdHsxXtGUkw+zBVcdq+C68+QxeIuIGX7e63fCVhHw11/Mb4Du6Be
         QGwpY+X70LSi83nJiQ0NFYf5BWXcAF6OQAzT3mCM9gYYA9jyO6JG6k28Oe1CsG8AAYbm
         KsRdEt1BCAFLJflLs3XWdXTDwHNbTOfLQF+dMk+GcG8xUPEkpvwjvwECGN7O6dYNntbM
         wQRiSb1C3zsI26qQeEBQrVdhN8dAPDdXRnE/Mq+bGVTNYMk6mI602Jn9cs8gSJ4gTbHH
         pkkOLZT/b4pZeD9RIFkNs9RS8bFvUICq0l74HB6bmUrukPiXo3M3vljzgBc+20ftbOuM
         a1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789723461; x=1790328261;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sb1Vub//2FmjjK1XjawIHRbF0b2ZqywCKbgFVQLXFQs=;
        b=NkT8FOz0cuoWulSwnZnkYc+QgmqFygddhyWdJHG8j3iXr1EA65amJyfSmm+dSWOwzd
         m21jNEj4dNkSV7YJwcRuP/c1bWdGGSQgiNfDhaBkeEqCtuSBoZHNNNceh3/zYEPAQkY6
         UxZi3VXgTPXZkkWsCHXx09HK8oikWWZggeeJ83WTgfPLE6xS5ogEKNK6xL34M0s2YfNx
         CwVxnwVA+P4ev9v4BVpvxTSHkmNjkkHuiemFDxLoAtZDB9sOYeQqUNyT4eCyeSHTNamH
         bEjbxCoAfTpqB1cpmqI0GLOm4IgDi8u5VfEwy/dhTl18nu9wBLZkD05cerGiemt0EiQ4
         2MiA==
X-Forwarded-Encrypted: i=1; AKwUvBz/RaRdoZ0aD8+U/xGhc1L8BXNu1Gs4vhDuEJj/OPuIqYMCyM1FHqGAUd1DIUEcOzj+WESahJWOPA==@vger.kernel.org
X-Gm-Message-State: AFuF++lSJkAlZyEWJGxeW27meQ7fTxPhxrENQGLw1HMQaUrGK/j7m7a5
	onICDsWEVMbwcb/K/g5SDnFIw4bmFXV5p75uerdH0UV21fjdsiHpEmqXwLAH+5ZuBp5YCkKwNso
	YWew3uMFzSBwvkMRyJVcylkrzAorVwQlACBMAUticDZfTPTkYpB2juM7dL1KjWg==
X-Gm-Gg: AYBFou2j/tigBAEp7NHC70aZkuXIssqHl27KpE0Y8oN7iN4ymmj7Rnbpc0tTxdnCQqh
	2MwpgL94QVvzmoePoew5txuK200q6c8qhIdcMk6l0M2Msm32ANINZoc0zUQBwoQLJ0mP0kzhCZC
	8ujBuhlqC+fF6TDgzKDUoajftaUuiL3pU65XoGaILE3xfABM6kusm5jfQHNE+VZUyrbWq+zcKJp
	J4wFyi/s2SdPX/c6Bugqqp/JwAm2W5Cppnb740IgChQ6z/z33TLw3wVeOSuYbi2AOz+/7AKSgIt
	qBtnmUtcXpCBM0Euu5vuTdVfL7ExDVLNketrAzR8BXxcu44AWFn29szmeTovXuWmVD6p8dbyeAf
	mOmL+LtC2jUEOat6832t33hb4MI4HpN8Ru6yiEgusSq5h8Ax+ST35Y5gOgJwhtDQ=
X-Received: by 2002:a05:620a:4093:b0:93b:d7b5:8aa1 with SMTP id af79cd13be357-93bdca9201fmr235189685a.86.1789723461039;
        Fri, 18 Sep 2026 02:24:21 -0700 (PDT)
X-Received: by 2002:a05:620a:4093:b0:93b:d7b5:8aa1 with SMTP id af79cd13be357-93bdca9201fmr235188485a.86.1789723460651;
        Fri, 18 Sep 2026 02:24:20 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:82ae:cd75:d970:e66f? ([2a05:6e02:1041:c10:82ae:cd75:d970:e66f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872008160csm2986873f8f.32.2026.09.18.02.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 02:24:19 -0700 (PDT)
Message-ID: <a8eb1095-ff2c-4b60-af76-55f3dc137967@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 11:24:18 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/airoha: Request the EN7581 IRQ after zone
 registration
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260915194128.42508-1-sochnev.v.74@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260915194128.42508-1-sochnev.v.74@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEyOSBTYWx0ZWRfX9z+oFDdDz8q/
 3euyPcv/dD3WhZDkz8IF6bDrQjIS/S3NXZ0NPdyCh1rpuxHgNT7M8WreH9Sl++DjwLZH7JopErD
 hGMEDqKU4VSfVmQsNBzZYx/HzhjoqeE=
X-Proofpoint-GUID: kONnrZtQhmZ9S2_GA0C1xHSie5uTo-zc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEyOSBTYWx0ZWRfXw3wRnLbiosgw
 qRwfkNOfbrXz+SoJzyLk8KmCZHav4pQHCTk1W/xymgypB3T7sMSYmxjc7zeSVu6R55KetZKhiuP
 2ihTDykfVqTxLHtr6RtTFwPuqXffQ1bHtWG226nG4gZ3XiCWsokj14mh9vVlTOifF20COAlnu4G
 4izc3hVcn8b8bsp8HpnuU9S9UQBARVFYSIJyc6ngD0vquZ0V8FPz/v2dmsVOVm9CvLF+13eIh37
 qowedO59tvd7wez+L+Tv9jxzE2ye33CgU8hI41OBEx8uejw2e7FhOu+TvjHyeKBUOst2Ggm+28l
 pI9gg29OLs1gqb2AncyjLSxcTEFR8ginlAZ5dra9CZRDuSVtL9Km5qx3dmnvAL9S/RlGONXxtdM
 B3P69strVQ34XHXIKlFSk67hui370fzA0O4EEDErX7V7Pk25L7JThJfQhGccT6IXseqvWx5/LZo
 jU76ZEnuyLG9AUHYGdA==
X-Proofpoint-ORIG-GUID: kONnrZtQhmZ9S2_GA0C1xHSie5uTo-zc
X-Authority-Analysis: v=2.4 cv=cNF1IVeN c=1 sm=1 tr=0 ts=6aad0345 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8
 a=EzO2BoKCUxNfU9vyq0YA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180129

On 9/15/26 21:41, Vitaliy Sochnev wrote:
> The EN7581 IRQ is requested before the thermal zone is registered, and
> the handler passes priv->tz to thermal_zone_device_update(). Unbind
> leaves the monitor interrupt enabled, so an interrupt pending on the
> next bind fires while priv->tz is NULL. On a Nokia XG-040G-MD this
> oopses in thermal_zone_device_update(). On unbind, devres also frees the
> zone before the IRQ.
> 
> Request the IRQ in post_probe, after zone registration.
> 
> Fixes: 42de37f40e1b ("thermal/drivers: Add support for Airoha EN7581 thermal sensor")
> Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
> ---

Applied, thanks

