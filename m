Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FCC33D506
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778239556; cv=none; b=kQlwS5R5zzXw3wjq0dNQ82seVkjwC2954X+rnFgDTCT8lVoiJ1R+Do7bxREWwn7ejomZD4fCaLd6jZBIratCnXhWdDEQI0dz5/na8Bwvg2Uqkf6ycAz7oWibWL8gh9Napq6WW3cYBJ+DoGFxMHJFWHgL/B+6sGxKUFijNxO0aqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778239556; c=relaxed/simple;
	bh=wD5j8rt0dSEhF0q2hMieIlg5zWqwgiIHlW5Kir+x28Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q2bgFKCkC7yGLCViAX3lsdppM3aexy76q16W2AXvOgQMCHoWCYT382giSIgR4Cc3fJtudoVuU8M7Vxbkc4BMzjES6hWV0iboaW96ER7/86/LbOAMKsfINMkudEXMaNtsrvQyOTV0wkWU5roT/R4rfWqs6GhcnPBDj2pSxhLGJjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A3FfqYFH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=boagcqmC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A3FfqYFH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="boagcqmC"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6487OiUW2384344
	for <linux-pm@vger.kernel.org>; Fri, 8 May 2026 11:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g0jTW4sKikY/wqz7iN40y6tzI3Wvh1YmdS9omy6vL5s=; b=A3FfqYFHipDqEGBb
	ufOskjXITkepCCsoGU9ES5upnvlZI6IW2086xNDJEeANMkP1G+qilCw+6DqLZ96d
	y8FUoyhRUb5ANW/7B6VXMkgxS6tDQ7zqq7jTEIg9AEt+ZIDOM7tNyWOg/uNcL/ML
	fPwgP/A80wUoOxmNkC3PRfp/+QKovvuGBHBFXfxX7yhJdGtjQl/ka2yuMODBdW1K
	8jk3pI38RWH9u2gLDlL5zv3MI/IH9+tYNgJxC26SR6Hcr0Y19kaGEAExIvgG/6NQ
	0qaZ8HmK41X0cJWheYh+M0nWYZR6i+86tJQT0UTYK+1K/AlomTbinxyDR6nLm/Je
	w3Erpg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0wwukupe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 11:25:49 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8b52bb3ff88so67976316d6.0
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 04:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778239549; x=1778844349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g0jTW4sKikY/wqz7iN40y6tzI3Wvh1YmdS9omy6vL5s=;
        b=boagcqmCWiw2H4Faow9chO++NNVT5gOc7EdZ7avybemP2ZMw3Bhmj0oWH6e8uDlRDD
         ndTHjFXRc7pvwahxtLDK7yawyRQTDi+F/kVIvDlGinrZnU/C/9GNMr1khGovueBKkvsM
         Ur6FSLRYgT7vpQQ9ZNkJ2LvG6OENYlpuYV9521HnAZBuvVxJlGALMXZfvdKR5laVL8Qx
         EAjJZHnmLIbeFLda8dXCy7epf0Yor7SwHGGmunX7xMHdrvTeOtx0CozRfWLCA7rjaVz+
         ihl2I19/AY8dHwsutDTmae5X7MDQk0HhCX4xlDGRrH7VRuzIRRl78f4OG783kc/E/h0W
         C1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778239549; x=1778844349;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g0jTW4sKikY/wqz7iN40y6tzI3Wvh1YmdS9omy6vL5s=;
        b=OFN4mlWFlLtwM+X1FeQobYH9AwzY06PzZUUxGZjjsB3zhGsXfEo4J328j05ODgw5IS
         NvZGiR6f/ilb/xkZlBefyfictFHOGCSi1ZKjlMMIX6YRgVRXLxJaNwshTDw0P+UFwCtj
         oKNXXRqmyRh3ciiDzIbRTOXs7TiPpFs2F/9Wa0vicjBRsZ1sgbg+Z8tgnzgV0H/umHtN
         mZhL2MUTzsF1mqs7KyGkYeGJypnR9bGwWDlzxDu8RH8ljvFIrFB3HgT8rDRild4mRaPG
         uDzzYxLi+eTOi7fSdiPbpVivlBcABtlCDMN1vslMJSk8DPtaNWP+L79WCCtkATRdC4fe
         YF0w==
X-Forwarded-Encrypted: i=1; AFNElJ9XT1tfByrbqe2chIQVG7M4Cxw/ZnSnWEq+h66I0T0zB6wll1paD9eWkhMYqkyft5ZmxXDYWH1CJg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh31+KhKwdOt5ovSXBPE9MMBpkrk0PwAyfs7x8armBwQM3PFjC
	K/6JPv/W+fVaSaGQm1DMjLhu3CW71yG7WQKDQCGUQWgw9g8T1PmabFyLCjXRonWl9eemIKoQDXW
	NDDTo0h/s+RgxKGpB5z1QpUZX7SHcvO2QnKXpoUZYV/tvsKfJkzhYukuL/bAzzQ==
X-Gm-Gg: AeBDietpS7vb6ofzPfl0swtu/P8HkoE6J0Kpwe3aPCqyLLjo/Uc+z4vcFBbeCscLegT
	zweWQU9IcwocMPDGPxtk98EvQfPXk38Y44RtaoISzEYVNjr7EkvbtZT3eqBGgfRaHG6EDWI+OBx
	wobOOhtvgW50ElGAWoEG3lWv1AbKds6rt9X0mIuctQPfCLbpZRUcE7bctu1ASktcF1zGaDKc9Co
	yd1VNSLjhn4AZha82fJChBIcUTOsUSXISL5U8nc+K366nmjLuFCS8oqwnHDmgza6ioOdIRhpO5+
	jvi+geY16Wgwdlsv9Q6hmH8I+qcySdJcfNhciPAEuva3jIkzRUFGD86Yyl8Mep06ayOHkdO+NCV
	/0XA+/IWKsfYRzFxiyid5N8kVYknUhnKZLe9Md7tcUaQKwlU6vGPY9ZZb1kPlHDU8zy8yIpVZoI
	MxHaHNASQfodPpxXC3QQs=
X-Received: by 2002:a05:622a:178a:b0:50e:5a1c:d807 with SMTP id d75a77b69052e-51475c1a3eamr83898031cf.27.1778239548934;
        Fri, 08 May 2026 04:25:48 -0700 (PDT)
X-Received: by 2002:a05:622a:178a:b0:50e:5a1c:d807 with SMTP id d75a77b69052e-51475c1a3eamr83897821cf.27.1778239548539;
        Fri, 08 May 2026 04:25:48 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:1bee:ca9c:164a:a7b3? ([2a05:6e02:1041:c10:1bee:ca9c:164a:a7b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e4bbebdsm4002131f8f.5.2026.05.08.04.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 04:25:47 -0700 (PDT)
Message-ID: <b120e546-2a41-4efd-b0c6-8a63eb5bbd93@oss.qualcomm.com>
Date: Fri, 8 May 2026 13:25:47 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/core: Split __thermal_cooling_device_register()
 into two functions
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org
References: <20260505144447.2853933-1-daniel.lezcano@oss.qualcomm.com>
 <96515043-d9be-475e-81ba-71a8fbeeaedd@arm.com>
 <e7d09cf5-e653-4668-88a9-b6bf51240ac2@oss.qualcomm.com>
 <70f2b2b4-6066-4c48-8834-b907b5146a08@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <70f2b2b4-6066-4c48-8834-b907b5146a08@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2tBeZpOwqJ-3_m73KqTCfwtDlquH_XoO
X-Authority-Analysis: v=2.4 cv=Nd/WEWD4 c=1 sm=1 tr=0 ts=69fdc842 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=cq08qmKiVzzLYLijMZEA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDExOCBTYWx0ZWRfX1Clx8fh+2Ej0
 cGLoZa4V+Wi3/jpdba/cA2jueh9dFCP8M5tBVPGcsHlkuSdqfzVoD41xlTvI35xZCPeFbpItbfr
 Wr/+Kf6jkomLwBABzd14HMJQzmi8CxEptOsZXYigMTX0zvsbZoSRChMP6o122D6poVJWP9xKF8A
 IH/pkUhxmkxzDKfXGZ0w3A9ecW6sXRlXvqCSktnipezKvI6fycdY/Qlnd0SuEANvEffsnTFd1n9
 16FSou2ONRjBk6avHqXcxWJGQY1a4+Midp7zqomyLsXB4cbMlkrfIlhAraHnr2UVFhi9cuZPEwn
 /tSOdolKoRC9sqWSzsrhqpaUHGn361dTexUdQ4FnaV1g4t5z3/uD+DW8BgTc1HrXWpgcY9E2b4X
 0/mcNf4FdajofVqW8PCdz/MYoOowkUjv4DfiSoqbLxcMsDSz2sr8ScbdkDPhEQC5tzFppiwrMiW
 uM2h0+YJYcp/FQPiJUw==
X-Proofpoint-GUID: 2tBeZpOwqJ-3_m73KqTCfwtDlquH_XoO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080118

On 5/8/26 12:35, Lukasz Luba wrote:
> 
> 
> On 5/7/26 19:26, Daniel Lezcano wrote:
>> On 5/7/26 12:02, Lukasz Luba wrote:

[ ... ]

> I would call them explicitly in case of 'if(ret)'
> error from dev_set_name()...
> Then the rest could end in case of error with that new
> 'put_device()' logic at the bottom.
> Would you agree?
> 
> A different option would be to refactor thermal_release()
> and somehow recognize the cooling device not based on name.

This mechanism is not adequate.

thermal_release should not be used this way, neither it should be needed.

We should have:

	thermal_class = class_create("thermal");
	if (IS_ERR(thermal_class))
		...

No thermal_release needed.


But,

static void cooling_dev_release(struct device *dev)
{
	thermal_cooling_device *cdev;

	cdev = to_cooling_device(dev);
	thermal_cooling_device_destroy_sysfs(cdev);
	kfree_const(cdev->type);
	ida_free(&thermal_cdev_ida, cdev->id);
	kfree(cdev);
}

static void tz_dev_release(struct device *dev)
{
	thermal_zone_device *tz;

	tz = to_thermal_zone(dev);
	thermal_zone_destroy_device_groups(tz);
	thermal_set_governor(tz, NULL);
	ida_destroy(&tz->ida);
	mutex_destroy(&tz->lock);
	complete(&tz->removal);
}

In thermal_cooling_device_add()
{
	...
	cdev->device.release = cooling_dev_release
	...
}


In thermal_zone_device_register_with_trips()
{
	...
	tz->device.release = tz_dev_release
	...
}

