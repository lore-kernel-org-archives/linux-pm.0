Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB994756D2
	for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2026 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869545; cv=none; b=kEHbx1/+tFbm5zNpTdlTtABN8D7SfpDgGyIwN9uqF+qNMYZbHdpSRhLI/VMRW+Ur7xeebPoeA4OanC+Vwx+4PYPo/XaWA6HyfMX2d3hXRjjdkqD3eiDH4tHXksqX6WpNBWBYjxD/pqrE4aN98VgArW3usVwvVhoH+7+d6YtzFwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869545; c=relaxed/simple;
	bh=qplbsh/mSXiKomLy1bCLaoHsZycFdQMuX3h8VoKxnpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LqCCB5jSYmdgL8NzrRHDLpkbTPax8HknrERGs/YIjSQkN2dFksGRGFuNbd4ObSvSHkjknpMzWnij4U0jgkQylUVLvQRxV1Dcigf+X9UjYlgkJhhWv3SGb50ga7QLDQ644kZsA9KNxrVOLKknoMPsoLPQTvjVZF3gqVH122P3zCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ovAkk72E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Iw7boSKX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ovAkk72E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iw7boSKX"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674H0Igp580152
	for <linux-pm@vger.kernel.org>; Tue, 4 Aug 2026 18:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YtP2L62OBcnos1NyatTDhxKiVMhFH9/cdtH1RA7Q+Js=; b=ovAkk72EHYo/90hU
	T2pZh4UCjmwOPBXq/jEDdFzONs5oBoPsDyf+tRP6MVGxkHK2oosn2Dj6c6Zp0IN0
	yDkJZ2SaO05kXBs8r3HAp0cPpmW6tT31Evco7l2usYJqaZzC/wypt1evByg2mjFF
	xYZ/w5gMtmNI42ByiUJjuTtUU1xONCTVymnnxwXKeBmh/uV88/63phP9CQSLh9vg
	J25aULN9xUbUopCi6l7ZgSoxhtimVFtSLxUxK7zTzrPOPV2iMj8y5w316C2hBdtX
	+YtLm1K1K28uBkuM4AMsmsgjH6O8B35E7v2dPt5fp6SE3G1qrSjvlhY4LIhmL3RU
	x4+jkA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fum3q8hq4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 18:52:22 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb48f41343aso1028258a12.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 11:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785869542; x=1786474342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YtP2L62OBcnos1NyatTDhxKiVMhFH9/cdtH1RA7Q+Js=;
        b=Iw7boSKXKeSBC/EvwVuz/XakXFH1o/9dTsnm0IBNg+35Ku1B40NDaWJvzSD7pQuvP1
         /+Z20HQXuzvrA1vzyULPqNMOSrgdaHznVMEpv/g5ilRNIIIEPiVgWs50XnxCElFZCnnx
         dtw3l6X7in5+Eat9LyVkD/1uJtBa5rThPAdXzB2IMcc+yFNqvrDq3Aqn3tA/2l5psZbn
         Ecvo9kYVhYHbdgNJm2N6ijWAqgrjwBhEJS1JmjELQ0g/KNm0Z1Vzd30LwO6jucfi6rRy
         o5FS/tl43VXWHdmXjMQ51NhvuIdG7DhAJJVg76ICjdofSZs+71RlDGySpMXUjCByVS3v
         LX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869542; x=1786474342;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YtP2L62OBcnos1NyatTDhxKiVMhFH9/cdtH1RA7Q+Js=;
        b=S/C7MYppFCwWzqUiCvYxoIuISKVTHqGExcOoNE2LzTZ11FCX8QmBV1pLnZVa4nTzs2
         qct97JwwcKBwSIiu2emf37wHkteMJ9h3dI5SXfF3FG7wDuAO9+q1MJsgW1HDF8OnzpSN
         iS6uv1apXGctLiGxizW9uo3okvHetWeOBxIE/nKPkwDjCVQMMQHYPwmVa/eT+hIV9fGR
         ZuZHojtRl07DG4fMb0rCVhv3JUmQO/ZzZSQ1DEcmqIPHP5CMgsMQyv73RVg80gV/Rw+3
         Gbonspt2tAw//qafwujvsFcuxMgi6TPtXMTYpUKbikBJZ174Vub2tKs7/GD2pF7XiZt8
         OMHA==
X-Forwarded-Encrypted: i=1; AHgh+RpRo1D4qawoHqTiKqC0bfiE2pTSFKyEw+qdUcgoMcq2S5l/n9RFFrFSOSsODQ6YrAHE4v/XyyDk1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGV1pw/gMTf01wyYxuG/933GBEqrxmeIr4sWFPeRgke4t5Xy5q
	6m3be5HYQPKiSXYqwG0PiLZuzUmeG2tCEiL69xWtuLWSxiVUtIpVMEHvSuoOm4TrvYUwBawzNJz
	6r1jK0scYhB8fHB4Z1mTbKPMAziXRiGwThSq419tX05tTVKXKG9KQxFABBo2mVw==
X-Gm-Gg: AR+sD12JcXZUznQKfPztB5GOygwkX3vraVqhh16lx5G+OO1xlkXlfky19pGzIUnAPGR
	RSaP4hZV6nCtvUo2827IoTuXVYq4XXnZmu3aYBHltRzrwWFKwhQ30hv90//6vgA/SdemxFEtAmc
	dzr3Z9r5VPGiRiHf226qjm19Z3WmIlRaZ88OyhQTz7OfcBJIHtW/9mR+YAM3kIE4+QHhHRYwmwd
	0dz+NNebKJbZWYu0T6EpkzUG7oR8NSzTO8ioL2rTIZL1bD1aAbbg2ISm/ifuW+DzYDiUst2s5G2
	L4SvfQkZMYZH6FSnx+Cf00oEbGTGGOsdtHp63L+hTDnIHocA0u41CoGLvkhbpI2sYhc8btbhVwP
	XN96hu46Ld3vg6u+5Auwz2/ccUW3SGEcW5g==
X-Received: by 2002:a05:6a21:9991:b0:3a2:ed4a:5d7e with SMTP id adf61e73a8af0-3cb6c9c1887mr5739258637.22.1785869541529;
        Tue, 04 Aug 2026 11:52:21 -0700 (PDT)
X-Received: by 2002:a05:6a21:9991:b0:3a2:ed4a:5d7e with SMTP id adf61e73a8af0-3cb6c9c1887mr5739208637.22.1785869541078;
        Tue, 04 Aug 2026 11:52:21 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.234.41])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586447d52sm6700712eec.12.2026.08.04.11.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 11:52:20 -0700 (PDT)
Message-ID: <76c03e2b-649b-4316-9c3d-4ce5d27a86e5@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 00:22:15 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 10/14] i3c: master: Add helper to query bus wakeup
 requirements
To: Adrian Hunter <adrian.hunter@intel.com>, alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com, akhilrajeev@nvidia.com, rafael@kernel.org,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-11-adrian.hunter@intel.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260804133810.184905-11-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfXxJc1/VrUAs7c
 LCq72iyPZhWOVqle5BY0278empS19CEBh+W8hPNXdrvckyQMWJSHyOBMfLJiBX83P9wAipqGiRt
 AZRrwcmkWSC/Qm93ItVAwN7+2XJHo7Fj4eD/gIPCYuzgfZOjMpm4yPag4IblampgDnL5FPBdHL4
 kME0CFFaCWWzm1/YPWVdYkSTZn6Aa2egw9DUFeYddx4s2CTLXRjrtKMqBsPgOW90r0Lji8wVMiG
 tUWLHwBzgi4bajeN5mlttPPFwP4RjgGUois+aZC3aRoJNOmhVXW7O68kGamKVzV3k6lmRBN7amC
 afrBcezMp0oJoTzP7eZ9/a6cy0JK7tsu/fOAlwQ7YLaCmsvAeCe1HJ8eAhJlS8eoTyerwTQs6xM
 sVDhkwmaeCr2PTdr89Vf86YupPF/gxYX2dFP51kncQgN1BtrsAia+5M+Euw2RKRA2kNaLssZq4F
 c6QVeo9WwySxB+vt5uQ==
X-Proofpoint-GUID: _uNenHqm2lTRBE2SnysHer1c6V2j8JCs
X-Authority-Analysis: v=2.4 cv=LsiiDHdc c=1 sm=1 tr=0 ts=6a7234e6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=/lQgZcjXNA7ZrIsIl4Cfeg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=y7ZiA1EjnykWbA9aLYYA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: _uNenHqm2lTRBE2SnysHer1c6V2j8JCs
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX3YPyQIEsZOZu
 +nFi3/bqwHWvMLpaZr/UfVfAGBIawMXxEV8SfuI2M93ueIKHO/ldJCpuPn0ySGQPpWn8P2BpYXm
 BC+NJVkE0kdLPVlNgJzLgrjIRN2wiIQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040152



On 8/4/2026 7:08 PM, Adrian Hunter wrote:
[...]

> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 8c9e62e6f146..baf4769f0512 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2150,6 +2150,41 @@ static void i3c_master_reg_work_fn(struct work_struct *work)
>   	i3c_master_register_new_i3c_devs(master);
>   }
>   
> +/**
> + * i3c_master_any_wakeup_enabled() - check if any device can wake the system
> + * @master: I3C master controller
> + *
> + * Iterate over devices on the bus and return true if any device has
> + * system wakeup enabled and IBI enabled.
> + *
> + * Whether a device is enabled for system wakeup is user space policy,
> + * settable at any time through the device's power/wakeup sysfs attribute,
> + * so the answer is only stable once user space is frozen.  Call this from
> + * a system suspend callback.
> + *
> + * Return: true if any device may wake the system via IBI, false otherwise.
> + */
> +bool i3c_master_any_wakeup_enabled(struct i3c_master_controller *master)

wanted to suggest if this function name suits 
?i3c_master_has_wakeup_enabled_devs()
> +{
> +	struct i3c_dev_desc *desc;
> +	bool wakeup = false;
> +
> +	i3c_bus_normaluse_lock(&master->bus);
> +	i3c_bus_for_each_i3cdev(&master->bus, desc) {
> +		if (!desc->dev || desc == master->this || !device_may_wakeup(&desc->dev->dev))
> +			continue;
> +		guard(mutex)(&desc->ibi_lock);
> +		if (desc->ibi && desc->ibi->enabled) {
> +			wakeup = true;
> +			break;
> +		}
> +	}
> +	i3c_bus_normaluse_unlock(&master->bus);
> +
> +	return wakeup;
> +}
> +EXPORT_SYMBOL_GPL(i3c_master_any_wakeup_enabled);\[...]
[...]
