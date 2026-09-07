Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C6A26AF4
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788820041; cv=none; b=ZiyV0ndOhfaQEECbLNhjODylj9CJD1Txarjz4glO1XTyJwObvqwX2rKoiFFHSR0sS8SAPDBxCaNlwj6+VWZaj+N1ArOvGhjXigVBYPQDMUD7Y/4yMLJIFsgxBBXl9XfinW8qk03hIyE8AjATkVhy6vkScQR13USzNpr+nmUG3PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788820041; c=relaxed/simple;
	bh=w089gXyEOCJY9gUZSUVwdihbdEuqGTphnzmTU3c5wIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aj8YFFAGt6jQCNZhbXYCvdggae9JIEEYNpLLiNMKoqmRQ1njCW4Xq1qh85sHm60xj+LU155FS+dJb2VAXgHmRSTYOxWd3EqI+bYD61hVEsqEtOmiEsNyJ9MsiNXfr9q8l+7XHBXIXiwKQhUbzYMWrt2UYDsjZ2F9QpVsTgK43YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gaVEiIr+; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gaVEiIr+"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c0c45c580so43905381cf.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 15:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788820038; x=1789424838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=voF+0uPdvqMWSZZsE3DB359nSHA2KdFl0fM0Svv/P2k=;
        b=gaVEiIr+tWszuP7yIhlBLyyh6/EQoRUbXiocZyOvHCAyBAuFNw4GjNq+ApFupWmr+O
         +tDD4hPSE0KEVpVFxDgs2hlVMnH1STJdy/eJU1jdZzOxgpd3KhkSPxtbMxAeux4ifkJj
         dOgDQjsDRKYUGY83uMid7eSJa1jVyw8TBHH/DDUJC6VYhuPT7QNQmV+is1/w9MxWB06L
         /vIil5JV+IF72ZbJZw8oKRphab6uPo5BZN6FIITg8v049OxKRawJ4GU2ukGXiu/xBflG
         ehUOPG5JWTfgduNbsO32bN/kw2Jv9lVlhfbTfLG7myRDbuVZOHJn8mctdilaaubRODmi
         GRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788820038; x=1789424838;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=voF+0uPdvqMWSZZsE3DB359nSHA2KdFl0fM0Svv/P2k=;
        b=OL1aY86dHbiMxEhuupSOLcYQ64SQ81Gu6UE3ucX6sK6j0AWw2EkA09e5icGaxB45LP
         d1XtuozKGRhO6TJpi6ftKKi+CUseFunXT79G5lVrTQ3m8U5+r79T0+8Gf8eYJy4Eh2eK
         IH/PHlmivZo9ToPc1KYbCh5hd+JuTAzKUUB4ERUKyl39DBSWcF9d1UrJAuCVTtjOJkP0
         3DW5CgGHSsiXWEN4at01idIZOw2dNvcEH0fRi+53BrMxdybqCvS6gbT7Uduqm6a1zKV7
         CQw2kaEz9Ss3FZE5e9NSJ94yhPq2w1c+Dozxdq0tuRY6IkjeoR4Y/7YqlHKTkye4oFgu
         P2oA==
X-Forwarded-Encrypted: i=1; AKwUvByLpRw7tYgvRbUvzQ5wKVwRq1480eiW16geHutclHo6hezg3qkAY7U8d1bGHuXPeC34rTk+bF6jjA==@vger.kernel.org
X-Gm-Message-State: AFuF++kH8OpICvAdBCI1+sXefeb6AJ2fq4sExanbMAiV1yUtQ0VubudN
	UJe8df7OioRsx0isktfD34Vix4W2P5O7fbeJevn4JPoOdiMSAaFOgTzCUugmX8ag/iE=
X-Gm-Gg: AYBFou1lglvFl6LZh6jRi5kydHa7KLesCNKLfyvvoXzG4TBdNlvw8rAeRmBtq5EOzEj
	UoTDCXhFVvLunA9s1UlAsCcwjdjQMmpvL8VpePIg7JKl7i1eYvQSTyQlIxnOBBYfoC11/1BeO6K
	wuekbTzEzwjbb42/8C2cJo3wQsucAq1DKXhxQmyY9Cq56+HCejg0nZZtfBM3d6D09c9vWDe5aq3
	/4JiTHA5pCTeg5lXh9fI/kI5AWYHvvAkdt70lQ9389sezapjE95Cfb3KmTg9JXafp64tJbEqUFE
	TArG8sDwvTPG8JLv280w/g0/KBzTAlCBELvJb0k/o8+LkajOn8z/hsqnqQknLFfonyvpPrVDh4H
	jSlBFxvLXtpvI0pKcOnU2bWLAt/LsCqh0wPJjOYVx3SmwTEs9Y8hoLTAmJ3RKPO30o1qB74ERcS
	t2A/fblqKs8i/fGcZvM5cHdmkyuLqKy64ykYYqwH0Kkge1okYy49tz8AMohjJcw4Iwk4eZ+d2up
	s5kI6A/tFyjBY3bgqLMju4yvWHX60O8w+ILKmAPIi+4
X-Received: by 2002:ac8:594c:0:b0:52f:b1b6:a4aa with SMTP id d75a77b69052e-530547fb02fmr300586681cf.4.1788820038503;
        Mon, 07 Sep 2026 15:27:18 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53080ce82aesm39676931cf.31.2026.09.07.15.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 15:27:18 -0700 (PDT)
Date: Mon, 7 Sep 2026 18:27:14 -0400
From: Gregory Price <gourry@gourry.net>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Ye Liu <ye.liu@linux.dev>, Thomas Gleixner <tglx@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Ye Liu <liuye@kylinos.cn>, 
	Michal Hocko <mhocko@suse.com>, mic@digikod.net, david@kernel.org, linmiaohe@huawei.com, 
	nao.horiguchi@gmail.com, gnoack3000@gmail.com, ljs@kernel.org, sj@kernel.org, 
	rientjes@google.com, shakeel.butt@linux.dev, xu.xin16@zte.com.cn, 
	chengming.zhou@linux.dev, tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pavel@kernel.org, 
	lance.yang@linux.dev, pmladek@suse.com, longman@redhat.com, 
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, qiang.zhang@linux.dev, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com, 
	babu.moger@amd.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 5/8] kernel: convert process/thread iterators to
 for_each_*_rculock
Message-ID: <ap83lNf0bUXX4ZS8@gourry-fedora-PF4VCD3F>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-6-ye.liu@linux.dev>
 <ap7dC-LWNaoPYJvv@gourry-fedora-PF4VCD3F>
 <ap76-0-hN6CAcYXX@redhat.com>
 <ap8mgnpE7D4TTrno@gourry-fedora-PF4VCD3F>
 <ap8yoW37GY17pHYS@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap8yoW37GY17pHYS@redhat.com>

On Mon, Sep 07, 2026 at 11:54:41PM +0200, Oleg Nesterov wrote:
> >
> > This might be my - admittedly shallow - understanding of scoped_guard,
> > but does scoped guard handle goto correctly?
> 
> Yes, it does,
> 
> > and why it's generally discouraged to mix cleanup.h and goto.
> 
> Hmm, why? I didn't know...
> 

one of the reasons to use cleanup.h it is to eliminate the "goto
for exit cleanup" mechanism in the first place (says so in the first
paragraph of cleanup.h).

Later in the header is explicit says don't mix:
 
 * Lastly, given that the benefit of cleanup helpers is removal of
 * "goto", and that the "goto" statement can jump between scopes, the
 * expectation is that usage of "goto" and cleanup helpers is never
 * mixed in the same function. I.e. for a given routine, convert all
 * resources that need a "goto" cleanup to scope-based cleanup, or
 * convert none of them.

This particular patch only does a partial conversion - so it's a
bit of an anti-pattern.

Reading up on scoped_guard a bit more it seems you're right it handles
the issue to jump-out, but i can see why cleanup.h says "don't do that"
because it's confusing to look at / hard to reason about.

~Gregory
