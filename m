Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794466891;
	b=BlZy1HWx/wOu9IF2+vulLCczY2XdiJIGu0JytdHjlz6eALjoQFOGGPx6/qfiCG1FkfsL
	 Fq3Z4p0RBs113IOZMqVGvuOVSrE5uUC0zQZqZq5Jwj6hKau2hQcULM4CsPHP9ZDTbi2xr
	 p1F2yyBPnGBGf8qdAk6MYoDx2GqB1WI7oiUb/yDBLtkd/j6kr8J15VgYZxU0HT+NGCQdw
	 w105W1GxfWjQRXTRBflEQwh8zoN6zfBSEv2kOlhT9bGeSIjzTyIHXGAzsZZ6rho62xKnm
	 iAl+SG1WUS09tmcP2shhqD0LXdfiODAKaBpWpb4pzQnaoK/v5sIhXylU6h2QFGsZJbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=MSgj+o0QjwP2h00l2eEN+Ttef4mTAsT4O3zROWvRIfE=;
	b=ObHsJSHdmhS1oPVxdA+65dc8kJQUIZ2jpP5+VySIRWNbMp7z0xzmeUMEHpZtGROBB+j/
	 1eJyqNLbFWoTg63YhNGsSDHqE01YQkVNq5oR3VgWFXasltE4S+vqpHn6u3znZ4b7bQJd0
	 9PbHhTfWZGdc9mKVNOCHghrkQj56rdpeUrnr7/gotKUILRGZAdw8TWgBBHM0QcJqIHcbF
	 PzW1j4PzR4clMawkl1/3JfYkySJdxryhbEIJvFbabSwZzkUL/TSqR+moCOmqTMS/RouFy
	 xXL5VsX5lfrkm9KxHfLIxB2XmCQ2pi0x9uYPrn2F8Ngqqi0px1f97bHUpPcguLEjqyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bIpAcp2q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518EB606A321
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 07:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 518EB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bIpAcp2q
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so830655a12.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 23:01:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794466889; cv=none;
        d=google.com; s=arc-20260327;
        b=ectmICEB7nbHzHgSsPHMKf45lwpGmSUbqiNTlgH97en7QL7xoTBqfyMIbpZgJq2ydp
         jq7vdl6DVyu5uv+gbe7LIRb25dZZGlyx3T8qjiH46Moh3qlbAOLEwoqbzoPYzSf9thc1
         gZD7uoLhOy2aAWXCDcpeuZymwrWNjrdck54HvQgE9UjtCbgSiigN9K3JJHlpYWhm+mr4
         rwGtNZ8c84PCJOp8gBZPbAUZGBRiVddtyK/BgUx+X6Kf+c+bi5cqbbXaoszL/GrTHKTF
         UwrEJIhzwTALj4slIcW1cQYmBddQ21QmOUJLtyAytPQChyFDRokhGIFL3RnxyXQ7zeE6
         bvGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MSgj+o0QjwP2h00l2eEN+Ttef4mTAsT4O3zROWvRIfE=;
        fh=x156VmvH5kxIncHqephahsXndCSXGtTy1+pHcrUJa8o=;
        b=PqmrTr1Es2uNYOjjzwfT+4a9PDmgCxg7epMWInmrHTl27pRL7K9c7IqIK5yO4Py0Cw
         ZVEr+mT0KwxgaTFOrX2yoBUpGk5Aceq9q0mqGy0gMisyKvcRB9AjI7N1T0k8KYs7vuU9
         Umj/EUX5BPouBGQ4Oj3U1bV3NYRmxZV9j6JFQ+qjfHHPwxoZwX/eqD/FRZKaN+64bOyF
         HKyVbMfH86gZBAsHpNbD58tpEahFuubnEkkcarcP7VuVfI8euek+Gj9Lyhbxfj1QPQrw
         MBY+tH4UaNKRS6HqNdmmFVrtC9UboMdxyWW0JKOfF1bc+u+PGTStBaD+9OXhy7sdBTW8
         EYIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794466889; x=1795071689; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MSgj+o0QjwP2h00l2eEN+Ttef4mTAsT4O3zROWvRIfE=;
        b=bIpAcp2qreVIVwcFgyLpVXjX7iiaMc9q2ep0+vdt6k2iMXzJsY/oB1Vm9qDTcGuo3N
         O1EQIp++X5cYQuDLwjuH0LPk+F/L5OY2D5+mqvafj9A+riFZXjmAA51TveP9ma6A7v8u
         T3+fo2hrzvtronss649/uOS1y9Nn8nbGu0TQj19yYPZM8wLr3/njU82QaMPsxO0m0+xt
         4+7GxU4Ka63LpFTYuKMhcliw+mt0IjilzvgbJZUWOQUveGzm5CLIUkI0T8K3gU/EKtLk
         I2gxNBCICd7ps0/I4IEAdvsDBM+ZDDU4EqFbqw6LxAHFUfbgUKBFYh4tOrzBGDZEe+5P
         ALnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466889; x=1795071689;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MSgj+o0QjwP2h00l2eEN+Ttef4mTAsT4O3zROWvRIfE=;
        b=u9Bi5NwMwoPYH7loOhTQTXQs0q5P8j7pVsya+SuoAxTVoGYXlJHjx97zZxweHoBh57
         eIDs96Y31iys+X8vopmVDXbjtm1dGXI/hapmgLOIBvd3YnqASqSdIDncR0kd6Uqt3GOY
         zXeBecIrkXlPJjXOVBVYGpPddVmQYJyztnQ7M55Z7lqpgbQpDk4iDEXnVG6A12euup7S
         H8+/cK67r4751EOSDYsd2oOY18u3grOK0SuH6ZOjHaRBaUyiLicScI+1o28qu3G7IEFT
         yW19X/ZYWBWo+xOpvt2SXt67xkg+0LrNOenmZ+Tkw1K8Lvw2hKnqVAEBngsZC4aiCGuT
         v+Ig==
X-Forwarded-Encrypted: i=1; AL+hErHlw3O/xkySHyojwLHEvFKXYbwFnzLhYlKT/oAxgVhPSjX/4Qouovlyxp/bKm3NtaUfY/EagARdCA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/arVS3/EFf71q7hrKRrL+HIKqt8OmORouktmRiWBsjFhxWME5f
	SpM8NHKHM+j2aGT2KPhNzgmeS49wbBjvDIb0SjvPObCNrE55+milj5E4+wJYBbCQWkqYF8dMT0N
	LInk0nAB3ts3DppmKwg/YxQm9O9TEgKr6nJyBY2NVWQ==
X-Gm-Gg: AYBFou0p/FumzXrAifij5YhWzthkLmEERaY9w1+xlq6NDV3vyDnejj7+hzMA7E9AskX
	o4/z4mSxaRXCMKN370s2RasI5cKd/AYMOY83IJY/lO3ZeEciOzFK1c4+dSJs6qVtX0wf5MW9XOS
	/l7XRFwbNbMQbhrX9eyLjy417cbYUVV5tlOCKS414gsC3jDElOxKA8QXqweXJgvI1wIb+wEKliy
	pjmbzX1bK89Rwl9pG5J7q3RcYm3ukZO6s9CKJmUfV2iiB93ED+qjwVaAWtCJCv5Oh8BfGW5e2Kh
	udhDDP72WmW3ERGDomBTXV/6WK2pwW9AU7bbv6MRtBQGse+B9eeEfIkcIeyGt3TofRbusY4rAyE
	rIHxY41yIp+A1ZZTH5xhVDk6bLH2gawHoeC/v/jHoWBwrjgC3dOwhi5QQcgRQZB6Pgk2B6WdYfy
	ekR8WLHiXqd+gw60Y=
X-Received: by 2002:aa7:c606:0:b0:6b5:94d9:10f8 with SMTP id
 4fb4d7f45d1cf-6b7773f5a18mr2509828a12.21.1794466889315; Wed, 11 Nov 2026
 23:01:29 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-9-vincent.guittot@linaro.org> <20261109155418.GL1779021@noisy.programming.kicks-ass.net>
 <CAKfTPtA-nrgGQGcBPqNoPk4atOHakyZK9Fk-4AsrHBrnvPXTLQ@mail.gmail.com> <20261111090155.GF2668564@noisy.programming.kicks-ass.net>
In-Reply-To: <20261111090155.GF2668564@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Nov 2026 08:01:17 +0100
X-Gm-Features: AclHuK8UVt3x6vMPLZS8pSfeYTsVIPRoQvrz41V51tB_Ja3VDFaTVes1TsX82JE
Message-ID: <CAKfTPtBfQd5nD9jNdayGbEW_P2bDMvOm=GZ3Q-gu+O6KkQmKbA@mail.gmail.com>
Subject: Re: [PATCH 08/20 v3] sched/fair: Add push task mechanism for fair
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, lukasz.luba@arm.com, 
	rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, kayracizmeci@gmail.com, 
	tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Nov 2026 at 10:02, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 09, 2026 at 05:14:39PM +0100, Vincent Guittot wrote:
> > On Mon, 9 Nov 2026 at 16:54, Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > Can't we add the 'p->nr_cpus_allowed > 1' condition to rq->cfs_tasks and
> > > use that, rather than adding yet another list? I mean, its used for
> > > migration, so excluding all pinned tasks actually makes sense.
> >
> > rq->cfs_tasks can be quite large (we even take a breath during LB)
> > whereas this list should be 1 task most of the time (except during
> > wakeup)
>
> Like in the other email; detach_one_task() is also just one task :-)

but in some case I want to do more than one like the case described in patch 20

>
> > > Also, I'm still not sure why we need a plist. The rq->cfs_tasks list is
> > > MRU per set_next_task_fair() moving the current task to the front.
> >
> > The plist was only to reuse struct plist_node pushable_tasks; in
> > struct task that is already there for RT
>
> So while plist makes sense for RT, it doesn't make sense for fair or DL.
> Notably for DL we keep pushable tasks in a RB tree.

I can use a rb tree as well my gaol was only to reuse the
pushable_tasks as those pushable list are exclusive

>
> > > So reserve iterating rq->cfs_tasks, skipping blocked and current and
> > > such, should get you much the same over-all.
> >
> > Yes but I was afraid by the overhead of iterating this list which can
> > be very long; We have already seen email about bug with thousands of
> > tasks queued on the rq
>
> Right, so just take one of the tail and stop there.

I don't want to take any random task from the rq but only one that is
meaningful. Why do you think having a dedicated pushable list like rt
and deadline isn't worthwhile?
