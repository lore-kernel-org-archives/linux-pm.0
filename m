Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568A2443308
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626140; cv=none; b=DQpsk22zd7Y9jHzY6AQd5HLCLpVwKnzval4byE1/OsiSAkKVbqAl31mevWeuRdozlM8brlHOgXuL9ad+UFut+xBfNKpSsEcwwWgumgpAR0TdXPrpuBwj7aVr0JGsXlbYQBqWcgupDYhAIe3Sg8mblGS5B24tK6+RDGpgl9aqc1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626140; c=relaxed/simple;
	bh=iJG8Toux2U5TsrzwottVDiL8Y/t97me5211y2C4N37I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LXyL8ls2P+w8YbFV6EtM+x2ys2PQkaAKJZ/gM6Po9uVu7XYfn1VykoIE7WzIwUXsijJOiJ2yZOClmypUN+eI/1Fdb7IXfhfQwwj9qNOSFH1eCzOJYJG+tYwaj9D1DOrmj6uJ6cmvF9tNHadI0eID1yAF2gyxEcVDE+uZ8f2c8i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IPPhBua4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IJV9CNuM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IPPhBua4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IJV9CNuM"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L7venW092270
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 09:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pc6KxO6xh4zaSrcFhKD91Fl76TRNxmoAYzgik4d1dlo=; b=IPPhBua4b5Qx0rSA
	XP4Q8DYw9P7x9yqJWFihYyMjnkBuuy2TxJYB18LJa4q1McjJQhMlAXE5Wuhvp1iS
	zbZv7VQOGds/RGgmYo1cQHuBauWNXdsqwNFqgS+rqJOsmdkaI3B0DEt3mFqX8jh+
	7WsqzOA7Dw7T3os6E4mkFViI+TPchskNE59TuDLv+wDkO6Xt8pfKekWkOca7vsyN
	HQ+8/cX7Yjs1DJ+RXgGgjmlN2/5/ctItw1/el80FGt6ARuex17LpeQkjflu4Tud5
	gGDDI0hbuK/Td2bn9fM7AmpQsHYwjeVXKjRcbps86kFi2r5uiZ27WhRRHjTYZqOv
	29wLuA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj01a9ucw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 09:28:58 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e475f83a2so7557165a91.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 02:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784626138; x=1785230938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pc6KxO6xh4zaSrcFhKD91Fl76TRNxmoAYzgik4d1dlo=;
        b=IJV9CNuMuNYEgLdN5TkZPpV+nUzirtZygngYK45PbztAN3AHFSFR7Lpvw7DrUXUNXi
         0FITJlXQbGEfqmIc36/uBwl9PRpgjss80ocqLLkmaSQ//30y43Ilb+6ZsUBLZx0bXHrB
         p6+Qquyat8dyoNyr6gun+bZElJSc5MwnkkG7Gy++yP4I7tFUgQXlJoCTBfNltx3idcOo
         tyZHlK7zZ6YrluHz8Blm5sbIL5XDZ9pnd9UGLhU/VH+Af/nBv+F8jwYz9dffLjdaP6bQ
         uJxJvJs0E7mAHxuu14pTBEkXRShVeuQnppG+HtAXLU0LrL0OASAND7raBcvZvfHC3NrO
         TPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784626138; x=1785230938;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pc6KxO6xh4zaSrcFhKD91Fl76TRNxmoAYzgik4d1dlo=;
        b=qHWvOa4HZXkM0cr5jvfEUBOSaAoIQuAf2PKSUqSUtghGhComS8SQDe6nv4LI6Juia0
         kcvwoq/VRLmqOUfpWRuG09Bq2Ked7Hp05H36d6ERrtzBnWzM9azNB2e/jdfjI84Rs8b3
         QMSNO2NFkqFqj+oN+7/LiU1MqPpC5M+QbuMG8Lz0KshgktYk1DfeL2oMaOGsY+RPJ7YX
         /TtBayBOr8HEk+Nkq7+ykhnrquWOvjbUY4E6hlesFb0REzZP09Hg7LaDdffGaA2yuHWO
         6B/zhtHQ3htk+Kw3Qk5P6LYOl1Fdr8+YgYm6AbRXGL9/asKDYUD020WmnMtMqCmoCrSr
         QnMw==
X-Forwarded-Encrypted: i=1; AHgh+RqCfFKNHatevk0YBg4iItQCeWJma8TfuHX9GE79Gk5SIIeah8PQ45C2hinxe1DlSQ4p4EEVaFItfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiLFhvkMLtmWWUNrnmVJ6tk0BNnKdqvG9GeXXQlc8oW/lVMHrY
	SdY0BlzpYHlocDeuA3RX0kEi/RYCygmNro3hf/F3n36GCVbmVjeGq/MVrg345PCJG3CJMvuy321
	4iJlF+eTnzXW+xyLoa1Qfo+z+E7S57B0eEzDlbr6laUehXnhNMHhBG6V/owmODw==
X-Gm-Gg: AR+sD10AWk5n36Si2D5Kipllwy88bo0njoFeSbddZH/T/MlqYSQkyBw8/PCi/7Vo+0l
	zxE0LcIVfsOWa3zYmyn1Iy2LogzyLoqJKTEDribyiTWlUCc9sUgkmQoUTDLuIhnwSZniPi1lTdg
	q8osCIDPG7bL8X0DZGzHyolIje9ZwxDPbxy+If2NLlrDKwrAMyiY/OgB//atYZKZRk3/m+IKGza
	G7L6JfXbvAjAyBF3gGoEfVFq5u+snYjroKGLhbPZoaxD8KwkwBc2hYDtrHz3hiQ+Z9ZCppPvCQs
	DscdNUGVxCGMfuDciNpe8yFh6JTP5jmW8DueIH0+FQgE3eR5PIrgHAkW84dS02F6iXZrPlHZrNt
	G64/kAv8gjQ76aZaHphxj52Vps4Yb
X-Received: by 2002:a17:90b:580c:b0:38e:2524:724f with SMTP id 98e67ed59e1d1-38e4b410109mr18418055a91.12.1784626137871;
        Tue, 21 Jul 2026 02:28:57 -0700 (PDT)
X-Received: by 2002:a17:90b:580c:b0:38e:2524:724f with SMTP id 98e67ed59e1d1-38e4b410109mr18418025a91.12.1784626137393;
        Tue, 21 Jul 2026 02:28:57 -0700 (PDT)
Received: from [10.218.15.172] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d093bd8f6sm3740252c88.4.2026.07.21.02.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 02:28:56 -0700 (PDT)
Message-ID: <05081037-9ed8-4e0d-8480-cfa45e950727@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 14:58:49 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: Disallow disabling boot CPU based on config
To: Sudeep Holla <sudeep.holla@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20260703-disable_boot_cpu_offline-v2-1-782d16ff58c3@oss.qualcomm.com>
 <20260703-competent-adaptable-coot-f8daaf@sudeepholla>
 <4b7fe7e6-2531-4d26-9085-43f40a2ce2e0@oss.qualcomm.com>
 <20260706-practical-inchworm-of-experience-d4e0ed@sudeepholla>
Content-Language: en-US
From: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
In-Reply-To: <20260706-practical-inchworm-of-experience-d4e0ed@sudeepholla>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BL6DalQG c=1 sm=1 tr=0 ts=6a5f3bda cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=dWC8hVThGWP9nuoixJoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA5OSBTYWx0ZWRfX7l0tnIdT1ddl
 q+NzOgRZmjC/L3st9bQ79rUqkxGEP6dBXMe0aJZRvM9nxfBB/qPZZmvwgL1EdJ+sKmuL8ilzIqN
 c6XUQXSuVZk2BrtlkTXXLDZub8sDsJQniQsFg/mAQ9Uxh7OtdSOK6z3Z195evvt59t94DncEl7C
 v20BiaKfNiUB021gGz6eNOjGHKk7y+2bbmQYui4Zzp93z5eq3kHQ2jDvfLaJDv1sLbGQ2IUcwB3
 s1/hkML9dDjb6SA7wBJnZKHQT+I9y5DAmTMHQxftu8rzjKyxV/Vsm1NNMSYKIc31xi+YEEo3h1E
 ZxYdUBQhilQhVieigbNpmcWF1YIoWppEjbaF6v8ttDGeqw/brtiQ1aQhWVOhMe7vhygOPXpVARI
 ofKy1oWhuJj+ekUOlbd4iGNcMnf6V/375w51kFFQVBbPuLs69W5T+4xgbqgIEouNvFkwfEu2oYf
 HBIKwrWyykVOU/uXRXA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA5OSBTYWx0ZWRfX5ndhltoENfmz
 hidkvXC56u6INML9IZ0Ip1EAchl3P9T2TIbqoi+n+TP2wb3Oss3leHFiXvBNJw8qZ8OthJ2I9Gr
 unYcxewkYAY4xPznCxJJWqxpAmFcqiA=
X-Proofpoint-ORIG-GUID: BJ5hP6diy57i1qJr9wQxiPz8_BXTy6Ey
X-Proofpoint-GUID: BJ5hP6diy57i1qJr9wQxiPz8_BXTy6Ey
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210099



On 06-Jul-26 2:46 PM, Sudeep Holla wrote:
> On Sat, Jul 04, 2026 at 08:43:39AM +0200, Daniel Lezcano wrote:
>>
>> Hi Sudeep,
>>
>> Le 03/07/2026 à 17:51, Sudeep Holla a écrit :
>>> (It is always good to cc all PSCI maintainer for any ARM64 CPU
>>> hotpug/suspend related changes)
>>>
>>> On Fri, Jul 03, 2026 at 04:50:02PM +0530, Sneh Mankad wrote:
>>>> The Qualcomm SoCs like LeMans, Monaco support suspend to ram which leads
>>>> the SoC to ACPI S3 similar state where SoC is turned off and DDR is
>>>> retained. The hardware design on these SoCs forces a constraint to suspend
>>>> and resume the system on boot CPU / CPU0.
>>>>
>>> And you fail to explain why they have that constraint.
>>>
> 
> I still need the above to understand the issue/constraint better.

Above mentioned SoCs have boot CPU fixed to CPU0 in HW, whenever SoC boots up/cold boots it starts with CPU0.

These SoCs support suspend to ram which leads to ACPI S3 similar state (where SoC is turned off and DDR is retained)
PSCI SYSTEM_SUSPEND typically will be executed on boot core itself unless it is already offlined and non boot CPUs gets
offlined using PSCI CPU_OFF.

As HW constraint always makes the SoC to boot with boot CPU, consider a scenario, where 

Boot CPU is already disabled / offline => suspend to ram is triggered => SoC enters ACPI S3 similar state (only DDR is retained and rest of the SoC is off)
<So far good>

External wake up arrives (say power key press) => SoC starts booting with CPU0 => CPU0 becomes first one to "land" in kernel now. 

Kernel may later bring up other non-boot CPUs via PSCI CPU_ON calls.t 
However Kernel had already marked CPU0 as disabled/ offline but same ended up in kernel without PSCI CPU_ON call.

To prevent this inconsistent state, before starting suspend to ram, need to make sure CPU0 is always online from kernel/
disable offlining of the boot CPU.

Although the HW constraint needs boot CPU to be online only when suspend to ram is triggered, current patch disallows disabling it for simplicity.

> 
>>> Is it because some secure context is not allowed to migrate ?
>>>
>>> We already have a mechanism for that in place and this hack is not at all
>>> required.
>> Do you mean a mechanism for the secure context or for preventing CPU0 ?
>>
> 
> I meant constraint based on secure context.
> 

This is not because secure context not allowed to migrate but above mentioned HW constraints.

Thanks,
Sneh

