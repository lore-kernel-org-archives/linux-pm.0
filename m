Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710863E16AE
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 21:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782335053; cv=pass; b=VaRQ0Eaulxrgt4CcNjNG7YYQ2PqX0ZJofAoao2t0+G+AkURvBvp1KrASW7ycAOceEuajZhyFQY7MgjBGf0xp2WodIgK1TliNMCkCXTwg33HU+xp9U4rUycYcPcYYdG8FMRiHIP0SGw/QvBKQJ9Vi4H0bD8z6zZ071j18tgkQ61w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782335053; c=relaxed/simple;
	bh=to37Cn07ZVKNQBHS3sjMVRa5Ugz7FYZWzqJpz60TV6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8+it/FaFiC6F95VPiIW28Gl5vBhJZxawg+cxulUV5vO4oq/sdek2AV19qSpiJ1v1imS19y7ojB2v7126Jx18ne5oA1FW2J4y4Y2JPg8iKfKnHmdrLB6hK2sFwteqo0m35czxUsgXiGtfq35bJoZ/GzyB9yb0ROAhM1ZUERT2IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N60Nv2sc; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N60Nv2sc"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c0115a3794bso283113766b.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 14:04:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782335051; cv=none;
        d=google.com; s=arc-20240605;
        b=jx4tERfWXFFMCtFjDmz7pNbK5a6DA1B4SWt2lcDblTrATZez6Tz2o7fD4ldIgMR/ro
         BInjDcOLB0FqJehlPeO02H4jfhB5YQqF172tyHeHYj5Gu+piVdA/jh+qm3M3tbwXbc1o
         TeablaeKJ8b1XqSxuTNaiYTQ90v2FR+P/hvyoxJDByiBphG6gfL4p8Tpdc7FvP9JjFN9
         ZlUetPNuKNwot4Ik3qZyTgqjalRq1wdkISfVux9MXAXfMw0j3gIhHSPrC94ad4pyn9Y4
         tSFDjPAdvUsJu3ZSJ5wzpJ8gH9qUNSTjOG+Lq8nzOQIHOJv1dPrJLaeHDvkrO3VLTA/n
         SPFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=to37Cn07ZVKNQBHS3sjMVRa5Ugz7FYZWzqJpz60TV6M=;
        fh=4tLHi5GSD2PJFcLaVcoXuaQz92BgJAvBkQNdHwV5FRk=;
        b=EJq8Q5cW6dWzihWZXru+Ta8Yj5DVIGzIHs4dapKYu6+P4gmFvo3UDDCLfjad3J95sz
         PUZ7qGOBuuZv3qhxlx28a/9WR6lvY0xr7ptHafb5GB8H7wZmoyoUQIwdDWTVKrd13777
         6xCyIaY1eSQGoSGz28GcRVY7uLQZ47DigZj6UX2GBZdDk44FnYBQNFczXWLp2cnAK3jN
         dfeATqCuTyGnJV8oKpOJT66aRN3EJO5n/S4UEe5k4tJ3EBBuichnEG8WGQ+UIHDA2Wwj
         3GoP291Qg7j0yH64fqigQvVORhud0L1QSul9i8wAajX+haQzYHWVHkyS49cpAG4m8Ecf
         qH5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782335051; x=1782939851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=to37Cn07ZVKNQBHS3sjMVRa5Ugz7FYZWzqJpz60TV6M=;
        b=N60Nv2scEuhTdjMQhWA/rVxzjSr/0fCkOx2cz7OaooaoH0YPKWht8ZZRrnGOyGAsD6
         NLk65HCJbxx12bVWUwah8sdpP1NY32afiSJ1opA8bPx9E/YdK5hmoxk8GeR0gzdZ2ULo
         5/A+jMUQv6Y1tRq0eR9Ug9wU32dk5e634voJd0dQ7wtFp4Y8C4GV0vmA5yRjFsJY3t7e
         dhZVOoCuUeV+Jjj46Bun32aMM9j6y0QbsTRlcB4w0ED/mf2aIkMRaQn/5zfjekP3arHJ
         5E8nBC4RrhfsuiTQspUiXg+8iGrXauInDYT3l2p5BGq6wu3fuxxs8hezt78FnZW3Qbka
         q9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782335051; x=1782939851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=to37Cn07ZVKNQBHS3sjMVRa5Ugz7FYZWzqJpz60TV6M=;
        b=gmVkzdbmWb3fOKQI27kalXARNF0jkbBPqrYRYOlq+s8dSDHLA/a38Xe3LkOEkav0rp
         WCYKPLoCXQBtNLJJgP3JSYNC9v138PD+wyZm1WCrdPI9kwNz5ctjVfs4IlneVg98OR1Y
         QeGSiW27W/ohlfij2StPOiOKsglfa+KDo6FqFU2xABXgW4gPkQ1ie4/qMpxzktrybUy3
         nyOsSTHS+9kCa9UddCz+YjU04zHLNAu28oRg9v1eSPBogRoaivm/UH7zbV9wMPgEKoL4
         imCd/iGlZOWJWnd4NKPHSFxbHaQ/s4dypsJEkjtEmoTV+uM1TYhlNepYqjhZsOC4Q+a4
         V79g==
X-Forwarded-Encrypted: i=1; AFNElJ+pHo5vXWAJ+cWvyBE5SBAK3cuBfVsDAoBTYjsR8DKuXRhhGIHrBX6gwyVBHnQcq170yOGw7ROakg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+sOSvjkKmKWJ6nrtakSsTz4xv+U6e5pH1GI/iuQmLdARyCsl6
	QKA87a+UiLj7MEJI5kbaTBTeJkcEWJESR0UlzCbgBw+KAD1TkA5bFeumOXPw9vV3C/aNyoalTjK
	r4RLEcasubiNLqqHyBuRTgFizAkpRiLQ=
X-Gm-Gg: AfdE7ckxpHbE2lm2Su5Q64VVLTuTKRcX7gMenz6eiTdXYglwl9iKdDio3XhpmUyxme0
	iGsXwQ+xTxC9UUtJX5ZkMxGAPU476s3XD4hknZnDHpWcEXWiIiRO0XGzZ+Aopru+W3u/ELvAdty
	rxgUnsjeG/ltYnoGJxk+vQOCY6ANfijF3d2KQw9kNovoQH1zl+x7fF7ZLMTwEQOXUTg0z5zF5nJ
	JjRNZtPkLfshLcHHTOZhHFGhgJfnOCPktmGkc4aw91GC1MooXgqtZZGn0b1pF7qenl9G4moKw==
X-Received: by 2002:a17:906:2091:b0:c11:f5dc:20f with SMTP id
 a640c23a62f3a-c11f5dc0530mr112556566b.31.1782335050642; Wed, 24 Jun 2026
 14:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611204658.47987-1-elazarl@gmail.com> <20260624203147.67528-1-sivany32@gmail.com>
 <f623e4c2-0007-4dca-a263-04f258e4f207@oss.qualcomm.com>
In-Reply-To: <f623e4c2-0007-4dca-a263-04f258e4f207@oss.qualcomm.com>
From: Elazar Leibovich <elazarl@gmail.com>
Date: Thu, 25 Jun 2026 00:03:58 +0300
X-Gm-Features: AVVi8Cfs2TsKCXtmn3EqiTiaTtKd32d3czJdPJ5mXf-5RvoafwrBhfhGs8QaQqU
Message-ID: <CAHNTFm+3TdAzNUpEb6sZ6kx+i1XmcgWDufa+MPJnMtD32VgAAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] powercap: dtpm_cpu: Guard em_cpu_get() against
 NULL return in sysfs callbacks
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: sivany32@gmail.com, linux-pm@vger.kernel.org, rafael@kernel.org, 
	daniel.lezcano@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jun 2026 at 23:44, Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
>
> Can you provide a script or a recipe spotting these issues ?
>
Thanks!

I'll describe the thought process.

In 46dc57406887 we found a single instance of `em_cpu_get()` without a
NULL check even though it can return a NULL. I think the catalyst was
seeing that this function could return NULL and not seeing NULL test
on a call site.

After some discussion we concluded that when a CPU becomes impossible
`em_cpu_get` can race and dereference a NULL pointer theoretically.

While we acknowledge this isn't a huge issue, a NULL test in a
non-critical path doesn't seem like a huge issue either.

We grep'ed the code for other usages of em_cpu_get, and traced the
calling process to see if they can race a CPU becoming impossible.

(While looking at the code, we noticed the rcu does not guard the PD
pointer, but that's for another WIP patch)

I'm not sure if that's was the question, but we used AI to:

1. Trace the possible call stack of a function. It did a tremendous
job there. Faster and more precise than myself, seeing through
"vtables" and describing the callstack correctly.
2. Find similar cases of RCU used in the kernel, and try to imitate
the behavior (for the not-yet-sent RCU WIP patch)
3. General kernel chores (find maintainers list, running sparse, etc.)
4. Create a reproducer for the RCU race to test it on a VM.

Let me know if you want more details!
