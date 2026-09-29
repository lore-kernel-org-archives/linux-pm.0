Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8753451D6
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666124; cv=none; b=meXWdIbRrOe9rZPCd1EtmZtk+jlaOaWljAmkgOa9jFaLBHidhXxoKwdPh1bvWc+tDg0gddAsIyMLdk6qDKsCcB6N0ag/zidVV2lIrfHAKbz/Q9R/WicSd1afNbOp0wgot4Grp9cx3vwQElxucgxYcNMr2M6lF46k1Av3ZknStG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666124; c=relaxed/simple;
	bh=qszUiDvaOO/n1E+7SSEf0ZKynE5xJbrnBglcmF9RpRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkQHgnYoGnrE7GfX+PmXIxtMqe3jfMpILka4/BqRqBl3cVhrtWVGaDLOH+ed18Jkfq3siSIvdaKa+K+PIkuyD27I7m2n3r6bv1X+pIl1a3F+YlhRpLvvcwKtpq3rW3fe2lQ3rYqJ7p48+0cKvX+5qAumNU3fOGffKpw+eUhKfsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I2N8kMTZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Oq/BQt96; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I2N8kMTZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Oq/BQt96"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T47KgZ3241645
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 07:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/utobSwhxghVA2xnPXVZCi3XdzkIWIdMCAeXFlgaONU=; b=I2N8kMTZGHQUaCTS
	cfu1f1pKXwfVUf+TcGGez2yj0leuv+1uMJLmWRaeCYMaOuoklGOaGM3srSVhePBg
	QgOcnyNbKc3TmVKIbymmWpnkEoiV81kE3OqOSpv5AWUtJg/GOMmZ5rOy+QdEK1c0
	ci4cjR/5G8sVnIRhLpkku6ywTlwKmh0YmUBCfl80oGRV0vl+Qyev09fuEeDpazRd
	XNsVffcSLDE/JaGzMYO6lK+HR+FRH+q91UOIOSGh3wg3ZafqaUlg5lE7FVLzn7zu
	kMy/lIkdxqtJm4h6oytwB3zeBaRHtESWbPRZqFkZgumyia/EkqSCk4UVYGs6DpDv
	i1Z3jg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0144snj9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 07:15:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93a08ff8451so677444685a.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 00:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790666121; x=1791270921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/utobSwhxghVA2xnPXVZCi3XdzkIWIdMCAeXFlgaONU=;
        b=Oq/BQt96Qx6AyDuZDZcpm6f2daCXAv+3ly0W2eliq8mszG6Uk6lFY5OPEDR1nVS1SU
         lzsNwpleQ3yd2Umv1qq3EqgsU2AWVCC/prBEAd5G/I4HepXNTQCf5TfQ+anqVb3j3wbK
         1tkPscuz9hnJ8aUSBvfP3YTQLaHhv1erpQ3ki/GfY1YnhmEd3ntPp6pr8Hfif5R1/g3v
         bViPjwU+V+/F1csnunPhcIcMnLsBUYX2zmchzCmGHWDNmqzbIqP6LXLQWVOrxFWT2QRn
         P3gbVvgY83i5KqoFXgi8I475fQuLyKMsDtq+iAn5mZmQQc1E9cSK7QFqxHncoUVp7Xl9
         u7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790666121; x=1791270921;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/utobSwhxghVA2xnPXVZCi3XdzkIWIdMCAeXFlgaONU=;
        b=I5sL4wojjkn1sCk/7+AIqsqwXVk0rA/m3g9fKRWINaEIOoUKoukY+1qZfdpPjj3z8i
         wmc8Z+PehlBTLm/gLaUXeIssoZhDa/J+3k02PjCfoW4JAgf9vChKsaZfSWEOuItqobpa
         vuuDVYQtfH+J7btcpgdtJrah0c6knGOlGs4mn2LlA8IPWFOkQY7NlWxEUV01CtW8B47Z
         WXwFFX2eY6HnEkUQhunCjW0iFpbXNzfeCA/Kf/HxKgUEQ39zwbOagd8PpGgv6/OadFAY
         htbB1eZjo4plo0YDp38W8UdES4Gbzrfm4OS74hlv5faLm0+UA40YJpmNVtIoEHgRe41H
         mzmQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1KYK0sQbIHM4HUkVC5m1UEzGIV2BFHJig9TE0YQOVxhbqs69u9hKPxOfzAhIAjfgWYbZBfHKbig==@vger.kernel.org
X-Gm-Message-State: AFuF++npssu5RzHzG2YdOA/gH3+sT85QXWI0D0NcjpcsKV/SoiZYEwzY
	hUngFBuzhgUyjR0FjFTyprecZvSr23Ycvm5CjYIVdk1xGPkZYXvR21OoolZwU5AqLTGzr8L0sDM
	M5Q7taUrsPNCinh7uTIWkwmWz2N+w7B0EGiw1nMxpZjEJWobgBzOL/ZEdBUGaEg==
X-Gm-Gg: AYBFou3+XcsruHwl3wF8RVvRCFFEN5rEM/1iSkqZJWVK+4A4XgzLk2SI4/ihGAb+I2b
	591yWowNO7C3ylhYIyDgq0cCLPaVGWWwP7bbj7RHhRs3dwoqzIT7pNxFuj8HA49jRmXNV3YRsLq
	OyxzPzZnvfvngAV3vOnfIh/VnDKuYNhCa0C4ERK0XYK1rOpOB8aYPRUh0lzFeAy1SukU9XH133x
	PEQhR6i7dUGpVknbKVAeICLoRfN6aTvdo7mHF3FlVVzqmOsWBKXH0H2e8e5rryIYPeh1dfG3SWd
	kvhRZ+8NRSY88lLQHkt9tHff8k1SJh58bm7mpxAP7ByAytxaQlh8X/BIZyHqB47ceEefaID1fGF
	2n0rLxJQg+rtzq2ZFslF80d/pX/UMJDdnASgHQgKSWxHJHsBaWzYNe6xcsWa2mw==
X-Received: by 2002:a05:620a:801a:b0:93c:6f0e:8468 with SMTP id af79cd13be357-93c6f0eb1e6mr1223984685a.43.1790666120463;
        Tue, 29 Sep 2026 00:15:20 -0700 (PDT)
X-Received: by 2002:a05:620a:801a:b0:93c:6f0e:8468 with SMTP id af79cd13be357-93c6f0eb1e6mr1223979785a.43.1790666119968;
        Tue, 29 Sep 2026 00:15:19 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00c0730a8sm58408545e9.0.2026.09.29.00.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 00:15:19 -0700 (PDT)
Message-ID: <4005518f-5ca7-4849-a256-5c3fd481f2f0@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 09:15:17 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/ti-soc-thermal: Cancel pending alert work
 on remove
To: Weigang He <geoffreyhe2@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260926124931.3599746-1-geoffreyhe2@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260926124931.3599746-1-geoffreyhe2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyOCBTYWx0ZWRfX5KTBvsWkDjd3
 3D81co+FaHH7P9N/narQ5ewXX5aVplRvEBCHa6WxDJFjMpZdqRB4cwF2VWalrwzTVwNMGPnYdBF
 k1vOCHgZi7oM6LsjzDT1+xKd3/7Vmsn4As3JPGEmNSt2AZ4/A53Ibv5/zkSKk66yuHFifiesSkI
 D6PWdGDoYq8p9APEplwUwsaDYOmUYnaHfamkF22vODlNHBCoJrVLu2GdOK0eaM59kx/zXxnWZmT
 rkFz4v6XfsU9ALQpmnPW1bmfw4TfwiFDzzFYGp0v4pnuI636k+0BHGUmbvTO41i5Kd/bSFxmXzh
 fvTx7KCmLFzEyH84lWVH7Bvhw3XnjZ1Y3CSoDKn90H3K6/infXoSAPTAm45mqiH/D45WlgFhMwm
 bqQnfRXDy7o3TdstI4OkQjBIGMCz6mfGuJp6nNQ4oHxu/HwIF+B3PhTJGUnhr5+N7y7z0WHwaOe
 m+W/zG7VDm6EhjKnTQg==
X-Authority-Analysis: v=2.4 cv=FJSOVOos c=1 sm=1 tr=0 ts=6abb6589 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8
 a=xTF1z28j0uidfqTO1jQA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: yjOZIVW6m0fRCVkBZ1zmkA0hdlETlyTC
X-Proofpoint-GUID: yjOZIVW6m0fRCVkBZ1zmkA0hdlETlyTC
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyOCBTYWx0ZWRfX06wpiX1FubXS
 mzFCsjoIIearlTMCSvyaT50R6W1UEemoGLctKuNE0V7ZSPEKhUHwQO56ARneCW6xzOvqqJoMSRw
 iSpEn0PKxEHepraFA5I6ROPttihnyCg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290028

On 9/26/26 14:49, Weigang He wrote:
> On a threshold crossing, the talert IRQ handler calls
> ti_thermal_report_sensor_temperature(), which queues the work embedded
> in the sensor's ti_thermal_data on the system workqueue. Nothing ever
> cancels or flushes that work.
> 
> ti_bandgap_remove() frees the talert IRQ last. free_irq() waits for a
> running handler, but not for the work the handler has queued. When
> remove returns, devres unregisters and frees the thermal zones and then
> frees the devm-allocated ti_thermal_data, so a work item that is still
> pending runs ti_thermal_work() on freed memory:
> 
> 	ti_thermal_work()
> 	  data = container_of(work, struct ti_thermal_data, thermal_wq);
> 	  thermal_zone_device_update(data->ti_thermal, ...);
> 
> Free the talert IRQ before removing the sensors, so that no new work
> can be queued, and cancel the work in ti_thermal_remove_sensor().
> 
> This needs an OMAP4460/4470 or OMAP5 SoC (DRA7 has TALERT but no
> ->report_temperature, so it never queues the work), a threshold crossing
> just before the driver is unbound or unloaded, and the work still
> pending when devres frees the data.
> 
> Found by static analysis tool CodeQL.
> 
> Fixes: 445eaf871bf9 ("staging: omap-thermal: common code to expose driver to thermal framework")
> Assisted-by: LLM codeql
> Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
> ---
Sounds correct to me, so if nobody is against this change I'll apply it

Thanks
