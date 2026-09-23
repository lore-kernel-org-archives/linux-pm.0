Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B253C4949ED
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162782; cv=none; b=bdQBZO6HDb1U4F8WWYWtOVetWoIwRWeAoDiaWKVzFl+tZ1wKBV5AJIJUSfvyFd3ia3i1pNib7FTENIPCcBvzKGeWNuIiSILbWyuI7dXd6VvC5gCo8LR5iUW72PvfMLWiaWBNTIUMkHXgouhXsQzYPNfkggOctNdBom2ONFT5tyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162782; c=relaxed/simple;
	bh=1MCzPuhkOUx0yiCuhAWhyHvppbKmv7dz62NnFmmX68o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=imo33O9qE66gc5zb563kM+1Ob/CdBv88fShUP/aIcCvI1vJpvOMemrXFTC49Ujv8DRxW81GsX0OXGYGHvvFguYWaNU68rtBF/7oDSFtwZTOlBcek0m5UZxRqidgSC1c5SJpdl2pZNgYhrspfLxU8Ptv+03GJ3hlJPxrOahIoLtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HptVv/Mm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O/jbzqCR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HptVv/Mm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O/jbzqCR"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NA31gc3936261
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 11:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JqrKcvddEjNxdraXN5+nL8C9yc6R7w3YPVbh4Z3k6lY=; b=HptVv/MmzLlyy6aW
	SWMDsOq9FeecDMFcKgSUvkiXmdZx3LxUnhHOgkV9PLObA5OD5u7aoJc8DrK3qCGp
	1PZd2HLhj9W9950/cYWWaeekldN5+7tV/xRqyNHSVxa07Vcrxs5tCeXwty1fI8MM
	qBb+olSYXpK6Rm6Dh3qfs5mPrDJbNSZbKWSP4MTcDZ27d62mNpOHfUOhf3zEBFSy
	suqaTrw712vgO8ruwiI7BKyRR3PCCpdx4Xt1GwT0tquW9SGBxZH8ikKg8Py8yhD/
	2AGNTLQ2HwcMCnicaq7njhTS9g8R26O5h5z7Y9hoDUEQ7+/9tNtDiJU7bYt9ExS/
	HFBYaA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv428tg1c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 11:26:01 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33bee712354so985739eec.1
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 04:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790162761; x=1790767561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JqrKcvddEjNxdraXN5+nL8C9yc6R7w3YPVbh4Z3k6lY=;
        b=O/jbzqCReHpnfiHgSP3671AQDPQRfbW9pji8r4BdWszkKpH3dWbyjH/eXZkthtuTaw
         FS+XVJqhs2b3CIx13+FAmdBEqSlYBQYwJcFXjCWrxJg40S+/tfbJkukyj5TQUBLLDSHO
         Qufd9FWN9IL1q4qufW92IOxq82l+JaNM/JPJwQn06mvaV8GjczQ7EOmu3R56cNj163NO
         RevRBZ2wsQ6zgRCIaJ4yWymB6mNnaw5Vgk4c/uKJXWZ4vrRpANFUALTM9C9mD+tCGlpp
         eO0Rxy9fsGrPlGWa3k/svHdFqbL8xaVsPqNP1Tqo21XI8XHJdCBJ0cEbD1gQUom12gX/
         AFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790162761; x=1790767561;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JqrKcvddEjNxdraXN5+nL8C9yc6R7w3YPVbh4Z3k6lY=;
        b=bA8aUodf7K/S8gsnctEtBlfjAFLyUzHPUVe9GiiyCur4IsmghZHDujPQbRByvfam+v
         ycgnplrNI/wZ3uohpYMrY2IJnE009oXuT2KeZFUWvw7EnfYPTCXy+QeOttROxbRfLdVA
         r+ZFkuUXUvg22R3TdWiwOE3kZX5ViADz0H70BU+Yk49WIMK1TNeW6N780O0htnHrGj4F
         aUItOx6sm4dNM2QRGDb6zCb1BMzTQFuHPiZeXzhgr4Sq8jgl5VCQmYzpukdH64v61kXK
         MmPfcUdG/PkEOD/rzCwfJfN53RfYQh4Nl7cyzCxr6TPY7ux+zgol3kl9X931p4r6DMbZ
         R2yg==
X-Forwarded-Encrypted: i=1; AKwUvByVFm+feEI57adtg0wk+qeSoGaKNNbaxqXeVsIJpBFbsCkZX4OwYlF6cD4xQ5U1U7qcYmzU4EnPBg==@vger.kernel.org
X-Gm-Message-State: AFuF++nPuc2RYeEDk3Jf2ROUCbGV6Kw80Gzi5P3zA1/Oe/KvIYWnl+Eq
	BEe5Zjhx7+M28e+2l6JX38kK7U9MTwZPLekaQfdbJLsLACsIKBrwQI1sA3uuCM7Glzyxk/kXQ0g
	Qhg32kCc2+9hsxTRFCIerpMtAM34o5xHLKZLR9u6GIuHjP+cx+ZWs8HlyBhY3bA==
X-Gm-Gg: AYBFou0putFWo84QhTchnyNaEe+6z0x4OKUm+xfr1ALAUBMvsqiEK8kTPuMPLgOy4TI
	PpUqkg/Pd+oiXjlf/g9rDEXiSSzM8c7lfjEeEvpNWBwB1l0b39kz/9mH2Qgi20tmUtsXCjRejNh
	+lwcQ9ZDIsaksIL+juKIXY2CGGQC18iGOQwTJrF9bL2G5wdR1jS3gwjS4UMI9GJD+4XgUHtS3Ff
	iy7Kx96XPIr4ZEVSrcdnw2up8WZLeg8FP2E19urecp48H3zDfcOpQeGzzAtOtP7ZkXnmYt81afB
	V29zwn3Bz8DlZ1aOfbyK3mfrUuhSrfUyMH5dZ+Dyw5F+2VP/5tsmZ5afK1D06FGUsPzSfhSAWpd
	TxeMYgDw41jN7GowY5FPqjLDh0RYyVfI=
X-Received: by 2002:a05:7022:282:20b0:144:eab0:9cbc with SMTP id a92af1059eb24-144f9170182mr2757109c88.37.1790162761162;
        Wed, 23 Sep 2026 04:26:01 -0700 (PDT)
X-Received: by 2002:a05:7022:282:20b0:144:eab0:9cbc with SMTP id a92af1059eb24-144f9170182mr2757074c88.37.1790162760586;
        Wed, 23 Sep 2026 04:26:00 -0700 (PDT)
Received: from [10.218.9.75] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f9877462sm5682402c88.10.2026.09.23.04.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 04:26:00 -0700 (PDT)
Message-ID: <c132d8a6-f845-44bd-b0c9-33b5a99f9759@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 16:55:46 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v25 04/10] firmware: psci: Add support for PSCI auxiliary
 devices
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan
 <andy.yan@rock-chips.com>,
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
 <sudeep.holla@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, mfd@lists.linux.dev,
        Srinivas Kandagatla <srini@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260914-arm-psci-system_reset2-vendor-reboots-v25-0-4aaf5c09b5c2@oss.qualcomm.com>
 <20260914-arm-psci-system_reset2-vendor-reboots-v25-4-4aaf5c09b5c2@oss.qualcomm.com>
 <CAPx+jO_tDttD8+XpRjG6E+XyQa=-_v-Gr=2Unc+6OSBJ2P7Oqw@mail.gmail.com>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CAPx+jO_tDttD8+XpRjG6E+XyQa=-_v-Gr=2Unc+6OSBJ2P7Oqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EZdd0/mC c=1 sm=1 tr=0 ts=6ab3b74a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=2jq_lC5E59YAp211iCsA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: gC031UfeOKcdOjZGEOMl9OfMYTzUlVGi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0NSBTYWx0ZWRfX3sjT5xo2MV7B
 sRK9oPTYy4/zCT+RciBXR3Vfjefmy/tNha8y8oQF12OLzDW9Ey/yUNCIWz8PdAi4oIw1wvlhpy2
 BsNtY5t5CqYVHBbFSG0atk0s2miF2YxBqcVgiFYmeez3FHThteYDItdL+W+7+SHCCcYHs1Lb5L3
 y2d+VHn1UsQr/oUkCSpRHCn2LU+vbqbYQCzxOlzEe130QdYaBHLWDJHpLqeW6G7aJ6+TJou32Co
 lMAnppqmtTVE6YMTf+7sF+XxubglBbBDPYwGHnFTIfd0YgBBffS0tl6ZFj/5k5V5uC7FX1x7Ptk
 wrnoaJzUfp6gc1VbncOqxaP7540qTO0fAQFquMapvlp6h7oVqyOlBGV1GwyfZNpWp/JNM1MqvOR
 7HW1k7j0W445DiP3YO+AiEEZ/sctuurrJTFga1Wj+UuhBfWh82534wRY1NXF3uK7zvX6kuN0TMW
 EWRIDO0VTceP4o8Qk3A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0NSBTYWx0ZWRfX2iuvPq3VyBpz
 dIZG/JH97kUbT+7oUcU16+3iZXte1UGwlbl7b4fcH+KIdQBMY8tf3whMr/MHeZc7iODpNaztrhL
 dwuiMksEyDW2kXuNB1b5OTvQcDjjGwE=
X-Proofpoint-GUID: gC031UfeOKcdOjZGEOMl9OfMYTzUlVGi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230045



On 9/21/2026 8:36 PM, Ulf Hansson wrote:
>> +++ b/drivers/firmware/psci/psci-devices.c
>> @@ -0,0 +1,41 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include <linux/auxiliary_bus.h>
>> +#include <linux/init.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +
>> +static int arm_psci_probe(struct platform_device *pdev)
>> +{
>> +       struct auxiliary_device *auxdev;
>> +
>> +       auxdev = __devm_auxiliary_device_create(&pdev->dev, "arm-psci",
>> +                                               "psci-cpuidle-domain", NULL, 0);
>> +       if (!auxdev)
>> +               return -ENOMEM;
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id arm_psci_of_match[] = {
>> +       { .compatible = "arm,psci-1.0" },
>> +       { }
>> +};
>> +
>> +static struct platform_driver arm_psci_driver = {
>> +       .probe = arm_psci_probe,
>> +       .driver = {
>> +               .name = "arm-psci",
>> +               .of_match_table = arm_psci_of_match,
>> +               .suppress_bind_attrs = true,
>> +       },
>> +};
>> +
>> +static int __init arm_psci_init(void)
>> +{
>> +       return platform_driver_register(&arm_psci_driver);
>> +}
>> +core_initcall(arm_psci_init);
> I think we should move this to arch_initcall().
> 
> To allow the platform driver to probe, the corresponding device node
> in DT needs to get populated, which happens at arch_initcall_sync().
> 
> That said, to be consistent, we should move the cpuidle-psci-domain.c
> from core_initcall to arch_initcall too.

Ack. Will update it to arch_initcall at both, cpuidle-psci-domain.c and 
here.

thanks,
Shivendra
