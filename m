Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E634637C0E6;
	Fri, 18 Sep 2026 02:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789697396; cv=none; b=rP4yrxjcAb8UdChBf/PXqkjO7DKluwhkFgbJRHMrEQ0tQ7FgnAda6h3nc7qZ/oxCS/6RUEZgSZaO4hm1rMpbAlnPfvi0ov6uC5EzP/WY1MvnkahUBsQrpN2QwwAq1wbgRamsQcZzl7GRwzdooZ//NkE4Bll3asCvYIdko6rCeo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789697396; c=relaxed/simple;
	bh=9AHFymcEggm+eyJveZpNlt5t1uo2n8bwwiI4sgXhx3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWflCfuG891zq/6vNNHN3UFmPaRvghpp3BjHDk5ZrDAJvXYnMl84OJ3KCpEjc/zFhEXMTwO+da0KMECS6XQaYSQA9ZH0TOr2kCuRY1WXLWOdEodEawG5WiStHkBfwKuPStKattOUZ7jsXnzdDhfqM9VBILMItaXO0CxrE6SZZ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 03860222b30611f19a56ed5b684f684d-20260918
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:4490f51b-738c-4009-861a-383ba5e4a6ab,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:d737a891d5fcc2ca218761711a6b65d2,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|50|99,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 03860222b30611f19a56ed5b684f684d-20260918
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1573458098; Fri, 18 Sep 2026 10:09:43 +0800
Message-ID: <b81b66cc-1761-4653-9cdb-c8a8286718bf@kylinos.cn>
Date: Fri, 18 Sep 2026 10:09:26 +0800
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
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <1789693766158145.347.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2026/9/18 03:34, Rafael J. Wysocki (Intel) wrote:
> On Wed, Jul 29, 2026 at 8:16 AM Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:
>> cpuidle_governor_latency_req() is evaluated on every idle-state
>> selection.  It aggregates the per-CPU resume latency with the global
>> CPU latency and wakeup latency QoS limits
> True.
>
>> by repeatedly calling
>> get_cpu_device() and pm_qos_read_value() cpu_latency_qos_limit()
>> cpu_wakeup_latency_qos_limit().
> I would say "every time" rather than "repeatedly", but fair enough.
>
> However, those functions don't do anything expensive except for
> defensive checks that can be omitted.  Have you tried to omit them?
I haven't tried that, but I found that function_graph may introduce measurement errors, especially for very short functions.
>
>> Use ftrace's function_graph, we can see:
>> parent:          do_idle
>> parent_total_ns: 36671010505
>> parent_count:    5994
>>
>> SYMBOL                                                      TIME_NS    %ROOT  %PARENT      COUNT
>> --------------------------------------------------------------------------------------------------
>> do_idle                                                 36671010505  100.00%  100.00%       5994
>>   cpuidle_idle_call                                     35566528731   96.99%   96.99%       8570
>>     call_cpuidle                                        35476606844   96.74%   99.75%       8561
>>       cpuidle_enter                                     35472932468   96.73%   99.99%       8526
>>     cpuidle_select                                         52097031    0.14%    0.15%       8580
>>       menu_select                                          49555181    0.14%   95.12%       8580
>>         tick_nohz_get_sleep_length                         28843887    0.08%   58.21%       8570
>>         cpuidle_governor_latency_req                        9567488    0.03%   19.31%       8580
>>         tick_nohz_tick_stopped                              2057031    0.01%    4.15%      15695
>>     cpuidle_reflect                                        11427201    0.03%    0.03%       8561
>>       menu_reflect                                          6579506    0.02%   57.58%       8526
>>         tick_nohz_idle_got_tick                             2231559    0.01%   33.92%       8526
>>       __sysvec_apic_timer_interrupt                          105520    0.00%    0.92%          3
>>     tick_nohz_idle_stop_tick                                8279641    0.02%    0.02%       1475
>>     ---- skip
>>
>> The majority of the time spent in cpuidle_enter for CPUs entering
>> idle state has already been charged to the idle path. Among the
>> remaining contributors, cpuidle_governor_latency_req() accounts
>> for a non-negligible portion of the overall latency.
>>
>> Under the menu governor this shows up hot: ftrace data shows,
>>  cpuidle_governor_latency_req() accounts for about 19.9% of
>> menu_select() time (~1.9 us/call).  After caching the aggregated
>> value per CPU and invalidating via QoS notifiers, that share drops to
>> about 4.2% (~0.3 us/call), roughly a 6x reduction on this path.
> Is there any real-world workload in which that difference is actually visible?
Sorry, I only tested it under no load.

>
>> The ftrace data before and after the optimization is shown below:
>> 1) original
>> parent:          menu_select
>> parent_total_ns: 160492937
>> parent_count:    16718
>>
>> SYMBOL                                                      TIME_NS    %ROOT  %PARENT      COUNT
>> --------------------------------------------------------------------------------------------------
>> menu_select                                               160492937  100.00%  100.00%      16718
> Where did you lose menu_update()?
Because menu_update() was optimized away by the compiler, it can't be seen in /proc/kallsyms, so it won't be traced by ftrace either.
>
>>   tick_nohz_get_sleep_length                              100262940   62.47%   62.47%      16698
>>     tick_nohz_next_event                                   67891299   42.30%   67.71%      16689
>>       rcu_needs_cpu                                         2825649    1.76%    4.16%      16689
>>       timekeeping_max_deferment                             2380377    1.48%    3.51%      15296
>>     hrtimer_next_event_without                             17865162   11.13%   17.82%      15296
>>       hrtimer_bases_next_event_without                      2707631    1.69%   15.16%      15296
>>       _raw_spin_lock_irqsave                                2461132    1.53%   13.78%      15296
>>         native_queued_spin_lock_slowpath                        177    0.00%    0.01%          1
>>       _raw_spin_unlock_irqrestore                           2364647    1.47%   13.24%      15296
>>     can_stop_idle_tick                                      2906072    1.81%    2.90%      16698
>>   cpuidle_governor_latency_req                             31988150   19.93%   19.93%      16718
>>     get_cpu_device                                          4122502    2.57%   12.89%      16718
>>     pm_qos_read_value                                       3427318    2.14%   10.71%      16718
>>     cpu_latency_qos_limit                                   3005804    1.87%    9.40%      16718
>>     cpu_wakeup_latency_qos_limit                            3005475    1.87%    9.40%      16718
>>   tick_nohz_tick_stopped                                    4551981    2.84%    2.84%      29496
>>
>> %ROOT = share of menu_select; %PARENT = share of immediate caller (inclusive)
>>
>> 2) post-optimized
>> parent:          menu_select
>> parent_total_ns: 55428604
>> parent_count:    7626
>>
>> SYMBOL                                                      TIME_NS    %ROOT  %PARENT      COUNT
>> --------------------------------------------------------------------------------------------------
>> menu_select                                                55428604  100.00%  100.00%       7626
> And here?
>
>>   tick_nohz_get_sleep_length                               37464607   67.59%   67.59%       7544
>>     tick_nohz_next_event                                   24076913   43.44%   64.27%       7522
>>       get_next_timer_interrupt                             16332381   29.47%   67.83%       5854
>>       rcu_needs_cpu                                         1489633    2.69%    6.19%       7522
>>       timekeeping_max_deferment                              870851    1.57%    3.62%       5586
>>     hrtimer_next_event_without                              6140153   11.08%   16.39%       5586
>>       hrtimer_bases_next_event_without                       979000    1.77%   15.94%       5586
>>       _raw_spin_lock_irqsave                                 808786    1.46%   13.17%       5586
>>       _raw_spin_unlock_irqrestore                            785518    1.42%   12.79%       5586
>>     can_stop_idle_tick                                      1583137    2.86%    4.23%       7544
>>   cpuidle_governor_latency_req                              2321119    4.19%    4.19%       7626
>>   tick_nohz_tick_stopped                                    1863015    3.36%    3.36%      12751
>>
>> %ROOT = share of menu_select; %PARENT = share of immediate caller (inclusive)
>>
>> This series:
>> - patch1~pathc3: Add QoS notifiers-related infrastructure and updates to
>> latency_req_gen.
>> - patch4: Implement QoS constraint for cache-aggregated governor latency
>> - patch5: add latency_req QoS idle-state selection test
>> - patch6: add idle-state disable selftest
> So this adds two per-CPU variables and a ton of extra complexity to
> optimize the case in which the majority of the governor computations
> aren't actually done.
>
> I'm totally unconvinced.
I agree, it doesn't seem worth the effort.

>
> Thanks!
