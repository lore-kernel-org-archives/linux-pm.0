Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FF72E736F
	for <linux-pm@vger.kernel.org>; Sun,  6 Sep 2026 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788707637; cv=none; b=EI2LkET6A1+rpqL9NXxhk7FV0j9AqazHamITCpRtgyXox121IbGs4s2/H+8Gyd1JkPlrGbvRwMX/Cust3zGUum1OtquniVlcE30nWzIpDw8wSTtdSeVHbnzzITyKppyx5S76PNF7NUQM6DwqEgOeXqXAufpwnyRM8L9Ca+wR4wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788707637; c=relaxed/simple;
	bh=/vBeovAKlfkxErQIL+wWOGlWME3YMwpZybmfzJyGqtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fc6QL1cDBfr1WMlyi3aiBucZBnAFOeaCfZNyzbL9E941ZwVO4FG2kSqOajILyQxExKdYh9+Lx2ta52g1oBx5mg9BiQtMprG76JdfBjwAqM4ltXcntaoVzlctQZ9ciGMARvS9X4P54OJdNp6NPx+LGzpmradZu2pmAGzV6bi61jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a1iDf+j4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X2HPLpQO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a1iDf+j4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X2HPLpQO"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 686EX2mm1837202
	for <linux-pm@vger.kernel.org>; Sun, 6 Sep 2026 15:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T4SdcNzIo3p7/l31uFVcGP3qz3Lf1+uQEV5rsx9A6c8=; b=a1iDf+j4ho/6G396
	nwkpRblmF9bd9ECPa8r4sbEdGgDJKBSvG+BEWhlx/4Izwtd7qm6YYnjCutmVy2VL
	jkE8XmwZE5jqe06r5D6rvMSes2iroNmoqAhmVRAvBKoLO5X193myR/N94qZuhh4e
	9N/ghHqlydXEpq6ip6enp1vRZivkKzJ9SMQApaCrnGxZVw4Z81/52GRMMuTSX4i/
	LZs3s979QBnuklYsDaqLjpdyUdKyOeBoekhEL5CTXPStJc7KKfVKUk2mDP3drmX4
	+F/ak23EXJgpkQjPcIMjBvlQU1KzjTBwpRYuXhIMKKd+uiWwUqS2FLcN2KlZvuY2
	8sy38w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggany3ku6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 06 Sep 2026 15:13:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2db3734d06dso18819395ad.0
        for <linux-pm@vger.kernel.org>; Sun, 06 Sep 2026 08:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788707631; x=1789312431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T4SdcNzIo3p7/l31uFVcGP3qz3Lf1+uQEV5rsx9A6c8=;
        b=X2HPLpQOa79vvcU6gMJN1MNEpAELE8PNKgqRl/VLox98R0KM80c8VLArpxHyj5x0Tl
         Mkb9eY8vYBVO04pfxH5kWKVOp9Ti5C67Ae1bXIkj1l+Lf+Y7bZKZctfB+F2+LZh7mSaG
         jZ2WvsllPck0gP5mhL2Pc4PUv9wsTLMnd5yXlbiu73T2DI975T1gHnPSEWGby7lu/dlb
         0Y6aAHKMf23rUZfPERrp6gfM/dSfj/clcUQ+J4GxZiTCJbH0Z7fMWpjT5LZhcdzLNTth
         KMEedW1OJEdCgm7+5bzNKJ+QTgJbjATB5VVLByno8EIHUTVx63bMsr7AAJQsE52/6KPV
         a69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788707631; x=1789312431;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T4SdcNzIo3p7/l31uFVcGP3qz3Lf1+uQEV5rsx9A6c8=;
        b=MJvMIQwk2atsdZcGObYNKhZOlbsWljgwwIfKfT055Pm01TgIzdHnIaLPZh5DKW9566
         H+x/hd661viTzP+SjfOw2ysI1KVxjAG7qeBnYK7PTzRVBAEMvery+8+lKBJ8/tUAM79E
         nQpFYuHsNOrw4Bf5W7hCpN7vybh7KxWwhbq8ft2+MVEvaLK1COORraxR7icppWtGbTia
         XxH56ux7J2OGeoG9c2pVbu9qH+s5nzApAwM46zm8W9CtYOlXYxz2n4qy41OUFPxb30s1
         muzXend0cAbwXy+24qp2v4HzYHpCkKdmc8RGA9wzKEFcJNdJdKai/KP3W18iawvWJch7
         uM+g==
X-Gm-Message-State: AFuF++nn66/565jxNwaNu13NrAwCQ+mhBEvUFHULGwdCXgk10PZjM28c
	m8IrpIMjemcN+i35yj9FOmrmrSfgICv/bo3dxpFbd8uvYy8KsS5H1B/J9Xjlof2eQmaGpPl2kbB
	mbSbY8IRFCcwOx6HiGK7rXMqksEbSHhiCUUhPWnx8yT0gknbCYs2T3kK11GFSLijO2S6N8Q==
X-Gm-Gg: AYBFou0nrrAkTBvCXSCfZ454DWoKaTe2nIxEXQsxvWcH0PbrG+k5DkWoHqS4nRUGKFs
	GTxqLM9KPQIoAuIwNMOrkec+3+9JzBnbUlcIwffpUegWjEQTLBm0TZpIc8HY4NfkjcfJDERbrnL
	4oR1/YiMuxun+P1RbJzRYiOYkyC2f+uxukvUzesj9IJvuJV1h47bm6n/NaDgIbZFiBq29aq299q
	0O2pUN5jtYO2q7A6AQ5b2jV0+rDn+75jcwaN6ANeaTHT44L94BomGZhP1DhPCzZXXgZ1MWi8V52
	i+muam1byXnljiOrk1jZhB+7045J4T0/Y1qHlSG61YFgunDJ69eRWtEee5SfA/8Igj0mKBQZUhH
	nNfUbh0WU/KFOGtLEoxF31AMo/ly+cq7JNTB+VU0zJkmUxwYxbcIZxZYQQYinI//6dtIoQvs=
X-Received: by 2002:a17:902:bd03:b0:2d8:d4d0:792f with SMTP id d9443c01a7336-2db1288bcf4mr167345135ad.19.1788707630755;
        Sun, 06 Sep 2026 08:13:50 -0700 (PDT)
X-Received: by 2002:a17:902:bd03:b0:2d8:d4d0:792f with SMTP id d9443c01a7336-2db1288bcf4mr167344715ad.19.1788707630169;
        Sun, 06 Sep 2026 08:13:50 -0700 (PDT)
Received: from [10.133.33.92] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1497d9ddsm33312655ad.31.2026.09.06.08.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2026 08:13:49 -0700 (PDT)
Message-ID: <f0b59964-081c-4547-8251-3e3134c4942f@oss.qualcomm.com>
Date: Sun, 6 Sep 2026 23:13:02 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: conservative: Ignore idle periods when a policy
 CPU is busy
To: hu.shengming@zte.com.cn, rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        luo.haiyang@zte.com.cn, zhang.run@zte.com.cn,
        zhongqiu.han@oss.qualcomm.com
References: <2026090215474182681fN7LLOSpqIc3s3OqJaW@zte.com.cn>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <2026090215474182681fN7LLOSpqIc3s3OqJaW@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X45i7mTe c=1 sm=1 tr=0 ts=6a9d832f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=1RTuLK3dAAAA:8 a=VwQbUJbxAAAA:8 a=0eKtK12xCi3f4MogZNAA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-ORIG-GUID: 9_QD7Qw1n30v_nGJ_eH9bjeG9WnDIkUq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDE3MCBTYWx0ZWRfXx8m9l9PkMJ3e
 dSW34L4CllmQEftI2yE9kkzzR2yi5nkDwE7IxlSmzpq+ix6kg35+l+dBnbYKeR0QLHM2rANf5Vs
 wbKdNAGIGaEm7WYllTT/6ahoBnSdvHQU5kZyQWF0b73jztrvuEwg6kQgPMqV+O2Vft+9OmpFssA
 IZLe4Gv4Q1EujoZWjuACqLpUGnmjL15+jAfpdjRvRCiDYGG84+jTlp61wMB5QTGltaVg768l4q/
 prIvJEWaQyc+TD+4jl4twRxR0VaZWYkWF0ODg+tCGUOmyoWb2Y3dbWMJzePANZK/Z7r4YP59Gir
 aKIQf8laXMnQa2joWu2dnZUAOxhg6nfB3KE4RfICgH+6x3W+16E8Pn3a7QhejrmMXiXpT2MU3K1
 RNa+uxhzxNtuHXL98sdHzFkFkk9epmwto4RKn9gLe4BMlqamZrWaQiBlu3XSLul4AeWgZHwQYL7
 x1q2Xjqb6vC2nEK15Rg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDE3MCBTYWx0ZWRfX/kvNgyoNPbeQ
 U7oA5aPml8wpOMOB1oFlabUtkJpwMjQXv1p0ac2IWUqfAefo3UWJo+dIRTPbeRixRqA+F/OIcxk
 7L7YotY1Yze9c2vlPneiMyueafWqi4M=
X-Proofpoint-GUID: 9_QD7Qw1n30v_nGJ_eH9bjeG9WnDIkUq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-06_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609060170

Hi Shengming,

Thanks for the patch.

On 9/2/2026 3:47 PM, hu.shengming@zte.com.cn wrote:
> From: Shengming Hu <hu.shengming@zte.com.cn>
> 
> For a shared cpufreq policy, dbs_update() derives the load from the
> highest utilization among its CPUs, but it also records deferred idle
> periods from any CPU whose idle time exceeds two sampling intervals.
> 
> This lets a single update report both a high load (from a busy CPU)
> and several deferred idle periods (from an idle sibling). Since
> conservative applies the deferred down steps before the up step
> triggered by the high load, the down steps can outweigh the single
> up step.
> 
> The issue reproduces on a policy shared by CPUs 2 and 3: a CPU-bound
> SCHED_EXT task keeps CPU 2 at 100% utilization while CPU 3 stays
> idle. On this system SCHED_EXT generates update-util callbacks less
> frequently than CFS, so DBS updates are sparse, tracing shows:
> 
>   load=100 idle_periods=7 interval=59 ms
>   load=100 idle_periods=4 interval=39 ms
>   load=100 idle_periods=2 interval=19 ms
>   load=100 idle_periods=7 interval=59 ms
> 
> With the default 5% step and a 2.6 GHz ceiling, conservative first
> removes seven 130 MHz steps and then adds only one. Repeating this
> sequence keeps the policy near 530 MHz despite CPU 2 being fully busy.
> 
> Only retain deferred idle periods when every CPU in the policy meets
> the long-idle condition. This keeps the existing behavior for
> single-CPU and fully idle shared policies, while preventing an idle
> sibling from downscaling a policy that contains a busy CPU.
> 
> Cc: stable@vger.kernel.org
> Fixes: 00bfe05889e9 ("cpufreq: conservative: Decrease frequency faster for deferred updates")
> Reviewed-by: Luo Haiyang <luo.haiyang@zte.com.cn>
> Reviewed-by: Run Zhang <zhang.run@zte.com.cn>
> Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
> ---
>   drivers/cpufreq/cpufreq_governor.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 710d93ec89b5..64eb6b5f08a4 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -126,6 +126,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
>   	unsigned int ignore_nice = dbs_data->ignore_nice_load;
>   	unsigned int max_load = 0, idle_periods = UINT_MAX;
>   	unsigned int sampling_rate, io_busy, j;
> +	bool all_cpus_idle = true;
>   	u64 cur_nice;
> 
>   	/*
> @@ -233,13 +234,15 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
> 
>   			if (periods < idle_periods)
>   				idle_periods = periods;
> +		} else {
> +			all_cpus_idle = false;

The problem is real, but I don't think this condition is the right one.
idle_time > 2 * sampling_rate tells us how many sampling periods were
deferred for that CPU, so its negation means "this CPU was sampled on
time", not "this CPU is busy".

Since all_cpus_idle is per-policy, one such CPU is enough to discard the
deferred periods for the whole policy, and in a shared policy it is
possible. That effectively disables the optimization from 00bfe05889e9
for shared policies, which is the opposite of what we want for power.

What matters is whether the CPU was busy over the sample, that is,
whether the skipped sampling periods would have led to a frequency
reduction at all. It seems more appropriate to key that off the load
measured over the sample (kept separate from the possibly inherited one)
against up_threshold, so an idle-but-punctually-sampled sibling does not
throw the deferred periods away, while the fast downscale on wakeup is
preserved.

May I know could you comment and try this patch on your scenario?  Once 
everyone agrees I can send this formally:


diff --git a/drivers/cpufreq/cpufreq_governor.c 
b/drivers/cpufreq/cpufreq_governor.c
index 710d93ec89b5..f10fc335e70e 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -126,6 +126,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
         unsigned int ignore_nice = dbs_data->ignore_nice_load;
         unsigned int max_load = 0, idle_periods = UINT_MAX;
         unsigned int sampling_rate, io_busy, j;
+       bool busy_cpu_seen = false;
         u64 cur_nice;

         /*
@@ -147,7 +148,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
                 struct cpu_dbs_info *j_cdbs = &per_cpu(cpu_dbs, j);
                 u64 update_time, cur_idle_time;
                 unsigned int idle_time, time_elapsed;
-               unsigned int load;
+               unsigned int load, measured_load;

                 cur_idle_time = get_cpu_idle_time(j, &update_time, 
io_busy);

@@ -186,6 +187,19 @@ unsigned int dbs_update(struct cpufreq_policy *policy)

                 j_cdbs->prev_cpu_nice = cur_nice;

+
+               /*
+                * Load actually measured over this sample.  The value 
used for
+                * making frequency decisions below may be inherited 
from the
+                * previous sample, so this one is needed in order to be 
able to
+                * tell whether or not this CPU has really been busy. 
Note that
+                * no per-CPU state is updated by this computation.
+                */
+               if (unlikely(!time_elapsed) || idle_time >= time_elapsed)
+                       measured_load = 0;
+               else
+                       measured_load = 100 * (time_elapsed - idle_time) 
/ time_elapsed;
+
                 if (unlikely(!time_elapsed)) {
                         /*
                          * That can only happen when this function is 
called
@@ -220,14 +234,16 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
                         load = j_cdbs->prev_load;
                         j_cdbs->prev_load = 0;
                 } else {
-                       if (time_elapsed > idle_time)
-                               load = 100 * (time_elapsed - idle_time) 
/ time_elapsed;
-                       else
-                               load = 0;

+                       load = measured_load;
                         j_cdbs->prev_load = load;
                 }

+
+               if (measured_load > dbs_data->up_threshold)
+                       busy_cpu_seen = true;
+
+
                 if (unlikely(idle_time > 2 * sampling_rate)) {
                         unsigned int periods = idle_time / sampling_rate;

@@ -239,7 +255,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
                         max_load = load;
         }

-       policy_dbs->idle_periods = idle_periods;
+       policy_dbs->idle_periods = busy_cpu_seen ? UINT_MAX : idle_periods;

         return max_load;
  }



>   		}
> 
>   		if (load > max_load)
>   			max_load = load;
>   	}
> 
> -	policy_dbs->idle_periods = idle_periods;
> +	policy_dbs->idle_periods = all_cpus_idle ? idle_periods : UINT_MAX;
> 
>   	return max_load;
>   }


-- 
Thx and BRs,
Zhongqiu Han
