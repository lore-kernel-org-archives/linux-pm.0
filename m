Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795593564;
	b=DLbBXf2zVRLlL9DNMw7PppAhMR5hWzgjxptcrXZQsqkHofvfZS6yme5NnTBqS2Midsm4
	 ofy+MV1FcrtdZy5JktwUjPO+qPYUZcVJHgyDr7qVc45bdSNBQpJsNb01INB6mAtWbIX64
	 siDH8m7902LimF941kHFhSHydfmcPXz4dSeAXsmYgAksgz1la91SCQJZXk/C9F5hONEKy
	 bZ9lfcEjRYFSWXiWAgxtJSjuHKywfhoK3t4JWl4ehXqP7Piz1z/+u5hr7ashGS+hut3cL
	 C4a2Pmk3Rp7hntDtzVgoNC39VL5D2cfUWSl4dggLdiLHAoRXg/8sSHDf9VaOuuXry8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=lPt1APWAuM+EKrwwPM+5moxwmnQPMXvp+cSe81HAQX0=;
	b=HQv1BqEhiB0sJISwaEHnMy/mDd+GdR2s0n3Pxy0moA1c3ZPgFivik1meaNev76QblY95
	 1jZW4YeeMvZzNAn51VzlI8Ts5IYZxTDjStC3/DMO1vFv/3/wcuM0rq5QQ+gS62lqenwDK
	 U6wUyx+F0rB4h/IupdopoN6vI5h3WLmctdiRl4DTyEEB1isG+HplmYoHHRFE8Lk3v6LFy
	 qzsREYY/U5ISG1iZkNpa2TDFBRl3wkbD5FOF5rKE90MGigAHPQj3FeVeoOzeZ+qdNNeBP
	 Gr/6HNsor9iKrfVbJOtHgmnNOJYLbo7xPl/MCQ3qS9Kf6y1cACHERtT+jqbEASk4svQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pc7WeAg3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9112B606A323
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 07:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9112B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pc7WeAg3
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b87408c797so7396103a12.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 23:59:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795593563; cv=none;
        d=google.com; s=arc-20260327;
        b=eUxfWFTF7Kb4g+nrh6Bmy4jrieL17BBH0/a3C/oAFNhDtJYI5vgtbgCGjSjK8VUYpN
         uc5qLoSMA+g6elG/betW13pz0VZeNQNSehC2nFxQBKWvA8dDlDp4jlLnK9XGW60NLAEO
         PmPvFtKwUTlE44zmmYrmEKt+e0VS7S2ql34W6owcWIxd5GKhL085YP8A952r1RZDx4oY
         M6Fy9+ZcRIyzNNTx3GEQTbPZYUmB3Dc9phVU7s0hroHOsPKo+t62pcdvy6Mo/p6FUhyN
         TZT8cLhjGneQ58omeWIkUprz4/x2TNqmPBgaySbELbwwrr/1DJSfx+fMsa22wNvWyF+U
         D9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lPt1APWAuM+EKrwwPM+5moxwmnQPMXvp+cSe81HAQX0=;
        fh=iQ+ej+0bwVsKlr5Zy2S1v2ySPONUYd4K5NdbiUB/Z8o=;
        b=CB2VpRyZmxOT73hrxlJFZ4tRfpFsddlkuSEywCIVItyL7lAHevOMxAfAwzJsnRRcLD
         jTzsLIlZa384TzbFHOdx7O9M9ZSWkqFhEVLW6BiOQ+kE543lJIgQekjLeA1NS72noDLT
         IsB+A/FMcWY+x4dRo68aC/ZPVRWxeP0z3mPNi2eTbxoAaAsysNnQ1SmxmOeT1IZHVqGe
         ivXGrbiVOcLqyb5Y1AwgrlmiXJ4JidNZLoKpps1xS8H7MtQ30HCsy03d6w6lcPMNJm2m
         bXx6Rxs+NxrsAXQUJfmR1cNBX2r60JkwXHQ2XMxjMH0xsmUsT/UkJYkzUz3i5gmaqsl0
         T8wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795593563; x=1796198363; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lPt1APWAuM+EKrwwPM+5moxwmnQPMXvp+cSe81HAQX0=;
        b=pc7WeAg3PFpolsGeh7V8GC2dhbxFBLdAcrs7u6ZPkIeaUJf1R6Fw3I/CyF+FdKcBWk
         2D138Ya8HiMVieQLfnW3JVJ692QehF7L8UAguWp8cjsVxzcggC/FYDrIN+CvVsyXc8iS
         hQmcWHvqy4QoR9DFn50U7SbhAUWOLNmTtiaB1yyjAW0+X4mDK5SY1nFGpeFPIy7g//7T
         RhxJDU5e8wPQBYjdyFVFY7yir1OEosiVnYUV0FHMaqbH4OQrEYF//B9PL2hEuaTLfYq+
         W/vHLCDVfH0ZyMViirkpyNhNVwKkmsPVWYYLjVkOhgBjXwTW5c50jsezU2pivEuzd1hF
         POrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795593563; x=1796198363;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lPt1APWAuM+EKrwwPM+5moxwmnQPMXvp+cSe81HAQX0=;
        b=kJnE0k/FHp4NWygyKJBHMtyGZGdy0DWSdmqn9E/xnAIbHw01DOFUq6Ve1BmTZ5NFWi
         5ehln7oRhAvbaPaAFJPttWXicUmCS7tT5hs1EJ13aUC+UHYbCvYP6iALM/uXkqnAsm6r
         9CNt0+lmetf6E5DvhLxIEZxB57UOpdQLZc8pcONoivumW4c93zXHjMFvryNtwhyPWDd+
         Z/KmApG11N//f39LaH5KIVgY91lSdFXNAITywBwS3MqFnPy778WL5ZiZXqgi1/hGAdSS
         7QN6rzFBM+OCjgh30Xh84iyqbKTkE7fQNibrJWdo30N5g8l2EkZvLkm4S0A0M5NGIG2h
         +AMw==
X-Forwarded-Encrypted: i=1; AL+hErG82BmslT/t2LctmlnJ0tH+1mSyHtdQaEFEq1dSRONNHOVgkvQrg7NwJLwss0piZrq5zfIPi5RdGg==@vger.kernel.org
X-Gm-Message-State: APuU4Z82VGkvZH0iYpXJ5p0ynh1w2OQknjb4CLGjprTe5Zoma+Ckwx2D
	HIFAiRzlLzLGpxdqXbLyrNGjVin75T7FA0clDX7/GX7EJ4p8mWrMwPEyIVT1NAtoPmTfEWqzwBk
	BiX85mYiopuj3Ve911AGbujF59Gj7Lfm3m2kA9clxKg==
X-Gm-Gg: AZFdTZdhsLRWkB55Dn0YtKaM0uHqe1tAF4PPQ04yHQCGiJ5nsPl3u1KkJkJz35BnCj9
	QKqD5/PAxyRmnmOanSv0Xb7LxDjUcCkH+jRqcDKzZ8P6IjTxAFDG1H3p02QwiJ6xdJG1gKIe6cc
	bB3olKQKEQkShPRDXAgpNLR1byk2f4jRZRhoJcA4OaYjLaH+UCvbsNraSb6kpFuHLWlCrf1PoE1
	gfnYiNgYYLSum4FTJ9AiJPj5tNJGpcgmUBSknAqQj6vBCOQOf+iDzESZsFs7qy+/VB+9k9UuPD6
	NOYdQvnB2d/hLDzsMpQOoLFmvoUHzuqJR55fpuT2aadxmwedfUx/VLOtWqGOz03PC9JOIyt2WZk
	79SGy06bUqANDY4h00AFIu9ELSztmXPmFU84+d0m09NRgWCZufqDcq+xS0u66+7rSJ9Y=
X-Received: by 2002:aa7:d94a:0:b0:6b4:2960:d38e with SMTP id
 4fb4d7f45d1cf-6ba37e874dcmr9501044a12.26.1795593562901; Tue, 24 Nov 2026
 23:59:22 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106151947.3991524-1-vincent.guittot@linaro.org> <20261123140513.849567-1-qiliang.yuan@linux.dev>
In-Reply-To: <20261123140513.849567-1-qiliang.yuan@linux.dev>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 25 Nov 2026 08:59:10 +0100
X-Gm-Features: Aa3M54p2o-4OXRV5MRF0nedJcIovnM36DUkkwJL8BE3h8cyZzFyeML394K6ItNU
Message-ID: <CAKfTPtAN0K0Ly1tM-2R=-9qLx=Nh5p9+GHeqRLHy-nbeAxZU0Q@mail.gmail.com>
Subject: Re: [PATCH 00/18 v3] Improving latency of short slice tasks
To: Qiliang Yuan <qiliang.yuan@linux.dev>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, kayracizmeci@gmail.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Qiliang,

On Mon, 23 Nov 2026 at 15:05, Qiliang Yuan <qiliang.yuan@linux.dev> wrote:
>
> Hi Vincent,
>
> On Fri, Nov 06, 2026 at 04:19:27PM +0100, Vincent Guittot wrote:
> > The 99.9th percentile are a bit worse mainly because of the decay/reset of
> > positive lag. Eternal positive lag was beneficial for cyclictest which
> > doesn't do anything while running and slowly decrease its large positive
> > lag.
> [...]
> > The test were run with the default 2.8ms slice to check for some
> > performance regressions
>
> I ran the series on a fully loaded and an overloaded server-style
> topology, to see whether the push path costs anything when every CPU is
> busy. Guest with 32 vCPUs on an EPYC 9654 host, set up as 2 sockets x
> 8 cores x 2 threads so that it gets SMT, MC and PKG domains, on

Thanks for testing

> tip/sched/core bfee16fd01d4d (patch 10 needed task_tick_scx() to take
> the new rq_flags argument to apply there). The four kernels were booted
> in turn, 3 rounds of 3 runs of schbench -m 2 -r 20 each, median of 9:
>
>   workers  metric              base   +01-04   +01-15   +01-20
>        32  wakeup p99 (us)     3116     4648     4648     4632
>        32  request p99 (us)   34368    25568    25952    24992
>        32  rps                 4327     4907     4898     4919
>        64  wakeup p99 (us)     5656     7736     7640     7688
>        64  request p99 (us)  194304   162048   161536   163584
>        64  rps                 2507     2532     2529     2532
>
> The wakeup p99 increase, +49% at 32 workers and +36% at 64, comes
> entirely with patches 1-4; adding the push patches does not move it,
> while request p99 improves by 16-27% and throughput is the same or
> better. So with every CPU busy I see no cost from the push mechanism
> itself, only the lag decay effect you describe above, which here also
> shows at p99. hackbench (4 to 32 groups) and tbench (32 to 128 clients)
> with the whole series are within -5%..+3% of the base.

Yes, clearing or decaying positive lag softens the capacity of a
sleeping task to preempt at wakeup; that's why you see an increase in
wakeup p99 but an improvement in request p99 and rps.

The push feature doesn't impact your figures if you keep using the
same slice for all threads.

>
> Thanks,
> Qiliang
