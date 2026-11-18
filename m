Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794983128;
	b=VLUv5kpCLJAqgoKyn4EoHE586FLTlBOCEvzNkC3NkoNOQaUTsj3oL5YhB5r+2NRCAdQI
	 0o/35ghvLdlXqWDbc78QQy2V4v8uQAzCvLRfDXZ4OpW4fX0kt/YPZyjG+mxkAjzRlOcOS
	 MFEEZhHygHPthdx0PUvuNsC0jyd/qZkCuMlDRN4qffzzKWeO9b5E+4WcIfv2MdkhzKp2M
	 NdFmPRqIY8DKV2OtAF9Hr8Y2p6WOjr2SSA1GDuzvd6Jqc4XY2T9Ky7OnVsgE4ENrWxLFU
	 Syt2bDcize8EnrFs5vc7ODqnddnU9KN6Kd9hI/aJrMyYp0Zd4rruQzNxk48+tYpshMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794983128;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=vHktRanl2tt0UlSkckJQ6mb0uteRAyXN7CZHm6pyMuY=;
	b=Mv9j9u1mUYSkGYzw096C8V6duq4ay5sPFR4JNs3SE+RX2zqC/EQey7dwbdvr/AY24yEy
	 5UHQULZb55dxBDOFvGwJkIVi76R1BkCemC6cfLDuGI6wRQkJRnRceibkkPjCHLDH0PKqy
	 Ee/cKBqu69D6WY3NsOFn19+YIKfgPYszxo2zjmykKgtmAJ1Cw2NFs0eb3vgA8HH4TpIH/
	 BIQ3nhkRdFre9bUcocGNVYyTtkw1iq+QsG6QowKTWRyvYJcnXHDx50b3H8IXOY+618m4Z
	 vVKMAJhqUqOAUh/DdYNZuLgphj+vtb2Amh01AOrzTdOpmppaLG/HuFTjhIIXEprdAqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AQTOwXO7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LMpNOTIJ;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72093606A31C
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 06:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72093606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AQTOwXO7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LMpNOTIJ
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2V1th2106297
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 06:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vHktRanl2tt0UlSkckJQ6mb0uteRAyXN7CZHm6pyMuY=; b=AQTOwXO7FiQkVjmD
	5axA+ItGGGgIE4xstftS8mxDgz/nA64w2UWB3ElFZwoFM0QdQgtjodwMBGP6UJvO
	4d41JnqG7o1DsQOOX+LdW8sOzbiYnT0bwtNi/UocGxiL4Z/ZdQKkjrV6KVErVmgC
	UCWkl0FTecYv7ng+9YVVUMM0d8dy8yIYmWwbfCf1B9QXZeAG0HfOvfzO3HIL48Aq
	oDmYpsMQSGhtiQchuoyxHCEbDeDvHSYbqKqdkEe/l2nGdeEbJtzwA95Lzpp5VMln
	GFosUPSzA2weirAV2hVK5q/vVU91f0Mt4gG7v9w4xXfylALiD1p1gcgbZl0Vtk0w
	VF4Hrw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv8sh06-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 06:25:26 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cddc4bde4adso417603a12.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 22:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794983125; x=1795587925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vHktRanl2tt0UlSkckJQ6mb0uteRAyXN7CZHm6pyMuY=;
        b=LMpNOTIJgeTocO/gTNrWM/6r5/1SM/RkoepX4xDrhAO2NJs/JIuhx63Nl2dAJWvyHS
         oNjcQISi+GewZ6hooku/012DXHEd5A2xHIARgAwB60d6ILQLPgpGu9xNauLW/NwTovL3
         wU0Y3Rc6d5exwG7rZSO5W3lrk3E7RSQ8NSfy+IvfitZ36LVb1r0d5ds1fLzn9DxAf96U
         SIb02ftY9bo/pxJdZYYNjxDaiZl3jucu+735VaQSTnEP4CAUfY4KEeeDyIglvZsZOqXu
         EFcrOO60gL7CviHfc5gshEwCW93THvO/d3B4FVrnvBDtGjczNuuIHRZDp+SeLspQNRS/
         VETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794983125; x=1795587925;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vHktRanl2tt0UlSkckJQ6mb0uteRAyXN7CZHm6pyMuY=;
        b=LZGHFX5QCWDzCAnyaf9yj6UjHra1Tpc+b4kU/lJFGd8JrTNR8RJOEC6Cvh1MylccEu
         97N6Rs5qtUDpH5UQk8OIF3yopwna/I590tfZrabftn/WMTIyPBF56riGquSVG8UwlXgS
         LUNnpSGle0DvJak2Cr4WK5/XDIAeid8v86yc2CdSAddhL3p/8pyX7botiWSB9/Zc514+
         3nFh9SOjihyJlU4dJsYl0l/ES1QYJAp4gStcHcL/ewOiB0NGqKk1GTWkbSWpzlOll/Aq
         TgI/uXbPJLIO+49pgPQsLh+rfLSfb/S468S8Rdq3Ld7ArOh5wLtcfa1haxUH67ZZ8GIt
         ErUw==
X-Forwarded-Encrypted: i=1; AL+hErF9gVSaaAX8DW0EajJFOlETlG9Dn1vF1TVVvssP2estdg6q12SEqFf9T9zYHZlXsxDmR8OBtr1KMw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/nrTcndgyRb7mKgUBuo5CVNfAGe+gQYHsFkVoydmGdBHT9Na2j
	RW8m4A34hLtsOgemF8ikekKBjXhsTBsu4uxMEi6VWPutycFrIn9oM5EwjYr2Z4S/36v4jlPqV8F
	xrbAcS9c3uufqtc/0iKc+6Q3qPQg3SHcxxBhXRkp+AiL3OClqqNCNoq5RAJZkww==
X-Gm-Gg: AZFdTZegYmRQzVs6Eq92ZnvGOus671NsMiCK3wLC+Jw7ImKSZ1811vK5VtgOzRdUcly
	x5FsGqr8BCkkQhGAT+SFMperfKzrihUyv2ZA0gm6Wyu9Q09BibWC+54ul5OLuoE+woB4Kw6JUno
	Ie+WP+E4lwEA129uI7Px778PDXXhRv3oDI/NO4k5kMLlSyESQkny1pT8aIJ3Knk7gBhk+1h2hWp
	0yFakqbH6A++eMk5su9PyKsXddq5be+YCP60z5X6Aa7vbvtbM0xbqYZneneU5VE3EyfWIjIAC1R
	I7DHnGur6bdKczKj/Tu308Ht+36rCBocYGwICei4hp6yAK90MsMN3WEJhf3HB4ntFZnksQiMpr+
	uZxf2VnqvdKv9wq+dEQQVLqFCkr/S+c0p2KL3o2VXvGzqI7MoGPV5Kv/vdwKhZrOBAzTrMJcXNr
	Ox7g==
X-Received: by 2002:a17:903:90f:b0:2db:3b35:1ac6 with SMTP id d9443c01a7336-2eff7100c5amr16624365ad.5.1794983125074;
        Tue, 17 Nov 2026 22:25:25 -0800 (PST)
X-Received: by 2002:a17:903:90f:b0:2db:3b35:1ac6 with SMTP id d9443c01a7336-2eff7100c5amr16624175ad.5.1794983124581;
        Tue, 17 Nov 2026 22:25:24 -0800 (PST)
Received: from [10.218.7.34] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff61841aasm7605435ad.34.2026.11.17.22.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 22:25:24 -0800 (PST)
Message-ID: <e2967948-59d9-4937-8c21-39bc8b48b195@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 11:55:19 +0530
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
Subject: Re: [PATCH v2] thermal: qcom-spmi-adc-tm5-gen3: move hardirq actions
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
References: <20261113-adctm5_gen3_hardirq_removal-v2-1-a0c9c4800941@oss.qualcomm.com>
 <avcpU3P1jw8NESMu@ashevche-desk.local>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <avcpU3P1jw8NESMu@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -ur3It4XSHAkWRCmqCmupQIGmwt5RJq0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyNSBTYWx0ZWRfXzw/uE3mKZAN+
 3d61IyAP7vj3VdMV3/J8TiwUAMBblEFmCLTqP3kh7PqpWskuMdn7350574sDLPUBebew3GrIgzV
 ZYjR+11nQMzRipmgDnA1cTz2kCBpMMU=
X-Proofpoint-GUID: -ur3It4XSHAkWRCmqCmupQIGmwt5RJq0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyNSBTYWx0ZWRfXzyse8Z6QgLvt
 NdHv5Oa+VagBW752nvx+yDpliA/aTfI67/5YG/HB5N4LgPn+G6oI7KoO5GHmZTFphGMoACBl4pF
 45NBnPcmlp83HTSZf/FC1W00MqfIlwSSxjhfxuw6G9oO/ZWC/bCKuG9D6B19E8XgiltiJ2N1RA3
 cwePIkShbMyVAu5MV7QkGLrFmkpqSBMzsVM0JxvuXT6ZLMX5x20llkPJD0n+zk1BhK4nzGMW04L
 1ZBDEKrVQ5bHvGyH9+SSIf/nWp19BHMyGyCM9S/Cse779CMpeA3Hg04npvaN3yTrd+zjFnqoHPA
 8NN92BMr4DWhz/WWNQ/7yIPm11o5XjH2wvIO1j2MpNbs3nO2wiFL6nre+lujTDCldbq4Yu5kKk/
 P8klcMYks3cWpUnNrQU+EtR+yxL8yt09YfUBlrZFk8+i2oWNhvIUpgzHz98p1AZpapoienw4g8l
 aMGRc4eaUPskvLTLu0g==
X-Authority-Analysis: v=2.4 cv=NNVAaE6g c=1 sm=1 tr=0 ts=6afd44d6 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=niP4JTYLpQ8y5GhiJJEA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180025

Hi Andy,

On 11/13/2026 8:44 PM, Andy Shevchenko wrote:
> On Fri, Nov 13, 2026 at 05:23:03PM +0530, Jishnu Prakash wrote:
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
>>
>>   Call trace:
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
>>
>> Note that both handlers used a local variable to hold the index of the
>> SDAM whose IRQ was triggered ('sdam_num' in the primary handler and
>> 'sdam_index' in the thread function). These are the same value under
>> different names and 'sdam_index' is kept now, since that is the name
>> used for it at other places in the file.
> 
> But this is not the point. The point should be semantics of the variable
> and not frequency of use.
> 

OK, I see, the right reason for keeping the name 'sdam_index' instead of
'sdam_num' is that the variable represents an index instead of a count
and not simply that 'sdam_index' is the name used for it elsewhere.

I'll update the commit message to mention this, but do correct me
if I understood your comment wrongly.

> ...
> 
>> -static irqreturn_t adctm5_gen3_isr(int irq, void *dev_id)
>> +static irqreturn_t adctm5_gen3_isr_thread(int irq, void *dev_id)
>>  {
>>  	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
>> -	int ret, sdam_num;
>> +	int sdam_index, ret;
>>  	u8 tm_status[2];
>>  	u8 status, val;
> 
> I probably missed to point that at the same time we can split semantically
> different variables.
> 
> 	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
> 	u8 tm_status[2];
> 	u8 status, val;
> 	int sdam_index;
> 	int ret;

OK, I can make this change too in the next patch version.

Thanks,
Jishnu


> 

