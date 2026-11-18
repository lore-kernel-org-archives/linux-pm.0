Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010639;
	b=SYkPupvcNdCAEdlAf5TZmYND5U+wZLCfnzrIZ7ft9ShmZidBtQY/r/QrI9ddXjIvzt3y
	 DY7/1n9ydUYBwE7lhQFzgJf+D7zc9QSLVajCe24Eie2ntVxQ6b6R2+2kFspcpyTK5RR9F
	 b2LoWLfAZee2zPoUg4mvVGBVlmVC6L7p5IyhaNf+3skcya9B9HeCMwSk8hls8rvsoaLqn
	 7GrZzsBqN8A3O4m4m+ycs9Tp8yCA6oRPNkvDHMlhYR77vqsCGX2Faw+8hX233ehFvqPhJ
	 Jz8vXrMgXGU8ciu2Yc38x9BWgzWWvIMere7/NIMHe9H1ox53IdStlG8qVdvYFsOc8TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010639;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=U4yvW/bZFXVXxFQbUaDkeXJTatVe0Umzb3Tgo9Fy4/Y=;
	b=c2RJ9IrlzVt8VwmbaELmxX+14/5Ad8a62oYxdvYrihJ+obdReHBUe2fnqfxSE4Co6gb9
	 GONvFzZQpTllIYF0dNXYQ40w/pLqScpJfOjQLtmgW9YlMeYzF6G6vh+A57i6IOeQ3Ws8l
	 zJaca9RVwLJsRm+k9Zkx0zFkuVIS67hxiIfMDvLf4Mg+xHtHmvBbAoU2DvfbfMeIJT25f
	 TaqIRJnuC7PQMkW8XIv8m4kOAkeHPBnIlqAlu0Zl5U2PGjsqySNAHhrURBzGbp7Qa7+ct
	 zb+kBtx4M4gHRodjEi+Yn1lrOIzTiZORAzeCFt526PPYTfE5VsDHKj9INK5I/JXk6+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZNTbekvC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Qono0Bi5;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300CD606A339
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 14:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 300CD606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZNTbekvC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Qono0Bi5
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDQjrV1320740
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 14:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U4yvW/bZFXVXxFQbUaDkeXJTatVe0Umzb3Tgo9Fy4/Y=; b=ZNTbekvCdAZRQWOO
	zU/KTAPc1uzOAY2LAk+B0Sd9kdxLzOSH2EPxIArWsBUTw/vU76jxIoyQ5W+8UUAP
	m+lXUduoESBfx2xMu9RSenQPLjR8OCMQcMzGzT3Gq7DtuMpKqPx2T6+osJvyBtfV
	iysTlSGSY/qN10QBKBLAgPJpGey1xC+cIBGY4kdKcJ1a6jWFKBPzU2s1MVab6K5o
	2PBxI3Vxxkv/K1nqKndEnXbWd4Rj5qy/bKg5v24lWsfs+Pveh0vsCJK8RILHWf9y
	kPewHEJOsGElfRO5WQ3/n1es3j2REFxDQgiEEljLIZU1iF3kQWCAxEJv9BQs2n7A
	RGfXhg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yvck9gy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 14:03:57 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b08aee6b3eso944414a91.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 06:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795010637; x=1795615437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U4yvW/bZFXVXxFQbUaDkeXJTatVe0Umzb3Tgo9Fy4/Y=;
        b=Qono0Bi5KKVaxLrWtSM16nzELXLXXItcQ3UZk7IanuZbqh7wBPsax+ZSKYMEoXyAUv
         peDvcEpE2ZS+DTG7HF0/pDHMDMbG74VczKFiggivXuU1t/2A8zBBJVKO6sMwLzZhhKej
         zYSDlGpx8cVMkVvugE/CsVvonvWKw95u1QDFstJfg8qED3n5yEpEi0E3D8+GRelYxwiB
         OJuqGaD2+Xejo9r9uyMol0fnURnEBfYhX8bwI0cLwoNz2x+2EzWsKWM0YkBQ7KcK3Jsg
         cr3HMMuMtkHGMXREJFN3V17dWZSx2vgiZ/WHLE4vkcM7iAyny7kqlW6IXt1zxWAPS28e
         XjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010637; x=1795615437;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U4yvW/bZFXVXxFQbUaDkeXJTatVe0Umzb3Tgo9Fy4/Y=;
        b=eSzSjXpAdl7I9oQTzxNRwe32iJoQin5hn5jRc9+Y1ZaJPI63QnRUWv0MXBV3McL0IZ
         oyKGCX38wdzEqaH4R4sg2V+kUhWYysihwCdIzbsn3ZC3FzT8Clnzsoz5cx3di6spafl5
         qB3boYlLIfvQoMNdWN0nSmQiFNoumqo32qP2GFHcaKsN9MwO9/L2fvo9/vsaM15q4ncz
         AE1y09cgUMp+lQ06IVHRGzqXevZz/uZyCTseVl2iLa6qO+veKQB6QpvOJyEhqdAn9/qr
         EXaVYymqfRqZmKYebmF1RRkghn8ObRGAM5hFKYblEGxP9Ov6Uq/ZvEmPCUPD0UmiznIt
         3uQQ==
X-Forwarded-Encrypted: i=1; AL+hErGIKld3SQKgcGh8he/zjatqgjaNrHRtiZv6NE0N4eltwYI04ppyWSv+Grz5HA+6qWia/dwMkd2+dw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/+cPHrDFDsF/fxIUzuYFnpwVF4UJ2y7U4tWXGpNWas+ESHVUbv
	lo+jP9Yk8ualL9ZCYeZaT5X63zVZDVjYd+KKoo8KrtW7HrVXtRq87zP57jFeux6zcIcfG/Z/+QQ
	Q54KwVKYiD6onXXXK6gBJHlPXVrqmr+y9X1eMEHRizbOlEYv+hsFfA5N0JwHBZA==
X-Gm-Gg: AZFdTZcIJQxk9nGe0WkqMTXcC/QDZr6bMBN60lU+mcs++C4fiyTpNzcX1Uo0zA63mQx
	rZckRhOPusjJnTt+ejxCNStxjYlqIv77AAY+E+yuwlEvILqOBNaf79ghPCqnzIfkaM4omHfWIpR
	LnzylN57jxlSX2OtckZELj2KkOBZK46GbEdjFc3xnqBna7Qm/sfUGKx/9zBAirErpLGwtRL4rEb
	sSDMHWTSyWduFKY6BcrBnh0dais1k3DPoOoPQYlJ+28a4va4rsNYth3Y2tr8oueutV3yyOKoWZE
	TsPS+0Ikc0K4HjI+qXgiMaa4Rc/Mfc3YsUhrvFynDPsSiMmaKPJi1n+EFYzT8GnTrCA6sCEVvJi
	DAgg79b1ATmMjcAPECtwdei0mycCdtTixiSHqZBGEhEikcNWUJJFdTI1+vbj03LyYxFU+CVp/sU
	GzbriWsA==
X-Received: by 2002:a17:90b:4c92:b0:3b3:b71e:b2e7 with SMTP id 98e67ed59e1d1-3b3d0766880mr2786160a91.36.1795010636408;
        Wed, 18 Nov 2026 06:03:56 -0800 (PST)
X-Received: by 2002:a17:90b:4c92:b0:3b3:b71e:b2e7 with SMTP id 98e67ed59e1d1-3b3d0766880mr2786113a91.36.1795010635774;
        Wed, 18 Nov 2026 06:03:55 -0800 (PST)
Received: from [10.218.9.75] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff5ed13a2sm14908515ad.6.2026.11.18.06.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 06:03:55 -0800 (PST)
Message-ID: <7c67eec5-b382-4e58-bf3b-09df69752f5e@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 19:33:42 +0530
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v27 02/10] power: reset: reboot-mode: Add support for
 predefined reboot modes
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz
 <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Pavan Kondeti
 <pavan.kondeti@oss.qualcomm.com>,
        Abel Vesa <abelvesa@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla
 <sudeep.holla@kernel.org>, Andy Yan <andyshrk@163.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>
References: <20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com>
 <20261029-arm-psci-system_reset2-vendor-reboots-v27-2-fa4b3ff1359b@oss.qualcomm.com>
 <avo7dUvBvULHCOY1@venus>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <avo7dUvBvULHCOY1@venus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=R5OWitRX c=1 sm=1 tr=0 ts=6afdb04d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=JKe0p63tuqD2XvbLR5EA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: iNRXOO23mf_FH6BDTn5BGNa-3LniPJDv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1NSBTYWx0ZWRfX+nD/1YQWyov8
 NXuHvk63eRAdhF2IrpEaoCj8fuujPF4CrIyojRJy+8nr54HMUEY3QimtZ5cgLBbpFYit8YtFUbF
 2earSgTiKXGjTeZnEoTYXmNvBtxIIaQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1NSBTYWx0ZWRfXzIAUiMcb85cX
 I2K6KrD+Q2DVCDUcCL27RhcJ44caaZBpJ74U0NJv/s3OD2A0K1Q7i8HdrsleZ/9E6eVwoyfmjP9
 2UYZnd/HjKEUCZp/fGz3XKS4W2/04JPj3DrxOZV27C8V8NME/qqr23o2767kdSQqAJleL96tzOY
 7jdVq41CoK5Es2pBdw3VIBy6EnfnwYy6lXPuzMyXLTCj/4ipYVWBHi33H3nBTEzSSKxJoGYTJXq
 jG3NUW5zL1HLAiBkJt2rF/o4YjWD7pnaYxe26rHJKgP/xYE8JzBpsX5K9UZP20owLszHJ/54Qlg
 EQFVG27CH6b1CyUQSg8h62QLLfnHgEYWcTLuK40ny5Zl0ZN5XcGPdKuG8Ib6s1aHV1jnORHT0Q7
 hdj7pakkDcACo1NbN8L77ysB5i8bRr5L6dFqSQN/F2UYod4ZWdtSq/uKLIvAoMbchaO1HiApA0W
 POoD7III9drplog45zg==
X-Proofpoint-ORIG-GUID: iNRXOO23mf_FH6BDTn5BGNa-3LniPJDv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180055



On 11/16/2026 4:43 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Oct 29, 2026 at 02:30:56PM +0530, Shivendra Pratap wrote:
>> reboot-mode based drivers can define a reboot-mode by adding it under
>> the reboot-mode node in device tree. This limits such drivers, to define
>> any predefined reboot-modes statically within the driver and creates a
>> dependency on device-tree.
>>
>> Extend the reboot-mode framework to support driver-defined predefined
>> reboot modes. Add a centralized initcall to initialize driver state
>> along with predefined modes.
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>   drivers/power/reset/nvmem-reboot-mode.c  |   7 +-
>>   drivers/power/reset/qcom-pon.c           |   7 +-
>>   drivers/power/reset/reboot-mode.c        | 192 ++++++++++++++++++++++---------
>>   drivers/power/reset/syscon-reboot-mode.c |   7 +-
>>   include/linux/reboot-mode.h              |  26 ++++-
>>   5 files changed, 175 insertions(+), 64 deletions(-)
>>
>> diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
>> index d260715fccf6..700732ed0f5b 100644
>> --- a/drivers/power/reset/nvmem-reboot-mode.c
>> +++ b/drivers/power/reset/nvmem-reboot-mode.c
>> @@ -51,8 +51,11 @@ static int nvmem_reboot_mode_probe(struct platform_device *pdev)
>>   	if (!nvmem_rbm)
>>   		return -ENOMEM;
>>   
>> -	nvmem_rbm->reboot.dev = &pdev->dev;
>> -	nvmem_rbm->reboot.write = nvmem_reboot_mode_write;
>> +	ret = reboot_mode_driver_init(&nvmem_rbm->reboot, &pdev->dev,
>> +				      nvmem_reboot_mode_write, NULL,
>> +				      NULL, 0);
>> +	if (ret)
>> +		return ret;
>>   
>>   	nvmem_rbm->cell = devm_nvmem_cell_get(&pdev->dev, "reboot-mode");
>>   	if (IS_ERR(nvmem_rbm->cell)) {
>> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
>> index cd7ba680b841..55aaa99d88b6 100644
>> --- a/drivers/power/reset/qcom-pon.c
>> +++ b/drivers/power/reset/qcom-pon.c
>> @@ -84,9 +84,12 @@ static int qcom_pon_probe(struct platform_device *pdev)
>>   	reason_shift = (long)of_device_get_match_data(&pdev->dev);
>>   
>>   	if (reason_shift != NO_REASON_SHIFT) {
>> -		pon->reboot_mode.dev = &pdev->dev;
>> +		error = reboot_mode_driver_init(&pon->reboot_mode, &pdev->dev,
>> +						qcom_pon_reboot_mode_write, NULL,
>> +						NULL, 0);
>> +		if (error)
>> +			return error;
>>   		pon->reason_shift = reason_shift;
>> -		pon->reboot_mode.write = qcom_pon_reboot_mode_write;
>>   		error = devm_reboot_mode_register(&pdev->dev, &pon->reboot_mode);
>>   		if (error) {
>>   			dev_err(&pdev->dev, "can't register reboot mode\n");
>> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
>> index 328fa37598df..fd61de226383 100644
>> --- a/drivers/power/reset/reboot-mode.c
>> +++ b/drivers/power/reset/reboot-mode.c
>> @@ -30,12 +30,12 @@ struct reboot_mode_sysfs_data {
>>   	struct list_head head;
>>   };
>>   
>> -static inline void reboot_mode_release_list(struct reboot_mode_sysfs_data *priv)
>> +static void reboot_mode_release_list(struct list_head *head)
>>   {
>>   	struct mode_info *info;
>>   	struct mode_info *next;
>>   
>> -	list_for_each_entry_safe(info, next, &priv->head, list) {
>> +	list_for_each_entry_safe(info, next, head, list) {
>>   		list_del(&info->list);
>>   		kfree_const(info->mode);
>>   		kfree(info);
>> @@ -119,6 +119,80 @@ static int reboot_mode_notify(struct notifier_block *this,
>>   	return NOTIFY_DONE;
>>   }
>>   
>> +/**
>> + * reboot_mode_driver_init - Initialize reboot-mode state
>> + * @reboot: reboot mode driver object to initialize
>> + * @dev: backing device
>> + * @write: write callback to program a single magic value
>> + * @write_array: write callback to program multiple magic values
>> + * @predefined_modes: optional predefined reboot-mode table
>> + * @predefined_mode_count: number of entries in @predefined_modes
>> + *
>> + * Exactly one write callback must be provided by the driver.
>> + *
>> + * This function must be called with a valid @dev before calling
>> + * reboot_mode_register().
>> + *
>> + * Returns: 0 on success or -EINVAL if callback/predefined mode configuration
>> + * is invalid.
>> + */
>> +int reboot_mode_driver_init(struct reboot_mode_driver *reboot,
>> +			    struct device *dev,
>> +			    int (*write)(struct reboot_mode_driver *reboot, unsigned int magic),
>> +			    int (*write_array)(struct reboot_mode_driver *reboot,
>> +					       const u32 *magic, u32 count),
>> +			    const struct reboot_mode_entry *predefined_modes,
>> +			    size_t predefined_mode_count)
>> +{
>> +	if (!reboot || !dev)
>> +		return -EINVAL;
>> +
>> +	if (!write == !write_array)
>> +		return -EINVAL;
>> +
>> +	memset(reboot, 0, sizeof(*reboot));
>> +	reboot->dev = dev;
>> +	reboot->write = write;
>> +	reboot->write_array = write_array;
>> +	reboot->predefined_modes = predefined_modes;
>> +	reboot->predefined_mode_count = predefined_mode_count;
>> +	INIT_LIST_HEAD(&reboot->head);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(reboot_mode_driver_init);
>> +
>> +static struct mode_info *reboot_mode_create_info(struct device *dev, const char *mode,
>> +						 const u32 *magic, int count)
>> +{
>> +	struct mode_info *info;
>> +
>> +	if (!mode || mode[0] == '\0') {
>> +		dev_err(dev, "invalid mode name\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	info = kzalloc_obj(*info, GFP_KERNEL);
>> +	if (!info)
>> +		return ERR_PTR(-ENOMEM);
> 
> info = kzalloc_obj(*info);

sure, will update this in next post.

thanks,
Shivendra
