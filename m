Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794241691;
	b=x3IjDZ8/ACHqdkEoEo95SGOycY6jdP7hQ5oWR7sQNBO7XPflA78aeZbyIxMiM81Cz1D9
	 7H0wXQfv5/+sgMxcRySF3AgTclzzgDRNdz5QfCLevjFrTuDkFSkwuMQgRAsMzVgu/upmD
	 vkBplZZtOvM1j2egywzJX2RkuojLIh7Y5PlVRaj7CsKwlJtdED187wS8RVog39Wqf/0Jg
	 rRBYMIJ3+2DiuaEQyMEjbEt5aSBAOA9JGDYSHzT/sxf7Qxy+LAN5F2+qhZ5PKa+CBch/H
	 hX73uI2ZwLBxeOlZWrhD5xC1mVzsgVXQuEvzaFKJ6kVjpwhrL2jGrpR/XA4GW0OXCUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241691;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=66BRn2Aye/0ckjUoOnRMmf1MQbc/vWAfUdGb1bh4c6g=;
	b=unTIaQMe+0ZprwHKAeg0uJ9RhcekRtLOL89CAjAvWsTWtfDuv8mOElt7wcdvLNPLVorU
	 diCtBOV3qMpxFX2TgJkJuwLTRuzQYThuq3WTI6g3PQbPKi+FcDPUFPJ88h00yGOiAGrwz
	 aPWN8USdW/yDHlQ4S8tZiOn+2XiLjDnnz8Jc/iFGilycTzRau+csgi3Pgolh0AeTcI91L
	 7z3JHamH697YKcYgzw3jZG5sJHcm7hM4g7JRf1mNWhhSRGmpulOfrZ3ITs6nrxGWa6qxw
	 NS9qK0M6iTIj9tBoBSm6+bJqR+uT1UZzhG6dd1TFez5VwFjqTfbn+yUL4wzg1y7o1HQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=c5bgooxP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80BF606A31C
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 16:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E80BF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=c5bgooxP
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b70d5b07faso1315053a12.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 08:28:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794241689; cv=none;
        d=google.com; s=arc-20260327;
        b=eLii33yZJ3mOVCVxXHymzDM+zR7Gg0ykFKAtWcSQyypVOGmHQPNpzLgwdTuE/IwPIU
         6A2FvEKnKoMb93ur+ZxgpqoLpNep8JOU+MWVwQUnH2QzHbLJO1PgeVqxWYGRRWYhsGO2
         MbXlAY7mQR9XXeb4afImijfOSjGb9s25v3ojnG0nlctM1zPsY2YteMZY03XeO6dW18RU
         eL6nmuXAGxvhCn0rJrVjBo3Gw+5FidLxOsX2CmTNATCdqFpx7BIssxspl3UKlnzqOzWx
         vToGqjbYkEj+uWqBJqOCGablDRtduQ54BhM+oQnAd3tFAsV30wHQZr60CuS+y5LHK2Xv
         MFRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=66BRn2Aye/0ckjUoOnRMmf1MQbc/vWAfUdGb1bh4c6g=;
        fh=N8jyB+izXPBgA6VB8FM4Nn37YusbySwm0/bttiZR/y8=;
        b=ULo8oGUqrvtq3sbHErzCPrjvOV+Enmqysgmibze5vM6Xz054gVq+hteNYhD9vMy4kM
         fn2+qsgOUL670xu/pbKeWUGvAnhQkgy90J66LCfHR9Rva/L4qR2fkJ+LJ4fwKEACNCZs
         JmjgsSYtnCukJqctQCEUUgqEQF1i56cKRukhAuvm9m+wxQnWokR1yT1HFDh1IZAgc0Wt
         /dANTpUiFnZ372YppikUZOLzPJqmsmi7uOmFoKodA3GRlXl5YmeMFEC883thLWoI0yAG
         ZmVJYa9T3BbONfygA7aX7ynGoLTQbS7Y0EK/TLZD7H/eCJwPolw+/2SCHCmTbJT06iuU
         aXYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794241689; x=1794846489; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=66BRn2Aye/0ckjUoOnRMmf1MQbc/vWAfUdGb1bh4c6g=;
        b=c5bgooxP+zL2y2viM40h+sJqVumJmHq5Kg9TLeYFT15jIeoR5HX9An2PQpeJKDtNtu
         ImcSH4yDqkTx/VqSBiRl4ZR4Bz7eaK2a8I9+/9hmOrkT5MGDWABDpf/7jAsbSRwn/lD5
         EJT08F5PC6HyzBtjMHpCK272l+tS9YlTBNd0D4H5qgFeYbQp+cjjUK3UiDYniQ2Y8T+K
         nL4d/pT+C7at0GsIJiH/xselnVabgFr1OF9ziBH59MZykD0HqPALvmIFYLUIYWQlGNFc
         naJn6D6jhLBc6pannUzY6hMpU8hVDhuQXVWTjKG/+LN/cwjs64OwFL5ohVarFFjymlZs
         MSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794241689; x=1794846489;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=66BRn2Aye/0ckjUoOnRMmf1MQbc/vWAfUdGb1bh4c6g=;
        b=m784PavBH3X9bo8o/eLb8YaAM09CjlJmJC9g56EyxUmkKS/tVwPkc/0z+rHAapOH2+
         fqCGag7i8fz8w5IVkYrLZ/aD9v/csLeNjK1cSVH3eg2rPM7ZZYP34ASWb24ms5WMz9SM
         WWO1/zc32MHANXIQWAJwngdimW/q403U/KBChWeyyolOsl6xCHiGRZyIg0iM0CyOudO3
         BBoV30XCYPPTZX+hDMZnWAOdvFDQeZDYnOtNPbRkXqrj20W5MTh+aqPBH70vRjh3kR/I
         WEm2ms9+1CD7bLbhwmJ3XUaY1lvLKhIjiZWhsBcexoij3eM7OjnhTi1vOC6Ntm4MdxOX
         Mh3A==
X-Forwarded-Encrypted: i=1; AL+hErEcTpiFBcH2piM4GwP2AZ3HrI9spVrZqfxcPJkl+8mZDmfuajs/qZSSbkqth7D5B+TX8MHn8L00vQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+cRRUnRB8vz1NqLx2GkVk4rtNU+7YGdSsNvJMKqpmbZ4McbpRN
	2+mI648F9Y796Rk9J/stUl1gmipMGbwS2SVurrH3fExzNWw0Dxa7V7lDtBTR620J/wFe67Y5Q7w
	XLM9u2rWKwGsIQusZAkNoGfIlQG64Lmx6ewOzpfLOPg==
X-Gm-Gg: AYBFou3/ZCyaxrwCK5w6kCrV8tq7K1HcykoPk46/zhpuAu7tISmwB2SYazE+Ht9rr3p
	HQMHBu2c9AD0QLOjv8PmRLbLfZdQ7HFCLOr9UtGJgSFVxEP2r1iX8fLJLzwXi6K6oPnre7VxuXg
	zpgIouLpBp8iHXa8kXQN9P16Bc7BJf8G/Wrr1gyeDj9BFa4fdoU9No7AGohXSpW730ivPafL4rM
	veAPuA5kiFPna6We85KmsYoO+Q79HDZ9VhoTAIkufR7QbwB/kttumMJDx7GJH4TblGWFSAe5VeG
	vFoY9tzYXV01cBX9Sj9Q+WmOkonHTXBwBV88b6ZVHBkyLuhVfUBPyrm3HX7S310y+j+Dw4Atg3/
	7k/H7cHB9PGbcC0SHWxFdTBj+HQjZNGzOc6w4r0Vynfh1ssa2hpFj1oMJJFliEBK5rht3SA==
X-Received: by 2002:a05:6402:22cc:b0:6b1:cd52:5798 with SMTP id
 4fb4d7f45d1cf-6b756b07148mr54356a12.42.1794241689236; Mon, 09 Nov 2026
 08:28:09 -0800 (PST)
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
 <20261106151947.3991524-3-vincent.guittot@linaro.org> <au38gSTzmvPKmqWT@scheduler.schedules>
 <CAKfTPtDXo8_3tfXt=UH+BKyO1rJCWjRAVXjO5nFVHO1NBd8LyA@mail.gmail.com> <20261109154536.GK1779021@noisy.programming.kicks-ass.net>
In-Reply-To: <20261109154536.GK1779021@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 9 Nov 2026 17:27:57 +0100
X-Gm-Features: AclHuK-qEpP_7M7KqnfdpIA6Mgua6z_axLvPnkGDjCe32vaSEKTrZIO3tqlNgoU
Message-ID: <CAKfTPtAL9T0bGZdhkodC49DtNUFKJgEn9f5wLNBe_rGxzJEN0w@mail.gmail.com>
Subject: Re: [PATCH 02/20 v3] sched/eevdf: Reset lag at wakeup when prev CPU
 has been idle
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kayra Cizmeci <kayracizmeci@gmail.com>, mingo@redhat.com, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 16:45, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 09, 2026 at 04:27:14PM +0100, Vincent Guittot wrote:
> > On Fri, 6 Nov 2026 at 17:22, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
> > >
> > > On Fri, Nov 06, 2026 at 04:19:29PM +0100, Vincent Guittot wrote:
> > > > @@ -8376,6 +8383,9 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
> > > >
> > > >       dequeue_hierarchy(p, flags);
> > > >
> > > > +     if (!(flags & DEQUEUE_SAVE) && !cfs_rq->h_nr_queued)
> > > > +             cfs_rq->idle_seq++;
> > >
> > > This needs WRITE_ONCE, no?  3/20 uses READ_ONCE().
> >
> > I hesistated to make it WRITE_ONCE but i concluded that it was not
> > strictly necessary because the READ_ONCE is only used to compare the
> > value but not use it for any computation or sync so if the compiler
> > wants to do any kind of optimization what we really care is : is it
> > equal or not ? so any intermediate value that we would read would be
> > ok
>
> Right, so without WRITE_ONCE() the compiler is allowed to write the word
> in random order byte writes. When comparing only cares about equality,
> any intermediate messed up state is not equal. And since we were
> incrementing, we're not supposed to be equal to any previous snapshot.
>
> Therefore all is well.
>
> That said; we should either document the above reasoning, or just do
> WRITE_ONCE() and get all the sanitizers off our back, because I'm
> certain that KCSAN is going to complain about this.

I agree that it needs at least a comment. I can use WRITE_ONCE but I
remember seeing somethign about its cost. But does it worth having
sanitizers complaining ... I will run some tests and use WRITE_ONCE if
I don't see difference
