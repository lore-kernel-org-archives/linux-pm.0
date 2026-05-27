Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3195C2DEA9D
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892010; cv=none; b=bvaNND4YzOcCcGgmy9t36ZskIzcWzqKbqROWirgVY6gsv5jE0k/hhV4Q3yyDTe9VY7nOsnSdZ9kinBKc+AgTla8lyV74eRnTbjHac9Mi7VTGmvoIPdfw6DoDXSdY1weAxYF6ezuw1HYoD+K6xZUVZeAVwWcYV2Emwih3MgJdNa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892010; c=relaxed/simple;
	bh=p0fc+TweU4yaDgwD97IW1GkjSBHIlSMDS6Qj+2AHseg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHEozVLsNBB1L7bFU2sEBl92YrNfbUzfzi2X6Kld8PajEG99JzF8Cq4NWwGAV4o+7FrzgmkIWbC3LFrgk5IVC7EnXk3ZPmc9s2zJjm+Nj6SpEH4/Ig9yt/w91AqzZ5o0B6H+syEg+hahhyiUjBRpn7/HE1fL4g0oPFOV1+cEJoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y3vr6Znd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TiozGbRP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y3vr6Znd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TiozGbRP"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RC4wvM1478000
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 14:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r7tUykhC5tSiT4yDAefapRxy4lcsiJZ62SujSiahRh4=; b=Y3vr6ZndV9AH3rPN
	BaG2d93xTNzXUv8SD2U9Nf5qvSgB7ODiGGHoAvcu9KYI+21SvmMRVAwA+YK/tEgG
	FlfzAiIIZZk2LQ4ez6mVkEPFsdCy2HW6MwyI3H1nWX5roYnsvJy9PeBdkgTcnRjR
	lALOrKJntMzOkLZuNvjDMxDwii1Pq60KslXIRPcZWrzKITFdoznUE9L6sy9kEtC8
	dbJD5jBnmXT0UzTTXPX/VytVXCoOkBM4GBH4ZVB/RNpgylkBJWWbb+lUUESGI5IA
	Q4AaqLKNhj80VFIMPTs+ldeGHaWtRO4AcnBl/a1T2/Z0WZuZHAmD1wuyofbxjVBn
	dvjzxQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee0a88g5c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 14:26:45 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c828659ecd4so5172027a12.0
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 07:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779892004; x=1780496804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7tUykhC5tSiT4yDAefapRxy4lcsiJZ62SujSiahRh4=;
        b=TiozGbRPy/hxy+DQwQv/x2bFtRBmsthkIr9weM/7AyebRMdQ1f4mXrBdLAE+/jEhME
         L/UtcUtzJruXTJG+HeCG6BpgW6v2KEJ4SFOonmgCRF0ywAY6CSfUYxdtgnDH1/pdtNmd
         eAMy+LN52UYWjVUV0nzj2dMVcLFLHriLiZimuKqPI0RC1C6TjtSYF7DIsP4GF65KgD4N
         9wHpFNNdu0eeIA1STNt04kAKnlkbdJWjOCKWKIML6EViB0Q6QlOZtlhR/N3kdA34wWfo
         PalNsmEF6G/FaQZjJy8uy2ClE6hrT49y8penO43PT5nUi28OOz/eDSn7r/xUlNaHtic3
         gCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779892004; x=1780496804;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7tUykhC5tSiT4yDAefapRxy4lcsiJZ62SujSiahRh4=;
        b=o3lQqaUZd4twmtpTLV+tvsodwoK+/oeHlpaOsq3jp4SHak9ZLs5PrA9BZlEAa7nJl3
         OWluYpYQXp/BDSfzXV6TvHo+SlPuJ4EaAFqCz4cXNBpdEHY7AFXH7WyqksmR0TDmD/i2
         bMXrFUYarDI7naMeSPP6ng+r0hzim+el4LKTnXZ1uRK+gowIv77ilGJu9ggLmX4o+L5Q
         AiGhR0/bhY5KkFaVoXCrrpkwPA2+jaiCxoIGykSmFLs/NB93EkZaq0h9g5eduRFi9lB/
         frHRoZTKc067REGcpgSSjmrneYPtXpWzQlOPcmJ1zjJRTUdICBaniKho7+DlRsyq9zpM
         Qjww==
X-Forwarded-Encrypted: i=1; AFNElJ/dv+jAU5RS2DVSzpSFDcfRK+mqnIfN2R7bj6LPTOPFf9xQG2M2M8fsFZO2cW2sKK3ejeDPyxNCag==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkGBDJP+/H7vIZcFC4uK23y4Omt8wBHH1nMpfikJI42xi2SwSu
	aVG6bD3AMlqo3Rv/spJk4S7e0tIcn5+taqOXoFobaE0XMIbb2CJtYPuLX0MBpxAZMFN+UmCnAyn
	JEUR9q0/hXTCQM7pW/ahHktE3nlLTPsCVfpoHqs0wtRFFC9ETBfuk93o0szWgtQ==
X-Gm-Gg: Acq92OGZfM6Akk3/ou/ymHe2SRZbXUYxMF9gkJAY/44ViIjRxE2a5AjcsfdTk6fg8dC
	E3o/hZyN3eUGaTSzbj/JUt5pJEOZqt6lGdsTPfxKG6bwBqjeY58quvgcPESu4MpvsbQl9DvDGNQ
	CviylMVnuPoAdohh5aWiBfpvmRoLkE+3kjHOGQb0rUXAQSZ8UnW+OK6AXvz4bOqK0X6QsDnRUpb
	aS8oJ9NeSdNuK/ewJW9hDHhXV0+27maOZvxxXRwkRZG3U1E6+U7VhNgIxU+st+AiexS0pUKSptF
	NfMOjIvuwX0O4pNuf/LQ1gqapPNX0dWack/A9LTlzqrfDw5LBktKclHk53l4k5pTLr6zilgyPql
	nimqXKr5xBM7s45IEvUfl2lgTFD/mNDfRYhQagDVcKCKTGMkdpRlO8KLD1vfvMZEBX93xAMP1yx
	T7Kfd3WtWjmV+09DpwaxvH/sB81npg
X-Received: by 2002:a05:6a21:694:b0:3b3:2703:111 with SMTP id adf61e73a8af0-3b328ee2f1cmr24572553637.44.1779892004191;
        Wed, 27 May 2026 07:26:44 -0700 (PDT)
X-Received: by 2002:a05:6a21:694:b0:3b3:2703:111 with SMTP id adf61e73a8af0-3b328ee2f1cmr24572519637.44.1779892003645;
        Wed, 27 May 2026 07:26:43 -0700 (PDT)
Received: from [10.133.33.240] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85205616bdsm13292837a12.23.2026.05.27.07.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 07:26:43 -0700 (PDT)
Message-ID: <18685e08-d304-4138-8c70-9b239e5c5925@oss.qualcomm.com>
Date: Wed, 27 May 2026 22:26:38 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] governor: Fix races and stale baseline on
 prev_cpu_nice
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, venkatesh.pallipadi@intel.com, davej@redhat.com,
        trenn@suse.de, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20260419132655.3800673-1-zhongqiu.han@oss.qualcomm.com>
 <CAJZ5v0i_KhPRkh-p2pCKgV+UKO5bnTJF0TVbQNsjpY4iBO3w+g@mail.gmail.com>
 <0b1ff222-ecda-4b21-9604-7d4e8fc86279@oss.qualcomm.com>
 <CAJZ5v0irkk_8sRQ59KYKpz6RmQYmdZk+edVr5=WSpDsKpS4kBA@mail.gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0irkk_8sRQ59KYKpz6RmQYmdZk+edVr5=WSpDsKpS4kBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XrrK/1F9 c=1 sm=1 tr=0 ts=6a16ff25 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=c92rfblmAAAA:8 a=E0ooF4KgEWxh89Kj4k4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: cICr5_ZwugpFYHCP4xV_G3xJUyCX8uAS
X-Proofpoint-ORIG-GUID: cICr5_ZwugpFYHCP4xV_G3xJUyCX8uAS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE0MSBTYWx0ZWRfX9P0wtTD58Ce1
 mFpf3pBbZA1BGXPWAAAHKH2E4rb6B6Y9JorXtOrsme/tBmsaGjIDP08AeF1moGWUvxXcmlLeyC5
 Rz/8/pLkjiiN+VFTKzukEybXDRzztJL+0dVZ4PhZ1PZ2FyeK46HbyohS8it9QHFkGgfvJqqGr/o
 UCUNq116fNdGjHRzzKtyVFWmu5mOBwtdVfmQoFZyA17i3s5vRmiWP7e7OjKoBxRta8TMIpKLpkD
 0ryZYU2c7U38QUgQpHv3KaKwZdNM5SqEsQPELAHjYbX7RYIEgAC35WqRis1o467QoY2O+9w5i4j
 Crxs+RZPll8x1U/73+Rxp8b35qXJ/gogoPti7I2RSq99uhcOaNd0zkHDQMDerHqAexYF01kJvsS
 lgPQxeoAq7t0P+9fnKqQwhr5CBzHLMY8BMQHgon2JOJMFN29hZeYW1XriaDJmJf4o5H9haTtPw/
 gWHcXlw5qwc0eiloByw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270141

On 5/27/2026 1:09 AM, Rafael J. Wysocki wrote:
> On Sun, May 24, 2026 at 7:57 AM Zhongqiu Han
> <zhongqiu.han@oss.qualcomm.com> wrote:
>>
>> On 5/22/2026 11:14 PM, Rafael J. Wysocki wrote:
>>> On Sun, Apr 19, 2026 at 3:27 PM Zhongqiu Han
>>> <zhongqiu.han@oss.qualcomm.com> wrote:
>>>>
>>>> Patch 1 fixes two baseline-consistency issues in the DBS governor
>>>> framework.
>>>>
>>>> gov_update_cpu_data() writes prev_cpu_idle and prev_cpu_nice while
>>>> holding only attr_set->update_lock, whereas dbs_update() reads and
>>>> writes the same fields while holding only policy_dbs->update_mutex.
>>>> Because these are independent locks, the two paths are not mutually
>>>> exclusive.  The fix acquires policy_dbs->update_mutex inside
>>>> gov_update_cpu_data() for each policy.
>>>>
>>>> Additionally, cpufreq_dbs_governor_start() reads io_is_busy before
>>>> acquiring policy_dbs->update_mutex.  A concurrent io_is_busy_store()
>>>> can update io_is_busy and call gov_update_cpu_data(), which writes
>>>> prev_cpu_idle with the new value under the mutex.
>>>> cpufreq_dbs_governor_start() then overwrites prev_cpu_idle with the
>>>> stale value.  The fix reads io_is_busy inside the mutex.
>>>>
>>>> Patch 2 fixes a stale-baseline race on prev_cpu_nice when
>>>> ignore_nice_load is enabled via sysfs.  There is a race window
>>>> between setting ignore_nice_load and gov_update_cpu_data() acquiring
>>>> update_mutex: a concurrent dbs_update() can see the new ignore_nice_load
>>>> value but read a stale prev_cpu_nice, producing an inflated idle_time
>>>> for that sample.
>>>>
>>>> The fix unconditionally advances prev_cpu_nice on every dbs_update()
>>>> call.  With prev_cpu_nice always reflecting the most recent sample,
>>>> enabling ignore_nice_load can never produce a stale-baseline spike.
>>>> To keep prev_cpu_nice handling consistent, gov_update_cpu_data()
>>>> resets prev_cpu_nice unconditionally alongside prev_cpu_idle, and
>>>> cpufreq_dbs_governor_start() initializes prev_cpu_nice unconditionally.
>>>>
>>>> v3:
>>>> - Update linux-next base
>>>> - Fix two additional issues found during sashiko.dev review:
>>>>       - Patch 1: move io_busy read inside policy_dbs->update_mutex in
>>>>         cpufreq_dbs_governor_start() to close a TOCTOU window against
>>>>         concurrent io_is_busy_store().
>>>>       - Patch 2: restore unconditional prev_cpu_nice reset in
>>>>         gov_update_cpu_data() to keep both baselines consistent when
>>>>         io_is_busy changes with ignore_nice_load enabled; update comment.
>>>>       - Patch 2: keep gov_update_cpu_data() in ignore_nice_load_store() to
>>>>         prevent a stale-baseline spike in the governor-start window (when
>>>>         ignore_nice_load is set before the first dbs_update() call); only
>>>>         cpufreq_governor.c is modified.  Update commit message and add one
>>>>         more fixes tag '326c86deaed54a ("[CPUFREQ] Remove unneeded locks").'
>>>>       - Update the commit messages.
>>>> - Link to v2: https://lore.kernel.org/all/20260409111407.9775-1-zhongqiu.han@oss.qualcomm.com/
>>>> - Sashiko v2 comments: https://sashiko.dev/#/patchset/20260409111407.9775-1-zhongqiu.han%40oss.qualcomm.com
>>>
>>> So sashiko.dev still has some comments on the first patch in v3:
>>>
>>> https://sashiko.dev/#/patchset/20260419132655.3800673-1-zhongqiu.han%40oss.qualcomm.com
>>>
>>> Can you please have a look at that and let me know what you think?
>>>
>>
>>
>> Hi Rafael,
>> Thanks for pointing this out. I've looked at both comments:
>>
>> Comment 1 (io_is_busy transition window):
>>
>> The race is real but pre-existing. After Patch 1 the only remaining
>> window is the gap between the io_is_busy write and gov_update_cpu_data()
>> acquiring the lock:
>>
>> CPU0 (io_is_busy_store):    CPU1 (dbs_update):
>> io_is_busy = 1              mutex_lock()
>> /* waiting for mutex */     io_busy = 1  /* sees new value */
>>                               cur_idle = get_cpu_idle_time(io_busy=1)
>>                               /* prev_cpu_idle still set with io_busy=0 */
>>                               /* idle_time may be clamped to 0 */
>>                               /* load inflated for this sample */
>>                               mutex_unlock()
>> mutex_lock()
>> prev_cpu_idle = ../* reset */
>> mutex_unlock()
>>
>> The mismatch between the two metrics causes a one-sample anomaly in
>> either direction: 0→1 tends to inflate the load estimate (frequency
>> pushed upward), while 1→0 tends to deflate it. The AI's "drives to
>> minimum" conclusion is wrong for the 0→1 case.
>>
>> This window is inherent to the design. One possible fix is to add a per
>> policy io_is_busy copy inside policy_dbs_info and update it under
>> update_mutex in gov_update_cpu_data(), so dbs_update() always reads a
>> value consistent with the current prev_cpu_idle baseline. The impact
>> should be a single-sample frequency spike that self-corrects.
>>
>>
>> Comment 2 (sampling_rate_store vs. gov_set_update_util):
>>
>> Also pre-existing. The race:
>>
>>     cpufreq_dbs_governor_start():     sampling_rate_store():
>>       mutex_unlock()                    mutex_lock()
>>       gov->start()                      sample_delay_ns = 0
>>       gov_set_update_util()             mutex_unlock()
>>         sample_delay_ns = rate  <--->
>>
>> If needed, e possible approach would be to move both gov->start() and
>> gov_set_update_util() inside the mutex would work.
> 
> Yeah.
> 
> So I've applied both patches in the series as 7.2 material.
> 
> Please feel free to send a follow-up patch making the change mentioned above.
> 
> Thanks!


Thanks Rafael,

Sure, I'll look into that and follow up with a patch accordingly.


-- 
Thx and BRs,
Zhongqiu Han
