Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A113F3203B4;
	Sun, 20 Sep 2026 01:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789867608; cv=none; b=PKlfrode5GwJ21a1hD2rl19xAUJdx5Wh+nTmY1D+9IUAKYLA3jbhbZFoZcaciaY3mOQISwHjAg4/ACRY/wz1LnWRV3xFeCDtX5Hl+rlTLkUk+pTxFfhOTh9NGEu2tHdCqNB8czp35dNw+BsuJ34ewszbKdyAWwcWVICQb1uRF6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789867608; c=relaxed/simple;
	bh=hQ2YQtKo+lGFX5pz4R9iNvjn2ddTKSsWKeIbp79soKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOQX+Fcbn6vxBCgPd2FgjnSF9dDlI311/+Ux9gwoSO/6cIXIF3Qk8OI9HAJNo6IfyvC2JgdsIVEcg1JPHdXv/q/If7WpXTu6ac+/XYiuyKQPfZqfvXiw73W+y6Y9vI9rGikcC47ZPuwNDaA/J9dr9LQBHdlZ7ENEBgSDeFq+OUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 53c3b2a6b49211f19a56ed5b684f684d-20260920
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:663688f7-5d7c-4453-8f6e-b72763eef6d6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:173d2fe8b43c80a999446499db76668c,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|50|99,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 53c3b2a6b49211f19a56ed5b684f684d-20260920
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1775970865; Sun, 20 Sep 2026 09:26:38 +0800
Message-ID: <ac745597-8a43-43d0-b468-07896c3ac9a9@kylinos.cn>
Date: Sun, 20 Sep 2026 09:26:35 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] cpuidle: speed up do_idle() by caching the
 governor latency QoS constraint
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: daniel.lezcano@kernel.org, christian.loehle@arm.com, lenb@kernel.org,
 pavel@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260729061549.13419-1-tianyaxiong@kylinos.cn>
 <1789693766158145.347.seg@mailgw.kylinos.cn>
 <b81b66cc-1761-4653-9cdb-c8a8286718bf@kylinos.cn>
 <1789866017803592.362.seg@mailgw.kylinos.cn>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <1789866017803592.362.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2026/9/18 20:06, Rafael J. Wysocki (Intel) wrote:
> On Fri, Sep 18, 2026 at 4:09 AM Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:
>>
>> On 2026/9/18 03:34, Rafael J. Wysocki (Intel) wrote:
>>> On Wed, Jul 29, 2026 at 8:16 AM Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:
>>>> cpuidle_governor_latency_req() is evaluated on every idle-state
>>>> selection.  It aggregates the per-CPU resume latency with the global
>>>> CPU latency and wakeup latency QoS limits
>>> True.
>>>
>>>> by repeatedly calling
>>>> get_cpu_device() and pm_qos_read_value() cpu_latency_qos_limit()
>>>> cpu_wakeup_latency_qos_limit().
>>> I would say "every time" rather than "repeatedly", but fair enough.
>>>
>>> However, those functions don't do anything expensive except for
>>> defensive checks that can be omitted.  Have you tried to omit them?
>> I haven't tried that, but I found that function_graph may introduce measurement errors, especially for very short functions.
>>>> Use ftrace's function_graph, we can see:
>>>> parent:          do_idle
>>>> parent_total_ns: 36671010505
>>>> parent_count:    5994
>>>>
>>>> SYMBOL                                                      TIME_NS    %ROOT  %PARENT      COUNT
>>>> --------------------------------------------------------------------------------------------------
>>>> do_idle                                                 36671010505  100.00%  100.00%       5994
>>>>   cpuidle_idle_call                                     35566528731   96.99%   96.99%       8570
>>>>     call_cpuidle                                        35476606844   96.74%   99.75%       8561
>>>>       cpuidle_enter                                     35472932468   96.73%   99.99%       8526
>>>>     cpuidle_select                                         52097031    0.14%    0.15%       8580
>>>>       menu_select                                          49555181    0.14%   95.12%       8580
>>>>         tick_nohz_get_sleep_length                         28843887    0.08%   58.21%       8570
>>>>         cpuidle_governor_latency_req                        9567488    0.03%   19.31%       8580
>>>>         tick_nohz_tick_stopped                              2057031    0.01%    4.15%      15695
>>>>     cpuidle_reflect                                        11427201    0.03%    0.03%       8561
>>>>       menu_reflect                                          6579506    0.02%   57.58%       8526
>>>>         tick_nohz_idle_got_tick                             2231559    0.01%   33.92%       8526
>>>>       __sysvec_apic_timer_interrupt                          105520    0.00%    0.92%          3
>>>>     tick_nohz_idle_stop_tick                                8279641    0.02%    0.02%       1475
>>>>     ---- skip
>>>>
>>>> The majority of the time spent in cpuidle_enter for CPUs entering
>>>> idle state has already been charged to the idle path. Among the
>>>> remaining contributors, cpuidle_governor_latency_req() accounts
>>>> for a non-negligible portion of the overall latency.
>>>>
>>>> Under the menu governor this shows up hot: ftrace data shows,
>>>>  cpuidle_governor_latency_req() accounts for about 19.9% of
>>>> menu_select() time (~1.9 us/call).  After caching the aggregated
>>>> value per CPU and invalidating via QoS notifiers, that share drops to
>>>> about 4.2% (~0.3 us/call), roughly a 6x reduction on this path.
>>> Is there any real-world workload in which that difference is actually visible?
>> Sorry, I only tested it under no load.
>>
>>>> The ftrace data before and after the optimization is shown below:
>>>> 1) original
>>>> parent:          menu_select
>>>> parent_total_ns: 160492937
>>>> parent_count:    16718
>>>>
>>>> SYMBOL                                                      TIME_NS    %ROOT  %PARENT      COUNT
>>>> --------------------------------------------------------------------------------------------------
>>>> menu_select                                               160492937  100.00%  100.00%      16718
>>> Where did you lose menu_update()?
>> Because menu_update() was optimized away by the compiler, it can't be seen in /proc/kallsyms, so it won't be traced by ftrace either.
> How could it be optimized away?
Sorry, "optimized away" was a poor choice of words. Nothing was removed
- menu_update() still runs, but the compiler inlined it into its only
caller, so no out-of-line body is emitted. No body -> no function entry
-> no call fentry site in __mcount_loc -> no kallsyms symbol -> nothing
for function_graph to trace. GCC can do that because menu_update() is
static, has exactly one caller (menu.c:228) .
