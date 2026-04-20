Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ED9389107
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776683189; cv=none; b=fQj0pJYvomuNco5LUNFC9LcZ/NUXUyYJ88LhH2e8ntBOxf9rW7yFT7+PZQQrWk1rreFYaDltEtGVsBUia29chsgr4wUWNp2WnSZ5hr2LASS6GM6jPE5rPQxJ9hJGCi/OG7Pwq0ZOUb/kisoeLqgmp1hvDJ7gZ2SLICevUSPOcJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776683189; c=relaxed/simple;
	bh=teuNoK4emsPEHIOZR9bW0yrvh2BUodDHjM2demeo2nU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+ilvbhlmInlwjLttV0fZMrI1R7xSg4WY08xym3jqt+F9pam0X1OTWUHHSzVLRqIU0ctRjK5suLK8R9vLzBuTVEO0MXqHoH8t72t6Rr2fXTpsmfdAOuz66X1NZxMisuh7XYfgPtgAdA7N/EZOnYVFd/dUiiWahD4zrzcFuGjA5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=evYQw0uD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GLe3r2+1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="evYQw0uD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GLe3r2+1"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K79FbZ1598277
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 11:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2G953hZMJUmujnmYUhAxX8wJ6Fmm1Vm5+Mt2U/urYLo=; b=evYQw0uDxsjzzlr2
	IH8TRX0E62HF50TqV8nIGXNi2Ux8gh4e8N4pwyOjJFdfB0RRJkEV2zjJRFoCQFTG
	O2nQ/0dR4nvWENx40WEOCenm5BZdDKgeUmP0veDGUTxctfsrEToQld0ya3KK94pT
	PrD0hEwPSqoBbc29k4hS0+lnT3vLGqJdEjZrTR/vyQbGmJiZN5ljGwcHF6AtcvAK
	EGoUUd9PiNroBiiwJGKOkWf5sMB/HRP0dmWKBzjUKXyjt/ayZ7inZb+E26Cko0y7
	w4KLYZOemyxl81dwhzlGJECh4jd0wtECwy04tL3e7omEDpFjro5SNq5DGouCuYVy
	h1NGTw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfgnh5gn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 11:06:27 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5fae584a130so3621764137.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 04:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776683187; x=1777287987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2G953hZMJUmujnmYUhAxX8wJ6Fmm1Vm5+Mt2U/urYLo=;
        b=GLe3r2+14Cbu0Vqnway44vbAF6NUacWtE4weYmPIgGin5icZsAJ+qtQoUFwrIMG2OC
         ujl/1ttJ45iqi1oqKx7rjlcKtWQY5srs217sFMv9q/atiqwn/9JoiZMpcXSQJHLCaRYT
         OpSKWkxlLT8XIUQIjNj3oJH8JByVgJOYB7eTU8nCyEp1rMPEZ0+1uyPsgn8eUTLL1d3W
         CT3m98gbigpwJ072CiikrQyMU3PylJ8P7Nvnpx+NUEFYLQ5xGoF9EyfH7rQWX7SNsI6w
         nCT/UCgvJ8FfZzKCQdt0NyK56WTw5kbpMC4ynJf/JHsyFVJP9sXO/RATU0jcU+sA0AtR
         Dweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776683187; x=1777287987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2G953hZMJUmujnmYUhAxX8wJ6Fmm1Vm5+Mt2U/urYLo=;
        b=UDphMeQ3niol4ZCYQf7F45iv+xepfOUhXkFtz4VIVqPYXVFbI5ULRW8PgVHd3ViB3Y
         Y1F5Slw69ut2NvsKpJAhkm+2g2Apg3oOH1mFIsHIljGvtGOmBjwyBbiMdl0tenggxtFC
         bGg4ms5bKHRO77HiqEJclCnXS3inSz3od771x11h+gH5JwVmlYSjw7ISqs7uC0K5ovyo
         uKunB2bR6C0UkhgH4WONSif87tXFGm0puYFznAvsNS89VUzGkgfksPjxydXcxMO6tTIO
         0w2e51cuY8N38IhkLYd9qnSna79RKInrPImzj/M7bhUz1c+BR7G85l9RqYy3DjweV3/o
         TmnQ==
X-Gm-Message-State: AOJu0YyvwvhOjKbmoEzUr5IMNsj2pTDHo/a6NMJKtXrXQidtHYzk2cRn
	qE+hD7nuT9mOiJrF7U86BtiFYC9EUT0EzZAwVHAhHEkjvJkg7ERJYyA31U4yP1/Sd1lD846u+6O
	pneYJKx5sKxGZ6RYhkn1Mf95tVRKq0LQReFqHN/XRCHO3SR2YBXtPXgRA0LMO4w==
X-Gm-Gg: AeBDietqYpLjdTCgvmfeDk7kF/xHkKGat+RScfyWHZ+VdOL4Wcj4ZIZ5jorlZRBTYX0
	nFWmRvpdzqDU291CRhtiHbMM92HSPYKY3in4KXJMI6diirzHZlYlUzcFtrMsfuoJIMLcqLTV8wS
	yxGhc26xtWId733bhrf27/whScLnKZ2dZbNlQL47MjYuNe9txpuqNqi6gYHYzrh1yIvAF0xpalg
	GX13VtaUSeamXKFoSXyC5b0eqjGgCxNZcy/cS9QNZSj/iUdqIdFPsm/Yjw+Bkl/E2QbDg6T/pbx
	svJbBAltBhU9tgQG27R3mYGFh7IiXcrzL2mlmomJW2OE0EJj57ux7/3pw8ohK8bbf2Z1YDWxY/3
	gckp333lV1BZ1wgbUi20VXQvbsYaWW0tdA00BPI2R7JRhitOytp9F5qnH3PV66N1/hGhLFob8kK
	YZN+WltlwQoHNGffno04w=
X-Received: by 2002:a05:6102:dcd:b0:610:6e69:5235 with SMTP id ada2fe7eead31-616f71f0a70mr5407254137.22.1776683186720;
        Mon, 20 Apr 2026 04:06:26 -0700 (PDT)
X-Received: by 2002:a05:6102:dcd:b0:610:6e69:5235 with SMTP id ada2fe7eead31-616f71f0a70mr5407207137.22.1776683186269;
        Mon, 20 Apr 2026 04:06:26 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1365sm29755408f8f.7.2026.04.20.04.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 04:06:25 -0700 (PDT)
Message-ID: <0934c77c-3a6c-4a74-b52d-f255d2929700@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 13:06:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Pre-CfP] LPC2026: Power management and thermal control
 micro-conference
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Lukasz Luba
 <lukasz.luba@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        amit.kucheria@oss.qualcomm.com
References: <CAJZ5v0jp-xWc_7Njjsva3EBhJXM31XVBpSspSkTd7FJ0wz1ezQ@mail.gmail.com>
 <1d111777-d1f1-4737-9dd4-3a1205876a2d@oss.qualcomm.com>
 <8677457e-5d8a-4f30-a688-a4613f17c740@oss.qualcomm.com>
 <CAJZ5v0hb-RT5ZaRyea+ge5jMsv1g4i-0ONpc2O4uqKe+6A+bsw@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0hb-RT5ZaRyea+ge5jMsv1g4i-0ONpc2O4uqKe+6A+bsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: neHTuVNGpGnTvE4q9M3tZQTAB00_AcrY
X-Proofpoint-GUID: neHTuVNGpGnTvE4q9M3tZQTAB00_AcrY
X-Authority-Analysis: v=2.4 cv=TK11jVla c=1 sm=1 tr=0 ts=69e608b3 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=VeBi7jdpqQz4crEdz-UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwOCBTYWx0ZWRfX2Sm6HLld0meW
 8eQDWM5mVHot/OQs32kCbb9ekgOB+mtzQB3qPxc2FGfSLQvYXbquPiwNUk+XnSgZ9pCVY5JO0xa
 s05saftd78Cuh7FaCbwDWOOUQb/7XQOv2I/rYEabegTsgBE6TytrAmeirpj2l7jd1cndXO7JquW
 CqdPYXI/IWn7phqat0EEpVqRcEuMcnPvaqL0N2LgNfiKUD1kYOuW16P7Uvbc7385Fr+YhZ7NFS5
 aK1Zx74iaHj90FiEH3mFBc2YnymRblBOCy7LX6z9c7bXj5xVYoNXU2j+HA2TLQYMveIGu9KiLhX
 hGfNEKaef7PDGq3to9w5D9GU7FBdLYiu4c6o92/KMH4PgCOjVfg1Iw5UYPxAtpkovJC7anovjSm
 mwPUMV/tGNn4fKBtazCOLTMLi95ZqBixnO5zHhWBqEZslZOJlY3zwqIZ0eDsv+YufpG2YnDlixL
 fS75NqW0N7QXIkytQGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200108

On 4/20/26 12:22, Rafael J. Wysocki wrote:
> On Fri, Apr 17, 2026 at 5:05 PM Daniel Lezcano
> <daniel.lezcano@oss.qualcomm.com> wrote:
>>
>>
>> Resending with the correct email address for Amit :/
>>
>> On 4/17/26 17:02, Daniel Lezcano wrote:
>>>
>>> + Amit Kucheria
>>>
>>> On 3/26/26 15:35, Rafael J. Wysocki wrote:
>>>> Hi All,
>>>>
>>>> I'm looking for topic suggestions to be included in the power
>>>> management and thermal control micro-conference submission for
>>>> LPC2026.  The deadline for submitting LPC u-conf proposals is April
>>>> 23, so if there are any topics you'd like to be covered, please let me
>>>> know within the next 2 weeks.
>>>
>>> I've some topics to be addressed regarding thermal issues, limitations
>>> and enhancements, suspend/resume limitations, powercap enhancements,
>>> user space resource management and may be power supply.
>>>
>>> I'm still in the process of collecting information, sorting them out and
>>> doing a selection of what is the most relevant for LPC. I should send
>>> the selection in a couple of days (may be 3)
>>>
>>> Is one title + a couple of sentences fine for each topic as pre-CfP ?
> 
> A title line itself should be sufficient - I only need a list of
> prospective topics to be added to the proposal.
> 
> Also, the deadline for proposal submissions is April 23, so if you can
> send me something earlier, please do so.

Yes, will do
