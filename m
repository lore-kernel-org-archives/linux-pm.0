Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9216438F24C
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 11:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561573; cv=none; b=Uy2RXffSyR5sUTNNdtzI+EPaUUGX7Uqkt8KWzm/2Fpa9V2GERmXjmzcXBZz1ZNHYLZBY9Z6MAsmDa1vb/3dPFSW2s3z+7n112Ok/zdZVJVTNpwbcyvoW9zI5zLnhSekO49Ppm+6ezd85ejswJBJbbK6iwturehWYuIM7Lg7Kfkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561573; c=relaxed/simple;
	bh=GsB/BDBtYHQjLoehOOANUPS3ZltGayGa06lBSGhlTyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGv8mYv0SIN+hS6zIhqw38ezdh347V+6KLoxgqiqPHYSVV79jGs230a42L74DnzGcpNX0GE9mb1Gi4/mpZQ5Hdd8elnRcqnYZDfn8gfT4m01jimfRH3BQ2mDJCXplfGOR4PHIBO2AGvwVlco77V+JWbNu2A8Jzo/fBsXe/S0zv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RpF3BiHu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NVNORW8b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RpF3BiHu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NVNORW8b"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6376Kio1493201
	for <linux-pm@vger.kernel.org>; Tue, 7 Apr 2026 11:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p06D6z7PPjOp305ThiF1ke9VrYyHLovqGljvnynJk4c=; b=RpF3BiHuaelR42Q+
	zCx7MlPAJ22VKxkCBvWPnAc+u3RA0E/wJXB8Sl0bXzlLksO3W2GJjU7BrgMNRjp0
	339M4HbSXsLnBMJ4vqejEYOaeSBbmMHAoM2cb/97KinP/Z+WzgFlRPCt20L6aZXQ
	mMoJ3U9CoE6fEmuTmMNJdj1R1TBLR3okEm8yVeMNVEHVmnERPYwJf8ey6IKAB8Ln
	hP/s4fI853cbrO2IZF1/AeAM6Ds7u+5OWtZP57eVje1yvN5uElrv1wKvfF8wnB7G
	UjPonWF4HadfZhIJSlvgN2uar1z0I2bsRLew/sg/bKf7yECNTfuDeG9sKFQFOvpy
	y1wI0w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr8teuu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2026 11:32:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so2967193a12.3
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2026 04:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775561571; x=1776166371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p06D6z7PPjOp305ThiF1ke9VrYyHLovqGljvnynJk4c=;
        b=NVNORW8b+NwNGcbr2wGbxsn1hrBWEQPUZCSkqmNdtSoiRU6+1CQTPlz2Nd5pNn/NNl
         EBDmZFTTtcQLZt7TI/MQ/i6lzF4UA0DF73Nr41qPcnwikF9GYtd39ofe/1enBX8PIGl+
         c+FPhxg5/QpMRhJt57AmbkmeDS4o64Nr1gij1tT0YCfug5eBrgxH/1Bab8RATNARax8K
         M4WRcRWhGacPYSkvhCuLS9O+b6MYKI6/IGJ9EIoG0zrhhIMPywSCQQ8NXk1wXfuuT5Qc
         9Id6Dg4XSlB4HX9WpPf4N86fN9G56nGLvectZeBoJjOydNGYcsBY7F2uEmliXIHYWNO/
         Jj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775561571; x=1776166371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p06D6z7PPjOp305ThiF1ke9VrYyHLovqGljvnynJk4c=;
        b=bm9oc5vLzYzEMXABmFAX2k50LPAcXyQVuwV3JAbD0ln4W7ZmD1Ssuv85n4ZDpsDCd3
         lR8N1F73R9+ZqF7MdaW8Yj1oSh99ICAKnYx5u4iPTgee2Et8lTu0EF1qQpJt8AyEb93m
         UyZp63UhlGZvYiZpIu9FAMaSwMzjkOAVT024vLOmM3lb2X0ndILpKjbaZJI9qjbRPxhV
         tB7j2zbAOPLvwx+OsUvQvOpQwv00UXZEhn9e2fz20P4VqV6QsBIajHJX0hhzACJjvvaW
         QT3NkGu1i9zROOBBf58FC2YzaxTaBcVQJd6COcSIdYVaSScmRjHulIVWBKqj1Vq+qeXi
         mDyg==
X-Forwarded-Encrypted: i=1; AJvYcCV5KynJDvpLoPfN8W3HmUAk5GofmAfwzKrdPBBF8Klx8l/xvhE1R2cWUT006gx6rNW6EFIanKS4Cg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3seseghRDcOu9fgMGz5LtMAtYpDXxWNB7Z9HKyewbx+RAMJ7n
	qGRAv7KFEZx0sVsNBDlV7K77f7GuofLH2RMctOnePG0p0EdZ0MUWgSLi5kI6ve282tpdN24uUkA
	Rgkv/XWYu8AJvT0HdABQvY4bCxvzlHjugrsg0GNLLiPlVu6KALJfLrLo4qWqNCCJ3vmedMIsU
X-Gm-Gg: AeBDieu4a7qCNWU7741xqpXxb1Kl987UlUjXF3TG3FqBb8hv4VHI/xHsYLvu/b46qgv
	getlbjPydmCdVb8T/3+zZjg4wy1ZJ/N1A8iEFwvL8OYpVMiRl69UVcuUIUu++9DxhpATLdlG9xp
	c+c/ELp0wD1IY6vbiOjdzOqsjwNCJv9wqzkdWR6BV81LSvL70D8sSexIBFGtCUiIbshw8sTV/JF
	MU9Msb0d7KsX1MHjwBeQ5Bw8/6jw9d7BKMwqaBa5aBRBVYANj/ZEYwXWjVlsHvQaKYm6ipcyWo3
	hON7b7jhH/Px/n0APeJyoN0IFfm/DHZXsJtzYMXsXaJ+S33Lw0M0iiIJPhVHMFIJ98y+NjHeQ47
	nZxvvfezAbnKQiiy0Ch2yhi837eY/jv12/9skZvjgpszp7KhFo/TyaCl8GvnEy1z4nwn48WDVFa
	ElWZNPDNuWLRF/msJk
X-Received: by 2002:a05:6a00:1805:b0:82a:1380:417d with SMTP id d2e1a72fcca58-82d0dbcfad1mr16233355b3a.52.1775561570684;
        Tue, 07 Apr 2026 04:32:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:1805:b0:82a:1380:417d with SMTP id d2e1a72fcca58-82d0dbcfad1mr16233325b3a.52.1775561570149;
        Tue, 07 Apr 2026 04:32:50 -0700 (PDT)
Received: from [10.133.33.42] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c4387esm18126396b3a.31.2026.04.07.04.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 04:32:49 -0700 (PDT)
Message-ID: <2864ff7a-61a0-4b4a-9e54-389ab47fcc98@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 19:32:44 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: governor: Fix race between sysfs store and dbs
 work handler
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, venkatesh.pallipadi@intel.com, davej@redhat.com,
        trenn@suse.de, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20260406110113.3475920-1-zhongqiu.han@oss.qualcomm.com>
 <CAJZ5v0j7z0oQTDLAA7wtCpF-33ZSw6wxEoL30eohDpBTofAGVw@mail.gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0j7z0oQTDLAA7wtCpF-33ZSw6wxEoL30eohDpBTofAGVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pRmxHFmElyTFS3_k6v8BZjFxPUxTBHq9
X-Proofpoint-ORIG-GUID: pRmxHFmElyTFS3_k6v8BZjFxPUxTBHq9
X-Authority-Analysis: v=2.4 cv=c9abhx9l c=1 sm=1 tr=0 ts=69d4eb63 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=sLMbjZCTKKTjWq_z0XMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEwOCBTYWx0ZWRfX6xkA7Js5uh15
 8jTQpkbBOozGSMFRKxakWWo2F9dBm7qXS0Ad8X8i7+lfEOZpzhGuI8nasP9dwZ+XwmRMLYIeAnc
 sddmG3p+mckoeqKXlkAgfUGLTX0S0YvgaxBB4f9/j+sVyijPICY45gF1yo7TowPh72yAvRAYTBK
 0N9h1QtUfqz5tnlrBeiO3sKH7I6oX+IAFme9xNPHGpY7BJOf40QvvxrR+5sJD/HGjIA9RDiLAqe
 Qrhgoks8/eiX9q8TBx4eRQ7F4uNh0s6vdmhHphxZ08j0EflIhjvFwhsPyQGOwbm4AxamMLK8doE
 fvca0DL4RHDVi/ypyiC7w10BGKCQRx96Tcd1h/s+jOjURlDdnc0fIItfoUHuscwBCZvB4QQVhWV
 +1LsWgivefkJo+NLwgMElZLjixycWTXOOQBt2QTJHwyAOZYXD+Ghd0ImhLoLCh5md/28FPIIynR
 Yjd+UTICIss0ECztsPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070108

On 4/6/2026 11:21 PM, Rafael J. Wysocki wrote:
> On Mon, Apr 6, 2026 at 1:01 PM Zhongqiu Han
> <zhongqiu.han@oss.qualcomm.com> wrote:
>>
>> gov_update_cpu_data() resets per-CPU prev_cpu_idle and prev_cpu_nice
>> for every CPU in the governed domain. It is called from sysfs store
>> callbacks (e.g. ignore_nice_load_store) which run under
>> attr_set->update_lock, held by the surrounding governor_store().
>>
>> Concurrently, dbs_work_handler() calls gov->gov_dbs_update() (which
>> calls dbs_update()) under policy_dbs->update_mutex. dbs_update() both
>> reads and writes the same prev_cpu_idle / prev_cpu_nice fields. The
>> potential race path is:
>>
>> Path A (sysfs write, holds attr_set->update_lock only):
>>
>>    governor_store()
>>      mutex_lock(&attr_set->update_lock)
>>      ignore_nice_load_store()
>>        dbs_data->ignore_nice_load = input
>>        gov_update_cpu_data(dbs_data)
>>          list_for_each_entry(policy_dbs, ...)
>>            for_each_cpu(j, ...)
>>              j_cdbs->prev_cpu_idle = get_cpu_idle_time(...)  /* write */
>>              j_cdbs->prev_cpu_nice = kcpustat_field(...)     /* write */
>>      mutex_unlock(&attr_set->update_lock)
>>
>> Path B (work queue, holds policy_dbs->update_mutex only):
>>
>>    dbs_work_handler()
>>      mutex_lock(&policy_dbs->update_mutex)
>>      gov->gov_dbs_update(policy)
>>        dbs_update()
>>          for_each_cpu(j, policy->cpus)
>>            idle_time = cur - j_cdbs->prev_cpu_idle           /* read  */
>>            j_cdbs->prev_cpu_idle = cur_idle_time             /* write */
>>            idle_time += cur_nice - j_cdbs->prev_cpu_nice     /* read  */
>>            j_cdbs->prev_cpu_nice = cur_nice                  /* write */
>>      mutex_unlock(&policy_dbs->update_mutex)
>>
>> Because attr_set->update_lock and policy_dbs->update_mutex are two
>> completely independent locks, the two paths are not mutually exclusive.
>> This results in a data race on cpu_dbs_info.prev_cpu_idle and
>> cpu_dbs_info.prev_cpu_nice.
>>
>> Fix this by also acquiring policy_dbs->update_mutex in
>> gov_update_cpu_data() for each policy, so that path A participates in
>> the mutual exclusion already established by dbs_work_handler(). Also
>> update the function comment to accurately reflect the two-level locking
>> contract.
>>
>> The root of this race dates back to the original ondemand/conservative
>> governors. Before commit ee88415caf73 ("[CPUFREQ] Cleanup locking in
>> conservative governor") and commit 5a75c82828e7 ("[CPUFREQ] Cleanup
>> locking in ondemand governor"), all accesses to prev_cpu_idle and
>> prev_cpu_nice in cpufreq_governor_dbs() (path X), store_ignore_nice_load()
>> (path Y), and do_dbs_timer() (path Z) were serialised by the same
>> dbs_mutex, so no race existed. Those two commits switched do_dbs_timer()
>> from dbs_mutex to a per-policy/per-cpu timer_mutex to reduce lock
>> contention, but left store_ignore_nice_load() still holding dbs_mutex.
>> As a result, path Y (store) and path Z (do_dbs_timer) no longer shared a
>> common lock, introducing a potential race on prev_cpu_idle/prev_cpu_nice
>> between store_ignore_nice_load() and dbs_check_cpu().
>>
>> Commit 326c86deaed54a ("[CPUFREQ] Remove unneeded locks") then removed
>> dbs_mutex from store_ignore_nice_load() entirely, introducing an
>> additional potential race between store_ignore_nice_load() (path Y, now
>> lockless) and cpufreq_governor_dbs() (path X, still holding dbs_mutex),
>> while the race between path Y and path Z remained.
>>
>> Fixes: ee88415caf736b ("[CPUFREQ] Cleanup locking in conservative governor")
>> Fixes: 5a75c82828e7c0 ("[CPUFREQ] Cleanup locking in ondemand governor")
>> Fixes: 326c86deaed54a ("[CPUFREQ] Remove unneeded locks")
>> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
>> ---
>>   drivers/cpufreq/cpufreq_governor.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
>> index 86f35e451914..56ef793362db 100644
>> --- a/drivers/cpufreq/cpufreq_governor.c
>> +++ b/drivers/cpufreq/cpufreq_governor.c
>> @@ -90,7 +90,8 @@ EXPORT_SYMBOL_GPL(sampling_rate_store);
>>    * (that may be a single policy or a bunch of them if governor tunables are
>>    * system-wide).
>>    *
>> - * Call under the @dbs_data mutex.
>> + * Call under the @dbs_data->attr_set.update_lock. The per-policy
>> + * update_mutex is acquired and released internally for each policy.
>>    */
>>   void gov_update_cpu_data(struct dbs_data *dbs_data)
>>   {
>> @@ -99,6 +100,7 @@ void gov_update_cpu_data(struct dbs_data *dbs_data)
>>          list_for_each_entry(policy_dbs, &dbs_data->attr_set.policy_list, list) {
>>                  unsigned int j;
>>
>> +               mutex_lock(&policy_dbs->update_mutex);
>>                  for_each_cpu(j, policy_dbs->policy->cpus) {
>>                          struct cpu_dbs_info *j_cdbs = &per_cpu(cpu_dbs, j);
>>
>> @@ -107,6 +109,7 @@ void gov_update_cpu_data(struct dbs_data *dbs_data)
>>                          if (dbs_data->ignore_nice_load)
>>                                  j_cdbs->prev_cpu_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
>>                  }
>> +               mutex_unlock(&policy_dbs->update_mutex);
>>          }
>>   }
>>   EXPORT_SYMBOL_GPL(gov_update_cpu_data);
>> --
> 
> Please have a look at
> 
> https://sashiko.dev/#/patchset/20260406110113.3475920-1-zhongqiu.han%40oss.qualcomm.com
> 
> and let me know what you think.
> 
> Thanks!

Hi Rafael,

Thanks for the review,

sashiko.dev points out two pre‑existing gaps rather than regressions
introduced by this patch.

Issue 1: There is a window where sysfs writes can race with the
unprotected initialization loop in cpufreq_dbs_governor_start(), which
may lead to races. I will address this by protecting the initialization
loop with policy_dbs->update_mutex.

Issue 2: There is a residual race where dbs_update() may observe a newly
updated tunable together with stale counters, leading to an inflated
idle delta. I plan to address this by always updating prev_cpu_nice in
dbs_update(), regardless of ignore_nice, to avoid stale state. I will
double‑check the logic and address this in patch v2.


-- 
Thx and BRs,
Zhongqiu Han
