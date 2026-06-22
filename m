Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCCA348866
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782155035; cv=none; b=rBOgPzh2bLBtctne8aIgFt+elGr75eCF+xDBsN4exD7hWsECrzQVUYgEh00ebwres2d5DQVR9/WG7T6xf10r0M8xk/elqH6x3brr6yUXgu6gVXkUjSWI5rbGW5kN678UDfng4fxapgmrj/zjXFJHOxqDaj82OWuFKI3R+1Cgw1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782155035; c=relaxed/simple;
	bh=uM6rjwv+rWrcNEl8KjTKnVcDSG3oUNpsPUMqnFOcLeE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F8XfVL0JZ538CgPlZZ6gTwgXnmVB9ai4mZT3t1gMO6BPYUtw2388vIUWmpZznH1Dj0dJogIn7puvJzwM7ArdqI14JFbleRUG40v5PtlDBJDSbFM/mh/AiYWjjSf/czbsoV88jOVeZmoTT46RlJfsfymDWqgeShcCXivAPi2Q/gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFiZE21b; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFiZE21b"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30c0a352e33so197594eec.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782155033; x=1782759833; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uM6rjwv+rWrcNEl8KjTKnVcDSG3oUNpsPUMqnFOcLeE=;
        b=LFiZE21bJOd27mvhUeQY65zQorGfroSNylZhnl5pr3qjxqG/eN1p6cReYMi7Y8XHb0
         7P2yUKScTc7SL9KBMwdl8WT1nEKnGZf9ur45NKJJuEmRNsVr4TarSwghnJCBC39U5FT/
         hbLMbAuZB7Uhid7P768tqQ5oB5rNa0UgEghjqL8I6E/OiecFdkW7XXJUCVzAvM2Bcvqj
         aAAg70ofC8G+A3+uW7Vx2nk3e0tc12ATFJvEbWA6+4EjPe4CrUqJXP2Emg2HT57KZ67b
         LsX6aiKqdjYFThFXLMKvM5eHENHiOf+kS4D8rdkQabgcObx3aWN/R9FVWrU0LGgqTlRe
         mYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782155033; x=1782759833;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uM6rjwv+rWrcNEl8KjTKnVcDSG3oUNpsPUMqnFOcLeE=;
        b=pwpCKgcBGCcQyVV6S3+29Wq6hZY4rLbXpw6Tg6Q553Ik7IgoA9PVKsg2jr7BB5rXPy
         Ztp/kxrwBpMPeO6MfF1CAUS3dmQl3zBvpU6PRVeOndytUDzMNkGncq3qIvYjzXj9XdUp
         oTT6rKJyxSGaVhJEWoqrtEvIjOZ00I++AMGXJTr0MDl8fHFwRoN2wi719cYsDz9wiGPw
         ueRo0iZ9RXoZb7bmF0n8xgGFC6fMNA7Y8N/+BhKZyZj4pLvb0EC0qYtgq5lQXNyjxX0I
         pCF2kb1OQ43IOAjZR9p4vT1CYU/8/rzMpoCvxqXZj7Ge6/2N1mBBIqZIfE+WE0pBaM9l
         Yj5Q==
X-Forwarded-Encrypted: i=1; AHgh+RobfI0J8by9ZIkT+VsNhDL1rv2BdAvz1HObi7TchWCtv8fA5QUOLrJucKOTl0lLEFBIwRc/hSOa0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDvGcZ+PGW0YY2MliIxxPe/eHAWJz3lwtxkGlFQmtVqw/BPNrs
	mCOQ5MV5+g3LX54bN+3Me9pFNhT3p0zdeCwU/DjXTE9GIcBSGQJcIrFU
X-Gm-Gg: AfdE7clEZOQ+C76978gMLxLnlh70xcrOV4LJNAcdsraQSoqe1Bqw8vQRrLCMB6s8wgw
	8o+UL0SfvadddjmnmSBViHqRDUInJ0T+RvtHYp4dL0ySQvXO8q8yVa/MRVHk00d0SMuEvO+cAxV
	2xgEkzWIPtuMUqaFvJOfWuui70QIqGgq7YQSzbsVx4Kv2pcwM4LjYqRN6l6W8GLnchKOpTwLNXJ
	dOSkVwDdwjqV1ARfOqPpuV+OyB+4qFH2k2Vs+tzDYPNd0S1Y4eyz0LRxoIE9JnidqsOhoq8j+U3
	3giHh9N6hx5znbY+AScegdcVAqwx/qF6YQHrLMQQNMcdckWKhdODjRfpf+VbicwbQfqJc7vIfsF
	QSI/4PeqZHmw9Y+DAeghKxDLvBVz3L8Hn1SvMztvcM86l3A//IH98z+YIL+FLi9/eqBqxsVMSYr
	QQh1R9EucbcPLkpxoOLjGhda9sqIA4qukp3xo5ypGAqMYKJX+d/D361KHFQiryhEpdkB4=
X-Received: by 2002:a05:693c:2887:b0:30b:cc4e:6396 with SMTP id 5a478bee46e88-30c5553b105mr382073eec.7.1782155033135;
        Mon, 22 Jun 2026 12:03:53 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:6e2:c699:67c:63fe? ([2620:10d:c090:500::1:5387])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1be4967fsm10549199eec.26.2026.06.22.12.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 12:03:52 -0700 (PDT)
Message-ID: <1979fc81ae7bdaabda8616cd9698a40ef8bbfaee.camel@gmail.com>
Subject: Re: [PATCH v3 5/7] kernel: Use mutable list iterators
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kaitao Cheng <kaitao.cheng@linux.dev>, Paul Moore <paul@paul-moore.com>,
  Eric Paris <eparis@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski	 <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend	
 <john.fastabend@gmail.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner	
 <hannes@cmpxchg.org>, Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, 
 Maarten Lankhorst	 <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock	 <natalie.vock@gmx.de>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar	 <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim	 <namhyung@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Oleg Nesterov	 <oleg@redhat.com>, Peter
 Oberparleiter <oberpar@linux.ibm.com>, Andrew Morton	
 <akpm@linux-foundation.org>, Baoquan He <baoquan.he@linux.dev>, Mike
 Rapoport	 <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav	 <pratyush@kernel.org>, Naveen N Rao <naveen@kernel.org>,
 Josh Poimboeuf	 <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Miroslav Benes	 <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Will
 Deacon <will@kernel.org>,  Boqun Feng <boqun@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,  Daniel Gomez
 <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Steffen
 Klassert	 <steffen.klassert@secunet.com>, Daniel Jordan
 <daniel.m.jordan@oracle.com>,  "Rafael J. Wysocki"	 <rafael@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>, "Paul E. McKenney"	
 <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes	 <joelagnelf@nvidia.com>,
 Uladzislau Rezki <urezki@gmail.com>, Juri Lelli	 <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Kees Cook <kees@kernel.org>,
 Balbir Singh <bsingharora@gmail.com>, Anna-Maria Behnsen	
 <anna-maria@linutronix.de>, Thomas Gleixner <tglx@kernel.org>, John Stultz	
 <jstultz@google.com>, KP Singh <kpsingh@kernel.org>, Matt Bobrowski	
 <mattbobrowski@google.com>, Nathan Chancellor <nathan@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, David Vernet	 <void@manifault.com>, Steven
 Rostedt <rostedt@goodmis.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, 	netdev@vger.kernel.org, cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 	linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, 	kexec@lists.infradead.org,
 live-patching@vger.kernel.org, 	linux-modules@vger.kernel.org,
 linux-crypto@vger.kernel.org, 	linux-pm@vger.kernel.org,
 rcu@vger.kernel.org, sched-ext@lists.linux.dev, 	llvm@lists.linux.dev,
 Kaitao Cheng <chengkaitao@kylinos.cn>
Date: Mon, 22 Jun 2026 12:03:46 -0700
In-Reply-To: <20260622042811.31684-1-kaitao.cheng@linux.dev>
References: <20260622040533.29824-1-kaitao.cheng@linux.dev>
	 <20260622042811.31684-1-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-22 at 12:28 +0800, Kaitao Cheng wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>=20
> The safe list iteration helpers require callers to provide a temporary
> cursor even when the cursor is only used internally by the loop. This
> leaves many functions with otherwise unused variables whose only purpose
> is to satisfy the old iterator interface.
>=20
> Use the mutable list iteration helpers for those cases. The mutable
> helpers keep the same removal-safe traversal semantics, while allowing
> the temporary cursor to be internal to the macro when the caller does
> not need to observe it.
>=20
> Convert list, hlist and llist users under kernel/ where the temporary
> cursor is not used outside the iteration. Keep the explicit cursor form
> where the next entry is still needed by the surrounding code.
>=20
> No functional change intended.
>=20
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---

Beside the fact that this does not apply,
I don't see a reason why is this needed for BPF sub-tree.

[...]
