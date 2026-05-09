Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137CE846A
	for <linux-pm@vger.kernel.org>; Sat,  9 May 2026 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778319560; cv=none; b=s8GM0wX6gX04B67IFep6jbD6ok4Umzns6B9r2jgL1Ki5+CMySaZOoLHNuhU37dCqDaZZVQvr2VkR4Dl8igLtob2/4Ah2BLBPsByUpQdVx0GuOMWvqBZRK1Q0li7FozN3tcZeZDLDOObY1i2ZNG+EKncctvakzETSuYxC/JPZ4Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778319560; c=relaxed/simple;
	bh=s59hq7ofQy10K5TAr45AegO8DqtMpdcwABj4ejLj+Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJ3oXw/KIfecrEjtqAmq0pNIAVeLIXQh3M8yc3BsbQ68pp/VB2joUEEX4zMJE2EPtpCnM0VRokiYNSBn2coEkqBRBT9SfYktzMc6HAzkAtZdMsQGIuRlTjSfxcqk0TbNVe0DxltBbEU6HZlBIUEgd5TweEyJq/3pdf98RHFqq4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=fdYx9MwV; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="fdYx9MwV"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bc3582acc23so418833566b.3
        for <linux-pm@vger.kernel.org>; Sat, 09 May 2026 02:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1778319556; x=1778924356; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hO8PVrigNakGtQ8OxMq5Ncf0k1CMm9+uGBhvQnIye7g=;
        b=fdYx9MwV9FljHsFtAH8PJvk3krTD24LfI3PKn0xADS1LCjPZuq47KEhuBRjRlPrLYx
         kipyzYxLfpfSIah05g5TfKDlHA8/EFa27KiTVLmvM7ssGucA4q9W40SUUde/CO4naT2f
         iZGCDX4zFlIWs3hOcmLnsxV8785mNgScOlDP9iuxVA4jy7WpKn5dKANuurctZ8hI8afZ
         HBf9NAefZNhtYwtGdjnovHr2qo8tjDj8vIjZFwRVOh1MBfsiAGpC0lokvPAwG9nzSncB
         vwFt6OSWEGQj3Rm7/Tr7k7v5M9bM+XGoNqLrmUkj9G1i2+RlGRb6umjBqaH95tCc0rQ5
         sSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778319556; x=1778924356;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hO8PVrigNakGtQ8OxMq5Ncf0k1CMm9+uGBhvQnIye7g=;
        b=Xg7ftMpRhwGNMHRJ7cWUNiWccRpIoM0Yz4Xfxx8cHfR2+l10yTZ/uKGoMBPuAP0A+3
         C7S6LT4MC8MyIeRYdpF/Umk1m+UaSuePbcPDufez2KC7XnV7PBtdfN/BAEwRthg5lgSR
         ZEbyqyzFyBRSkUJeB3cOuN/xRGTaB0VMyzXa+q+Se//dhA/yCewDlny9PMPg4vhhzCwI
         Kt9sEU1mkqoOSmL4adu5JKsGxyXCgA64pI0isF8MiQ3C6OvKKWccGmxSEXY5v0m8tzdU
         wngNfvVhi6Q0/KG8pnD0CodM/Qv5dFI3DGKPvxc3VadC1KmMILpb9LGZwLalV2cFYntw
         j3ig==
X-Forwarded-Encrypted: i=1; AFNElJ8B3SjLsJDAUpDOXQcLHgrst2uU+WssGJcTuzOoGR7S5djaAmTljyytecJyrxMkRo3WsuF+rJnxlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKwUjoDli3QU9I/WikcM8iiZGTXQiaZ+RZdCh4YmDZIPEiHBDz
	7jj9mTKLEDtmGCLjsNK1UgW4sGfoMANJZy36R6kz6znnEcgGfLWSvEW98RDPc5g74AI=
X-Gm-Gg: Acq92OHsccALII2mWDarCp+za6j3g27rcYuBc0crEejR0aZ/NufCm9TzpVAKiJpAv9t
	zqgUgpYJwwkVl5TG+BG3blKSYPeGHlxFPAST1SJK4Y84mDq68w2WCZdyNlDbZ8356QhYGBaKAwr
	KKW/iivXe/8n5RPoJpTCjcApVocJ3n4P/IwKPjAuX5T7QR4PFXdDg+CDfPUo7YREzehna+Ap0UN
	FaqvC3lKUYENIath1cB50MF1jEMlA9pGpiZVwxQGARiCmGFnr5DFaR5l5zVagGU+YpuygSKikWl
	FiihTIDFJ9vqp6QU6cjXJSSm7AQ5CJ/JrSLYTzXzIHEJUGCdpZKNhoPJmXJMqUqZkYI6s3K58ST
	ka2BbfqNDaiUsdpjXl/yv/kaKIVPUlxZaQOn018B9GBwKQlz2iv19KsnjPLsshRmMdPy/AHrvME
	ZYYC0wjGp1uqpjk12kWw==
X-Received: by 2002:a17:906:208f:b0:bc5:cff4:8e20 with SMTP id a640c23a62f3a-bc5cff4afa7mr670496866b.27.1778319555868;
        Sat, 09 May 2026 02:39:15 -0700 (PDT)
Received: from airbuntu ([146.70.179.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcbcd90cd1csm104922766b.60.2026.05.09.02.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 02:39:14 -0700 (PDT)
Date: Sat, 9 May 2026 10:39:11 +0100
From: Qais Yousef <qyousef@layalina.io>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Vern Hao <vernhao@tencent.com>,
	Vern Hao <haoxing990@gmail.com>
Subject: Re: [PATCH v2 RFC 08/13] sched/qos: Add a new sched-qos interface
Message-ID: <20260509093911.iwqkomyoapnlgmnn@airbuntu>
References: <20260504020003.71306-1-qyousef@layalina.io>
 <20260504020003.71306-9-qyousef@layalina.io>
 <2b9fd875df1f71d2c12c21938784a6c1fd38c04a.camel@linux.intel.com>
 <20260507095516.vv7blulzskkyezin@airbuntu>
 <615dfcf8-31da-4e65-8964-c39022b5a1b2@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <615dfcf8-31da-4e65-8964-c39022b5a1b2@intel.com>

On 05/07/26 22:20, Chen, Yu C wrote:
> On 5/7/2026 5:55 PM, Qais Yousef wrote:
> > On 05/06/26 13:38, Tim Chen wrote:
> > > On Mon, 2026-05-04 at 02:59 +0100, Qais Yousef wrote:
> 
> [ ... ]
> 
> > The idea is that the cookie is per QOS per process. So QOS_TYPE_A would have
> > its unique cookie range, and QOS_TYPE_B would have its independent unique
> > cookie range. To allow flexibility and extensibilty to describe independent
> > behavior that requires independent grouping.
> > 
> 
> From a user point of view, I can think of the following use cases for
> fine-grained
> cache-aware scheduling:
> 
> u1. A user wants to enable or disable cache-aware scheduling for all
>     threads of a process. (No extra tagging is needed.)

This is a special case of u3 where you say all threads are part of one group.
So tagging is required; to enable/disable you'll have to have a knob to switch
that behavior but you're deferring to the kernel to group, which IMO is
a problem to delegate to the kernel. More on this below.

> u2. A user wants to enable or disable cache-aware scheduling for all
>     tasks within a cgroup. (No extra tagging is needed.) Vern from
>     Tencent was advocating for this model.

Same as above. We can have a NETLINK to tell us when tasks switch group and
auto tag based on that. Although I am still worried that this is not a great
way to tag and should be based on process and task. But I guess we can try
things out and see what works best. According to the plan this becomes
a userspace (schedqos service) description problem rather than kernel
implementation detail.

> u3. A user wants to enable or disable cache-aware scheduling for an
>     arbitrary set of tasks. (Userspace tagging is required.)
> 
> If I understand correctly, u3 is exactly the use case where schedqos
> cookie can help. Under your design, we cannot tag an arbitrary set of
> tasks with the same cookie; we are only allowed to assign the same cookie
> to threads within the same process and under the same QoS type. So
> this might eliminate the case where different processes share data

Is this a real case? I'd really love to know more details on why. I still think
inter-process grouping is better done via cpuset as this tends more towards
a partitioning problem.

That said nothing in the API actually prevent us from adding
QOS_INTER_PROCESS_MEM_DEP tag and make the cookie global and unique. But this
will come with implementation challenges and complexity. As a starter I'll make
sure to catch and error on this case to not repeat latest tcmalloc mistake. If
it makes sense at anytime, it'd be a matter of adding new qos for inter
process support.

> with each other that we want to aggregate(NUMA balancing's numa_group
> is an indicator of tasks sharing data)
> 
> > > 
> > > We probably need a sched_qos_cookie structure defined analogous to
> > > the sched_core_cookie to anchor the tasks.  And sched_qos_cookie could be a ptr value
> > > to sched_qos_cookie, as in sched_core_cookie instead of it being a __u32
> > > as in the patch below.
> > 
> > As part of the API or internal implementation detail? I think we do need
> > a cookie structure that stores the sched_qos_type and sched_qos_cookie tuple
> > internally as implementation detail. But not expose it as an interface.
> > 
> 
> Yes, I think Tim was referring to the internal implementation. We need
> a pointer to link tasks to their shared sched_qos_cookie.
> 
> > I think the cookie values should be userspace managed. From experience, this
> > has to be done in a centralized way via a service otherwise you'd end up with
> > a mess. There has to be an all knowledgeable entity managing things, which is
> > what I am proposing in schedqos service. That's why the whole QOS now is
> > protected with CAP_NICE capability - which I forgot to mention this change from
> > v1.
> > 
> 
> Not sure why we do not leverage the OS to allocate and manage cookies.
> The OS has full visibility of system-wide information and can maintain
> globally
> unique cookies. Users only need to request the OS to allocate, attach, or
> detach
> tasks to an existing group without supplying an explicit cookie value.
> One possible reason I can think of: since the schedqos cookie is defined per
> QoS
> type and per process,it may be more convenient to manage it entirely within
> the
> schedqos service？

Because for kernel to manage the cookies it means it needs to understand all
the rules for grouping, corner cases and trade-offs. We lose flexibility of
adding new QoS easily since for each new QoS we need to nail down all these
rules and progress will never happen - or very slowly at best. AND the
scheduler will have more policy embedded in it that will make it trickier to
change and evolve code without breaking user space behavior since the behavior
is purely embedded in kernel space.

By delegating to userspace we remove all of this. We provide the mechanisms and
the trade-offs, grouping rules etc are all managed by an all knowing entity. If
grouping rule A is better than grouping rule B, we don't care. Even schedqos
service hopefully wouldn't care. It'd be a matter for each admin to specify the
grouping that makes sense to them in a config file and restart the service and
hopefully everyone will stroll away happy. That's the dream at least :)

Note users will still get an abstraction via schedqos, but this abstraction is
in userspace rather than in the kernel. I anticipate users will just interact
with config files to describe their cases.

And as I mentioned in LPC, we can easily add a new service to schedqos to help
admins find out which tasks are memory dependent and help them fine tune their
configs. Perf can do that, and writing a simple daemon that can help admins
monitor/profile a live workload and spit out that grouping these tasks based
on cache would be beneficial shouldn't be too hard. The process can be fully
automated too to change things on the fly if folks really want to.
