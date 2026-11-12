Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471867;
	b=ONuRAjkUAf2CUHCHbHG7TFOKeIOyHwegVMmT8NMcpwQ/z0KLHcjS5Weok7cY3fgL6t4Z
	 caRWfE09yHrIXlMBrWsYpGd5DQZvJ18LlLZHHP4BioRTkc+Fc9z3G7VrHd/atH5uvdonI
	 ANXiLDVnfXyzb1OibjCCVGkh8ByWQ4Qtx8ukcORmAneomIodsQLBKpdAB1P9ySbPARGTk
	 7LbN6NoJi/fSYEs8W9xZFhMCc8XeT7i68qRgMR42xIGmxC4BkQbyfk4xm8V1p0hH8QGbP
	 psZz6x3MKyTRnyeYFDnACtPde66M1F4q4b+h0+boUDMhfmXClsg/UC06zqVks1PP+PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471867;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Hnm4o7Efp6uAFK0sTejyg9BvHNWzfhth1bKiu10aeTU=;
	b=gnTPoofZHEGQ+mcPHw6vdquedVETDfiXtnD7Af2ZR8GHeUhnnl42pG/2LXBDT1+9JYQP
	 YkfT9m+5+5ZFpexn2PV61ubDE9WfTV1bMlpKtf5pFCAr/Wddo2FJncxYB9SnDAY8FErCs
	 SwAfksoIpAAKkUxf9gkOemdXFNtPzTrcGZMJDViUzHX17XPklwlATgbzrfwxuldVkwFUo
	 ZuOiiYc2rBrxS0ki2q+PFmM/FXAuMOmdJeZqd36xuO0GF9TZhcoBd6NKAU0eoPxcWY35F
	 yi1jHuTgd93+0bqJK2YvpPfIEny/xj+zvUW7SNcJfhnfxv+9du/mzMF1ivNgaL26AWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KipuKcTD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="hEK/Pm7a";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6AF606A32A
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 08:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F6AF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KipuKcTD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hEK/Pm7a
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2ZPGe4092381
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 08:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hnm4o7Efp6uAFK0sTejyg9BvHNWzfhth1bKiu10aeTU=; b=KipuKcTDkwnA2b2Y
	vd3SUAXH4KXlfNttzEU/pll6PxpmjmFrzI/GS/63ecw96BT9Tw1/jZpVUjjtVv20
	7AEpxams0vFvOdAENEis4rCFD3qV5DE9v06aX7frdzF6ir9RRpP46K5EgmCEuGth
	MFegXECuBkCsmyVmxtWarin9oJAZZV+e1lU7LRsXA5NIKXW5Gdxc03HMtVgcxUys
	MqgZZZ51bojRzV4BkE/MWKqV4Iz0mUB/n7LhovOmjaqm9SjxEOEquwgx/Cp9RERY
	ZHKiqCjTlEkjvXtNO8UMQGMtAw2kKQp4eR4z8VBi83U5+0pw5lqKTx4vw+fcwGSF
	66Gjrw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw0m8hx52-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 08:24:26 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b175a69ab8so2923863a91.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 00:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794471866; x=1795076666; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hnm4o7Efp6uAFK0sTejyg9BvHNWzfhth1bKiu10aeTU=;
        b=hEK/Pm7aUSfLohFlWs371sm0Ua5U/Umf/kmxX56bjWdEBnCrvMwWbxgbO7qY2jALeh
         XvO5D0mOv4P8sngu4YJGoeHCq+zs1kBjqR2GYzkYszsZ34WrSa4g5avYXztPOQNo2XJY
         MvI9lW9PPHZvOAx9oATNDegL3UXKLxowxnjVUuDgEVygXf8h1ClP3twIpuVQBimnvyIf
         P7etDhFufMam5sMKQmhQJ7nqBf+NrCIuzprJH8Qx3oDFWoYypE+d7HkkUa1gPXCmg+hB
         yC/JXRc7vrlYsGs8VwjVvuZdsAvP7R+WAvAG1FWe+Bf2+9wbeEwfe0uQ5AEdf1+uIWzj
         bjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794471866; x=1795076666;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hnm4o7Efp6uAFK0sTejyg9BvHNWzfhth1bKiu10aeTU=;
        b=wTMqWjhPk5jfBivQ/3xYecN+wGj4ckGBrXDAu+48G2sBdRi7N4Jpzma4lLzajWQ63L
         Ly5oXiG/oOhZkUxPxi5YxdXF1CzWZobuYMY2PiD0DHE96FZb4S0Y+0gwE48X4PkvAwZm
         dd6GpblZ6vXGXqUUXeTbguPe5uELUTN3cImydDpBRUD3cjOpXKjynqgb8qd9EAsXIylW
         JhDQfGDDuNTAntjYLkQJg8fP2gjA9uHjHFxGyBY/a7NrCE8GhBxcMUuH0/PKRmMlt5vz
         IKdxAOYPgdOtHtVhzZTHg8ssyZjkVSqthNdLpvv8kzUwkUeyBnYfgW26AysqByBUpZJd
         38lg==
X-Forwarded-Encrypted: i=1; AL+hErG5MveuEnRbwq9ep5UpJeo5GfjqASUHSoDJEvDeJMHac0Cd12f7iV4qirSAujkA9HKxL04ctFxKng==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Hp2Pyf2FhCpCf0HJHL2o7kMsA2aQPOdQ1Dcn924AU9f2gwDV8
	Edv/EkPf8i0Lb89rNMmYUAhcnD0DkjO3ojj1lBNViKzPdQ2tOEHTGQVnhcNj23a0oK9DBhOx6Xv
	sI9aaRz0Q4E3SfiYfCZAKoM8wvgsV9sCD0rSuPsCreegOMO1cBOyzJLlknyYuCCJa9tpn/g==
X-Gm-Gg: AYBFou22bfYCV7rcqCffe9hXjBjUuRrKFW6g220YrFf1hYe+9htd3/wEJAUNmbbnFhh
	WFy+pXSn6EY+uj5kO7MQUrjWA7d9Lms55fvem7mZTMAhXvPfzoIxLYpp572TgZDla7GLfw+0lou
	nP6HbyfWPVfqmOOaPfFvUVmhkqCnZ9Ll5BpbJZ3di0bz1GsDb2XkTGSzId/0JjptckXFZxYOiDI
	BhLmFl+lcCqq9M5OM4jthOSDse80P/fAEBvhEXNLA+oKRdHo1R8ODEmja13m9c0I5Bgo/vlhhta
	++eoWpoM4jVPr4D6riMWvi/yfGVEpaYZFtkNj8vVSjsQTaxilvtLxnkEbP72rlVKG9ntCe2gzLc
	XdwSAusruK7X74eVS+L1aAGAwqYWf8BzEDqv9GmX+dFPSkZxCK2r2CEV6KAwBrOF5H9WfXBorue
	qsDQ==
X-Received: by 2002:a17:90b:2e46:b0:3b0:c22e:9460 with SMTP id 98e67ed59e1d1-3b182deaa09mr4492848a91.2.1794471865762;
        Thu, 12 Nov 2026 00:24:25 -0800 (PST)
X-Received: by 2002:a17:90b:2e46:b0:3b0:c22e:9460 with SMTP id 98e67ed59e1d1-3b182deaa09mr4492809a91.2.1794471864996;
        Thu, 12 Nov 2026 00:24:24 -0800 (PST)
Received: from [10.218.7.34] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d9baa5sm29887245ad.45.2026.11.12.00.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 00:24:21 -0800 (PST)
Message-ID: <5c879271-6e88-4683-a280-eef292c442ba@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 13:54:13 +0530
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
Subject: Re: [PATCH] thermal: qcom-spmi-adc-tm5-gen3: move hardirq actions
 into threaded handler
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kamal.wadhwa@oss.qualcomm.com,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>
References: <20261111-adctm5_gen3_hardirq_removal-v1-1-536ed503396c@oss.qualcomm.com>
 <avR6cHb6ZUsDzIV2@ashevche-desk.local>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <avR6cHb6ZUsDzIV2@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzMyBTYWx0ZWRfX2EY46VjvYil3
 3x+MdP9/QA8JGRQIDenrvwOf7uZZElwwrObmxjjDzSDhtFylPL0kEPMQQyCfOahxYOJ/SKY/pVs
 30ZIs/Sqtjqo2fB9BZcJWO4lW+enG8Q=
X-Proofpoint-GUID: bs1iP6yuc9ymMkRo-kKRbZmG3xL5sWIf
X-Proofpoint-ORIG-GUID: bs1iP6yuc9ymMkRo-kKRbZmG3xL5sWIf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzMyBTYWx0ZWRfX9SCc3MhAmyL4
 b8ladcSqKox/S0nqTfLiMiwZYT+iYC6S6UNXzrG6Tmz3So4oNtmNheCNJjn8h85sQ1NCGbUh8DA
 XyoEjdfQgn5HFwag9ctNkLndk0hbvgQpJl6ejzUgGLsXjaXGdxV6a5T3YL7oLeZMgGfAhyL+QXt
 zHR6nrwi6JUA/ZnB29gLklfrmv91fQ24WWolxMjVH0JzoQoZy8WCbUaEEmGVqgUpknCu7s9HEnJ
 vUhIzU3MUCWIq196zkVw4CAtSJeLX6EbqY7hwNr2GhUQAUGC6bqxJbLaHbNqOTzBTnz9cKt2QSk
 LvlJtnHCAOaNoHoZA0U6Ibn4kaWO5aG3RPuv81DchFuSQxGssL8K9opze3BC8XqGRBwJjGD6a89
 8JJk4thaSW5uSzWkYsddMpZPb2o8vwDZCGuhoQuCHJI8frSsghojwmC0dk4PHpdPpvO6nx9GoW+
 J7wCABjxxD2mCf83byA==
X-Authority-Analysis: v=2.4 cv=Q9dHcI2a c=1 sm=1 tr=0 ts=6af577ba cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=9akHpOJ0G8PeWv3IIDkA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120033

Hi Andy,

On 11/11/2026 7:53 PM, Andy Shevchenko wrote:
> On Wed, Nov 11, 2026 at 02:12:01PM +0530, Jishnu Prakash wrote:
>> adc_tm5_probe() registers the ADC_TM interrupt with both a primary
>> handler and thread function (adctm5_gen3_isr/adctm5_gen3_isr_thread)
>> with IRQF_ONESHOT. The primary handler calls adc5_gen3_read(), which
>> takes the SPMI regmap's lock (a regular, non-raw spinlock) from hardirq
>> context. With CONFIG_PROVE_LOCKING enabled, this leads to a warning
>> about an attempt to take a lock in an invalid wait context:
>>
>>   swapper/0/0 is trying to lock:
>>   ffff000b67201018
>>   (qcom_spmi_pmic:259:(&spmi_regmap_config)->lock){....}-{3:3}, at:
>>   regmap_lock_spinlock+0x20/0x40
>>   other info that might help us debug this:
>>   context-{2:2}
>>   locks held by swapper/0/0: 0, last CPU#0
>>   stack backtrace:
>>
>>   CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.4.0-rc1 #1 PREEMPT(full)
>>
>>   Call trace:
> 
>>   check_wait_context.isra.0+0x2d8/0x380
>>   __lock_acquire+0x2ec/0x840
>>   lock_acquire.part.0+0xe0/0x250
>>   lock_acquire+0x8c/0x1e0
> 
> Please, drop unneeded churn, since regmap_lock_spinlock() the rest is not needed.
> It's all documented in Submitting Patches, take your time to read and study that
> document.

Yes, I'll trim the call stack and drop the less relevant error lines.

> 
>>   _raw_spin_lock_irqsave+0x6c/0xd8
>>   regmap_lock_spinlock+0x20/0x40
>>   regmap_raw_read+0x88/0x328
>>   regmap_bulk_read+0x10c/0x340
>>   adc5_gen3_read+0x38/0x50 [qcom_spmi_adc5_gen3]
>>   adctm5_gen3_isr+0x90/0x130 [qcom_spmi_adc_tm5_gen3]
>>
>> There is no requirement for any of the work done in the primary handler
>> to run in hardirq context. Drop the primary handler and move all the
>> actions in it to the threaded handler, which removes the invalid wait
>> context warning.
> 
> ...
> 
>> -static irqreturn_t adctm5_gen3_isr(int irq, void *dev_id)
>> +static irqreturn_t adctm5_gen3_isr_thread(int irq, void *dev_id)
>>  {
>>  	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
>> -	int ret, sdam_num;
>> +	int sdam_index, ret;
> 
> Was the variable rename so important for the fix? Can we defer it to the later
> cleanups, if ever needed?
> 
>>  	u8 tm_status[2];
>>  	u8 status, val;
> 
> ...
> 
>> -	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
>> -	u8 tm_status[2];
>> -	int sdam_index;
> 
> Okay, I see the reason now why it's done, but I noticed no mention of this in
> the commit message. Also it's unclear which variable is used more often and
> what is the real semantics of its value. Is it number or index? With all this
> in mind, please at bare minimum elaborate in the commit message and, if it's
> actually a number, replace the other part instead.

In both adctm5_gen3_isr() and adctm5_gen3_isr_thread(), we needed a variable to
store the index of the SDAM whose IRQ was triggered. We called it 'sdam_num'
in adctm5_gen3_isr() and 'sdam_index' in adctm5_gen3_isr_thread(). In the rest
of the file, it is called 'sdam_index', so ideally that same name should have
been used in adctm5_gen3_isr() too, as it is more accurate than 'sdam_num'.

As I mentioned at the end of the commit message, I just meant to drop adctm5_gen3_isr()
and expand adctm5_gen3_isr_thread() to include the actions formerly done in
adctm5_gen3_isr(), but I see the diff makes it look more like I modified adctm5_gen3_isr()
into adctm5_gen3_isr_thread() with a variable rename, which is a bit misleading.

I can add a line in the commit message to emphasize that 'sdam_num' is the same as
'sdam_index' if you think it helps.


Thanks,
JIshnu

> 

