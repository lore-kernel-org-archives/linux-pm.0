Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B9749365C
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789991847; cv=none; b=rVTpUdb6FFojB+hzQ7+iz943IvDAdbRyuCeQUcVZtwGN1M22PUsZphNPR9U7+0yrOMQxeiuvpzjAG1AjbQ28bgDgkx1jUlydFcyaBQo+B76j53rbAV/dLv8y37LxbdU1T4J4s5fnosgNJ8eGvzmiGSyX1TuaOgn5NNCZBqWSB0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789991847; c=relaxed/simple;
	bh=a46s19uWMHTS78Yk2h9EFiIv+mAg2lXYSLAayKFym3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEq2qJGsIstG+9rLCA/fTV7yQ1L3ZWrTtIyKfjpnL1RqSRgEyqXVzsBFqJDrN1paJ2eUY3RF4pBJfPZvaansR4OggtSFswn8e1Mf98VgC5exYEvrv3EldkNrYiluuuc9g+aYwiXbU+Agf5ftHQE9C+LWJcY3t+hB2fSnF1yYfco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pgHLobZB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NgnWTCkB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pgHLobZB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NgnWTCkB"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAdupr228044
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 11:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=F+U6g5gueqDjL4Suw8UleQXx
	rIHFe/2S/+8BIIcGQr0=; b=pgHLobZBOfHsMyw+OWxY2u8iT5WDP9oh+b1DmWsl
	dt9LLDWr0ukDkQEmOADsor2bML3KzNJEYXskT8A7puw2q26mtB/6R3kJ1Q1cZyyC
	sAW94fGT6V9SZMFzsf6p0Dk0EpXt3eWAuLuG6WqSRlXr2lDUTQ41+J+5r5q3hj90
	DbSjZji1h2PLdIlt2j43EGBCtfnEqGX46HsHsJOihWCcQXcVV1T+DLLp5Z1Uk3K9
	cH96xumFOAn/cjI4+GOFbqG1u4A3PJs8lwAzXJlKpYmF7IRzT2/XiZYh2zXjpQWf
	lLgEYJ/PlnavuzSp43wKCq14NUiwP/IuYBmY17+qqbNz1Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu17grsjc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 11:57:25 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso5283467a91.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 04:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789991844; x=1790596644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F+U6g5gueqDjL4Suw8UleQXxrIHFe/2S/+8BIIcGQr0=;
        b=NgnWTCkBBj20/b4g42D69Jx56HbtyEg/RDFU/uVRCeLsxhG2w4K81xWPIV1PVVNo+o
         UKkbJ1cfvyuO70F7Cr+ckDAVBuprSCqfJeY06AV2Gxmalue0+3TgRH96cl22ps4LJaAm
         pzEbwx59fhR4VGMJVYmVto3X1UnpUFTGH6fvMtbssKK5IheKJ98nxWqDMrLw+to1kjwT
         9dJ8ygHSAKtuQlC52QSbAmMjB4uwKpb170n/tHrPOLWN5U49NuJTTtMLyjF3nW2lgVqU
         Zp4LlrT6VZMBjADCi3RqPgrubAEKvNGKw8i5/OaBNEyg27VYGGPIjDtPTJInP+bgP3Ve
         zYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789991844; x=1790596644;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F+U6g5gueqDjL4Suw8UleQXxrIHFe/2S/+8BIIcGQr0=;
        b=x8TQznh+zI3jH9ojZzlq37t+cDn6l5SLPJoQjJ6YI3oOK1H9OkFJsQpEKzjZO21Mwt
         9VIDNudrDLiGumsVjCbNyO7NdBfBCK14yUkBJnT5NhecBTRQexPAz2E24+yrJGETJEnk
         VlU4d3LBx0e0Rt3neOBUFyAE60zrqcLZvOtsd/aJHcPFJyohyWtaSz8rzYG7Cxt1e2x8
         7EAG/ZacyJAFW5HkY88PAtpCw8nqROm3T5BU05Hhw6paRntyFEErIKHKUuSx+WumNfyj
         hQO0+kbXTM2ThCBXX7Uzfv+jRaM1HCszwTS9hD3ZW0jRcq2P8UtPSvVgg/Q8qVktaxuQ
         SHrQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBMJOmDbxGbIIOcvvWj5Ln/hVo5NIGt6cXugj7qy4Opyk/eHtfKymxq+7wvzhMj39cyXdJlQby8g==@vger.kernel.org
X-Gm-Message-State: AFuF++knsW+LBXjpB/4zw3ONIa/3Z9v0dHKlIMTAu6F3qIP+OCf+hghp
	WQv6nVCLJl2x2FJfgrHar+v7RsBN6GPw3phDXaTESQgcZxDBD+53EZpNvCwSmIea7RY5JY+BcyB
	C6oHtzBys4/VEE73CtDFi02DBwp0P6IXmfaNuugG9YOcjuCgoNvE1zLxVC5i38A==
X-Gm-Gg: AYBFou3afah51+nXMapg4DmXyd5JFaJyJ6zWcEwQNt5ItGyQPPX6KbQRqRSBmvM5vkT
	UEFn91aJe1L8BHcuI1qnC3cTXiT5NpqwLY8UBYrElYSxc6m9Pvb20g9KH/FDJD4AjPN/0O9tVTJ
	dNHYYdT8Q4OiqS5p+tkhM6m9QFXp0P8xiIoEJ8PALEYq26qQEtWLJv4MK7TCcaR1FAxQ0nXI62K
	uZHXSAl0/peRF/ukmEoGAkQQYxXJkolC75GCiar6i1pwidLWTCsq7YYge82DRLtjVRwmWgvr1tF
	LWwHHuEpk5wB5pr/oavHT90iDLETSZx7jNiR0gq4vqERCTNF5c73ROLl8Oh1oe6CXP8yP++TRA0
	eCqYVQfSVOz8vm2hg1a/nHClwNilyWSZ1mXH255FkgggAeF3NuZs2pcKcsgIpyOmmGoOgFBYSvD
	6rdKHC9R7s1tbJ7q8=
X-Received: by 2002:a17:90b:5903:b0:39e:d36c:ee54 with SMTP id 98e67ed59e1d1-39ed36cef6amr9098559a91.5.1789991844483;
        Mon, 21 Sep 2026 04:57:24 -0700 (PDT)
X-Received: by 2002:a17:90b:5903:b0:39e:d36c:ee54 with SMTP id 98e67ed59e1d1-39ed36cef6amr9098533a91.5.1789991843977;
        Mon, 21 Sep 2026 04:57:23 -0700 (PDT)
Received: from hu-anancv-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c3314313esm19915703eec.14.2026.09.21.04.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 04:57:23 -0700 (PDT)
Date: Mon, 21 Sep 2026 17:27:18 +0530
From: Ananthu C V <ananthu.cv@oss.qualcomm.com>
To: Oleg Keri <okerixx@gmail.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
        driver-core@lists.linux.dev, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/2] sched/cpufreq: fix schedutil's boost frequency
 handling
Message-ID: <arEbnqUuOroYX1oG@hu-anancv-blr.qualcomm.com>
References: <20260908-schedutil-boost-frequency-handling-v2-0-25312a713699@oss.qualcomm.com>
 <178966110618.2386.17602156528185920946@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178966110618.2386.17602156528185920946@gmail.com>
X-Proofpoint-GUID: hKCMLSkxog_AXuT2ZTfZwZFDzZpiobhc
X-Authority-Analysis: v=2.4 cv=IewSymqa c=1 sm=1 tr=0 ts=6ab11ba5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=snW00zfRmaIRln_NaNwA:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3MiBTYWx0ZWRfXycysmhwRLUon
 IeHifNi5Bn7T9BaMXrdqfaFT2KGBzSKaP8rX+lX4vJg0wudxJ1MQYUXuZ2Lrdm6i0GIZ9gqakmw
 GPHdWShU61cs2pGbI+B+UwuZwyiuok+hr7lpr1MotcQVbQUtsSGvc4scrJeEdFUygRa4Ceblrm2
 3G0tewGILVVG3ZhkAYv/wBhmCxNP2MqXmFxS7gSm+kJ/PdrGxDIBRcgWWwcti7nAfZXqC8F1zbl
 N/7Ew11d2vykNejOIIwra8CN/aDZzRlGJGh6C6pYK+dUMNIKIsmMjSD1HYzTXGH6yq4dZps4xHw
 Kw92rvP/bT4xAAF7rUUkMbTOdl4taMhILJJXB6yjx6xPAeg8DFnXGpZqWYQ4TKYoH2iRHltuccI
 M47mJdizeLN4DAjC0MZjOFsMZOkVeDiVwO48tR3Lwr33ZXu3zAWGcGFm4vrmxu+51GSQOpyc4Zu
 FHZg+Kk73lbBo5p+W5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3MiBTYWx0ZWRfXzmcTVijN57QE
 zfr8R+sZcvbV4cffoPF3yUs2rOF0UdwoiNp63YpREEmrLgm4gO9SCc60MjHC0FyA12Kaj1pmVg5
 Ncrju4Egcfpk9Uztjhu+N49n3+zDhcU=
X-Proofpoint-ORIG-GUID: hKCMLSkxog_AXuT2ZTfZwZFDzZpiobhc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210172

Hi Oleg,

On Thu, Sep 17, 2026 at 06:05:06PM +0200, Oleg Keri wrote:
> Hi Ananthu,
> 
> Tested both patches on a Lenovo Yoga Slim 7x Gen 11 (Glymur,
> scmi-cpufreq) on top of next-20260915.
> 
> 1/2: with boost off at boot the little cores get cpu_capacity=553,
> which matches the 4723200 boost maximum as the reference (4032000
> would give 647). A workload pinned to cpu6 runs at 4032000 with boost
> off and 4723200 with boost on, 3.14 s against 2.50 s.
> 
> 2/2:
> 
>   # cat policy6/scaling_max_freq
>   4032000
>   # echo 1 > boost
>   # cat policy6/scaling_max_freq
>   4723200
>   # echo 0 > boost
>   # cat policy6/scaling_max_freq
>   4032000
> 
> One observation: policy6/cpuinfo_max_freq still reads 4723200 after
> boost is switched off again.

cpuinfo->max_freq has a guard that only updates it upwards, so it is not
able to come down. This is by design, to preserve driver set values. That
is what the second patch is trying to work around. Runtime enforcement of
boost frequency handling will try not to rely on cpuinfo_max_freq whenever
possible with this series, allowing the value to come back to a non boost
freq.

> Tested-by: Oleg Keri <okerixx@gmail.com> # Lenovo Yoga Slim 7x Gen 11

Thanks for testing the patches.

Best,
Ananthu
