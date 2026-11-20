Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795191529;
	b=VmUpST+sp328ffIVHyAiV6WuTHurDinORbuk9OBGkuZu0kmPosa2HJBRwYAoKcTUm+T2
	 +v7JvRUCKbAf1SFxpgtsu+tjb+0UMaR4nvqnAiHJf5mSGEfKs5kJLJtmI6QjF4eGPdXOd
	 tuImkyM2qcvhxefZyNpVg7uBuOq8QLCKEwwSPgBXwa8haiVEm5IcloaL3tqNuTlDbFtFc
	 ie9qhXjvXBktWkC1KbDa7J/q8Mtc40mninvOECVO1XRfbSfuScD5yKriQejrYEexxlTAy
	 zOEp/+k7J6+yQIeOF3Dgd7X58uecGd+CmJPSTkEMgaJj8oym/04ADBt105wFPgIHLpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191529;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=t4Dld1icNXmUDCSLkNCdijjtSGyDKFWKh8cFgLUwyhw=;
	b=L2bZU6tVT65aNRQ9px65sLSrhRo4jg+pHM2bZdbIJEw0t5CGqA3wwsBJ4diJnbEHfWYy
	 6Sb0TBbTkvOkHpqOGicAUtG9PiFDphMlMtG7E7Nh521n8D3xeyz0BV2kl3SMcE/ak0x5D
	 GoYPlfigrl76WAJQQIsFmeywmFzoKyiMVlij7BcCA7TERp3ZtVFnlnokfpmkYkPqh9IY8
	 wAvq9Sw2JYn8Sg8RFtYQ9Zv8C2743WzpdmGKYPUyXN6jwyfS7W4Hr72a7PmCvd0on+yr3
	 p6ODjY1mwqZkGTzaEpL3cMENx65Vtab3gC6gfBaxgkRdR+lDhTjBoNSWDUd72CcQjtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZlbugbdA;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TQFppb5l;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36651606A330
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 16:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36651606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZlbugbdA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TQFppb5l
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKEfIrf2040014
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 16:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t4Dld1icNXmUDCSLkNCdijjtSGyDKFWKh8cFgLUwyhw=; b=ZlbugbdADM5bEepW
	juQrJ1QpPboC/UD0P9/ahdjjJvL8khpdCZF1N1R8Sn3WWEHC4D7IwOGOFyd88zwm
	cEF0r8rAssLKZBh1Y7qLrrIS21I3kWA/0nq3rzw4jjAcnwNMO9Rzjry+Y2xjlTQu
	V6IDN6D6rMjNuYlIz3uyPmifo6egm7y681+/pg1c1PVxBeIhbyA1WJW1McOJ9b4c
	Xbcn3nC8VN9FrsBfbdV5K2346HqyP/QLZ9LTSxUqglhCsrlI9obQvmBUiyrgSxBP
	4tC14qkzd/sBXXFXXCDL8uiiIU67Q255lcjfWPUkLRDJHjzN5lUgyarhCSX3hvGy
	dce/hA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjttqua-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 16:18:47 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b40e7f4fa2so1994352a91.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 08:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795191527; x=1795796327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t4Dld1icNXmUDCSLkNCdijjtSGyDKFWKh8cFgLUwyhw=;
        b=TQFppb5lcKMUm6lpo7PUc97eM5dnLxmBdCp+hQh1nrn51oINQ1oI5vgTKX1+ktxZXl
         wBIkX9qsVqTLAXxQ8K7EUSm9qO1qJNsoXCVWS1Hi69OPOMV6L40ZR46yTJG8q4MVKDpY
         2xWzen6ZdKXQVEP1zThAQNO5xxFNhjBaogtghBgOHxT4gcQOgYB4+vrq+cPCdUWeHv4M
         LnkyFu8TlDCqrFs/v1Nh/vtadLJjASx/i2x2otg8Lf7kdVmeEpEghuuJX7usGgiNyyyV
         kIFBT4BkBcv9wCVYyaW+e9AVrV1kNR5IF0OfEv4psUin8vMsrrgt6o+D+MUnokul4qgI
         kocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795191527; x=1795796327;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t4Dld1icNXmUDCSLkNCdijjtSGyDKFWKh8cFgLUwyhw=;
        b=U0JGg+ORh0V/XvEZ33LvhkeAZ4BR9wi0ndwcpVpJpmXtqT1zUrVnlPlget36zVwzgm
         G6+CvehonWfUT2ZtyWqUdQEKpm2Xc2KROWo8M2+ZXzgiQvBNADuK/o1oDU8NL0maxUgW
         DP+6DEdVledi5pu6xV0tm2iIfbtlw2abYWKh9e5BptX3QmaQxGBNcHSY6NBiUwVhDNXM
         1iuS+SPAr+vrx57U/w/8F9WE0uf5dJ84K6Lw1q7uk7ubLEmfGmXIxouVpn3zg2Grd+MB
         wquCDuFd3Xihr2VnkHgyWjy+ent4o3x80o3vaknToqazjsmysOww8ycf2y+pXtq6HGVu
         u5LA==
X-Forwarded-Encrypted: i=1; AL+hErF5lBaMzG4P/oWGvbm7LS2mJ/XncgRMx8uu2lG1o4zVccQuFGcpPUgirZ3rBsFByxOI+GdhE3L1HA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8c/B8dSX+arSP17uBb3XjJc2YnlPNFMZguuvspPFWmRUMkDkjF
	Cn7J38wNRSiL7qlmwauMmobag3Cb23ozKNsoL/pSiRR7+B6eFR9mepJfmPWurZGNsJXZleiqOi+
	E7cJKkFMxRDzW9BIxPVCkTQqDmKxTsfLtbZC9DUoFTjNZkddBGE1QKsU2qmJILg==
X-Gm-Gg: AZFdTZeUyqi1WL3HBdN0rPm6uDGiNghsgmG5bHstFyUnWErq69N43UGAOBxhfs2WhJV
	Y0MGNA4ds+THM4tFR6NJS2qdFhjyzQJNIsQEFFgT428XylsOB4D3YSSb6QvvhsBcsttLgeSsfli
	TjyLxUB07x/5L7HZz/et2jHQ3N3TYhf/OyRhY0ugM/yy6FOkSoX7JBJ8UScUwju9uQwoQ1XrISx
	akMez+KWOBDuvohXA+/j/qRdHqA/8O4/+o2zJdWQLweSRi6ZADN8i0kXnTW7zYZIKLsPEWPo99s
	jAxI30P55fB1c4juJxNh6kA1xJcboBrVklngJzzbQXVMXIZ60DuJbBPKfHNb8mZ6G0hxOaSrvkW
	Goff9He2F6hxLuGWxM5s+sRy04XHAenNooPWCMcsc8XmRGenZjJeqoenpTVhvAGs9n1hQrUoaCq
	rpA2sdFifL
X-Received: by 2002:a17:90b:384d:b0:3ae:a4fe:7ad4 with SMTP id 98e67ed59e1d1-3b41c8528b4mr3720514a91.2.1795191526813;
        Fri, 20 Nov 2026 08:18:46 -0800 (PST)
X-Received: by 2002:a17:90b:384d:b0:3ae:a4fe:7ad4 with SMTP id 98e67ed59e1d1-3b41c8528b4mr3720458a91.2.1795191526149;
        Fri, 20 Nov 2026 08:18:46 -0800 (PST)
Received: from [192.168.29.31] ([49.43.232.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ff2561asm1701473a91.1.2026.11.20.08.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 08:18:45 -0800 (PST)
Message-ID: <72fcd590-cdb7-4223-942d-329ecbd950e0@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 21:48:28 +0530
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
Subject: Re: [PATCH v27 00/10] Implement PSCI reboot mode driver for PSCI
 resets
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
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
        devicetree@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Song Xue <quic_songxue@quicinc.com>
References: <20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com>
 <CAPx+jO-WLCnVecquKbVaCcErbhuFt6OHFUmzbgNHjixx0r-wMw@mail.gmail.com>
 <avo8wrWBjsk0RU6s@venus>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <avo8wrWBjsk0RU6s@venus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kV69pFt92n5zUrfpctsfe6Z4LtmkGvKX
X-Proofpoint-GUID: kV69pFt92n5zUrfpctsfe6Z4LtmkGvKX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2NCBTYWx0ZWRfXy5SUHilRby5X
 2iPLPXCY0hk2bOgB9DnWM1SPhbYcQL497yZn71dYWnmYewnykov8ZPW+LV21b7ajGPGb04MpDVz
 0V6IStZHZ5tVkGKeh9LhAF6Updn6AVGsWkHPiaHCZpU1yML0E0FZf8I9iEiTMRxgPs5unKip2v3
 NNUk7Yku7BCDLtcxa23NncU8bT2B5DmJrhv8AjWoGto/rKQufOYiiOge1t76sSRNr6b5v4V29Zb
 qinzHReopnDRsTScYmbm6r6jmIqH4iV5cZTSFwLCUn7vJhBYATv8Tip5HSefbx+aRD1lLGFv9Kq
 W+GHi9cNWsoZyjtdVwXUVY6Nw0Nv8KoVifEjZjvbizbHwXLvJbbOeyFaWhCTNBJsZEEU0jLfEhN
 uhAITS5H5wKAodhgsR8tB5ssbRRnALJLQmFiZzrYP2cbY//nmaxjVuP26xobiYYpj3s7/fr24ri
 qdVM18Q7tZ6iEWztw9Q==
X-Authority-Analysis: v=2.4 cv=XcccX455 c=1 sm=1 tr=0 ts=6b0072e7 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=rVPHjc/N4E3dzGhKvu3xTA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8
 a=wsFT6AapSP24iMOhd5AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2NCBTYWx0ZWRfX0bQIDW1gQ1X4
 POQUa+1VcLsbrHMzN+B8XkuvW07AZpCOIIy+PEjljJnhXPj66ZRRPG/Hph/ZOlST1fjn83uXj8p
 ufwpstfi7bPkDWey1k9p38ejo7jGidk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200064



On 11/16/2026 4:44 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Nov 09, 2026 at 04:47:29PM +0100, Ulf Hansson wrote:
>> On Thu, Oct 29, 2026 at 10:01 AM Shivendra Pratap
>> <shivendra.pratap@oss.qualcomm.com> wrote:
>>>
>>> Userspace should be able to initiate device reboots using the various
>>> PSCI SYSTEM_RESET and SYSTEM_RESET2 types defined by PSCI spec. This
>>> patch series introduces psci-reboot-mode driver that will induce
>>> command-based resets to psci driver for executing the device reset.
>>>
>>> The PSCI system reset calls takes two arguments: reset_type and cookie.
>>> It defines predefined reset types, such as warm and cold reset, and
>>> vendor-specific reset types which are SoC vendor specific. To support
>>> these requirements, the reboot-mode framework is enhanced in two key
>>> ways:
>>> 1. Support upto three 32 bit magic values as arguments. This enables to
>>> support for a 32 bit reset_type and a 64 bit cookie).
>>> 2. Predefined modes: Add support for predefined reboot modes in the
>>> framework.
>>>
>>> With these enhancements, the patch series enables:
>>>   - Arch Warm reset and system reset cold as predefined reboot modes.
>>>   - Vendor-specific resets, configurable via the SoC-specific device tree.
>>>
>>> Together, these changes allow userspace to trigger all above PSCI resets
>>> from userspace.
>>>
>>> Note on introducing psci aux devices:
>>> Based on feedback from Bart, Lee and Ufee, PSCI child functionality now
>>> uses aux devices instead of an MFD driver, with psci-cpuidle-domain and
>>> psci-reboot-mode probed through a common PSCI aux device enumerator.
>>> Reference discussions on this:
>>> https://lore.kernel.org/all/CAPx+jO9Hi2R_UnCEhsXLwf74c3RTb+RodaJ6SOVXbQX_eHt++A@mail.gmail.com/
>>>
>>> ---
>>> The patch is tested on rb3Gen2, lemans-ride, lemans-evk, monaco-ride,
>>> qcs615-ride.
>>>
>>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>>>
>>> Changes in v27:
>>> - Removed unnecessary headers from psci-reboot-mode - By Bart
>>> - Rebased onto current linux-next.
>>> - Link to v26: https://patch.msgid.link/20260928-arm-psci-system_reset2-vendor-reboots-v26-0-b24e2348e8e1@oss.qualcomm.com
>>
>> Overall this looks reasonable to me, but I will take a closer look in
>> the next few days.
>>
>> When it comes to the merging strategy, it seems like the best way
>> would be to funnel this via my pmdomain tree. But I need an ack from
>> the relevant maintainers to make sure there are no issues with that.
> 
> Works for me.
> 

Hi Lorenzo,

Can you please review?

thanks,
Shivendra
