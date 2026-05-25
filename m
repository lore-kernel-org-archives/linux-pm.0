Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB973E314D
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701675; cv=none; b=mqwHkYdSFONkoIAgx6bXYnXTYI0Vwe9uAv1Ila7kizuz1Mb1M+3bKLUAcN6WW3JE9dbr1etMpi5YXTVFmfoF7ScOGf5jlMacruibR8/0sf4mlgsEd+Uy+YFx6FSS6Smwzd4DMibQTgbf0VmHFdcKumWOsFIZuRFrbHociiUKF1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701675; c=relaxed/simple;
	bh=sHZwQ8kTbtkLCbKSor+QBOmkUwZQk6J8JDiHoGrcmzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UTGyzjP2DPX+Qdqw44fZCuNuG98D4s9jM/Ncvb/EG1LzMb6hXTyV7akUJxRj0vOV0KkgvvzbjDUkCKd3lVJEM/fjmT3mi4x2nXXsqTBRmeDHOzH/TueRxMaqD8OkuPymxBc5XovuB7lez+tDOfWGzVnzrMBMIF0qbceTyctE3YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pecBBg+S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TDPB4Lqx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pecBBg+S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TDPB4Lqx"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P6UCen725099
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 09:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NWtZANLHzw4I/IUILA+giiDj3hDdk4vM2TOMGAB+8uo=; b=pecBBg+SsBTrRmQr
	Pg3TUzF8MmHBHR09X/FqARhTkfJBdK/6RDtiEhRtj0mRcmkDgKDSdOyuEqytApXq
	WVyX2QxasQhCfnhMP1AAAa+uO8xVM0J4enEU1Tuw/qqDW08qzaNautouP7MWtx5H
	l0e14uTrUywGuttuq2vndYtaxZOjzhC5eBdrP8HGvsaBvTQj4qNigwBwMGN/mtnk
	gOkeXwzCYrLxwvdLGa9b+AqwunWbx9/zRFTvUn4dW+g53zBJ9Ebx4HKlEOWkPiEl
	2XgYhnhjsZ/MxUS/iGyWahjRobN1Z+WsZDjBbv8HOAphLPS69hhTRPa1uX1Z+41p
	Vxg53A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb1kmpeqq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 09:34:33 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82fa1c94b37so9513258b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 02:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779701672; x=1780306472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NWtZANLHzw4I/IUILA+giiDj3hDdk4vM2TOMGAB+8uo=;
        b=TDPB4LqxmUonPgyOf8cS2BdCGQh6NvvwB4O+Mtc9kvyeXegmx2nJwyVJsAB41hUqbo
         /QGKYEt2XKsyfq210116/9elcLUyHOdRhcBntURiko5s8F2Fmg2nzcNBD9JZ596r+Zla
         x4R6yahYjyU+V7bWgnZEWL+moHo/ckrpKidcr6YkAggiG2/W4PxlU5Eg+8ckChgHhTEg
         AU61yhxnVq73TR4uFiP8Q+fcLbWDbI9sHwpP1xmKyZFpHyKbK1lCloXYYFMHcYWVhMHV
         pR/lnmgNX0FSSOBpkPDWPTBnbDpXfY3LZ+SyeE2W+Q+llPMLDQarYcxmA6hecmUC3fwq
         Mp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779701672; x=1780306472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWtZANLHzw4I/IUILA+giiDj3hDdk4vM2TOMGAB+8uo=;
        b=klL7y/jYsFhSR/d7ey/cBw6HLttvXgEbR1Nf5ji99fFVi714hmFtZ/mPnSgOyPwdig
         cjcEaEBqxAQmYznALi8slW3JgcU956DlIigyPIF3IhdfbKF38ho269JPjOx/MM9TrHUK
         GxubzrROiAyPLyYe+DuPx29deCAmXgv6pjnAeIgCtNhjypNT81iA4vrKG/gHzNJMCuXf
         zw6VLDZdgHbJdQH9rVRwShEAtgzuzG+O9NXC8e+2pCZ2qjOo+2kRhe2hHUH3IT1WfzG+
         KSV+7rjtZBS5JYfmaki3IsN0NId0nrckmpmE05ZCzCVnQO0jj9YMKbgz6xkPgFn4jav8
         euIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+2N7Xosv7UjV486jB0QVgIkusltAL+j919YDCBsBCojWyFflQm1GnVWDvj1OxI7XdN3IIwpBIiDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNujcwT/zhvK37b9R8AScvcKCM/eHPhpXrzLLvmAK4hP2GiWi0
	hPvKAuxgdicyfkK6L0kal0r6WrZtkfOjv8D9FeHYACB67BPrx99PXs5rSmqyghohBr/mOH/85ko
	jEzAqYZplRZcUyNiQxdRxcP81oBM78BglFQWYZqtjavv/5qbuEWVvwame5XLN0Q==
X-Gm-Gg: Acq92OHmFCpNxk3B/MaBKHLN1HyvwEdGoXG/mTFn6ws4u6UuNkAJGyCpvhZBzEkdtDD
	CDVnRus65zQpDjPq2Cc/8QzaDRfFPpyT35nEUXZBMpS6X6HcIoEm5jojdtiGsiohtbvgdZvGzkK
	U/Tq/U5US0z+zkv1ZMqFiNg9mT23zu+eXYoGCwEcntizn+ALYWhoWqgOy3KKboqNTE5iX7JyG+Q
	lenp80h0I68pd6DQp6JcgOKhhGyv5NGEtN595+AtN7CrUVaLAFmPbNgIxf8ih29Y/GYVsnuyxl/
	5jWZuxsXRgwmVeJMbzMF8xaocV00FuERpw3ZcKdcpmoXMgBEz+eXNhSe90YEghXQAicVu4aqzoK
	GLh29ONvsO9NglypNphZnkYXzA5HKF0/9Li54DHr3NNImRQsgcpnlJh3q
X-Received: by 2002:a05:6a00:3c6c:b0:841:a0c8:6e9c with SMTP id d2e1a72fcca58-841a0c8731dmr1853844b3a.26.1779701672294;
        Mon, 25 May 2026 02:34:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:3c6c:b0:841:a0c8:6e9c with SMTP id d2e1a72fcca58-841a0c8731dmr1853810b3a.26.1779701671783;
        Mon, 25 May 2026 02:34:31 -0700 (PDT)
Received: from [10.219.57.229] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fd80cdsm10474835b3a.49.2026.05.25.02.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 02:34:31 -0700 (PDT)
Message-ID: <c034a7c5-7215-4e96-80cf-ef0c51f8291b@oss.qualcomm.com>
Date: Mon, 25 May 2026 15:04:20 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 08/13] mfd: core: Add firmware-node support to MFD
 cells
To: Bartosz Golaszewski <brgl@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
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
        Sudeep Holla <sudeep.holla@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260514-arm-psci-system_reset2-vendor-reboots-v22-0-28a5bde07483@oss.qualcomm.com>
 <20260514-arm-psci-system_reset2-vendor-reboots-v22-8-28a5bde07483@oss.qualcomm.com>
 <20260521112638.GD2921053@google.com>
 <CAMRc=MfqaCjiALZyVBHQs=Taft1M9xmNTFvQHWPrd5PgcTfJDQ@mail.gmail.com>
 <20260521132419.GA3591266@google.com>
 <CAMRc=Me5QS4xA3PJWXNuRP1N_C+w3sP9ZvqH36GNh2Ebc9hwcw@mail.gmail.com>
 <20260521162705.GH3591266@google.com>
 <CAMRc=MdiwwX_XH7JFW8HuLvYA_ao50fjj0Oip2WMM4QROHRiFA@mail.gmail.com>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CAMRc=MdiwwX_XH7JFW8HuLvYA_ao50fjj0Oip2WMM4QROHRiFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA5NyBTYWx0ZWRfX3CRBO3MLTgfI
 Q5zZFc7jwAPlowoeyYlW+Gscu/drmP59CF9WJCCmxH330Unm9uN8jccIE+GuQPUGnHidouS+pEU
 82/9q9t1o6WkBezZJBJWzU+mEOeSkROkQMBWr2JZZSgENT7y3LcFeS4ahrWZ2qCBOSwOuM5oT1G
 igJ7JLgKRtY+QlqdfuRIl6udrnmqtg5W+gplH7bXML9mFbNXpk+Piahj+APIojFsxL31rtXnY/w
 0szRrB9zTGVBtwL2vsu0quEnFu/8XWKnFOTU9B48J1BJGsd+myyX6J3Oej1BcYOKOCf3EKWvoqP
 Bsv+wHqo8Fyx0r0jXM0jBoiVtd2RWO0wpQyIfdieHrVYJKJdeRi3zP/FgaQew3QSYBLNjgm054X
 SmSz/rWS5RA3mJvdSUsw2S17420dYq7y9gS+X1q5MjWR/XhtFS9I9LF3H5e6HInJTfq1DtopUWL
 O3OLN/kG7BQpSyPQkIA==
X-Proofpoint-ORIG-GUID: CXotDR1LDfbWlCvkpsniVL5MFcqpEsBN
X-Authority-Analysis: v=2.4 cv=cN3QdFeN c=1 sm=1 tr=0 ts=6a1417a9 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=VqCRv7ZaHuqyx2qM4PwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: CXotDR1LDfbWlCvkpsniVL5MFcqpEsBN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250097



On 22-05-2026 14:38, Bartosz Golaszewski wrote:
> On Thu, May 21, 2026 at 6:27 PM Lee Jones <lee@kernel.org> wrote:
>>
>> On Thu, 21 May 2026, Bartosz Golaszewski wrote:
>>
>>> On Thu, May 21, 2026 at 3:24 PM Lee Jones <lee@kernel.org> wrote:
>>>>
>>>>>
>>>>> I suggested it because of its flexibility. The alternative I had in
>>>>> mind is something like a new field in mfd_cell:
>>>>>
>>>>>      const char *cell_node_name;
>>>>>
>>>>> Which - if set - would tell MFD to look up an fwnode that's a child of
>>>>> the parent device's node by name - as it may not have a compatible.
>>>>
>>>> Remind me why the chlid device can't look-up its own fwnode?
>>>>
>>>
>>> Oh sure it can, but should it? I'm not sure it's logically sound to
>>> have the child device reach into the parent, look up the fwnode and
>>> then assign it to itself after it's already attached to the driver.
>>> This should be done at the subsystem level before the device is
>>> registered.
>>
>> Leaf drivers reach back into the parent all the time.
>>
> 
> But drivers don't generally assign firmware nodes to devices they are
> already bound to. This is racy as in probe() the device is already
> visible to the system. There's no synchronization of device property
> access - properties are assumed to be read-only for a registered
> device.

thanks Bart/Lee. Any pointers to take this from here?

thanks,
Shivendra
