Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748854;
	b=mfPq+aFTji1M3A019HLcKhVVP3+529oBt0atw6vWwxxLsRC6kuZnl+tEFX0uNjA9afbg
	 QkAg2kbif2OV1+Nl1KuS0lSEuAG6mqm/quH9CXSfbshbECi/1yHmsA/U/M9qU1XBRkgAN
	 Q+SemnI9InpxuiVeXcrcXDYCpku3qSlxVNFNYbSNFM7+1gQkwH6HQQA8DEInwTaXz/fTr
	 KzLPQarchAqXg+ck5UgEDGO8HTeiQi4+SJYf1Te6JPXwhnqE3YhEUwbOXs5qMtNC9AYXm
	 i3gIIKnemoWlzpaXA8cYe2QlJE1kWC707FYJwUT2ik6iTdmq3+RSlPSzoev9ZNGuo7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NHa3SLlf+DLkC9TdarwfhodZoRfY5RS1Z5V6v7io5kQ=;
	b=5TvOwbO0HmY0x9aF0FX+b1DhKnmkbwPovMRRuB+1K1iiR70f0uR5Z734S7Wk/F9w9ptg
	 Jb3A8snAB9C7reX+mACI2bbvo405nLx5zKg5LHBMYHhXjQMtX++SKIPhyqhh9zkVJQehH
	 zMCKQirs8NsgnXrruejQ9b2Ka4nuEVTUudyAAeO2PKWADKupXzSwGsOkQmaMh218WIDSe
	 UNcXhAnTTfSPjJCwNvcjEtExmHa4gMwIfnFwl0a0HWb/uHY/ZOImCUatWWm569Ykntl7M
	 0sFcWbb7qFK0GmMBSEiOvJXoyhboZNpFeCMkQgMTBpDdNavK4CJC5KhfpM7Sd4GJzEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Efby7Hk4;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16C1606A326
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 23:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B16C1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Efby7Hk4
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a215e64962so766735e9.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 15:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793748852; x=1794353652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NHa3SLlf+DLkC9TdarwfhodZoRfY5RS1Z5V6v7io5kQ=;
        b=Efby7Hk4FTpj5p+/1I7YbLSnsWkC1Qyah8L4kteH5N15noZv+ZXiB5yrmesnrLQmxv
         7SPbzn+qf/z6E43zM/w8Re2N+0b9Ho9oHPbe3X1FoY9mBpjA0sATYEF4td+t7Nd9BjsJ
         gglVBdZ//AIOnYtuSphsIqL4z/mpMNDKUEBufV8BAovz+VXB+Xc0+Id0ZaMKWRthOuSz
         jivCKHO1zCDqculfTT18ac8R/FZWSOMX+Mzl4+GPX+YGftvS0WsoWm02S7qOrhvyFQol
         IhL4jN7Cl62XtDWI3ND17H+ygA0zghI+f46scTLuXXqgab+tEtwR5h/PeMYmNxWemdkb
         a8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793748852; x=1794353652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NHa3SLlf+DLkC9TdarwfhodZoRfY5RS1Z5V6v7io5kQ=;
        b=mdy0bskG2oTbspPdm/8hiDBWEmghhqxc0paCxS2qjGrug1UMVYm96jIBYSiFQfqSsL
         ZZg60lRGzrZjypHrRB8FW5/mKzFP9ytKYEJgIb6J2/0usMtQ1vOPgStCc41ZtkLITuV+
         LvifiA9WEMRn3I26OVNPQXVUe/s+50/NTxFzU/+t0s91cB7C3j7Qg19KTMJ7eHcOyMFR
         Jv9hlzT3EdCPUr59Rew+RrwGBNLtVQMg1b3f0RfhKwSuyYRFp6PuUOijUSl23RSHL7t+
         e67H0HLtQfVRWdABYOvbyMK5F54ofbaVy4SQwAatfqJMjFCguZSmL3Q6QX27IslXOtTQ
         bePA==
X-Forwarded-Encrypted: i=1; AKwUvBzjmoIMy2DAtzlIqvzGjsh9+2LBk/MHJOGkpxlY3z/LPMRKfxoEogWC2pGoMC4fsUqhz08fSDjKug==@vger.kernel.org
X-Gm-Message-State: APuU4Z94xkyqI32SX/KL1OV8ARcSEaTcH8w5tMn7mfgCIpHKb/iHurP3
	lT1u81CIY+T/D5E4Nr5aSqzPvnANSEbBw9SiTGB5KQTooRfUmFrjLuenh3a+WAUtQjo=
X-Gm-Gg: AYBFou3zXOImzD+8l+3kN+KkjmqorlexVzOLG2If1cJ2bqyfc8KZDTOlNtXJNfh76v9
	n7umEsQGTQJkdfX2BUIhMdNa1UYCRS4PXZn54q2SjjNyipAB9ojpqBWvTY6bI2c77SjCSTP38/4
	QYzrzJliGtHdmISZRKCuv9Gt1F8Gf0nWraGW5VHdsnNhPPQVHtk/aIpfDz5wg8kyeOVqwnk8kEV
	a+XRbgn6K90sWtk7ryKyXfvOl5BMw4rhsiQ/B1+mawZ37Re5Mqqnk2+qLuYzKvlb73PeN6hLf5N
	IMfdp1gkdAS5pmmj5ddKDPfKbfapJEsYImLXeDHia+RjVv/v8CpR8kGg0Q6a+LG/5xq68jSHigo
	rBgAu9pHWCPCK6fBqIyVm/wzJyBf3tvnHKeqwQn6omfPlVTp4eWA5HkDxJm7htnJYLxPvzesNr4
	opFx0Wo7zVKuEMd8cATK8LgaoOtbgFJaVIek7qSMVWzJr6w7QuC9D0JXa/K08UZe8dqc+PnE7Eo
	ND/4TUGraxe4OQMZjrD/Um7Q2PMiSvpxnLEhJM72AJV4DAO97L+qV6jVfWvBo/lC36JI0LBDFPd
	qCIHYy7HSYh5iNfru2g=
X-Received: by 2002:a05:600c:3f06:b0:4a1:e672:5721 with SMTP id 5b1f17b1804b1-4ac181e75c2mr359360955e9.13.1793748851968;
        Tue, 03 Nov 2026 15:34:11 -0800 (PST)
Received: from fedora ([2.35.201.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43c17ecb4sm9524955e9.3.2026.11.03.15.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:34:10 -0800 (PST)
From: Francesco Nigro <nigro.fra@gmail.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [REPORT] sched: ITMT + DELAY_DEQUEUE: woken task waits ~1 ms behind another task on the preferred CPU while allowed CPUs are idle
Date: Wed,  4 Nov 2026 00:33:52 +0100
Message-ID: <20261103233352.2282883-1-nigro.fra@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <25edb6cd36cb77b82b40826b97232438f1443516.camel@gmx.de>
References: <20261103154603.1893325-1-nigro.fra@gmail.com> <25edb6cd36cb77b82b40826b97232438f1443516.camel@gmx.de>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2026-11-03 at 18:27 +0100, Mike Galbraith wrote:
> Mmm, that's a be careful what you wish for thing.
[...]
> Not a keeper.

Thanks, that answers my second question for your patch; I had listed
it as earlier work on the same step.

The stalls in the report happen when both busy threads are on CPU 6
at the same time. What the report doesn't show is where the two threads
run the rest of the time. With ITMT on, both run almost only on CPUs 6
and 7, the two highest-ranked of the four: each starts about half of
its bursts on each, and under 3 % on CPUs 4 and 5. With ITMT off, the
two threads' main CPUs differ in every run (run 1: one thread starts
99.9 % of its bursts on CPU 5, the other 100 % on CPU 6). Per-CPU burst
counts from the earlier reproducer (asym_stack2.c), 5 runs of 30 s:
https://github.com/franz1981/itmt-delay-dequeue-repro/blob/49b6d72cb41d2535964c87a660178dd636d1d366/results-final.txt

Is it expected that ITMT keeps two busy threads on the same two
top-ranked CPUs, sometimes on the same one, while the other allowed
CPUs are idle?

Thanks,
Franz
