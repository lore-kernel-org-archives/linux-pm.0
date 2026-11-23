Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442737;
	b=GNQEMxmECe5ryetLit3j08WljRK5GFMgH/g2EjNq3AzOy5dlY041devElr7GQuJVp36R
	 miYe44LqaauRO7c/XvpTUjEBVnAsY7J12sRAp12uo4qqQ7NjOu+QE+WG2oleC5kiIXJP+
	 b6t+k5HU6M/AJt6ZYWSJw7tP+iwHUdfDa8WAmN7LlWk4Q00QoCGuDFBMsnLSpZ2aTmxKP
	 W8jZwh8BhnxPb2VY7Hdxnkoa4WHvht2DvV5Pv0jKtbVQqhG9WpFkf4G4c7mLSjNfjUnpc
	 OYBDYkfgll++nt8J9HXVMTutNtr7KGjlK7Tu5/6azomdTiMxHFY8q/JVEICTtoVeU1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442737;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u9UfGQgMOVMlMO97GTbYnyC+y9+JoKQacU6NCbVAs0Q=;
	b=kHsSt9XZtWbrZjdvUQoH8vHIuO4UittIBBL2c92NcjdqiqkS5qH2Ku4LM3H4T5nz0hyh
	 Bbq74P7q+R0AltnnOEcoEhWXcxkIl7IpA+pEJFIOnqSzqtwgN33MedRPPwRqLMAcsP0rZ
	 pYPZRFWKF+HmAlOMc0sYMJ7ocEl1whQw/4nzHCa/NtmZ9AXM2EzioMgjxAzqI2JwyYl9k
	 AUx2VxBhTYwwKgoqIDahQwGN8ROr3s1Ox0wniBW96lgBrHR0uYfDIdefU0Rferxlz+km3
	 jvVhBTdV6OwjADNKdYLR5zJDO7Bp115S1bD7VRaE0W26iixHgfoFEfdCYfQe/Td8yow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TgOfyBEZ;
	arc=none smtp.remote-ip=91.218.175.209
Received: from mta0.migadu.com (out-209.mta0.migadu.com [91.218.175.209])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A14B606A31E
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 14:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A14B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TgOfyBEZ
X-Envelope-To: linux-pm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ShZxbALpq4gdPCiPD9hTQkMjI3nl6qml4e3uH88a2Do=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795442734; v=1; x=1796047534;
 b=TgOfyBEZhWzVnHY3uHH+SvDCYIi9+FuK/NBOYRwPgi4vFCchkx93hsOYcXxXShsX0xc1V3Bd
 2vRs6J6QgzDsNTbmoaTMEYDYKTL4cAltFqCRImIlBy1bLaGXnZF1KHtAv9Xg/k8hjlwD++V7KKW
 s1Pjh6e7YZ+AB4tQ1Z3i7EFo=
X-Envelope-To: linux-pm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9d6dd20083de15d5;
	Mon, 23 Nov 2026 14:05:30 +0000
X-Mizu-Trace-ID: 9d6dd20083de15d5
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Qiliang Yuan <qiliang.yuan@linux.dev>,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	lukasz.luba@arm.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev,
	qyousef@layalina.io,
	christian.loehle@arm.com,
	pierre.gondois@arm.com,
	sshegde@linux.ibm.com,
	kayracizmeci@gmail.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH 00/18 v3] Improving latency of short slice tasks
Date: Mon, 23 Nov 2026 09:05:13 -0500
Message-ID: <20261123140513.849567-1-qiliang.yuan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106151947.3991524-1-vincent.guittot@linaro.org>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
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

Hi Vincent,

On Fri, Nov 06, 2026 at 04:19:27PM +0100, Vincent Guittot wrote:
> The 99.9th percentile are a bit worse mainly because of the decay/reset of
> positive lag. Eternal positive lag was beneficial for cyclictest which
> doesn't do anything while running and slowly decrease its large positive
> lag.
[...]
> The test were run with the default 2.8ms slice to check for some
> performance regressions

I ran the series on a fully loaded and an overloaded server-style
topology, to see whether the push path costs anything when every CPU is
busy. Guest with 32 vCPUs on an EPYC 9654 host, set up as 2 sockets x
8 cores x 2 threads so that it gets SMT, MC and PKG domains, on
tip/sched/core bfee16fd01d4d (patch 10 needed task_tick_scx() to take
the new rq_flags argument to apply there). The four kernels were booted
in turn, 3 rounds of 3 runs of schbench -m 2 -r 20 each, median of 9:

  workers  metric              base   +01-04   +01-15   +01-20
       32  wakeup p99 (us)     3116     4648     4648     4632
       32  request p99 (us)   34368    25568    25952    24992
       32  rps                 4327     4907     4898     4919
       64  wakeup p99 (us)     5656     7736     7640     7688
       64  request p99 (us)  194304   162048   161536   163584
       64  rps                 2507     2532     2529     2532

The wakeup p99 increase, +49% at 32 workers and +36% at 64, comes
entirely with patches 1-4; adding the push patches does not move it,
while request p99 improves by 16-27% and throughput is the same or
better. So with every CPU busy I see no cost from the push mechanism
itself, only the lag decay effect you describe above, which here also
shows at p99. hackbench (4 to 32 groups) and tbench (32 to 128 clients)
with the whole series are within -5%..+3% of the base.

Thanks,
Qiliang
