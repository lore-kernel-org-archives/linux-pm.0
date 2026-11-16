Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822300;
	b=umZuYQN2i3hkwpaZvEV512idSuuWwlWQMzlHS46fHYfziWKEdCkm7ItNGxqGDf9qLX+d
	 SLLDltmw90bdVjR7hOx2yOBayvtK5Xd3yGnTPMeoofCECD3blbKB0tPsKiHpISyYwOs84
	 8gIGeRNqGPm6zj61wQD52eSHXQPEimnu/UNmTWUNZsNWCEVF/VN+mopjqjbhDuagJFv62
	 hAY5BUi91+RY/6joUi28NVtRXscPXGEJVxDG8Mp/cyfo4HAqYcyrCeXnJq2UleqNngcjk
	 jcAi3QP7N1OkvOKN+gH6I/r7xowfxXiOx2z7jtjZ6H5tJSUG2Frj8OTkFVtH9JiQlug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822300;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mFNFQKdbRBq8c1uwhiiA8pFPG9yosXGE3ZW84aM/LeA=;
	b=Be4aJf4rqwhf3VdO1uJbXnKHsomJfN7XcZ6ZmrksJBhpEj0Fak3QEQDMTHmB7TTf/ExQ
	 MGeIIuSdz+Szq/MdEIKkf1Nv6IN9VzXXTXxAVYn7C7SHg1XSJGWKY/30MeKp0vcw2lVqT
	 J9RMkbP1KfaeiTOKWwcUkqkUKk45yqlVr/wOZ0Vw61YMUCrDIUqOzpHe6bwXjyOmSlPsj
	 k7Hvm4uERkvXX0EtNyT8Ytz51WgZz5qBQMUmRKLqhbSGdIbPl92ZnkcwowfayFwmEmTNK
	 UNVt/Nyw+RlWw+SqL1L2eil4c72Y9uiNsqUonzOv7CaBFIwrhQ7JVMF+jF54cGoWt6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=igrwlQI1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GYZBONnB;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1767A606A883
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 09:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1767A606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=igrwlQI1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GYZBONnB
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG97U0p1161000
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 09:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mFNFQKdbRBq8c1uwhiiA8pFPG9yosXGE3ZW84aM/LeA=; b=igrwlQI16lc+UhOJ
	zfhAIpZIEsO5SzxZgZh6OfTV7jwZw465E5dvQO54kNOqU7l81GsoOMl4KdyBrxGQ
	g7+JiM4ISriNHLkMq0LzaGAmrd8bJyaEsmbzLOAZ5OeZO086vFLKZPYUVwnwGhFV
	jFgJMpadxoS2anFeb0plSiOSxue+TmqksxSFxqOz1v7v03Wb0KR4q6XtkIneMRsU
	N5xOjcEwu8GlmYArCetXaJrHKs4zlabuphPzXCxIMqcq41eU7Z3yDp4OS6H9Q7t3
	sR1AYj5zYyh05MbMMzp7Rgamo2+TMMT3jqI8/MLOllzrFanoHibLnDJ4eq4GL00x
	3PT2Pg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyxx2g4kf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 09:44:58 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a0688a43d3so2216936b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 01:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794822298; x=1795427098; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mFNFQKdbRBq8c1uwhiiA8pFPG9yosXGE3ZW84aM/LeA=;
        b=GYZBONnBx7vX7T5ja5qO4XiRUVKn1o1hlqFnBdrelkxWdefLbC+3yTDinfPzcaSSkV
         MYwRs1/UbryYl7jZ4pSp+ld5u1KdLq9k9fSRaKfXDiDxmIWQde7hHwmdsq+MxWWyZWb2
         9Qcm5hplZ3VajelRLu1ys4+jCCH/LQ3dv0kSxM2XWjEtSamP0n5A6+MZj1uJAYJq1/Gh
         up2hqECXe2hXsSyZDrhTp5qowycBeH3e45UYXuaiYLcBvtDabifRGdNqQIV38TtIBY8T
         5C49YMPyaYwsjlBx55Zc8w6Ole1CDcSXZrIU/bLYcokshJ5n0WtMI7e6rYTNq/7qSG3D
         I7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794822298; x=1795427098;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mFNFQKdbRBq8c1uwhiiA8pFPG9yosXGE3ZW84aM/LeA=;
        b=VSQoMriAoNo4mqFBUtn+lqb78QIkIuGfBmrg8ycZn2Cyaip7F3/ecLjldeG2pLCmZo
         iILIBpPa8VT9+RycZKan39xor02S4eOinwlWBA2DaMoJ883zaqxyvHfIHJaJbd2h60ji
         2dWlF6greGagPtwP/RMBQ5WB4+popQkjZZQOxVaqvw+yxoPCoyMYKSj6mLPD3M14m8Om
         pwXqE67w6zzeRJACzS7l0tU8oStodrXGeHNnRRzQEz5zxv2o4JHgp5RubGurcjgDJhVt
         QqXdUGNslPq+ni1H88kDp1MClCvRLD52zjtdbBVm937I3tw/P21rH17ithEtjisgCbhl
         40Iw==
X-Forwarded-Encrypted: i=1; AL+hErG9wzpmyFSIiT/QZgZdtj1wnwB0qvSTXOJZ70mcHDXaQt6Y88c/9fQUrRqLqsCG9aUUwFEOlrz/sg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/pKxo+uO/2LwE7BjPNWWsKvnnvJe8s0EJDpMW79yaq/XKuBDKQ
	VpZjBz97nRJWv+ZgxbPaFY2fN0j6U+umCQGReLowvkZ6rICtjgOeQZ2A7YM9pt6fu22rjKztnu4
	sQILsrs3puq+72NDtXCqUCZTiWhCPakEqeoOVesFMbaJis6mDgvkHMwJTWj9XdQ==
X-Gm-Gg: AYBFou2nz9gVtjTkJDcX6RxSL4q+LSsC5jlZ3C2NsVGFqGlrJ0RDzwS7L1AzJP4uc1Q
	lHvf2UvgXhsuYkwObX3ccTSayKRGcXeDBJRF/ozdFy1zqzawF2Pdy/bDYm03hvKF9gbBsmKMjb1
	XigQuJXViKjgHDpvzNCND07shGgbswaduzR6vS7r0ZtVxr5WQErZ5lmOzw7+sDnhhH73nM3/v0y
	4a4Gw8tJnGtW1NBIXuHP2YcQVJLAboYjUzeRXRjrvuIMX5isiOHehiOviPErhIHgEcTw3YTwWS6
	R14a1HrR761JIGIbC91PkdvXeVJVsxJ4HNoWfT103+xDylrDbibPtTSwetFAh4G4E8h/jrXa9E3
	1VA2OIM+KzdREVnV+fJoJ4ZpluvPGkSDAeYVjTxMrcsExuhBtKAF5GnE3VgG3nRZklwGVXTL7vt
	deuufA4X8Q9UtGyvDOnHDUfz+/ebkOP9UA
X-Received: by 2002:a05:6a00:e12:b0:89e:8242:f35f with SMTP id d2e1a72fcca58-8beb56cd357mr9342810b3a.13.1794822297594;
        Mon, 16 Nov 2026 01:44:57 -0800 (PST)
X-Received: by 2002:a05:6a00:e12:b0:89e:8242:f35f with SMTP id d2e1a72fcca58-8beb56cd357mr9342783b3a.13.1794822297003;
        Mon, 16 Nov 2026 01:44:57 -0800 (PST)
Received: from [10.133.33.43] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2053d26sm3424078b3a.36.2026.11.16.01.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 01:44:56 -0800 (PST)
Message-ID: <44ed43c9-a91f-445a-97d0-ebe538888cf5@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 17:44:51 +0800
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
Subject: Re: [PATCH v2] cpufreq: schedutil: Skip busy-CPU hold when NOHZ is
 inactive
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
        Avi Weiss <thnkslprpt@gmail.com>
Cc: viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        zhanxusheng1024@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261108145028.2483131-2-thnkslprpt@gmail.com>
 <CAJZ5v0g-oDagp2GrZyhLmT-BYJqcm-D4s1eTrXCxB-fj5BNixw@mail.gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0g-oDagp2GrZyhLmT-BYJqcm-D4s1eTrXCxB-fj5BNixw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R7WWitRX c=1 sm=1 tr=0 ts=6afad09a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=5gUmkPqmsy7klQfhE9kA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzOCBTYWx0ZWRfX7N+X25mRwIFj
 7cotA1lwdEW5B47BGAVX5uMvLOXBdaGNraTaSvjFHm0X25kURUTzdQjlAjTqYNA2FLS4U18rL2K
 7WVgdAJeCcmZqThL5QoohmbM2JRt6tw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzOCBTYWx0ZWRfX7C4VFO6fjsvE
 8kvcuF7gQqQiKXU4qSDrb6j/sI2T6Kp5JH/g7M82xTJ2d7wyXZbLX9Yo7gn3ey6nBNOkJRXSWS6
 MzcJ6LLzZBsmihBZaREnhwuAqeSeBm81T2BD8h5eqJi4c0W+wWhObItZgeb+YKLTXXMzfNkJ3qY
 cgUjF+vTOwNI6yRwnZ6SNUFy5cvA7Zzd5QE5lj4RYdABP+Apy91CFmMQS82JTdU8vU5UUFS4dvg
 XJtyfpaNcxBbCf4VV97JoHFcvQqnFgFq4YOX/XAZbnRcWnDFaixqt5MTkdtb9IC+7Lpo5acvzDm
 qtJaop2WgGtZOcytHLZ/K5Y5tFsMiNEBG3g7rAPzHx26USyLZrhzjkR0N3D0878zalh/tb+IluN
 zyOFYgtcOuZk+1GZHGKQlju+zOkIx4wC8MrvMA7sZMKWB/QxRR2VDvOMLRvb5u6yL1PCzq9kOFK
 kmmn4Ux+8S2mRxiMGmQ==
X-Proofpoint-GUID: PNyje9BAoyJ6Y1n_EB9ejZGb4T4hZIxh
X-Proofpoint-ORIG-GUID: PNyje9BAoyJ6Y1n_EB9ejZGb4T4hZIxh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160038

On 11/14/2026 2:21 AM, Rafael J. Wysocki (Intel) wrote:
> On Sun, Nov 8, 2026 at 3:50 PM Avi Weiss <thnkslprpt@gmail.com> wrote:
>>
>> sugov_hold_freq() uses the NOHZ idle-call counter to determine whether
>> a CPU has been idle recently. When NOHZ is disabled or fails to
>> activate, the counter does not advance, causing schedutil to treat
>> the CPU as continuously busy and potentially prevent frequency
>> reductions.
>>
>> Skip the busy-CPU hold when tick_nohz_is_active() is false. This
>> also handles systems where NOHZ was enabled but never activated.
>>
>> Fixes: b7eaf1aab9f8 ("cpufreq: schedutil: Avoid reducing frequency of busy CPUs prematurely")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
> 
> I'd love to see some feedback on this from the people on the CC.
> 
>> ---
>> v2:
>> - use tick_nohz_is_active() instead of tick_nohz_enabled to also
>>    handle NOHZ enabled but never activated, as suggested by Zhan Xusheng


v2 is small and only affects the NOHZ-inactive case, so I think it is
correct for stable if needed.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


However, the hold can still get stuck in several other cases, described
below, and fixing them needs a different way to detect idle periods.

I would appreciate it if the scheduler maintainers could also take a
look, since part of what I describe below touches scheduler internals
(rq->idle->nivcsw). Please feel free to correct me if there is any
misunderstanding.


As I mentioned on V1:

https://lore.kernel.org/all/78af4d6d-7465-4980-9d8b-e832db76a08e@oss.qualcomm.com/

This still leaves other cases in which the CPU does go idle, but
idle_calls never moves, so sugov_hold_freq() keeps holding the
frequency. In all of them NOHZ is active (except the first one), so the
new tick_nohz_is_active() check does not help.

1. nohz=off (or NOHZ never activated): b7eaf1aab9f8 (v4.12, 2017-03)
      idle_calls is only incremented if can_stop_idle_tick() succeeds,
      and it always fails when NOHZ is not active. This is the case
      current v2 fixes.

2. nohz_full timekeeper CPU: b7eaf1aab9f8 (v4.12, 2017-03)
      Same as above: the timekeeper CPU must keep its tick, so
      can_stop_idle_tick() fails.

3. idle=poll: 2aaf709a518d (v4.17, 2018-03-15)
      The idle=poll path restarts rather than stops the tick, so
      idle_calls is never incremented.

4. CPU latency QoS limit, short idle: 554c8aa8ecad (v4.17, 2018-04-03)
    With a cpuidle governor, idle_calls only moves when the governor asks
    to stop the tick (or it is stopped already).  So:
    - with a QoS limit that allows only POLL (or, with teo, one below
      7.5 us that leaves only shallow states), the tick is always
      retained;
    - idle periods predicted to be shorter than the tick are not counted,
      so the hold is kept across them, and never released if all idle
      periods are that short (e.g. a periodic timer below TICK_NSEC).
      b7eaf1aab9f8 counted them.


A tick-stop counter ties the hold to the tick policy.  Two signals that
do not are rq->idle->nivcsw and rq->clock_idle.

   - rq->idle->nivcsw: the idle task is always TASK_RUNNING, so when it
     is switched out at the end of an idle period, __schedule() accounts
     it in nivcsw. That is once per idle period, whatever the idle 
state,
     the tick state or the QoS request.

   - rq->clock_idle: written when the CPU switches to the idle task, and
     on every rq clock update while rq->curr is the idle task.

nivcsw seems to be the better fit: clock_idle is a PELT-private
timestamp, updated on every rq clock update while the CPU is idle,
including at wakeup.  If, e.g., an interrupt wakes up two tasks on an
idle CPU and the update for the second one is rate limited, clock_idle
changes after the last update in that idle period, so the next update
releases the hold although no new idle period has started.


The patch (RFC, appended below):

diff --git a/include/linux/tick.h b/include/linux/tick.h
index b121c5d53e30..4733344f695a 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -137,7 +137,6 @@ extern void tick_nohz_irq_exit(void);
  extern bool tick_nohz_idle_got_tick(void);
  extern ktime_t tick_nohz_get_next_hrtimer(void);
  extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
-extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
  #else /* !CONFIG_NO_HZ_COMMON */
  #define tick_nohz_enabled (0)
  static inline bool tick_nohz_is_active(void) { return false; }
diff --git a/kernel/sched/cpufreq_schedutil.c 
b/kernel/sched/cpufreq_schedutil.c
index 14405a614991..5285074ee2f1 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -53,9 +53,7 @@ struct sugov_cpu {
  	unsigned long		bw_max;

  	/* The field below is for single-CPU policies only: */
-#ifdef CONFIG_NO_HZ_COMMON
-	unsigned long		saved_idle_calls;
-#endif
+	unsigned long		saved_idle_entries;
  };

  static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
@@ -379,10 +377,11 @@ static unsigned long sugov_iowait_apply(struct 
sugov_cpu *sg_cpu, u64 time,
  	return (sg_cpu->iowait_boost * max_cap) >> SCHED_CAPACITY_SHIFT;
  }

-#ifdef CONFIG_NO_HZ_COMMON
  static bool sugov_hold_freq(struct sugov_cpu *sg_cpu)
  {
-	unsigned long idle_calls;
+	struct rq *rq = cpu_rq(sg_cpu->cpu);
+	unsigned long idle_entries;
+	bool idle;
  	bool ret;

  	/*
@@ -394,22 +393,26 @@ static bool sugov_hold_freq(struct sugov_cpu *sg_cpu)
  		return false;

  	/* if capped by uclamp_max, always update to be in compliance */
-	if (uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)))
+	if (uclamp_rq_is_capped(rq))
  		return false;

  	/*
-	 * Maintain the frequency if the CPU has not been idle recently, as
-	 * reduction is likely to be premature.
+	 * Maintain the frequency if the CPU has not been idle since the
+	 * previous update, as reduction is likely to be premature.
+	 *
+	 * The idle task is switched out once at the end of every idle period,
+	 * so its nivcsw, plus one while it is running, counts idle periods
+	 * including the current one, regardless of whether or not the tick has
+	 * been stopped.  The caller holds the rq lock, which serializes this
+	 * with the updates of rq->curr and nivcsw.
  	 */
-	idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
-	ret = idle_calls == sg_cpu->saved_idle_calls;
+	idle = rq->curr == rq->idle;
+	idle_entries = rq->idle->nivcsw + idle;
+	ret = !idle && idle_entries == sg_cpu->saved_idle_entries;

-	sg_cpu->saved_idle_calls = idle_calls;
+	sg_cpu->saved_idle_entries = idle_entries;
  	return ret;
  }
-#else /* !CONFIG_NO_HZ_COMMON: */
-static inline bool sugov_hold_freq(struct sugov_cpu *sg_cpu) { return 
false; }
-#endif /* !CONFIG_NO_HZ_COMMON */

  /*
   * Make sugov_should_update_freq() ignore the rate limit when DL
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index c6d86e4da8a9..878aca904f5c 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1329,22 +1329,6 @@ ktime_t tick_nohz_get_sleep_length(ktime_t 
*delta_next)
  	return ktime_sub(next_event, now);
  }

-/**
- * tick_nohz_get_idle_calls_cpu - return the current idle calls counter 
value
- * for a particular CPU.
- * @cpu: target CPU number
- *
- * Called from the schedutil frequency scaling governor in scheduler 
context.
- *
- * Return: the current idle calls counter value for @cpu
- */
-unsigned long tick_nohz_get_idle_calls_cpu(int cpu)
-{
-	struct tick_sched *ts = tick_get_tick_sched(cpu);
-
-	return ts->idle_calls;
-}
-
  static void tick_nohz_dyntick_stop(struct tick_sched *ts, ktime_t now)
  {
  	tick_nohz_forward_last_tick(ts, now);



Two other behaviour changes, besides short idle:

- CONFIG_HZ_PERIODIC kernels: the hold was compiled out there (no
   NOHZ counter).
- idle injection (play_idle_precise(), drivers/powercap/idle_inject.c):
   it runs in an RT kthread, not the idle task, so injected idle no
   longer releases the hold.

I have been testing this in QEMU with fake cpufreq and cpuidle
drivers as no real hardware with per-CPU cpufreq policies yet.

>>
>>   kernel/sched/cpufreq_schedutil.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>> index 14405a614991..50249cc1a594 100644
>> --- a/kernel/sched/cpufreq_schedutil.c
>> +++ b/kernel/sched/cpufreq_schedutil.c
>> @@ -397,6 +397,9 @@ static bool sugov_hold_freq(struct sugov_cpu *sg_cpu)
>>          if (uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)))
>>                  return false;
>>
>> +       if (!tick_nohz_is_active())
>> +               return false;
>> +
>>          /*
>>           * Maintain the frequency if the CPU has not been idle recently, as
>>           * reduction is likely to be premature.
>>
>> base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
>> --
>> 2.43.0
>>


-- 
Thx and BRs,
Zhongqiu Han
