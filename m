Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EDD4519AA
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 07:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790579739; cv=none; b=G0n6vDAAJu9GP0p99T5BX/SPaUqiN/ZPbKkGoJhPloJRawUYrBeWbC/lBFEFopb6Rtyjg7EHZAhtrrvcGjpUb4pHeZQUTZwsCJ8+mVPX+J9kOUm1KuCb+wWmLBRwDujpN57MLbO8r9LHCuZnzmmmwv7Tw9dOXHbQfN/S/Rp2Alo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790579739; c=relaxed/simple;
	bh=+daBNykDtoitVmw2pH2Lp/o+iYWPKsBbA/YVlTEUkHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9JICdTl/LND/emO5nWZjC9S7ECEaxcdgfwv9j3hCxJFte3mogbldiHm21MU5WQaiQ0pElLKCVI9a+0UxkA4cYReOqPNW4LsiAmJCF45OiriJnzMla8ejtIrIqwY/bCndLI/dkeCd3x6F+idjo7fWbvc8cvcdpEEOk495Te9FKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CZb/diIQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MGgJf1aP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CZb/diIQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MGgJf1aP"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S5P23u674084
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 07:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6QjPhn8BZa4tijFZnj8o1Lt6anEukICGQ77tzi/vVnM=; b=CZb/diIQd8dVEQ0c
	bHTrCvVycM3/TrAPigQx1a+c2JQbQdfSEOGxNckMgs4LXqXwy3Ts0Rwm5/G4m+X7
	l/cCgtwRHdXZDLXCPchgCt1nPzcV5tOmpfLnqt4fJAzrYHHFa0mjEiJD5dD9qNjS
	V7g4oHxKO7qGN8rkdiTyu9lBkeUbK8aYSlT2dYQQOFl1D6MkO2OFRmK1jC79NbEK
	hOoe0o+x/995EVPch4TUnhwuc1p7dREs8qT+nwOvlXMEz4MyoZ1OQJkM/b0R8cLq
	MMIJgOgZ14z5ZNJO8gUAx9+ut7a5PDWh4/RvpWhzJuvUXUEB2yZDIHPe5fm4n/yx
	k4TAow==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj2s0bww-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 07:15:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-934963b2bc0so708060485a.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 00:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790579734; x=1791184534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6QjPhn8BZa4tijFZnj8o1Lt6anEukICGQ77tzi/vVnM=;
        b=MGgJf1aPHXMo2NSg8ANo/WOfu+rXPW9VxoWnYie60BLOoVuu/J9YfBXFk77Qc8jK+9
         5ZjcDCQxNWPlkj2Je3ZuAbvAmxc9RrgQSB47MWkkjAWLkqNVhQapYzcb9szlgp9qsCW7
         n3Tdw/nIZUSXVNOdXZ/4UQmSIk0LoKJy5oQK26VmplR5uKi023/F0n6+ni3vrnvQQBny
         GXCDsF7Ac4onvVUGbqVGp3IOiw5eHm30vPNWlkD3rGj7l/xL0X0NTZjamKzqwh4DaCvT
         QPiWYqNWX6ZSeb80s/VeT1eS1MugI8sTXR5CF1p5K/YOTsYF9iGJqCcdseDbbR9TiiB4
         8M+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790579734; x=1791184534;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6QjPhn8BZa4tijFZnj8o1Lt6anEukICGQ77tzi/vVnM=;
        b=uRlnyVgknx5WWu4b/am7p9j7xv6K9vKqTshON9Nj6lrFqV09lR7tMS7wR3qRHuxPox
         IXAHZGexlO/yDTLwHW3HdpYwVtlj9j84O0bbiLIZAcM4pbbgl6tyns39r0f+PuWC/uFC
         LTzzecwsZ9gKumPa0b7ZYY8iEfd2a3fseJ6PnF6WBrM3Vc5h6+EqWlsvZpg/7Ue7WbRB
         B8D/0Guxdh6NsEYggJZjgqh+hejYhps58RXr5L27grkYIU8MRhua1G8lDjFGlSl/vWZm
         yBP67G8FSo3sSBi5NqEeKwhPcbuBthxkKeieu7YUqNSMJvuPrf7O6qdgMqj3dViX5t4f
         5+pg==
X-Forwarded-Encrypted: i=1; AKwUvBwadywCmSD7Oa/gUu6gJeQpq1+FR2yvZ5GQE6PomHIvhoKkG9ppoLBTVrnnyWNZHSqxw4tPUS8NhQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nAG/mAQDOzgXKcI7DFsuVIzZphGl0CfSWiNUrLnFfCJBzUhG56
	Y7yXndUDOTuMry+1w9NVr+pc+Bbue3OEvibm3Oy5GlhrqdpQlHQbW1TW9YzyWNARi4GcHOOCWsV
	zfxLo5/J2aVHiXWIU9c5tyPLOGYzCUQiddbIlKN4Zz7++cutUdh2SeoZJ+NbePQ==
X-Gm-Gg: AYBFou3u0TS3TE59zrWxjixlJ10R5RXZpN9x5HZmumroFtxm/9bfTApEmFw07wCheUV
	MTqiewAiVz8W8IS50RDy/zBYc2LBunCzwo7QNhZLSg5HWxjxOebvAMGuhcZeA1Dc/e9Sp4sLTd2
	Hm2TVwhEWgEpJyU6zDew0wzUiVWiPA0lDavESwYfoudKKqjqsQr9EZ1neZgo9jKJqCALBdCRLan
	7BbJAA/nOigtRGjvz/KA4VZrjiold2mm0GiZd1w2whNqmsI0TiJ8k79nSSaM2ZD1wm3s/QOzgI0
	fYDGPPPUaHWu9yI2qoyLiMo95UM9hCp+BgWanaVOEbgaZD38Kijt9OvhkJgEuM7FVcOX3tGJwnj
	dIQpU3CoCZpgjbLch0SZEb5q8ILjsvHGT+DUatjLEhXAszFiuIU/eOUeEBQTAhg==
X-Received: by 2002:a05:620a:2602:b0:93b:cb6d:6d73 with SMTP id af79cd13be357-93c43d7d037mr1862787885a.32.1790579733783;
        Mon, 28 Sep 2026 00:15:33 -0700 (PDT)
X-Received: by 2002:a05:620a:2602:b0:93b:cb6d:6d73 with SMTP id af79cd13be357-93c43d7d037mr1862781385a.32.1790579732950;
        Mon, 28 Sep 2026 00:15:32 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a84205esm24908932f8f.37.2026.09.28.00.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 00:15:32 -0700 (PDT)
Message-ID: <0aaf7166-378c-47d7-98d4-1004fdaeae7b@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 09:15:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] thermal/drivers/loongson2: Correct thermal sensor
 registration loop
To: Binbin Zhou <zhoubinbin@loongson.cn>,
        Binbin Zhou
 <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, stable@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>
References: <cover.1790561983.git.zhoubinbin@loongson.cn>
 <502911659e15a51c4e98c11f3cf476dd5f92e75b.1790561983.git.zhoubinbin@loongson.cn>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <502911659e15a51c4e98c11f3cf476dd5f92e75b.1790561983.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyOCBTYWx0ZWRfX0Jd5k8hqUA0E
 JM3igb+kZuopciBO24ax5IhV6gjJ8CHnh1fJIsmOfoDoKJ6VYVzorxt4fSsEgaJMSeWuft/hP7b
 i3Q5ZPdjVu88yPPV/3anFFU3Zauz1utI18VW3c4n6YdZVcNSn5nj/uYHU2Xx1l7cZip8dggOVz6
 n1eR3PXNEo8cR0EkiDmibuNof1+8rA9ThvZKP0Q5/X8rg/m/MOzNtFSYoTvIMhpO1agvq7dvyXh
 b71EwlT5VYh3bqyIu0W0vNKJveF7aSftiIu1GES8L/C9EkzBAgegbJmL7k7AE1vFruM4aLH5Mhm
 TNucGEk1jG+uAQspz9qTNAbUyrCBltH+VJd5+GBgRbVCucL8xFqSYA0QMJh+BXAas+vnVoZy9ER
 5Jl2Gi38Nrmyv9k/+tIl9mEKRCbKooTgnO6x0yZMl1WPOEb62VKkwNjgsZY3Qdr6U2+intNmopS
 IkWX4UVdFRJTIFGGbrg==
X-Proofpoint-ORIG-GUID: q8GirpTae_o6oYw6bWO1ACM4itrq_3Vy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyOCBTYWx0ZWRfX9v2B174CCMIv
 K3wZvXYz4FD6cHwQ6lHL/RtBqWJQmIkILd8p23jMduWJp6y7kLQk2aqnV0qKTBz6m46leB2eS0P
 lI6bzoWFsxMo2IVlPEIT2VEmai5kNq4=
X-Proofpoint-GUID: q8GirpTae_o6oYw6bWO1ACM4itrq_3Vy
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6aba1416 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=-hI6YwKNgXx_00ZoiBYA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280028

On 9/28/26 06:44, Binbin Zhou wrote:
> The registration loop in loongson2_thermal_probe() incorrectly uses
> dev_err_probe() when the sensor is not present (-ENODEV). In that case,
> the driver should continue to the next sensor index rather than treating
> it as a fatal error.
> 
> Fix this by correctly handling -ENODEV and only returning on other
> errors. Also add a final check to ensure at least one thermal zone was
> registered.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/cover.1783670011.git.zhoubinbin@loongson.cn?part=2
> Fixes: e7e3a7c35791 ("thermal/drivers/loongson-2: Add thermal management support")
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>   drivers/thermal/loongson2_thermal.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
> index 4d40fc706a53..99b7392fc68f 100644
> --- a/drivers/thermal/loongson2_thermal.c
> +++ b/drivers/thermal/loongson2_thermal.c
> @@ -160,16 +160,18 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
>   
>   	for (i = 0; i <= LOONGSON2_MAX_SENSOR_SEL_NUM; i++) {
>   		tzd = devm_thermal_of_zone_register(dev, i, data, thermal_ops);
> -
>   		if (!IS_ERR(tzd))
>   			break;
>   
> -		if (PTR_ERR(tzd) != -ENODEV)
> +		if (PTR_ERR(tzd) == -ENODEV)
>   			continue;
>   
> -		return dev_err_probe(dev, PTR_ERR(tzd), "failed to register");
> +		return dev_err_probe(dev, PTR_ERR(tzd), "failed to register sensor %d\n", i);


>   	}
>   
> +	if (IS_ERR(tzd))
> +		return dev_err_probe(dev, -ENODEV, "No thermal sensor registered\n");
> +
>   	ret = devm_request_threaded_irq(dev, irq, NULL, loongson2_thermal_irq_thread,
>   					IRQF_ONESHOT, "loongson2_thermal", tzd);
>   	if (ret < 0)


The [no]error paths are confusing and prone to error, eg: 'if there is 
no error then check if there is an error', 'when exiting the loop 
without registering any sensor, then we assume tzd is -ENODEV'.

Please make a less cumbersome and implicit checks here. For example 
count the number of sensors and then do the check against.
