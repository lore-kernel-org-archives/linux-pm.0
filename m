Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C7E54707C
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673745; cv=none; b=ZFNIIchGejivTh5k2+bQWHJ3br9dKsj+kG6eCwBhr5h9OlRVvuDAmu46xBxgZQ4rgZwEI83cKyraka/FYE6rIjKlZj4HMh2zDgNplqMttyR8LgkGNF4W3JTweLWQHJE5l3TocaBL274aqMgyZ98sFPnBl6xDa4ugUc35PEWm54c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673745; c=relaxed/simple;
	bh=CFbJiR+V6GoupLt9b/9ikjwGkfcFR3qlMuOgtlHDU6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QU2Dx6GxB9rsR4mKqOxU9i5QqdMqlCrjC194DRH/qoHyf80vpulSZdhnsw+EU3fRMEuMVaplPltXpgSJXwQYLdCPmoeOSDwxbaT0d6YK7tRoiR+2n90iWWy0H34Byd0YHeCkIluOBDwdHlqy2ZEQXCi0uFOGK+eACd7v4gbf2WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVL6Vt27; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVL6Vt27"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042971F0089D
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 19:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789673744;
	bh=3a9FjfFkPEGSCX372g1imqPw8idUvhGgu5KPAwR8rKE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NVL6Vt27Edo/gnQShR2JzSRyrdEffclsbWg48H2x33Sk9wV1iaLfZRJ1MFsD8gtug
	 I9o2MtLeiPJ3QUQPkZqwwdz9tfqDdHRVh6z/qJUTLqWpTcxAIbI/u4I4bjR7NmsfWR
	 Ui30j3BAEYmPVhSbA6oSRgsIo5WtUEYXJ3+tJUbJ3aKq6fgo6HlYG1UjEgyTrFg5rJ
	 Is01Rxk5yMOCOIMwrcnx8MAHPi4xOVszR7x1BmzAVBIRRxg7vuiFAhUYub9Dq6jcg9
	 5ebeggvj+W+56sLcILaeLZMxwSYkrN1MVZnMZiiXbwiKooq9FL8axCtnUjLRCOm1VK
	 T6c28dxUsoajQ==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f18010so1031865e87.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 12:35:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwO2zxJ7UNJSxpjM8iKP+oTm9xo+QdHFhY3tT5jowgQ1PmxNuwgRjR//bUOGMtbJXDir3umdJmMvw==@vger.kernel.org
X-Gm-Message-State: AFuF++mnS7Zi65O98WrXMIF41ikrLpp97cZXFTLcCnedZZztbbOQ7hky
	4DeKADtgRsqk1QufyrrK1PeJzfbVwwu1FBbF1+3J9MYatIV0lvUCifoc1ovhjqVdduKGm1PpDv5
	/87fuIUDnXpT4hTpax+4SmMfrFaOIPbo=
X-Received: by 2002:a05:6512:3b90:b0:5b8:b428:4abb with SMTP id
 2adb3069b0e04-5b8b6612144mr2409946e87.9.1789673742273; Thu, 17 Sep 2026
 12:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729061549.13419-1-tianyaxiong@kylinos.cn>
In-Reply-To: <20260729061549.13419-1-tianyaxiong@kylinos.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 17 Sep 2026 21:34:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jbOz=vdxrLQTOrM=iTL-+n0KioCvN0Y9XNoFcnj5ETZQ@mail.gmail.com>
X-Gm-Features: AcwNN1XWajak3BVQusHHcAXgW7Pb_sHWQ7is5G5UHOuR4DJVyjca-MmiBMcS2q8
Message-ID: <CAJZ5v0jbOz=vdxrLQTOrM=iTL-+n0KioCvN0Y9XNoFcnj5ETZQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] cpuidle: speed up do_idle() by caching the
 governor latency QoS constraint
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, christian.loehle@arm.com, 
	lenb@kernel.org, pavel@kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 8:16=E2=80=AFAM Yaxiong Tian <tianyaxiong@kylinos.c=
n> wrote:
>
> cpuidle_governor_latency_req() is evaluated on every idle-state
> selection.  It aggregates the per-CPU resume latency with the global
> CPU latency and wakeup latency QoS limits

True.

> by repeatedly calling
> get_cpu_device() and pm_qos_read_value() cpu_latency_qos_limit()
> cpu_wakeup_latency_qos_limit().

I would say "every time" rather than "repeatedly", but fair enough.

However, those functions don't do anything expensive except for
defensive checks that can be omitted.  Have you tried to omit them?

>
> Use ftrace's function_graph, we can see:
> parent:          do_idle
> parent_total_ns: 36671010505
> parent_count:    5994
>
> SYMBOL                                                      TIME_NS    %R=
OOT  %PARENT      COUNT
> -------------------------------------------------------------------------=
-------------------------
> do_idle                                                 36671010505  100.=
00%  100.00%       5994
>   cpuidle_idle_call                                     35566528731   96.=
99%   96.99%       8570
>     call_cpuidle                                        35476606844   96.=
74%   99.75%       8561
>       cpuidle_enter                                     35472932468   96.=
73%   99.99%       8526
>     cpuidle_select                                         52097031    0.=
14%    0.15%       8580
>       menu_select                                          49555181    0.=
14%   95.12%       8580
>         tick_nohz_get_sleep_length                         28843887    0.=
08%   58.21%       8570
>         cpuidle_governor_latency_req                        9567488    0.=
03%   19.31%       8580
>         tick_nohz_tick_stopped                              2057031    0.=
01%    4.15%      15695
>     cpuidle_reflect                                        11427201    0.=
03%    0.03%       8561
>       menu_reflect                                          6579506    0.=
02%   57.58%       8526
>         tick_nohz_idle_got_tick                             2231559    0.=
01%   33.92%       8526
>       __sysvec_apic_timer_interrupt                          105520    0.=
00%    0.92%          3
>     tick_nohz_idle_stop_tick                                8279641    0.=
02%    0.02%       1475
>     ---- skip
>
> The majority of the time spent in cpuidle_enter for CPUs entering
> idle state has already been charged to the idle path. Among the
> remaining contributors, cpuidle_governor_latency_req() accounts
> for a non-negligible portion of the overall latency.
>
> Under the menu governor this shows up hot: ftrace data shows,
>  cpuidle_governor_latency_req() accounts for about 19.9% of
> menu_select() time (~1.9 us/call).  After caching the aggregated
> value per CPU and invalidating via QoS notifiers, that share drops to
> about 4.2% (~0.3 us/call), roughly a 6x reduction on this path.

Is there any real-world workload in which that difference is actually visib=
le?

> The ftrace data before and after the optimization is shown below:
> 1) original
> parent:          menu_select
> parent_total_ns: 160492937
> parent_count:    16718
>
> SYMBOL                                                      TIME_NS    %R=
OOT  %PARENT      COUNT
> -------------------------------------------------------------------------=
-------------------------
> menu_select                                               160492937  100.=
00%  100.00%      16718

Where did you lose menu_update()?

>   tick_nohz_get_sleep_length                              100262940   62.=
47%   62.47%      16698
>     tick_nohz_next_event                                   67891299   42.=
30%   67.71%      16689
>       rcu_needs_cpu                                         2825649    1.=
76%    4.16%      16689
>       timekeeping_max_deferment                             2380377    1.=
48%    3.51%      15296
>     hrtimer_next_event_without                             17865162   11.=
13%   17.82%      15296
>       hrtimer_bases_next_event_without                      2707631    1.=
69%   15.16%      15296
>       _raw_spin_lock_irqsave                                2461132    1.=
53%   13.78%      15296
>         native_queued_spin_lock_slowpath                        177    0.=
00%    0.01%          1
>       _raw_spin_unlock_irqrestore                           2364647    1.=
47%   13.24%      15296
>     can_stop_idle_tick                                      2906072    1.=
81%    2.90%      16698
>   cpuidle_governor_latency_req                             31988150   19.=
93%   19.93%      16718
>     get_cpu_device                                          4122502    2.=
57%   12.89%      16718
>     pm_qos_read_value                                       3427318    2.=
14%   10.71%      16718
>     cpu_latency_qos_limit                                   3005804    1.=
87%    9.40%      16718
>     cpu_wakeup_latency_qos_limit                            3005475    1.=
87%    9.40%      16718
>   tick_nohz_tick_stopped                                    4551981    2.=
84%    2.84%      29496
>
> %ROOT =3D share of menu_select; %PARENT =3D share of immediate caller (in=
clusive)
>
> 2) post-optimized
> parent:          menu_select
> parent_total_ns: 55428604
> parent_count:    7626
>
> SYMBOL                                                      TIME_NS    %R=
OOT  %PARENT      COUNT
> -------------------------------------------------------------------------=
-------------------------
> menu_select                                                55428604  100.=
00%  100.00%       7626

And here?

>   tick_nohz_get_sleep_length                               37464607   67.=
59%   67.59%       7544
>     tick_nohz_next_event                                   24076913   43.=
44%   64.27%       7522
>       get_next_timer_interrupt                             16332381   29.=
47%   67.83%       5854
>       rcu_needs_cpu                                         1489633    2.=
69%    6.19%       7522
>       timekeeping_max_deferment                              870851    1.=
57%    3.62%       5586
>     hrtimer_next_event_without                              6140153   11.=
08%   16.39%       5586
>       hrtimer_bases_next_event_without                       979000    1.=
77%   15.94%       5586
>       _raw_spin_lock_irqsave                                 808786    1.=
46%   13.17%       5586
>       _raw_spin_unlock_irqrestore                            785518    1.=
42%   12.79%       5586
>     can_stop_idle_tick                                      1583137    2.=
86%    4.23%       7544
>   cpuidle_governor_latency_req                              2321119    4.=
19%    4.19%       7626
>   tick_nohz_tick_stopped                                    1863015    3.=
36%    3.36%      12751
>
> %ROOT =3D share of menu_select; %PARENT =3D share of immediate caller (in=
clusive)
>
> This series:
> - patch1~pathc3: Add QoS notifiers-related infrastructure and updates to
> latency_req_gen.
> - patch4: Implement QoS constraint for cache-aggregated governor latency
> - patch5: add latency_req QoS idle-state selection test
> - patch6: add idle-state disable selftest

So this adds two per-CPU variables and a ton of extra complexity to
optimize the case in which the majority of the governor computations
aren't actually done.

I'm totally unconvinced.

Thanks!
