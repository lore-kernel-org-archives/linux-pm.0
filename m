Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E308E4D8D88
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 13:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784812202; cv=none; b=eQPEsGzao76nchA2atqlhLYQ4HmoSbiA45tN/vMvZ+W4wiTdc1Gc/rxL8jmK1oye5uNOhNroXpjYZr7J/QwFg4dpizOEmurAX+If8hJ1Mijpj3BAXCqtNLjIDLAtsB7Esgphut/E5YtoFB/Pgsua2PNDxevgZi3pRB8eOBFD6Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784812202; c=relaxed/simple;
	bh=CNKvIyuRMUmNUe9hldyt1F36eDg0bIAgRNM4BeXJs4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aj0S7UD79czFuFuK8/ejqOLMY+UqnwuHvq6q1PE/FsHhpQb2iuQ8cBfwqyzJ5W5UDkDdx1hTnsQmmqNuxJ8TriWiliZU09xc/QeOEQExXNNRP9yunybf4C3kAvyx6WsjM2PwMheIpsvv0I3KXPK/tp0/iMu6LKZ9HDoXw5NElvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YWytQw4b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SJCfGrNu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YWytQw4b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SJCfGrNu"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NCvHQd3951271
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 13:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KYZXn2rMd8QXiAaMCeSTebeopGesML12+K9l8VKCmk0=; b=YWytQw4b2MYXel2Q
	85vv17LogPADiM+DaizyMO56OnUI2nzuvizaz8+Im84V8WwOw3IPTyJ9kJGMilt2
	7SsjU5BqDz252feWoCjph6gH9h1DTamF8TWk4rGeVV8Ka4exuIOwVm3WVaTJMjP1
	Y4Z+zsEW/4D1zUX3M2F1wlAtvAixgLGrC6o8AwSqaSUfc1aMasM3yDoA+hpuWbx2
	Y+3KqmlGZIKRZaKx3yow22oY8ZcwFZmuLTvGI9W33tVzbMgh2T9tAl0NeP1C3ssA
	mvwjMUc+r/yk7qQltiAGIe2OFWnytcXCEOqIeQ0rDmS4MM8C60vqotYWweWl2ONW
	u5X9nw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkjnu88jj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 13:09:27 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7459afddb73so124821137.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 06:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784812167; x=1785416967; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KYZXn2rMd8QXiAaMCeSTebeopGesML12+K9l8VKCmk0=;
        b=SJCfGrNukWdzm+iljAWff1T3O2zC+c7VN1HKwNsj9fyxVxR7YB97U1pGsTOz3QA2z9
         HLoymLp0TUANUdqF0P/J7nfYJYZXE4AdUclWkEqpM7bbCVZ8okzhF69xD0H30i/asNWf
         yuQ/MedMLgJPTD7PaYcq0AtMDqcWdmcJIY6yqUH5/aYxfPl5l3GsA7Qpfcn1awqM9oRH
         onTlxse00wFAn0I+DAFjQh2hdKhZU/n/DpnuocztyR54xSHOo0gz4BQjNC3IFFKSwN2+
         RvXH/fryPVN0XR5Xzn+YOsdLMvwqD/B03bu/sLE2ovJCrvmd3QYURujsh5HxSb2pgo21
         0O+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784812167; x=1785416967;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KYZXn2rMd8QXiAaMCeSTebeopGesML12+K9l8VKCmk0=;
        b=ETOEUmPZ4xnOKYJmzGin7TGXG7h5kV6VAiRy7R0h3hEzE5QAhvcTg/mbH57sx+fp/8
         CjquaVVjkMeTbdUSQlcTfX94ZIqyvB9JMfVX5fGP36yG3yUI0xQao/3fOZXF/vs3ppFp
         MYBV1CKhNbVLqUWHs3G+Ajy+YJHEIwQQo6LuHBQPhGP+aVWLU0lP81vSifD6HNS9+wBN
         2gVHZgErKBvRlPQ7qMpU6W2CnCnLx0kMGlh9tWLs3uA15fs8Tnqhmom9bhuCeRWBHiLm
         eQA1UaD/nZZano7intQh1FsDAeapysom92HT6i3TMc1ctGVRJb7GYywzH5Qt1YuZKbBc
         Fhlw==
X-Forwarded-Encrypted: i=1; AHgh+Rpn5jkTl6OIomT/9+GhYiagakm/mddW2PyWP9yrFHVmh26/AlpijJjj4aZkjZ2aBtMR7jVV1MYkug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm3JcCwB8GzShrAcpm3L7CrKcXcaRID4j+Rz19D64u6JU0jciv
	5QRyhf1rIHS08/wB7dDGLScixoDsW7RUdBuxUJJsquzGt3eGfUtTxnXMENLNlV5GKEIq/j2BN1W
	wKL+9dRHFVGViQt5S67ed0Pa4Mv8UjG16QHoWtYibrEbWvUF1sgU9uDbIc9W3wA==
X-Gm-Gg: AR+sD125ywvSeWA9tbGncN3f2/v6wurbGCOyNDdih4IF8utQFmpSpLpJfCsdWCQ2iN2
	iir/Z2TgkPfRLZPXsxG425bLy/t5xDak1KhPZlSrYQQEt74VJnLPIFw7JQnS42G1iEXDpgwHiTy
	jev8EtIu0H3gA9lHbdhD5XMaxyV+FX5vgXcOUQDQ4hftbJtxw2OxhEIseE72JUmu0QGgUhUGZTI
	qP7ZwvNia6CPH5YRr1WPeoeMsEXqAaXubOqDrV3U5AAqFOokq7hb6hFZMYza4Gd3c4Dr6g3caTo
	JKKs1XEeSlN1KvVJD5ytuPVBu8uO8Nj0G3px/dZxUjIWsw6J8HVdA/dXFfvuJrmc5/wUHRfJRIJ
	Xd/Fc9eKUa36zZnsXCtr/yie1IX1glTsefnY=
X-Received: by 2002:a05:6102:2d0d:b0:740:2d5f:e37b with SMTP id ada2fe7eead31-74d61016d97mr1173147137.29.1784812166895;
        Thu, 23 Jul 2026 06:09:26 -0700 (PDT)
X-Received: by 2002:a05:6102:2d0d:b0:740:2d5f:e37b with SMTP id ada2fe7eead31-74d61016d97mr1173098137.29.1784812166476;
        Thu, 23 Jul 2026 06:09:26 -0700 (PDT)
Received: from [10.219.57.229] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9774424ce26sm4513322241.13.2026.07.23.06.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 06:09:26 -0700 (PDT)
Message-ID: <d859dad2-b9d2-4d1c-abd5-bf007af0ebd2@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 18:39:11 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 03/13] power: reset: reboot-mode: Add support for
 predefined reboot modes
To: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger
 <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla
 <sudeep.holla@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        mfd@lists.linux.dev, Srinivas Kandagatla <srini@kernel.org>
References: <20260714-arm-psci-system_reset2-vendor-reboots-v23-0-e7453c548c21@oss.qualcomm.com>
 <20260714-arm-psci-system_reset2-vendor-reboots-v23-3-e7453c548c21@oss.qualcomm.com>
 <0c55125d-5304-415d-86c0-a589c612babf@quicinc.com>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <0c55125d-5304-415d-86c0-a589c612babf@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LwN8gUdQHIuchhIVeHYAgbpWjAD0PBRr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEyOSBTYWx0ZWRfX4QZ/qL5T5FLV
 ONqnbToLdK5F99O7dzU4Zfo1GnGkK27Quh/5HMRSCNRhndFPH856YGpByX7RKcwsJuXgJoB3xlp
 MMsM13ugJ8TQ0zA7rO+WrJYPnwFo+85p2Ol4b36V6EL50wT4FS8Kz461kfV4F/nvkzbr5XbKxTx
 Dv4mJRc69UvZUvckzZAzRAD26hIs8HRq9yU0C3vegVn3VTNwDnK8whtOxSzHrFKR8RZPwOH6rW7
 Q8NSpUwGhLNnhqxKCY0ElVwpWxmv14+l5U20OsDawZEf950IRTA9tNmC4afAjeW8n01057KY5R6
 CiZzTASAQw+wVr7948cOVb+Grk+FsBl3S/ujFaby815EzlJI4m7RdMiBhgNjsodJFriBUrYPrDW
 i54PoS0YViQTmDMZ46l++Wn6bruk2SshAV9+4kbg/mGS/dMSsZ8Mw5EQfDIysgJf5P6rc9u00l5
 aKx7HL6/5s+q/e6Wi9Q==
X-Authority-Analysis: v=2.4 cv=Een4hvmC c=1 sm=1 tr=0 ts=6a621287 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=rfji2Jk2iV-f214sYr0A:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEyOSBTYWx0ZWRfXzFVShzei7YdS
 3ZehB4deN7HElCbp9bRzY0mcZOkJx3jpvpaUAmwu54H+KbiPpLTeCJi/rHIfg0Mvo0rIkWsUkiP
 0sukVF/phN+1mM+noa4xfu3dlNSLOnQ=
X-Proofpoint-GUID: LwN8gUdQHIuchhIVeHYAgbpWjAD0PBRr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230129



On 22-07-2026 13:10, Pavan Kondeti wrote:
> On Tue, Jul 14, 2026 at 10:46:31PM +0530, Shivendra Pratap wrote:
>> reboot-mode based drivers can define a reboot-mode by adding it under
>> the reboot-mode node in device tree. This limits such drivers, to define
>> any predefined reboot-modes statically within the driver and creates a
>> dependency on device-tree.
>>
>> Extend the reboot-mode framework to handle predefined modes alongside
>> those defined in device tree. Drivers can now define their own
>> reboot-modes and register them via the framework. A centralized init
>> call has been added to the reboot-mode framework and adopted by
>> existing drivers. This ensures driver state is initialized together
>> with predefined modes.
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> @@ -195,35 +264,17 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
>>   			continue;
>>   		}
>>   
>> -		info = kzalloc(sizeof(*info), GFP_KERNEL);
>> -		if (!info) {
>> -			ret = -ENOMEM;
>> -			goto error;
>> -		}
>> -
>> -		if (!memchr_inv(magic, 0, count * sizeof(u32))) {
>> -			pr_debug("reboot mode %s with zero magic values\n", prop->name);
>> -			info->count = -1;
>> -		} else {
>> -			memcpy(info->magic, magic, count * sizeof(u32));
>> -			info->count = count;
>> -		}
>> -
>> -		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
>> -		if (!info->mode) {
>> -			ret =  -ENOMEM;
>> -			goto error;
>> -		} else if (info->mode[0] == '\0') {
>> -			kfree_const(info->mode);
>> -			ret = -EINVAL;
>> -			pr_err("invalid mode name(%s): too short!\n", prop->name);
>> +		info = reboot_mode_create_info(prop->name + len, magic, count);
>> +		if (IS_ERR(info)) {
>> +			ret = PTR_ERR(info);
>>   			goto error;
>>   		}
>>   
>>   		list_add_tail(&info->list, &reboot->head);
>> -		info = NULL;
>>   	}
>>   
>> +predefined_modes:
>> +	list_splice_tail_init(&reboot->predefined_modes, &reboot->head);
>>   	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
>>   	register_reboot_notifier(&reboot->reboot_notifier);
>>   
> 
> This splice here makes me ask why we need separate API for registering
> pre-defined reboot modes? why not extend `struct reboot_mode_driver` to
> pass on the pre-defined modes and let `reboot_mode_register()` take care
> of both OF & pre-defined modes.

so something like a struct reboot_mode_driver should have a member
with list of predefined_modes and this member will be owned by calling 
driver?

> 
> The semantics of `reboot_mode_reset_predefined_modes()` is very
> confusing. It is not clear if any client driver needs to really call
> before unregistering? The unregister it self is cleaning up these
> pre-defined modes since they are spliced.

sure can try to align this using above approach.

thanks,
Shivendra
