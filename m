Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602995;
	b=dtI7MHZHN9PavOG1m1yB5me7ksuunJO4yMjLCnOVsetACmyvU+tfYbwV3Yl7UUNcLEtL
	 EoZHFcwfL2U4s2/eSfJh9GnBfPk7bgXZOugy/CLQvVYz7e+nUcRwKMdIY5Hoy9OLigkUa
	 L+0XQNbqzPSZ3Q1vURXG7eYfY0ZYwpegwtjwrwNmbPuLAsqN1/pKm+CDJ+lHkmCm42L+f
	 so/lct0e5xAuWk0EQNhVPlCDzz592dYrsKKnZOpLJ8e6yov0uWxCYvSPeGaWsrmw04TpC
	 T/vgFmdMAi3ykDIkGlE2ypKahpOwYTlUIzwKlmcN+MP24qEGu4lgwKookaIsGuYsBRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602995;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jAEsJZYaibUUOKZ4k7NMqSX3DBwN04ZW3KixEdHDmuI=;
	b=NKCPeUotUspnnmqS2hUeijgsklxq5A9Sp9yTTQluoQkymfXwvOuVS31X0M3nCWYE3y2R
	 J7WqUk8qBIc5TwzQiI2cg5CAx0MNZpaxb+hfJbOfuZ6u4YnxAMkIQ7PSimowIKe75lrGn
	 MNJZRXFQhZoAGv8kc1I3KoDs5Bq0F0wfybu/mrrCxzykcB6uswFTCAVU/bgbJmho6DKEH
	 eCXnvilrRuL43igt9F3DUD8wn0eB5Wibtv3YN5njDZHQKDFeo2mlsFhWcanyPRMBRR1RB
	 aSm1Kba6hhh6HMz3B2Fd0etyYW1zWDKqNi08hp+gVuZswzX0vKm2cjnjNZWpUF/cKLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b4YwkgWa;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jqZx0FnC;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E8C606A326
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 10:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37E8C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b4YwkgWa;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jqZx0FnC
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mSMn555596
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 10:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jAEsJZYaibUUOKZ4k7NMqSX3DBwN04ZW3KixEdHDmuI=; b=b4YwkgWaX5Fozf/d
	FCcmChtVMCETvVXv2M9im1Hzn8szRM/kXz9Ix7ZfMKLZE9DCjJFfoMQL5F3JhMho
	17J9SWHDJIlozED9HRjUZmwv0le/Pf+Lrm1KhqeIeNNqGnXBDO0YhvE+RUufkH1s
	9DdsprT4+SEMKzDqkTI2CGWOPfSn+3xTONAyBbL2x0EwJwyLve7/es3WDfkXBfzn
	zEnyk0S0sAwrRszZ4i/XLq0+xaSgMuj+58WavUmo9c76SPmu6Nqw35p9EyEGu/L5
	javuNWbMtR+J5x1elMlrx+5pJJzsYR+6l5Ahlk56T6PVKgZKySLH6rFpXi7KEOE9
	Fptcmw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vvnrcd0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 10:36:34 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b0a7cbf164so4684555a91.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 02:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795602993; x=1796207793; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jAEsJZYaibUUOKZ4k7NMqSX3DBwN04ZW3KixEdHDmuI=;
        b=jqZx0FnCXufx5QO5UGmtuRBoVJBEvt1v4oOoKKy+nkKrFKAMGxf7QafrBo1J+ht99i
         2NnjPdbpzVkOdaIg8Qu6JHrH9lhhGJxHuIKsNjh7BBB/blBeoQYxcUEc2gdvIQIuw3cw
         Z10Jwg5/1j7VNwxBxeHEfP00dEXyl18EGuQunjWWIHnXe5haAbCAYTb1pfy4u65nb0/p
         +7r1pvRjOdPy7dlbs0BiUtIj/fKLpN+yUl1H1ToqQprhOy2H7ZdwaJplZWSkLaC2IHDe
         HzerUwn1yPtg+cpCso3llpHqE9mKkUwY1PzEmFjC5Y7F8xYmeiygu6HxiPN6jhMkRQ+K
         0rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795602993; x=1796207793;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jAEsJZYaibUUOKZ4k7NMqSX3DBwN04ZW3KixEdHDmuI=;
        b=uq3y9uq1NU4LowmiMJ0fWeJYrOJC4Z73sXAoPsbzbFNHCO+075Mre5ktb7+4QYOBjw
         3fDvWoHC8D5m6+eZk4dPDA1t76DSH3MTeOiBSfH5vsrcmZpD3L4ZQYG+HFpg32ke7QCa
         vHbc/WDDGgKoEBDP90CgOkgX4fnpeEKCyembrWTe7W0szQY2wphnm8SJg6YqdSlrcmFk
         WPp+lRgHggo2AqrYtxlnlHw1mrR0RpBic9W51XzG9vJDPJTmm5pOkCp17Lq6j/Pvo+vW
         aR0G+gPAEPdX1+x3ufzD2DXcNSzF7IJ5Ug5ZDXxoVJSdNnznJNFKeidrn6Ko+2VJqdTg
         nSUA==
X-Gm-Message-State: APuU4Z+R637jIDaa80fwbzdE4R3Z2NifYl9r24glyb7QgacEgvU/LCM1
	2aozZfV/+WvlgWqL/09MiUonLUyxWMbwCuprlQeuSEnFOX1f7XUoD/hOqOWWi0llbk5FYSYuxYt
	ZyXqVGHQ2mcrJrWGpOW3HkmQj/yeXEvK8tT1mB3pvUDwytvUkGzLP8K4WLETz7w==
X-Gm-Gg: AZFdTZdCwIhelG9nEn3hgA8huK1uqN0k+AR6ShHzdpCJ7y63ZFcbW5hUyqaOPk/a9v2
	ouaHoaDW82IXz6kM6vgxwLXWl0EA6Bu16y2jwZ4lTKDHocYfzI6m/+B6u+vWSsE9y9b9yQp0VAY
	iuNkc9uiHaB/Tq9LqWB9rA4FRCj1QOlSjWBWrXhUCiEaouTdFXcWMugLkNxsfc5EYIs6s9plU7L
	60cD9WrV/Ev7YnYIyDGPp+dLQTFQUWmGfFnAhXzOlFUphkaTF4sFcaJlecfU6VEVMZhB4vF1apn
	/lnQV4z60Ghko8lNgHgAvICYFKaIHsrxFG7NfrwHqBxxGz5TdiQRPGcFa2Rv2bpArhnZp/tbsUh
	gkCVLhK5lJE8uqoavWK3x+pZhL3Vym/xGAZsZe+8a/IIFtdXfhp60LwH6mIjgS8gvrzd46lFOoz
	CVS7U=
X-Received: by 2002:a17:90b:4983:b0:3b4:ba6:f712 with SMTP id 98e67ed59e1d1-3b41c9988f1mr18869665a91.60.1795602993111;
        Wed, 25 Nov 2026 02:36:33 -0800 (PST)
X-Received: by 2002:a17:90b:4983:b0:3b4:ba6:f712 with SMTP id 98e67ed59e1d1-3b41c9988f1mr18869644a91.60.1795602992591;
        Wed, 25 Nov 2026 02:36:32 -0800 (PST)
Received: from [10.239.133.197] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b82e624sm11657648a91.4.2026.11.25.02.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 02:36:31 -0800 (PST)
Message-ID: <42b78eda-ea3c-46fd-bab5-ceb81e22f720@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 18:36:24 +0800
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
Subject: Re: [PATCH] cpufreq: schedutil: Run irq_work in hardirq context on
 PREEMPT_RT
To: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
        bigeasy@linutronix.de, clrkwllms@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261125080613.1138573-1-zhongqiu.han@oss.qualcomm.com>
 <86b5a9f8-70f3-4a5f-b023-c9fb1a2faf83@arm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <86b5a9f8-70f3-4a5f-b023-c9fb1a2faf83@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MiBTYWx0ZWRfX7SgNVdME5LBG
 k51Gna+M6+nZJsWCzNNJnZEkXmP64qP/aXtopvKuIPovlcKpbS8WM2+IoGVbxxP9TOw6wIgghiW
 qBMNt+GF6ssb+nqLGPwphewVXYlZ/ZprWOxQNuU6A98IX5QnrH8Rh5JKbLwKLCsDw0RzZCYAq9C
 YLVdp/96q0o75Yln8gqCHLGJKH/vr5kVUDORwIB4d1Vv1pteiuk0imYcHnALDlX1+JWPb+U1Aqa
 zRE3zaAHflz2+hL4oUkTkS5Ce5We/1+Dbr7Ih+XChZtq/TtJ+O5jqTFun3lOmSMR3IQd96yiSj7
 amFP7lgizZWwtl1B/sHgUiTkXVOLd/4k2cS/DxWw2BZce+Oa69C4dMzHCgZcJ2e6oMCrV2XnKZU
 JxlyPE4VWunew6yxduYFV9Zf7jtl+zrasdzTEWeNixpi5pU2adQSwx1Io7MVrAK5qyj8i7WLOEK
 hv2/D4AzzoGlcIJExQw==
X-Proofpoint-ORIG-GUID: A3NF-uYf6KpiZPoYvoIW77RBEFh1osT-
X-Proofpoint-GUID: A3NF-uYf6KpiZPoYvoIW77RBEFh1osT-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MiBTYWx0ZWRfX5t/vMkK6Sf3m
 8Kwi5WQkxj59qE6m6vlKGbTuJDrK5WpRQQ+bklqdEsx/UoKl7Dig3RGSUUQAKeKaJtlYVQSHT0s
 LL5yZJKIEjnH2P7c/8/Ey73kSU1CmuA=
X-Authority-Analysis: v=2.4 cv=R4mWitRX c=1 sm=1 tr=0 ts=6b06ba32 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=YpS8oBoqdfD21wqEnNUA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250042

On 11/25/2026 4:26 PM, Christian Loehle wrote:
> On 11/25/26 08:06, Zhongqiu Han wrote:
>> On PREEMPT_RT, an irq_work not marked IRQ_WORK_HARD_IRQ runs in the
>> per-CPU irq_work/N thread at SCHED_FIFO priority 1. The schedutil slow
>> path queues its irq_work on the local CPU, so the wakeup of the
>> SCHED_DEADLINE sugov thread is delayed until no other RT or DL task is
>> runnable on that CPU.
>>
>> Meanwhile work_in_progress stays set, so no new frequency update is
>> queued for any CPU of the policy: one busy RT task can freeze the
>> frequency of its whole policy.
>>
>> sugov_irq_work() only calls kthread_queue_work(), which only takes raw
>> spinlocks and is safe in hard interrupt context on PREEMPT_RT, so mark
>> the irq_work IRQ_WORK_HARD_IRQ, as commit f8d958880933 ("srcu: Use
>> IRQ_WORK_INIT_HARD for srcu's irq_work") did for srcu.
>>
>> Tested on a Qualcomm SM8850 board running PREEMPT_RT, with SCMI cpufreq
>> forced into the slow path. With a SCHED_FIFO 10 stress-ng worker on CPU1
>> (30% load, 50 ms slices, 15 runs of 5 s each), sugov_irq_work() now runs
>> within 15 us of irq_work_queue() instead of waiting for the RT burst to
>> end (up to 212 ms), and the policy frequency is no longer frozen. The
>> irq_work latency below is measured from irq_work_queue() to the entry of
>> sugov_irq_work(). The cost is that the kthread wakeup now runs in the
>> irq_work IPI handler, as it does on !PREEMPT_RT. In a separate cpufreq
>> stress test with cyclictest (SCHED_FIFO 90) on all CPUs, this raises the
>> average IRQ work IPI time from ~0.5 us to ~1.3 us, with no change in the
>> number of IPIs, and the cyclictest per-CPU worst case by ~2 us.
>>
>>    PREEMPT_RT                           before              after
>>    ---------------------------------    -------------       ----------
>>    irq_work latency on CPU1, max        130 - 212 ms        <= 14.5 us
>>    policy0 frozen, total per 5 s run    0.57 - 1.25 s       none
>>    cyclictest max, CPU1-5               13 - 16 us          14 - 18 us
>>
>> On !PREEMPT_RT, cyclictest and IRQ work IPI duration are unchanged. No
>> lockdep or DEBUG_ATOMIC_SLEEP splat on either PREEMPT_RT or !PREEMPT_RT.
>>
>> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> 
> Missing a fixes tag then?
> FWIW
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Thanks Christian, add the tag on V2:

https://lore.kernel.org/all/20261125103451.1385246-1-zhongqiu.han@oss.qualcomm.com/


> 
>> ---
>>   kernel/sched/cpufreq_schedutil.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>> index 14405a614991..b2e9ac7e3517 100644
>> --- a/kernel/sched/cpufreq_schedutil.c
>> +++ b/kernel/sched/cpufreq_schedutil.c
>> @@ -726,7 +726,7 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
>>   	else
>>   		kthread_bind_mask(thread, policy->related_cpus);
>>   
>> -	init_irq_work(&sg_policy->irq_work, sugov_irq_work);
>> +	sg_policy->irq_work = IRQ_WORK_INIT_HARD(sugov_irq_work);
>>   	mutex_init(&sg_policy->work_lock);
>>   
>>   	wake_up_process(thread);
> 


-- 
Thx and BRs,
Zhongqiu Han
