Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441BB4E56C7
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789733289; cv=none; b=UoZvKuk0LitD39UU7CTn2pW5vueju8mJK3HARttaVDFAt1j99U67WDMtPyrFYQr/+1DY1KARw5BK4PWPss8y12RB+S0OxTlCkSwdy40weh1uTW2P915r3CTdhc9GYvA5e0GU+FH2e0PiqkPDnPASgwP4yzMCrbjMIH1MO2tWM8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789733289; c=relaxed/simple;
	bh=p8677V3MNviT9RpmlPVL8IWVx2X1Sk5Mo2vNOPX1nS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0iOOSYVhffwxIUWS3InapbYZBCrOOjX9kJGdRQBemDo+FMZ2odFSGUPDpOpgiSuue+nnqV+wxjxf9gwlQTq2RRfSfzNWYqwHaNryt8a/4PAj4icUHVQyb69HNCSuLzL/HSXVdSSZivGRng5tLUBTF3XH/j5MkoBPkhOCtyQyBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjVNhA32; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjVNhA32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50BC1F0089C
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 12:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789733286;
	bh=6bCNP0fuzxBayz3qns/DQBASbYRYkmJcvdx/H3OlAZA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PjVNhA32tHo2bLdixN3XqeQkmgh8JKL3CEqXcIK79uns1UmDlI3ng27qd2nyjWx2F
	 f2juVqFDJChfE+Wz1X+IpcEWPULBLMdK3sI6bSKTbbVJByKaR0sJIp8/2ScPwUv2pg
	 DmORGxCb2suz8BVQX57UuyuGoL6SeCXxEmETOVH9xXThHAnclVTd9Bjl10IdDXxCgP
	 aDMBpvUN81mt4+LPJ7Bz6NzuFYgi49dEnqUuzV3KjUNFP0l5JT4jzDWz++Q3Wn6mut
	 A4KcmbWELip3oJ0FdU9zcZmZ3oEos3tjMOgCNv5nc5fc7gqta/uGUGPgzmqJHt6ITK
	 s2HRXbBrPatIA==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a49c068e85so5451691fa.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 05:08:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByztJf67us7t9ebv8Px1VniurlAfuSLfkLja2aA01Vf5DNzqp7N93roivfjyey0xtKMU6x0KHcUTw==@vger.kernel.org
X-Gm-Message-State: AFuF++khA5bKH+1c7oNcel7CTaBURx+c+OlvtVz8Px5rll+s3w30GoNC
	Cjzx4WODmIS4IxUwjSjcO8ghZd25u4wo//e6sD+F6rDC4YmF80lfd75JTZQM1Bh0SZ34bsMbIJf
	mSLA2EqnXF9fCI9bi4TtlaylrlW9ueGk=
X-Received: by 2002:a05:651c:509:b0:3a5:d0ad:999d with SMTP id
 38308e7fff4ca-3a5fc0e9b0bmr4267041fa.29.1789733285206; Fri, 18 Sep 2026
 05:08:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729061549.13419-1-tianyaxiong@kylinos.cn>
 <1789693766158145.347.seg@mailgw.kylinos.cn> <b81b66cc-1761-4653-9cdb-c8a8286718bf@kylinos.cn>
In-Reply-To: <b81b66cc-1761-4653-9cdb-c8a8286718bf@kylinos.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 18 Sep 2026 14:06:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jt+V0cLvfU1Z1XKLiuywXGN0=gVzwSWHxqEh7-fY=Kow@mail.gmail.com>
X-Gm-Features: AcwNN1Xmo6yoYXNqLDquZ9vhUfUADswqFIUmbPmLr5V58dT7Jv5qMVAZX7xSZsM
Message-ID: <CAJZ5v0jt+V0cLvfU1Z1XKLiuywXGN0=gVzwSWHxqEh7-fY=Kow@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] cpuidle: speed up do_idle() by caching the
 governor latency QoS constraint
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, daniel.lezcano@kernel.org, christian.loehle@arm.com, 
	lenb@kernel.org, pavel@kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 4:09=E2=80=AFAM Yaxiong Tian <tianyaxiong@kylinos.c=
n> wrote:
>
>
> On 2026/9/18 03:34, Rafael J. Wysocki (Intel) wrote:
> > On Wed, Jul 29, 2026 at 8:16=E2=80=AFAM Yaxiong Tian <tianyaxiong@kylin=
os.cn> wrote:
> >> cpuidle_governor_latency_req() is evaluated on every idle-state
> >> selection.  It aggregates the per-CPU resume latency with the global
> >> CPU latency and wakeup latency QoS limits
> > True.
> >
> >> by repeatedly calling
> >> get_cpu_device() and pm_qos_read_value() cpu_latency_qos_limit()
> >> cpu_wakeup_latency_qos_limit().
> > I would say "every time" rather than "repeatedly", but fair enough.
> >
> > However, those functions don't do anything expensive except for
> > defensive checks that can be omitted.  Have you tried to omit them?
> I haven't tried that, but I found that function_graph may introduce measu=
rement errors, especially for very short functions.
> >
> >> Use ftrace's function_graph, we can see:
> >> parent:          do_idle
> >> parent_total_ns: 36671010505
> >> parent_count:    5994
> >>
> >> SYMBOL                                                      TIME_NS   =
 %ROOT  %PARENT      COUNT
> >> ----------------------------------------------------------------------=
----------------------------
> >> do_idle                                                 36671010505  1=
00.00%  100.00%       5994
> >>   cpuidle_idle_call                                     35566528731   =
96.99%   96.99%       8570
> >>     call_cpuidle                                        35476606844   =
96.74%   99.75%       8561
> >>       cpuidle_enter                                     35472932468   =
96.73%   99.99%       8526
> >>     cpuidle_select                                         52097031   =
 0.14%    0.15%       8580
> >>       menu_select                                          49555181   =
 0.14%   95.12%       8580
> >>         tick_nohz_get_sleep_length                         28843887   =
 0.08%   58.21%       8570
> >>         cpuidle_governor_latency_req                        9567488   =
 0.03%   19.31%       8580
> >>         tick_nohz_tick_stopped                              2057031   =
 0.01%    4.15%      15695
> >>     cpuidle_reflect                                        11427201   =
 0.03%    0.03%       8561
> >>       menu_reflect                                          6579506   =
 0.02%   57.58%       8526
> >>         tick_nohz_idle_got_tick                             2231559   =
 0.01%   33.92%       8526
> >>       __sysvec_apic_timer_interrupt                          105520   =
 0.00%    0.92%          3
> >>     tick_nohz_idle_stop_tick                                8279641   =
 0.02%    0.02%       1475
> >>     ---- skip
> >>
> >> The majority of the time spent in cpuidle_enter for CPUs entering
> >> idle state has already been charged to the idle path. Among the
> >> remaining contributors, cpuidle_governor_latency_req() accounts
> >> for a non-negligible portion of the overall latency.
> >>
> >> Under the menu governor this shows up hot: ftrace data shows,
> >>  cpuidle_governor_latency_req() accounts for about 19.9% of
> >> menu_select() time (~1.9 us/call).  After caching the aggregated
> >> value per CPU and invalidating via QoS notifiers, that share drops to
> >> about 4.2% (~0.3 us/call), roughly a 6x reduction on this path.
> > Is there any real-world workload in which that difference is actually v=
isible?
> Sorry, I only tested it under no load.
>
> >
> >> The ftrace data before and after the optimization is shown below:
> >> 1) original
> >> parent:          menu_select
> >> parent_total_ns: 160492937
> >> parent_count:    16718
> >>
> >> SYMBOL                                                      TIME_NS   =
 %ROOT  %PARENT      COUNT
> >> ----------------------------------------------------------------------=
----------------------------
> >> menu_select                                               160492937  1=
00.00%  100.00%      16718
> > Where did you lose menu_update()?
> Because menu_update() was optimized away by the compiler, it can't be see=
n in /proc/kallsyms, so it won't be traced by ftrace either.

How could it be optimized away?
