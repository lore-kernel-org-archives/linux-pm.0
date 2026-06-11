Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACB0317153
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196259; cv=none; b=alliXHwpkegEVVG5Dac4BMLLdRxhveD12vs5eoxJfzhGrpbqBLvIramd3igaY2On0R1nJ7uJzGdPLN1SzaruucyNVdqIbUfD0Omet/MgULCN+c8Liy+zdaDWIGPNxIeoZaTaWNae52NI1y5kIe6ZmHCLPHH/N7IbpQyXvkOT1Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196259; c=relaxed/simple;
	bh=krf3HaMPJXgKzlKQ0ngepJZ/cQfVsLaulpxkrHsT8W0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SRtOmeREhpJJdmJGO1cVBbYm5HSeqt+55Zof8tFykvvrMVXL6L4oWCf/gYUgSDCHNlh9mdMPIkqAgI8ir9BLBRdBN3B7xKJ1QsmPqpjoAYGAs2Hc+T7zJdttcBYNgveyMS6FBQYt9/FQc8r8m/8c6bRuu2WzopIVkwuBD5QqyP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=luUTcME2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OAyhsIhe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="luUTcME2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OAyhsIhe"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BFojWM3680462
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 16:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iOSSTINPYxoG/5DaQTGvJhl0JSwby/3qC3+a3z+0AOc=; b=luUTcME2sUlw61mL
	ReMyeiq0+X/1aoZE9CvGwEOvIQlQuWzUOedDJ/3cUnZ45h/B+oXs8/UysFWThEy6
	qPEEws8zhWxe5KJCYqvN8DjWs1W1nWf8oundDLi97+kbAeNwDrdXq/5DOwZYb1jO
	9vYUWJOSGfFqsRdDvUDeg7N1EqGwQOCBWWILNEF8gpNAAPYq0OFbiyqzBH50IQbY
	KMizfSv8hpypr/f4KRf1GemUOhia9OAlWoQqdvy9Q5FLc8E+vxNya4n4iHH9sn+c
	n57r4ascIllM2zZFrW9Cb0eCASmchsxOOXvK2uB6UvGBpbyKyjYQaAuPGo70I8qR
	9m7qUw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er014g8fc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 16:44:17 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c2d65d9792so271145ad.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 09:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781196257; x=1781801057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iOSSTINPYxoG/5DaQTGvJhl0JSwby/3qC3+a3z+0AOc=;
        b=OAyhsIhetZoDjF/9TguDIwzxQOI3euHlr4hASQZfC4jYJHstzQ4J3Nv7PJG/H2SUVi
         zuvmSjtqa2gsX6h4F4cQZK8UGObcxUpLE6U/7UL+/Gi9sxBcD+j4eC+QPceiQ5+1eafk
         h0RqTjoW3ViXTTM48Ahe1Q+cREC+PcZaPE7RMLjISnRffiUdAcqA/Eq6q+kINZ/m5iN6
         k100QiDFxMOQ7ql5fvMh64Nhe3ZMGJvJjsHC3hZGJEcX8P1ZaImN0QXP7yFdXL6oO/w2
         Gczi6GPyoB0XEJ2xup4pJd0k+CN00gwQq4FTiG+fuM+EyN58wGWHX/WFmPAcQMeT7LRm
         9KaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781196257; x=1781801057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOSSTINPYxoG/5DaQTGvJhl0JSwby/3qC3+a3z+0AOc=;
        b=KtcPsFNMXCTxhtpxoy8NTsxOxZIBDt8pyHrz3KBkA+38cwG0l2YwCmIdrtOjYNcokQ
         a/k5nbAAOH2zv2+NbsVQ/H6240CypVZa0W85Xb19oJMOsiBW0Vk/yk2XPh16vKZ8Dpzf
         esMWJCoe+AQ3JHfjm9jI86rSkag4uZMfM4M5nIf8hCGSWxuZSly1Zo9IyMH71K68hgvF
         5KjLEbKbMWdBrBCsLmrrf8fdoE4/RWvN3rLJJVaJzvCxM5jGFNQpfBQf/SORsZ/Mg7jT
         gLPpHJaSiWt0rf/A10Giz/h8Z/EAGQk+dInDZGxyZrDjkYbfqFle+vk1t7ct7FxCTD/E
         mKDA==
X-Forwarded-Encrypted: i=1; AFNElJ9o4cpfONZfAspk0EtY1UICobEKyYFvhKyKoTQUZb4SSJr9RASvQTrjQvmrufkT2Z+2dPz4qE430Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyypJel9Pfq655UDHLXHHKAHTpNVZUDU87ddFGu2ITpHr33UIKK
	bEJ8S/OuvTUpFyTL9e2GySzDfe4KAziByb/+2986JfS9OPJdyZlClLtnS/ozCX0ht1AP21X9fQv
	31yAcWIB1Eol+p0PYb7D3n7dVDcdX55FSKpxBFpsYjYWWXgVCWt8IAqXEPKogRg==
X-Gm-Gg: Acq92OFpUDvoZdJNaPT56064/GIuk9hrLK5LuVwIa7DCSHLHXBTIwBOqTVbLVGZtjiS
	Ln2wi4HjSOspgnUBKfJEw9wjuQf/B7Nd+AVeECuhJBGZG+fcNOQqOE0rRZpZw1rmvPH6N6TRHaY
	GBwQ4TOTENp82QhsPfGDscfKuz/O+aS0FkvSfO6aXdxGbLdjSU2K8JrGMjmZZgOY8mFqbtoWF4d
	M+hzo/o4MSRfSEQtvA1Pl0efzmxKkujG9O9SuOdPQzHQW0PDGlL1Yx99wNI303nI72YQYbgmAb4
	eV501WLv5TJ7orwbg3fOPWJ6WJlMosf68ywCINwxpm5CQOM92uOT1RxtJTBrlS2b4OJ3vkhnY37
	gkeAzfhsInvZcHcvmdT5oDvIArCGyoENa90U7CZyHhbJYe3Iyr+lV4hSq
X-Received: by 2002:a17:902:ebc6:b0:2c0:c940:dc1e with SMTP id d9443c01a7336-2c2f2c64838mr40351545ad.20.1781196256563;
        Thu, 11 Jun 2026 09:44:16 -0700 (PDT)
X-Received: by 2002:a17:902:ebc6:b0:2c0:c940:dc1e with SMTP id d9443c01a7336-2c2f2c64838mr40350855ad.20.1781196255866;
        Thu, 11 Jun 2026 09:44:15 -0700 (PDT)
Received: from [192.168.29.31] ([49.43.224.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f875casm285676815ad.22.2026.06.11.09.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 09:44:15 -0700 (PDT)
Message-ID: <9b1eb177-3a54-4e27-878d-b0e66362a30a@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 22:14:02 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 08/13] mfd: core: Add firmware-node support to MFD
 cells
To: Lee Jones <lee@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Sebastian Reichel
 <sre@kernel.org>,
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
 <c034a7c5-7215-4e96-80cf-ef0c51f8291b@oss.qualcomm.com>
 <81680397-3bbd-4f66-9166-546c8fe753fc@oss.qualcomm.com>
 <20260611164211.GD1212816@google.com>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <20260611164211.GD1212816@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EeeQwHd9TDXGGEOndfMXV-ChnOT1Se4G
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE2OCBTYWx0ZWRfX13grDPlqcpvf
 oT+LoZ/Na/I4OB3GwyUTZOMBMgDj81hqqpmPKIQiv7hyuWKhmCHvCin+rhnUaGs8sRKghllckL5
 bDg9ECmDwjysoFKSJnqln/lxiVkUNkY=
X-Authority-Analysis: v=2.4 cv=Qp9uG1yd c=1 sm=1 tr=0 ts=6a2ae5e1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=7stYiaCvZhmFmS4NdBt+oA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=lPjybrl6nYg-Po44eRwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE2OCBTYWx0ZWRfX8Z3LF1JXDf0i
 2SAJACUgCZCNPjb9bZm8v8VtBmjsiMELcqMHOJrjD59pImQsL0l7a8HQWrx62Z0IDcG2hEBj9mE
 gVAFo8nrdfJ2zI3RK7QOCIUXQ9vH+1uUEDqlMCy3d3UPNHeq1ezQXNNOPEug9myG8fXUbVadYmr
 eczK5o3rIsPOXkRrXocs+s0rW4+pyxh0eS1EECuTsavCJ+iz66Gub1HaDYMWhC8sO3u4ArGdCtz
 Mng7/f8sFAQW4sf+yAWlcDUy09UJf8glE9GCAYXs29wMX3JoZAqdiCsQWi0Aq2Ho0Ko8GIJkmbB
 GI65EC5nwR2kVYq8oHwbpvsR//3OmDIbZB/vS/hWk4gDQSqWGKxHsQAgeYHNiAb+ixU18bBQE6X
 1sG2hcGgGCTd+nIJC85aZex/Z/Z26KIHqsK4IIarf3WIasGx12wPAPUjhcFxyH4jfEoX6vvtv00
 YtQEayzsRK4PNLGP+Rw==
X-Proofpoint-ORIG-GUID: EeeQwHd9TDXGGEOndfMXV-ChnOT1Se4G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110168



On 11-06-2026 22:12, Lee Jones wrote:
> /* Sashiko Automation: Reviewed (0 Findings) */
> 
> On Thu, 04 Jun 2026, Shivendra Pratap wrote:
> 
>>
>>
>> On 25-05-2026 15:04, Shivendra Pratap wrote:
>>>
>>>
>>> On 22-05-2026 14:38, Bartosz Golaszewski wrote:
>>>> On Thu, May 21, 2026 at 6:27 PM Lee Jones <lee@kernel.org> wrote:
>>>>>
>>>>> On Thu, 21 May 2026, Bartosz Golaszewski wrote:
>>>>>
>>>>>> On Thu, May 21, 2026 at 3:24 PM Lee Jones <lee@kernel.org> wrote:
>>>>>>>
>>>>>>>>
>>>>>>>> I suggested it because of its flexibility. The alternative I had in
>>>>>>>> mind is something like a new field in mfd_cell:
>>>>>>>>
>>>>>>>>       const char *cell_node_name;
>>>>>>>>
>>>>>>>> Which - if set - would tell MFD to look up an fwnode
>>>>>>>> that's a child of
>>>>>>>> the parent device's node by name - as it may not have a compatible.
>>>>>>>
>>>>>>> Remind me why the chlid device can't look-up its own fwnode?
>>>>>>>
>>>>>>
>>>>>> Oh sure it can, but should it? I'm not sure it's logically sound to
>>>>>> have the child device reach into the parent, look up the fwnode and
>>>>>> then assign it to itself after it's already attached to the driver.
>>>>>> This should be done at the subsystem level before the device is
>>>>>> registered.
>>>>>
>>>>> Leaf drivers reach back into the parent all the time.
>>>>>
>>>>
>>>> But drivers don't generally assign firmware nodes to devices they are
>>>> already bound to. This is racy as in probe() the device is already
>>>> visible to the system. There's no synchronization of device property
>>>> access - properties are assumed to be read-only for a registered
>>>> device.
>>>
>>> thanks Bart/Lee. Any pointers to take this from here?
>>
>> Hi Lee,
>>
>> To take this patchset forward, it would be helpful to get your views on
>> fwnode based addition in mfd-core. Maybe, a member like "*named_fwnode" in
>> mfd-core and then a lookup logic, or any alternatives?
> 
> Can you please make your best pick and resubmit the set please?
> 
> I'll comment on a fresh set with fresh eyes.

sure. thanks.

thanks,
Shivendra
