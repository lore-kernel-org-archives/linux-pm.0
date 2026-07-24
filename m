Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6AD37AA94
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879272; cv=none; b=HFul5W1FFy8ZQZTHzYx4u3i4CeMa5dq+oP7W5Yd36BtZFzmSsYPbJq9RIrX8xjN7iVQznUWG9VyQDirgNbbOOtx8Z8VVtdrysE/Fwcv4W6g9anSUE+gLsfWKH+TOYT5Rna81/Y4YcmFLkbVYSyYTqIgAOhVE1WKduiCnTiNQGkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879272; c=relaxed/simple;
	bh=DIe88Zw9WWAuEjBW7hGr7bBuI8RJaECUB5RsHO3IB0E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Rbvc7edjmgpgohkQioNhQ6PEsRuxq5JkDEHKCR7GcuULeUUp2KvGpXq+Mp27KuGi/omrwGpxZq4qO/20Lr13tGpTbDkcOBU/wXw4cRvYuPYAAxFpfA4YwgG0R9wGmoRIvX2+AAsDHIpvu9PJLAVQvotRXgcQl7BFxby9OiUSAjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n7R34Aop; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fPIgci5A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n7R34Aop";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fPIgci5A"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5xVdi1892454
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 07:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5IHS8Pv+e5A5+jxfOg/W3A3G1owIeSmgpg8spUeYUKI=; b=n7R34Aopw1ZoRAQO
	BxjUWJFr/5YUsdAZLVguRApcRBzzjvPqoZaK/HfdljcNtUNAVWGDvN0K65tr+aLx
	xXga7fvJqhGhZPmUKANrQe+k3TPyQfTfJ/yfqCESw29oPmnandI+r+ADcEWASiND
	p6ACkMckJthlh4LjO7rcJ5rTFGfrYSz+bsyQ4bGV2ykfdbsX9EFdJKEov/bntSSD
	78i8kY/efbLjM7lyOj2Mujh7NjKA+D2qjP0E3UCE5W6NjqiWpPPCo0GLTYek67qx
	oePLWWc7OP3n4sOksp5XYJQubbJ47fyjNs0Ji5CyijixlutV8FkUbySngd3y4hM+
	cdbCgw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm2cx8db8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 07:47:49 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84842381150so254581b3a.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 00:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784879269; x=1785484069; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5IHS8Pv+e5A5+jxfOg/W3A3G1owIeSmgpg8spUeYUKI=;
        b=fPIgci5AmA+r2si1fKuHzhfSrpp+WcYhEUPICduAp/VIVS20hmpor0XbwTi90qJk65
         SkzX9/KcbHL1KfZAz73ZgOsPjS8wkoRNvFeqtDGGac0dhQKXliiQBDDS/7PONeP8iV1i
         j818mH6t2cWOb2olKGr4HJfso+2Q1PnZeMOu3oKJvTwvAWuP9KU+1JStquwNEangy3bR
         bkdaQUscvpl/IjaFdXFeILjjKa0epT/a98dOQYCh01DG2diFgPvjtNEacbeASWuufJhh
         ucxQ0wx5BK4eQQz3b93ZQcqOsAkibOgCwTUqdBMbaYehHvz7ppeA7YTAIHODhk5VIeYd
         J7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784879269; x=1785484069;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5IHS8Pv+e5A5+jxfOg/W3A3G1owIeSmgpg8spUeYUKI=;
        b=P2KOLjtYcqI2YuJeupvrdgz1ryiYLwje4nTcT58j0lhCKo3Ijao5zO8mHrh8irWSUF
         jAlEG8scYq3WARnBFJ8UyuzegBMcRuS/we4R6EJYBSN88GjVJSaMr1QL1y4QMNGtvwLq
         /HK0Ob7IMFxI2Cr3HcHniycYCuuL3BfqUf5gBcJNUUiGXJYk+qExVQDwmOYGuZU5ri6K
         pEQgmAjAXTYHzbZXLCiZNI3pxkO8/iVBjlsOOxPj1BtV32QBKMC23UepwJ6zbd8MSIbA
         IXRBcch0yI+aUFYuP9bbMpl5AMOsCke3NB/KmVFlApNgcyhrp37aE+skoRW5y1FnLknV
         68vw==
X-Forwarded-Encrypted: i=1; AHgh+Rr5j9dcMIUSeYvuRzJ3on+doNSeLyzjXDX3xm2MnTWImu1ORuA7c3g0N01KifO+v+n6WVZkH7tnOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyX2CuvGES6G07gkfRhhrHCh3PcUe4SCE70UqXT84b+Fs1yhv5O
	7tGNNp7YLLahgen1ClbRDnp5t1s/+EZUvF/8H4fGSZB5vhXPdPxap/Y8vn7fT0acxwPspYsAUMb
	rpE1K6295wJ5MnecmyIP4dzBDE9Ecm75zLFaZ6gdVLFwHz7/N4/DOTdtziFFI
X-Gm-Gg: AR+sD13gnhLc4nsXi7BD2uDZx/mN8NsYuxKtsimB9O/fipd8kHUTpnLvKxlM33/rGKj
	M8xFnGI6IIS6Q2vwN7jX3XI8qbWgejpO+81iDVR0Ld30lc3J7Z0k7dUWFennOun6lH0ZHz2j9w6
	+IOagDyQULDmUlIa0jac4iXL0XWlrU6rxrLu5F1OzOGiZJBJ9ncipLIIcs1KZun51s/vsqABR5l
	UiaXhhLtvQnBSAXbPcBENcblRKkB7RuUdqKg7hCYHabD8BVR77K9wxgIJq+HVq9BvGkG0BExAOc
	Yp0byUnh96S2+HWUNIE5KRsG4tHUehB4mKLcZAU3i+QhBq5zGtLj3upwgcmffiogwckC4nNO8Zl
	SLPn/Pa5d6pJNAHhXIFKezbVAlxJC
X-Received: by 2002:a05:6a00:32cf:b0:84e:1da9:6a53 with SMTP id d2e1a72fcca58-84e2b8688bcmr6892796b3a.19.1784879269003;
        Fri, 24 Jul 2026 00:47:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:32cf:b0:84e:1da9:6a53 with SMTP id d2e1a72fcca58-84e2b8688bcmr6892767b3a.19.1784879268506;
        Fri, 24 Jul 2026 00:47:48 -0700 (PDT)
Received: from [10.92.217.4] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17578345sm4201068b3a.39.2026.07.24.00.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 00:47:47 -0700 (PDT)
Message-ID: <e78ac252-1631-4f8c-a0e7-e48c66c20d9c@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 13:17:40 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/7] Introduction of PSCR Framework and Related
 Components
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Sebastian Reichel <sre@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org,
        =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        chrome-platform@lists.linux.dev, avaneesh.dwivedi@oss.qualcomm.com,
        umang.chheda@oss.qualcomm.com, faiyaz.mohammed@oss.qualcomm.com
References: <20250618120255.3141862-1-o.rempel@pengutronix.de>
 <3309e88e-e189-42ea-b74e-346aec1b4b5f@oss.qualcomm.com>
 <729b0e26-bdbc-42f9-8245-79b2942272c2@oss.qualcomm.com>
 <akJaAesz35Ml3iW4@pengutronix.de>
 <4b5321e8-05c8-4f3f-bc22-d3776e008151@oss.qualcomm.com>
 <akXnLLl_nq2G8EGI@pengutronix.de>
 <f1400208-0c47-4dc0-8b69-d3ca2b054bb4@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f1400208-0c47-4dc0-8b69-d3ca2b054bb4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rW1AaXQjqjDdBnvPczm8BB-JMAzTBgOH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA2OSBTYWx0ZWRfX43yy53Xg05yU
 Ir7g3iy8P/b/CH7YhRm0EgO6qqYjb/KV81UJQkX/hNSrXE4RAwRm+F2P4Sj8BZWQI49Zn//UPCG
 EBQUwULwDWDJCsqaSc5+fp8FGdnbT+5m/k/QWXwm+3xTLAwMInXKGBcN2iIGvgSTMxUpd4I9p6f
 Fr4FGCguys0TpUFMPSu68CzXttSNYzYwisnqJ0kZn1YTcJC2k3KsEmpAmtxecR3EVQy+DOCRsbk
 /x5he1LlTJ0EzeKIwbUamvNnaY/EK4jTvPSI+2zyQGhBuMIQIrD9pcl9TnBgBKEc6Gr2ME1P67r
 Xy0/tFxT9xW1FsPDA54Qp/7+dLdV3W88n726kYGq5wkcC5gIbwg/A7NS6YLehcIJcrVxcmuF3Z0
 OM8FXpq+r2u+iiy2iLVlEyEoCO5idJ3EfbRDQ9Z+i/1Rmw0kvUqa+G7UHJ0V3Q2a3P9Y4nL+QGL
 NoHh1Wt318mMKoz8mBQ==
X-Authority-Analysis: v=2.4 cv=X51i7mTe c=1 sm=1 tr=0 ts=6a6318a5 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=XVDgrs5tODRM-HsWCiIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: rW1AaXQjqjDdBnvPczm8BB-JMAzTBgOH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA2OSBTYWx0ZWRfX3yiK2drpQrA2
 1RPKm82aIaDrUiui+XIg167UDb2C1n8h/ZkFy/jJs9f+ktW4SFOKv4F1TUSLeP7TD0+fuTCxJzl
 tHjXzyD4667ziBXORwJwBxvxHmuXBaM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240069

Hi Oleksij,

On 06-Jul-26 3:06 PM, Faruque Ansari wrote:
> Hi Oleksij,
> 
> On 02-Jul-26 9:51 AM, Oleksij Rempel wrote:
>> Hi Faruque,
>>
>> On Wed, Jul 01, 2026 at 06:26:37PM +0530, Faruque Ansari wrote:
>>> Hi Oleksij,
>>>
>>> On 29-Jun-26 5:11 PM, Oleksij Rempel wrote:
>>>> Hi Faruque,
>>> Thank You for sharing your rational behind and idea behind 
>>> this framework !
>>> IMO it would be better to have a single framework to represent 
>>> all the
>>> reboot reasons of a system and not just the reboot reasons 
>>> caused because of
>>> errors
>>> Ex capturing reboot reasons like ota, bootloader,recovery 
>>> etc ... currently
>>> nvmem reboot driver does not expose a sysfs/ABI which user app 
>>> can use to
>>> infer reboot reason ...
>>> Also, it would be extend this framework to also support 
>>> firmware triggered
>>> reboot reasons  ...
>>> Do you have any plan to extend this framework to support 
>>> userspace triggered
>>> reboot reasons as well like bootloader, recovery, ota etc ?
>>> And also extend the framework to support vendor specific 
>>> reboot reasons
>>> which can be triggered by firmware  ?
>>
>> I have nothing against it. My imagination was limited only by 
>> some of
>> existing problems :)
>>
>>> We can co-work to extend this framework  ?
>>
>> Sure. Should I put it somewhere on git, so you can try your 
>> changes
>> on top of it?
>>
>>> On representating nvmem cell to the framework  - if not DT 
>>> what is your plan
>>> to represent it ?
>>>
>>> How would framework discover the nvmem cell if its not DT based ?
>>
>> I'll need to re-spin it and send a new version.
>>
>> Are you on linux plumbers conference this year?
>>
>> Best Regards,
>> Oleksij
> 

Just checking in - Do you have a rough timeline for the re-spin 
and posting the next revision?

Thanks,
Faruque Ansari

> 
> 

