Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610783F20FA
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299479; cv=none; b=d28fFTZfvhoSG1jNoqhJWtUsquFA0t62CxBLVE7PmHL8+i2ZFgBuvHuIV9aqgZZfBLPcIebSdgiRKwRprgTDM/yJ5DLYBXxVBakClfxbozmA2MS4Kokkhqym1NXe/YaIsD3yJzEtEQ3HFMFe1S0F2Fa0SCzL+CZsaxh4/EJasuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299479; c=relaxed/simple;
	bh=EDn9tZ5+fUuBBKe3xoJ2cTQEWFARqiy4G3gqZ26/v0s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CEiVngpHRsVGrFF/9+ubXqULtJWoHcaIVCZWeyQKayueEdqSGi5RXkLZhlJVPN+6vJVRCqsBJhsTc6BgJ5wXl4vLWbprNLsXMOG1A9GrmndvRD92XGYErdCeDdT0PZYqjk7kXIx8KRcmqsnCSm6xTQ0FYOSdCsVhFkwrm9/II/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QM+UTv5O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZeeR8inz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QM+UTv5O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZeeR8inz"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KFKV5h4115166
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 17:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mc/+ti7MrgQz8y3VEqUCtk+lZgtdhsk+7nKCgcRoRzc=; b=QM+UTv5OhjXtuCSi
	KN1xd8tqFVIXPKAg5jpokGrnXAf0a1U4PUDSH3RX5ZcUSIfS/ljobzI66f/YMPd5
	OeW7owetPzdc/VIDYIMFX5XxBnVHgbg1qEhvVvggSHh2Dt/Ai4ugHZN/Td7jCcq9
	qyP882YaEvZp+IISYEfjT1pwzbZU9wdrEhAxs/IPN1KoC3Hi34gmT1kRn4vpCfso
	bFoTCdn+DayrQ9/LCEQJ/yNsLfAEbMpX8BsqZXr3sSIunXz2D9AyUARKzHRV8lI0
	3pkoMnRs95y7EPSnM6BdMWD7BEOab50OdNnC7yFkBK9+Zeqi1ejGSw4ewFaAHUWU
	uy/sAw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e99w0j5nh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 17:51:16 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ba3245a43dso53764735ad.0
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 10:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779299475; x=1779904275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mc/+ti7MrgQz8y3VEqUCtk+lZgtdhsk+7nKCgcRoRzc=;
        b=ZeeR8inzCduryRtM+EI6j79s1QmDbtHjB0q7DV6gz/oujudf8o+kyFtou5z9yi0BNd
         vTgkcqYwSK94MED1GspVtGAzunggJGNXXE9iecQaznKAkwrxNjql7PjvnG68+vLf40mv
         MS2bHv9ijHNxJK3epFR1c0u4FRVkINXRwhyH/10oWILkcTVb7yXFuBvByI/Sj8KOGsTB
         zN8lxpdCtUZZkcGVxyh8bo/Vp4KWFWgnBawKO6o1Vl7kbbjnRtTXw+XongU4vmppGtsP
         ViBXvKS3UgM5Dk34bojYxdJBkGR/5k0690AtYbRRU6aHx0aU5aqnLjn2wrG8BPrcMyQa
         VxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779299475; x=1779904275;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mc/+ti7MrgQz8y3VEqUCtk+lZgtdhsk+7nKCgcRoRzc=;
        b=k2TdwO3G31718+AQguTH6QjbA92tiumDiS1Mq3R+8g5fjTgPYkb+m0DWPDqwBMb2m8
         Tyh9tfHxLgG9P3t8p/UccukO1ULXFnaiGZvl4EGQxDt5ChmwZUPvB3RDf5MCmMMjn9Ys
         w1y12tX9TNjLfuTUUEP+e+w3vGqoyTL00+AVmXaR9WGIqGeLF19f1fwUYk+Z1yAQsulh
         ajg4lkB+rWyg9Z8zMVgVGZty7iY51U1TWVSCFvCrfYrztHPptYY3+ALUtn6gec3E9CZJ
         tAmlxMD9C7J/7ACBgDkjNs1CrXGACBPmrrKMF2mJZY9p9jdbR0HF8vn+bu87hX//SIUX
         GupQ==
X-Gm-Message-State: AOJu0YyEWVEr3MX9jESTrsz2ifIo5PUKVsw+K4eU4OthrjP96WA/76yy
	FyjLrwbGyMdf03R8+sY87mxqHDXZIA119JAoQAFqo1+f1u+SwavLtJi4Q+v54ODWKutmQtDU/5s
	zFtc1jxjIp9zQtPUJlkESzIhzTVcd+UY7LpK6s6SVHtsOhMSYHNsdnaduA1nCTQ==
X-Gm-Gg: Acq92OGWUsAfz+jAyYDs9JxBhTdIuALcVwYvoaYzesvtoPUEOaDSY9+nxGhcxqDf92U
	kPPj3PwXPQqwisurPU3amf+lHgLaEIVqFMdVkGlcrnNAoOKtvL4AwRD0TI5QY4RZs75RGwWYOy4
	0vR8vy2O4/leQNUMK3/DTZ93LjKWfRaZ8WoIldBWHlpDFIpKadK+P9kNLdBVc2121dGXYFF5mVJ
	C4jIRGhiqtHnaULs1i1jmiOyLOFOUCkbWdCkq/kym0eF1e9oWPjL5roVrHaEyQvG7XuPLpHH30M
	yFp3CVncMLWqoRm2vayA5GnJNofKUuJxsFVeGmvlDzdWfFjfyrFbu9ydGGDqfscU4dZ88RxxfCa
	HZ7pQ/2LZxXuv8fBJJxh6Vf07dTXasOCKkJs3SmTvP956N48MPRCP5Qm+lGQiEtwqMA5gZVsCRu
	G44HNoGhR4YDkEsGO5
X-Received: by 2002:a17:903:2ecb:b0:2bd:936c:8155 with SMTP id d9443c01a7336-2bd936c85b3mr230398905ad.13.1779299475119;
        Wed, 20 May 2026 10:51:15 -0700 (PDT)
X-Received: by 2002:a17:903:2ecb:b0:2bd:936c:8155 with SMTP id d9443c01a7336-2bd936c85b3mr230398345ad.13.1779299474561;
        Wed, 20 May 2026 10:51:14 -0700 (PDT)
Received: from ?IPV6:2405:201:c408:b079:35d3:6970:1f3c:72e2? ([2405:201:c408:b079:35d3:6970:1f3c:72e2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f2dcsm225979395ad.13.2026.05.20.10.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 10:51:14 -0700 (PDT)
Message-ID: <b16ab4d5-40d0-4438-8fab-6cff3fa6845c@oss.qualcomm.com>
Date: Wed, 20 May 2026 23:21:02 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 08/13] mfd: core: Add firmware-node support to MFD
 cells
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Lee Jones <lee@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Florian Fainelli
 <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger
 <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Sudeep Holla <sudeep.holla@kernel.org>
References: <20260514-arm-psci-system_reset2-vendor-reboots-v22-0-28a5bde07483@oss.qualcomm.com>
 <20260514-arm-psci-system_reset2-vendor-reboots-v22-8-28a5bde07483@oss.qualcomm.com>
 <CAMRc=Mde7Y3CQ3yi=U+999JyHTNacebiK8jJhHuYBGaqn59yYg@mail.gmail.com>
 <f604833d-b333-4514-91fa-3cf95f99f9e7@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f604833d-b333-4514-91fa-3cf95f99f9e7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Klll93oADissdTBGmMl8PUgbpFLycClR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE3MiBTYWx0ZWRfXzJqWc/IB5JhU
 jGqCpBhKCRLRfSmqHvYVOuGOsf/BXXP7hK+lQFrQiZZOiVW96HxAVRbLB/UL4D7sNkSh6vvQknR
 Wv5C11EQpKar6q9Vid9Tg7zEqNUrexuni9jDET1So8OjF3PDbLpGW9oz0QubQSu0/26biE3tvPI
 dg6NheIXFo5xbQkw88sDzUQ5uFhOADbvCusRlKn6LcYUNoKRDhulYh5MOtzgFCr7xT6i2nBIwk7
 EpgOvvUS3x4gLum1n0Hhigz2ebvO2UD/dgk9fXmN2P4EHyZydrrrKRM4Vua/9/QhWaXNISKtKgM
 /c09NbKH5IvRdYTSQ8SdIKAF3w8iKZQdadz71DWqs82kporwWYdlAiUmhlwZTVktGE2JRHtMBTL
 GwK0PEjULIAPjm4J4DluzRMLLSc//KdDwQjmGzIe+FOXlWBl4nz7D6ubip8ZjKQ/IQnK4OpFBhD
 +Qhqx16iDljbdBp7eew==
X-Authority-Analysis: v=2.4 cv=RZigzVtv c=1 sm=1 tr=0 ts=6a0df494 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=UQidBoyNrwidYc1BrrYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: Klll93oADissdTBGmMl8PUgbpFLycClR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200172



On 18-05-2026 22:11, Shivendra Pratap wrote:
> 
> 
> On 18-05-2026 14:27, Bartosz Golaszewski wrote:
>> On Thu, 14 May 2026 16:25:49 +0200, Shivendra Pratap
>> <shivendra.pratap@oss.qualcomm.com> said:
>>> MFD core has no way to register a child device using an explicit 
>>> firmware
>>> node. This prevents drivers from registering child nodes when those 
>>> nodes
>>> do not define a compatible string. One such example is the PSCI
>>> "reboot-mode" node, which omits a compatible string as it describes
>>> boot-states provided by the underlying firmware.
>>>
>>> Extend struct mfd_cell with a callback that allows drivers to provide an
>>> explicit firmware node. The node is added to the MFD child device during
>>> registration when none is assigned by device tree, ACPI, or software
>>> matching.
>>>
>>> Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>>> ---
>>>   drivers/mfd/mfd-core.c   | 30 ++++++++++++++++++++++++++++++
>>>   include/linux/mfd/core.h | 14 ++++++++++++++
>>>   2 files changed, 44 insertions(+)
>>>
>>> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
>>> index 
>>> 7aa32b90cf1eb7fa0a05bf3dc506e60a262c9850..cc2a2a924d6d3044e29a9f864b536ee325ed797b 100644
>>> --- a/drivers/mfd/mfd-core.c
>>> +++ b/drivers/mfd/mfd-core.c
>>> @@ -10,6 +10,7 @@
>>>   #include <linux/kernel.h>
>>>   #include <linux/platform_device.h>
>>>   #include <linux/acpi.h>
>>> +#include <linux/fwnode.h>
>>>   #include <linux/list.h>
>>>   #include <linux/property.h>
>>>   #include <linux/mfd/core.h>
>>> @@ -148,6 +149,11 @@ static int mfd_match_of_node_to_dev(struct 
>>> platform_device *pdev,
>>>       return 0;
>>>   }
>>>
>>> +static void mfd_child_fwnode_put(void *data)
>>> +{
>>> +    fwnode_handle_put(data);
>>> +}
>>
>> Ah, this seems to answer my previous question, but...
>>
>>> +
>>>   static int mfd_add_device(struct device *parent, int id,
>>>                 const struct mfd_cell *cell,
>>>                 struct resource *mem_base,
>>> @@ -156,6 +162,7 @@ static int mfd_add_device(struct device *parent, 
>>> int id,
>>>       struct resource *res;
>>>       struct platform_device *pdev;
>>>       struct mfd_of_node_entry *of_entry, *tmp;
>>> +    struct fwnode_handle *fwnode;
>>>       bool disabled = false;
>>>       int ret = -ENOMEM;
>>>       int platform_id;
>>> @@ -224,6 +231,29 @@ static int mfd_add_device(struct device *parent, 
>>> int id,
>>>
>>>       mfd_acpi_add_device(cell, pdev);
>>>
>>> +    if (!pdev->dev.fwnode && cell->get_child_fwnode) {
>>> +        fwnode = cell->get_child_fwnode(parent);
>>> +        if (fwnode) {
>>> +            device_set_node(&pdev->dev, fwnode);
>>> +
>>> +            /*
>>> +             * platform_device_release() drops only of_node refs.
>>
>> Which is a separate problem we're discussing elsewhere. It should 
>> probably drop
>> the fwnode reference it holds, not the one of of_node.
>>
>>> +             * Track non-OF fwnodes explicitly so they are put on
>>> +             * all teardown paths.
>>> +             */
>>> +            if (!to_of_node(fwnode)) {
>>> +                ret = devm_add_action(&pdev->dev,
>>> +                              mfd_child_fwnode_put,
>>> +                              fwnode);
>>
>> What if the device never gets bound to the driver? The release will 
>> never be
>> called, this is why it's wrong to schedule devres actions for unbound 
>> devices
>> and one of the reasons for patch 1 in this series.
>>
>> What I suggest for now is: in tear-down path: see if the cell has the
>> get_child_fwnode() callback and - if so - drop the reference. Add a 
>> big, fat
>> comment saying that this must be removed if we decide to switch to 
>> dropping the
>> device's fwnode reference in platform driver core which may happen soon.
> 
> Ack. sure. lets me work it out.

Hi Lee,

While planning to address this for the next spin, it would be helpful if 
you could review and share any additional comments that should be taken 
care in next spin.

thanks,
Shivendra
