Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BC552CCFC;
	Wed, 14 Oct 2026 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995324; cv=none; b=TdKg/UbWtg4k8hzVcFVRaLIZu2lU5qBBxYvT1IxbVa+BPHEMV/sPaozex27icWv3wGufMVP0tQ7cGBUmD52FxPikpT1YwnHGo6hg2q2ZSTUR95dDjNyFjkbahHSn5zyzSUlummKGChxoTEmEbpZhQazcHBhzVDnS1TeHmsrUAKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995324; c=relaxed/simple;
	bh=Rw2DYCU1zFUn/jCerOOAEFcaFMcma58/qFJYx4jigmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6EcWGlx1fnK45QUGHRpEyvIEMnKR0Jux3TkOSZplNwITfIBw4b9MmpzaUBrbDfQLqhIEImhkesvWVFYdR4Ec/8vc3n/xuanqw1qRe/DEEg5waXz31RAwxzdxIFnaK2+nUMYMnjiBR8WYrx2zPWkW0u8YfgOYQaXV0GxvbE1Vn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rmgVH09O; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rmgVH09O"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEiVIw2327344;
	Wed, 14 Oct 2026 16:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pMN9zc
	12wh5XCYPys/PzOM2CBB3S8mkrJRY8br1KC6w=; b=rmgVH09OynpkvDM+7ruDL5
	L0ihpr4oojvDZd9eiIbnaWigYGREHdPwjWgIy8UeGTBk4km+2m1ubBVRDohTFu5m
	GA7m07K/Jsz8k5QCs8+8Rq3jAxvafozWUTQnZMBzOvwOkz/7Hk83g5n1TL/A+Z1/
	BCUyzJ086r6RpuJFuUyyE4vZuX6x1n013oP8HTAuWI4XdIlj+fK7iFfm0ksRerNX
	JXejXSd4zwwlsXxEs2SlKvGd0pk1Vgsn06A0bnYnbLEKh/6qbPdUSo+DWiIGZU1w
	nJzIPBdnt/6sJmz0P/u6GCysthD7mJSCXgnZ9zMfi7YfMncLjSgKdu3mwyyBKMpg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwj51wx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 16:28:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEba3t3639755;
	Wed, 14 Oct 2026 16:28:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9wvg3em1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 16:28:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69EGSAZx25559566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Oct 2026 16:28:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAD3820043;
	Wed, 14 Oct 2026 16:28:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E74DE20040;
	Wed, 14 Oct 2026 16:28:05 +0000 (GMT)
Received: from [9.124.214.100] (unknown [9.124.214.100])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Oct 2026 16:28:05 +0000 (GMT)
Message-ID: <4976fcef-29ec-43fd-8655-32874720ee73@linux.ibm.com>
Date: Wed, 14 Oct 2026 21:58:04 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/18] sched/fair: Add push task mechanism for fair
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
        linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org,
        linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com,
        arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
 <20261002154415.2270586-8-vincent.guittot@linaro.org>
 <a18e6fe1-e14e-46be-9779-3704ab8625a0@linux.ibm.com>
 <CAKfTPtDkSs8KOUYAdSOz_h93khGbT6TaVc9gCa1Cpa0JbmKEGw@mail.gmail.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <CAKfTPtDkSs8KOUYAdSOz_h93khGbT6TaVc9gCa1Cpa0JbmKEGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NCBTYWx0ZWRfXwpB1IwT3mpYt
 ImehsQLFHJJx5ewZqk/wWa0G3Vr4dTqzdurXncBk/x96bXRJLkwyylg+nbvYMsAyMGeK5hKNE6F
 F2wBWp5hS2KWNFUO7UAMc3fEw4mwi5UN2D+jw2CQbuhz7ew9V+De9gI881je83KVpKic5sFuvQY
 pYFKKIaoh/gxD7MJQfrdDjkwWzHuzb39cGJcX+/qBslnuQvtVxc9Wm/hXfgV2JeVQYf/cJtezwe
 4+zLSDpeYEgFMwyx5iZt2UxZLs20U++kuCcP4cyfK1XomcUqFR2oQAXurWf64ncVA8dkS614i2a
 KZQQY+iDOf5Kp4A9EV7/a/+Rjw+FQzxkAluh3eBMxP6k6FqopsxG8mblj8HE7Kg3IFJSNI07XBQ
 BrYSH6BfDxLEkfupHThXEWgrtxL9Gri6qSH53/P0PVxBMEcjd+PWpS7ThtVVNLeHg+A/EfwYgIM
 /ZxMlKSIUaEj+8onDrQ==
X-Proofpoint-GUID: bTnntmyhciz6VMQGtL75Hn2xX8z57U3F
X-Proofpoint-ORIG-GUID: f5RArQspwIy94p8IOOSF3AEcgcep3yTw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NCBTYWx0ZWRfX+XnNPF9Vjits
 UzkEu6haHnvxSrVR3jIUZVoRXNewSL97nw6D5kirRtRcN0XvHqKpyzZpNydZU0liTw9TtFoRFID
 Cqtc1htVFC2R0OAF4ZuRKTqqIccBQec=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6acfad9e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=tYy84T6U5ddJezyHrlAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140064


>>> +static int
>>> +select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags);
>>> +
>>> +/*
>>> + * See if the non running fair tasks on this rq can be sent on other CPUs
>>> + * that fits better with their profile.
>>> + */
>>> +static bool fair_push_task(struct rq *rq)
>>> +{
>>> +     struct task_struct *next_task;
>>> +     int prev_cpu, new_cpu;
>>> +     struct rq_flags rf;
>>> +     struct rq *cur_rq;
>>
>> You likely need below to keep clang's context tracking to be happy.
>>
>>          context_unsafe_alias(rq);
> 
> I just noticed that I didn't answer to this one
> 
> Why should I need this ?
> 
> rq remains the same in fair_push_task(). I'm using rq and new_rq to
> differentiate both current and new rq
> 
>>
I tried to use clang-23 and get below with the series applied.
It may not be exactly here. But somewhere.

make LLVM=/opt/llvm-23/bin/ \
         KCFLAGS="-Werror=thread-safety-analysis" \
         V=1 kernel/sched/fair.o

kernel/sched/fair.c:9971:2: error: releasing raw_spinlock 'rq_lockp(rq)' that was not held [-Werror,-Wthread-safety-analysis]
  9971 |         raw_spin_rq_unlock(rq);
       |         ^
kernel/sched/fair.c:9983:2: error: raw_spinlock 'rq_lockp(rq)' is not held on every path through here [-Werror,-Wthread-safety-analysis]
  9983 |         raw_spin_unlock(&next_task->pi_lock);
       |         ^
./include/linux/spinlock.h:279:32: note: expanded from macro 'raw_spin_unlock'
   279 | #define raw_spin_unlock(lock)           _raw_spin_unlock(lock)
       |                                         ^
kernel/sched/fair.c:9980:2: note: raw_spinlock acquired here
  9980 |         raw_spin_rq_lock(rq);
       |         ^
kernel/sched/fair.c:10085:2: error: releasing raw_spinlock 'rq_lockp(rq)' that was not held [-Werror,-Wthread-safety-analysis]
  10085 |         rq_unlock(rq, rf);
        |         ^
kernel/sched/fair.c:10093:1: error: raw_spinlock 'rq_lockp(rq)' is not held on every path through here
       [-Werror,-Wthread-safety-analysis]
  10093 | }
        | ^
kernel/sched/fair.c:10090:2: note: raw_spinlock acquired here
  10090 |         rq_lock(rq, rf);
        |         ^
