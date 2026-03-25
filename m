Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72804308F38
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774470243; cv=none; b=TxNQoRx6Nn4yqOkstr/+G/Y5jKNsOamhjjEFJPZIK+i5oyrlMCmwVVTyvgJ8qCtAnKf3fyqwVQPw0Y2wZR5xvSqO9wHgLx8+KQ7k7jTDpxdMFT/6mELsbpnKbPE8M9TZxmKoHoM3AamgKtcs27okk4Ef9zdXUZoGODh4v0YdQMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774470243; c=relaxed/simple;
	bh=yLQmvGZ9qUpeV/RlqPnpEBWWJVhN3ND5IbWmVgrZ9hc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q50B+9Jg8KUDjwPo9oaoWT2FPE9RrHssAsuO0E4ZuLzVa+M70pX8FtOJmtj+6nSE4wv3Viayo4VbSh8mT6H+qY1ou9RwNcfIJ/WHioRecoGBBoyVr0+KiyVk2zyOBRgtCIzvpt0Bl6gcIFy19ZIq60kzerRCnHmaXZQDy/R6K3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ud6j+46n; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud6j+46n"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso3028435e9.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 13:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774470240; x=1775075040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXPaSk6rOeSHzsuBeOwJ4iqoWQAtJOAov6388j1L0Ko=;
        b=Ud6j+46n3VJTG/W17THyEbW2e7ncYy5oZMQV/zIS4NWA6K41fRt8pGOa0mZHDls0Ho
         tAnoqx818c1OPDdszo6POX6hDOYA5MArxKOD2ks9ohbhzsbtLhMB5E0f48+qcmtHQXdB
         cc5+wW5wrEN449Uvk6PsvIiXxs65BeCk8dbppKk6rhVegLfzFq2mWRvqCt5WfZhDis6z
         YYIJMMc4+ONjPnmSe+46jOZZsxQDb42mcXES6s7IRWpwHayST7GJxYc2Iat7rCJmgwoh
         wdrKmBfOo3Zvu8butllgBCGlzd7zAlmaEKqr+RaBLjpIuaVI+C/Acsezbh155UecLcaG
         gqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774470240; x=1775075040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gXPaSk6rOeSHzsuBeOwJ4iqoWQAtJOAov6388j1L0Ko=;
        b=QTRcIuwNnQ7rZOLasZoOyToQEr79wTHix2eFtWWSFQFgjaQmYH98s8e7ZoZAbIJ8Vd
         mKsu/PXM8s+WCuOMp1TzOpfNNVgvhGtbFlOnzvGnwTBFHVR77/q5i/OAVaXxQCkY9e5Y
         x6O2SmAMyMOmCghzK7P4IXuL2BcI96um+WxrGFNFdrUUnAoCQZ1hBT9Ko3nOA0CQ5ULi
         5pm7HhpBNz69xkO8qxi8K88+M0ckyRu7v2jmBpxSfV0zCkUR/aTKSHU4E1SLD8oqXqn4
         J/SolnEh+TLXFAVCMRb/PTgFK688JJ9TkoIxWPgUB1qJeUmh9iMBTe9cPlhgsKG5Gmx9
         3j5w==
X-Forwarded-Encrypted: i=1; AJvYcCWr0N+mwzdNkqPhbBqkGUIKQm0/IDBifdTsQ8iySY81yNVvK57LhGQ6j5Ka5C3q6oTo0KLW4VdgYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhwIP0eYeA1Ze2apJ5a9NdVBb/5u4lqu9Ya2wlh3+j8wdQ8S/s
	8DYZE548JUdLkFsKr+TV/C/Bp5f01kzJJff49MxERWL0Zd3AJR+W28JT
X-Gm-Gg: ATEYQzxRDaHfMvszRyT8UvueU06LhDWtfeGoiUqrEGgu7it5gQabQqW2VpzPJKQpyaW
	2jpVEuR//xjpZbHE1SsVmjsN1dLiXyeANVZgFPiqEWpT4qrM6TkUef2G6m7Wz1d7FIwXKUl9Er0
	e3tOuVL5/JZzPaKctkUFMmzcFPQgpewhzlUoju1Du5hlpbKlUYFr3Fz0h2L7U194QJNRL4aLDTd
	TTiFzmvChd36jmbd5hwtJ+SB+afDZpCHwocoC17TqpmJQsgsk7MNYWQkV3mzoFwpha48SVlJnHJ
	RvqWHgynixlwKwqr9Dvq8x1jQ8TNqjxAcUaeIDWPwFZQuqZW8MgnUmPG3qVYphKFwil6Z5z7vSt
	Qg5DHpUwupiuMQq7MOz0rJhFHa/a8Gq3oQqussIc/kXRBVncwJObpeHW+hfJIkOO9dtGMQxetbP
	/SE/1r8Xt6JKtVTUKhuKm9YicMOtcKsBCo+XLeaYRZjWKc6+U3Gfx1US3Uv02uQqqe
X-Received: by 2002:a05:600c:4685:b0:47d:8479:78d5 with SMTP id 5b1f17b1804b1-48715fc38e8mr75859145e9.7.1774470239711;
        Wed, 25 Mar 2026 13:23:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871fbca47dsm2239685e9.1.2026.03.25.13.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:23:59 -0700 (PDT)
Date: Wed, 25 Mar 2026 20:23:57 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
 will@kernel.org, peterz@infradead.org, mark.rutland@arm.com,
 harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
 xueshuai@linux.alibaba.com, rdunlap@infradead.org,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com
Subject: Re: [PATCH v10 00/12] barrier: Add
 smp_cond_load_{relaxed,acquire}_timeout()
Message-ID: <20260325202357.3e203314@pumpkin>
In-Reply-To: <acQOMZMk0OMfIgFO@arm.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
	<20260315184925.b6f93386e918ca79614843e3@linux-foundation.org>
	<874imftol4.fsf@oracle.com>
	<20260316233712.7cbfac27@pumpkin>
	<87ms07rlp9.fsf@oracle.com>
	<20260317091705.5a64fc56@pumpkin>
	<acPo7l_pd5rnHpSX@arm.com>
	<20260325154210.79a621df@pumpkin>
	<acQOMZMk0OMfIgFO@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Mar 2026 16:32:49 +0000
Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Wed, Mar 25, 2026 at 03:42:10PM +0000, David Laight wrote:
...
> > Looking at the code I think the "sevl; wfe" pair should be higher up.  
> 
> Yes, I replied to your other message. We could move it higher indeed,
> before the condition check, but I can't get my head around the ordering.
> Can need_resched() check be speculated before the WFE? I need to think
> some more.

I don't think speculation can matter.
Both SEVL and WFE must be serialised against any other instructions
that can change the event flag (as well as each other) otherwise
everything is broken.
Apart from that it doesn't matter, what matters is the instruction
boundary the interrupt happens at.

Actually both SEVL and WFE may be synchronising instructions and very slow.
So you may not want to put them in the fast path where the condition
is true on entry (or even true after a retry).
So the code might have to look like:
	for (;;) {
		VAL = mem;
		if (cond(VAL)) return;
		SEVL; WFE;
		if (cond(VAL)) return;
		v1 = LDX(mem);
		if (v1 == VAL)
			WFE;
	}

Definitely needs a comment that both 'return from exception' and
losing the exclusive access set the event flag.

The asm probably ought to have a full "memory" clobber.
Just in case the compiler gets lively with re-ordering.

	David
