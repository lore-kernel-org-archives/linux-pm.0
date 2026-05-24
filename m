Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567042FDC28
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 05:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779602239; cv=none; b=A1a4rOoTtcI652unE/HJ5N90YdHquzYkyA2p/jnabFoPN7TH9UV6fSxqMjgRI9LnMnndCb8SlDStQjUv36h17Y7bCUakU3czqcsDUPgVgN/iY72mdCw+9CssnlSJOIKxrXZ7xCeXcZraUZqAP2sxB7CPZsEdfXwJTH0bZkT4O64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779602239; c=relaxed/simple;
	bh=DBvE6eSn4Tsk8XwCB20l/63+lcXOcuRtibhQZiRdyPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJ/Yj0XXuJXd2pl25nvchbpVfqvqElq53WVFWrXA8FBzUzBiN/j75XExGCTh+paIztP1khz/3EpLSE+KUn+WssLm0fwv703xDLC+CFs2qqCA23G/53dvkXlEIEJvFcLoyy7JOopm7e3GYjPvThdKWpFc9F6qFbvxWln8JpBT0Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oO2yLPEe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZUySpVVX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oO2yLPEe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZUySpVVX"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64O3AYbx558642
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 05:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qzH03fjJ1Nmt6kyPv0eoqDwea+gwhU6M6qDDpjTuNo8=; b=oO2yLPEeYCkkc/1S
	4OtiAu8OaPw1SEWME55Y+oIYHjFSG13ulyv2O2yjymBn+Cu80SF7hhYvijMIu/4l
	QnavCTfZNZSiGZnVggUhb6qaxC2eUBHBgwRcU4P+ouSHqR6rCOLC0pHb14DYe5us
	bjT7selBCntDD5WoTLgnJzHg/APNulGN8IMWT4Ltc7KN11+m1q8q9H8AkWHRc7f5
	IoO6A1dJO7SQ1lt7vcraWnMtMi0HMcoPbZRyn98PMfGTbGjXZXK1MCk7PPIFO0Xp
	j5U1GHlciklu9XNyokbZqvgcuBbJCDk4vhHcE8aBep7pi31ymjPy2kHVO0nCIKHU
	2jc6Xg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb50ftdg1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 05:57:17 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c82ba4715b6so9448043a12.2
        for <linux-pm@vger.kernel.org>; Sat, 23 May 2026 22:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779602237; x=1780207037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qzH03fjJ1Nmt6kyPv0eoqDwea+gwhU6M6qDDpjTuNo8=;
        b=ZUySpVVXicSSmcG0FGmFm036TaGaFRdUYjBQPSjy9BAJkmoDL8A9a4Gf6Dkiiz18xp
         Ze7DrBL5+0P03aqq7NG12yjzVz+qsLjTRd+PChRFfPOUN/Tc4U9W6MLmpO9ASAZVmsvp
         VbIH6SX0GBT34yI506zP2DNLcdUwD5iJwzQsK0oeNiWZqHbZ64WbqT6PzmLlb9LXCQL1
         w8yDQ8e+XgdmRcu2c7QVT7el1Jbqm5epMj4/dOHfusqepiR1cx0sZnqbQxxYe1VBP6mR
         5dUHeVNPtZNJ+C6c9A02lFBfKTs037P0A0xSfS4SLAdFTbg5E+Ji9UB73fle36GOJXTL
         skSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779602237; x=1780207037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzH03fjJ1Nmt6kyPv0eoqDwea+gwhU6M6qDDpjTuNo8=;
        b=L1xBZGaYdk9Zz9hkhkMzT4G2AR3YaXL70kROuOaJQj55CIFOu4Q3Bcj6INSL7Y9qoW
         pAFYCaJatXLGRzP0Vgn/vsZ9N+3VpuLejGJ2D82SJuGctUzklWCkIDpE9EnQ7ALGBXD1
         QO5ccM6G6MLjtd7Q6T/0eiySaYnJqF5f+61XoGjAeSV2fA6id73RzFvM2wI8Ski4eQQ7
         eBILeEWslAEjihr/pCV23Y9fGUbbQF9yUx4D2LxFy6DZs8e5zCUUAJoTZKf46qJGkaaJ
         RiJhDOHD9++4um3QYZjZ8LKf+AViS8ndovkE2D/6ctpYkRPp165UHohviLSKxpe6Ezk/
         zYPQ==
X-Forwarded-Encrypted: i=1; AFNElJ9f8WyZ5YOfMrCAOJeCXgDCK6oDSMKpIvV0Tvn6DKKV0ZDsBSIaz5Je+lORG1UGNvOen/j+U943yQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhMA33ZMC/66QP/kOSijNhzZ4OXbiijYFdyF2ow/V35C05K7qd
	vRDFFtbcsYF3m4f7HRM5SuUVjEa3ZMc/k11oZ5adDmPTOevab1hLm1bRZo1g+XS/0JRy8KQDt3N
	mkEmbU49Y6nQ1blWYGmDywPagnmPR2HF49iK4h99XkGkCUnbUGVefZFTv8LbnEQ==
X-Gm-Gg: Acq92OH4MBQKSUNWYPWJJg2VRdl2mD5rtobp5cx4FK9wY0iroHw4qx1he2dWkySdkds
	JIIrBv0VKjHDknyL/UhW5K8wtecws4B5lagzy13DfS5SLPK+x8+MwCi3BJoU8xAwjxf/bmGup9c
	dSdf9QgQt4TXyqtu1GKTKL3C5GHlrXghgioWGmxsszYnM3H4fCvNxHK1SLnxt5fOvWBDT6yFszs
	0mhPzNTO9Nsb5Y/EI6diVckBFRb+FDCRL9SEoAIZcOHDpXAlEG3Npax+5T3+XCD2kMVBYEwWVE5
	d1yZRIcBDoHfFHYIHBJQIWzTynu6/SllqnD3GRxZ0RNarXU/8Yuvb2s2VkEax/btCDIwYnPoKjU
	Ua34yflPmpjwVe35r1hrhU8MmsdCu81R2CFJWBE1o0S0dLf91zNKT050COYenbKZHRzDlR8JdqD
	wNwlw4K3/Ur18IDaVX0g==
X-Received: by 2002:a05:6a20:e616:b0:3b3:10e1:a87f with SMTP id adf61e73a8af0-3b328e5b2a8mr10026703637.31.1779602236651;
        Sat, 23 May 2026 22:57:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:e616:b0:3b3:10e1:a87f with SMTP id adf61e73a8af0-3b328e5b2a8mr10026679637.31.1779602236152;
        Sat, 23 May 2026 22:57:16 -0700 (PDT)
Received: from [10.133.33.182] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85202b946dsm5159436a12.13.2026.05.23.22.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2026 22:57:15 -0700 (PDT)
Message-ID: <0b1ff222-ecda-4b21-9604-7d4e8fc86279@oss.qualcomm.com>
Date: Sun, 24 May 2026 13:57:09 +0800
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
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0i_KhPRkh-p2pCKgV+UKO5bnTJF0TVbQNsjpY4iBO3w+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDA1OCBTYWx0ZWRfX4PZg20VRmvZx
 6JFthUdWHjcz4GCCm7X2FT4hpEeqN0zDrrZTmmmR+TbAYXhE2syZZYviyuAgh7dipEim2T1ucRc
 T98UmqoC5KXAiOxC9H9uYWKZejnO7TfIj/l+RombnXLoHX6lUPgX19FRZhxL21b/oSrrvVU45zU
 K2RODnbQIFSLf80dKgN63jHpehn3Aw+7adXiKaKLjXcLmDjqisTdI8y7OkiSF1S6czTANqq2bmB
 F5BzT+UzyT+NZc5IWoo6G/uTkc600lL1yltIBfKIfoRTH/O8waEsD/+auAM68YXN+XwDVR7ppFu
 481h3bW1nLyCSARFYqvj53ugEmZrGQaGSbtKCrhe0QSU5UTJlfY2MzBajUwJH4intoEt3fl4NHV
 XJiadTtuoNSxq1mGLohNzFCmOPfYrbO2lneN4dVLO0BD2nsl4LEPGF15PrNGKbnDYrJxAFb7EJF
 rVm99vJlULTfhYf9hnw==
X-Proofpoint-ORIG-GUID: jqUvYdOKAghYWnVIf-kxDgxoWosEwp_8
X-Authority-Analysis: v=2.4 cv=UdBhjqSN c=1 sm=1 tr=0 ts=6a12933d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=c92rfblmAAAA:8 a=d54LhpO68ssPAF01xmkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: jqUvYdOKAghYWnVIf-kxDgxoWosEwp_8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240058

On 5/22/2026 11:14 PM, Rafael J. Wysocki wrote:
> On Sun, Apr 19, 2026 at 3:27 PM Zhongqiu Han
> <zhongqiu.han@oss.qualcomm.com> wrote:
>>
>> Patch 1 fixes two baseline-consistency issues in the DBS governor
>> framework.
>>
>> gov_update_cpu_data() writes prev_cpu_idle and prev_cpu_nice while
>> holding only attr_set->update_lock, whereas dbs_update() reads and
>> writes the same fields while holding only policy_dbs->update_mutex.
>> Because these are independent locks, the two paths are not mutually
>> exclusive.  The fix acquires policy_dbs->update_mutex inside
>> gov_update_cpu_data() for each policy.
>>
>> Additionally, cpufreq_dbs_governor_start() reads io_is_busy before
>> acquiring policy_dbs->update_mutex.  A concurrent io_is_busy_store()
>> can update io_is_busy and call gov_update_cpu_data(), which writes
>> prev_cpu_idle with the new value under the mutex.
>> cpufreq_dbs_governor_start() then overwrites prev_cpu_idle with the
>> stale value.  The fix reads io_is_busy inside the mutex.
>>
>> Patch 2 fixes a stale-baseline race on prev_cpu_nice when
>> ignore_nice_load is enabled via sysfs.  There is a race window
>> between setting ignore_nice_load and gov_update_cpu_data() acquiring
>> update_mutex: a concurrent dbs_update() can see the new ignore_nice_load
>> value but read a stale prev_cpu_nice, producing an inflated idle_time
>> for that sample.
>>
>> The fix unconditionally advances prev_cpu_nice on every dbs_update()
>> call.  With prev_cpu_nice always reflecting the most recent sample,
>> enabling ignore_nice_load can never produce a stale-baseline spike.
>> To keep prev_cpu_nice handling consistent, gov_update_cpu_data()
>> resets prev_cpu_nice unconditionally alongside prev_cpu_idle, and
>> cpufreq_dbs_governor_start() initializes prev_cpu_nice unconditionally.
>>
>> v3:
>> - Update linux-next base
>> - Fix two additional issues found during sashiko.dev review:
>>      - Patch 1: move io_busy read inside policy_dbs->update_mutex in
>>        cpufreq_dbs_governor_start() to close a TOCTOU window against
>>        concurrent io_is_busy_store().
>>      - Patch 2: restore unconditional prev_cpu_nice reset in
>>        gov_update_cpu_data() to keep both baselines consistent when
>>        io_is_busy changes with ignore_nice_load enabled; update comment.
>>      - Patch 2: keep gov_update_cpu_data() in ignore_nice_load_store() to
>>        prevent a stale-baseline spike in the governor-start window (when
>>        ignore_nice_load is set before the first dbs_update() call); only
>>        cpufreq_governor.c is modified.  Update commit message and add one
>>        more fixes tag '326c86deaed54a ("[CPUFREQ] Remove unneeded locks").'
>>      - Update the commit messages.
>> - Link to v2: https://lore.kernel.org/all/20260409111407.9775-1-zhongqiu.han@oss.qualcomm.com/
>> - Sashiko v2 comments: https://sashiko.dev/#/patchset/20260409111407.9775-1-zhongqiu.han%40oss.qualcomm.com
> 
> So sashiko.dev still has some comments on the first patch in v3:
> 
> https://sashiko.dev/#/patchset/20260419132655.3800673-1-zhongqiu.han%40oss.qualcomm.com
> 
> Can you please have a look at that and let me know what you think?
> 


Hi Rafael,
Thanks for pointing this out. I've looked at both comments:

Comment 1 (io_is_busy transition window):

The race is real but pre-existing. After Patch 1 the only remaining
window is the gap between the io_is_busy write and gov_update_cpu_data()
acquiring the lock:

CPU0 (io_is_busy_store):    CPU1 (dbs_update):
io_is_busy = 1              mutex_lock()
/* waiting for mutex */     io_busy = 1  /* sees new value */
                             cur_idle = get_cpu_idle_time(io_busy=1)
                             /* prev_cpu_idle still set with io_busy=0 */
                             /* idle_time may be clamped to 0 */
                             /* load inflated for this sample */
                             mutex_unlock()
mutex_lock()
prev_cpu_idle = ../* reset */
mutex_unlock()

The mismatch between the two metrics causes a one-sample anomaly in
either direction: 0→1 tends to inflate the load estimate (frequency
pushed upward), while 1→0 tends to deflate it. The AI's "drives to
minimum" conclusion is wrong for the 0→1 case.

This window is inherent to the design. One possible fix is to add a per
policy io_is_busy copy inside policy_dbs_info and update it under
update_mutex in gov_update_cpu_data(), so dbs_update() always reads a
value consistent with the current prev_cpu_idle baseline. The impact
should be a single-sample frequency spike that self-corrects.


Comment 2 (sampling_rate_store vs. gov_set_update_util):

Also pre-existing. The race:

   cpufreq_dbs_governor_start():     sampling_rate_store():
     mutex_unlock()                    mutex_lock()
     gov->start()                      sample_delay_ns = 0
     gov_set_update_util()             mutex_unlock()
       sample_delay_ns = rate  <--->

If needed, e possible approach would be to move both gov->start() and
gov_set_update_util() inside the mutex would work.


Perhaps both can be evaluated and handled either in this patch or as a
separate follow-up.


>> v2:
>> - Update linux-next base
>> - Based on v1 review, patch 1 is updated to add the missing
>>    protection around cpufreq_dbs_governor_start(), and patch 2/2 is added.
>> - Link to v1: https://lore.kernel.org/all/20260406110113.3475920-1-zhongqiu.han@oss.qualcomm.com/
>>
>> Zhongqiu Han (2):
>>    cpufreq: governor: Fix data races on per-CPU idle/nice baselines
>>    cpufreq: governor: Fix stale prev_cpu_nice spike when enabling
>>      ignore_nice_load
>>
>>   drivers/cpufreq/cpufreq_governor.c | 42 ++++++++++++++++++++----------
>>   1 file changed, 28 insertions(+), 14 deletions(-)
>>
>>
>> base-commit: c7275b05bc428c7373d97aa2da02d3a7fa6b9f66
>> --
>> 2.43.0
>>
>>


-- 
Thx and BRs,
Zhongqiu Han
