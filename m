Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792863484;
	b=BQ5GCUDu1Py3ZXDSG+icqGoP/OATEb9Uc4hcuocWYdBwLtOKdnjNStxAcwnP6QrC1E4v
	 08s03GW3RZyHFuIBaJjyNye//tiolr5j4gGP4AipmmppByU2NPTxzEZuFNHIc/kVSOwAY
	 tIFdf1dj4ti7Jz86SOTxZpsSP7Vscv2w+92oFaCW3YFSLw6nGCZTlaHCTYjpJ2PbDcvM7
	 DOydoQ3U9qMqSofgVaivW3dswLSWjN+pAZSvLpzqjyRYG7DkP9YaUzQtW1HQSv0qvwMSg
	 4vWtUQPQIYhn90ocaJy320Xlru3d56Q2h04yptuL+OwBmivgal3jl4k5Njj1SPhDsuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792863484;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=kJivVea5NsHNKC9ACNe2SOGVDMBLTRikssbVMvN28NE=;
	b=XTKNdW7/IBZPCYDzE2g96j+x56+Du29RC0KF4p/O5I1rICvwqoKq6S6JQbfqytvYHhBv
	 tBLM6l/f90oC1b0Jmd1qSeB2pu9m0RLD0AeiimExOPN/eqHbxCp35NGutNx+Riv5wkvFc
	 /HE3R2ggbhP7wNKTA8tA8oZW2tkCYU1zgWrX0QF3PoQBfE1FJbivVf1awDAPYKlUQBg5q
	 CRd0a9FqK0BsjfsU9T8TAmmeooVyoUtC9XK4ZTJZfk0jOY63j26oLuBe7MffQBUEvzxLP
	 Xgq55xNgY4K0hcntXp4UNEYbfSpCMy8V5wRbxq+/fkQ2JIjGxksHGysSSd3vMdqug4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RoEVqh0Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E556606A31A
	for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RoEVqh0Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0219F1F01828
	for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 17:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792863484;
	bh=kJivVea5NsHNKC9ACNe2SOGVDMBLTRikssbVMvN28NE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RoEVqh0Zv7kFRIERrv1a17B4Zn2NiDE1uFvVXyONigDfGXa8FzU1/UQ+h+5A48Idz
	 JdAWlFjuff7+AK2sfNyUdVvm1wX3rUNv1Fcf8hZdUruM2gU5jXBfUCrN+tb077bI0Y
	 dQa2Qz7KC6cv7L/N+/dmelgPlAFtbIR1k66q97nI58j56qTT392CE7qT3NsmbqUNfr
	 JNTGqiQJh9yzaRSLGH4t1Eu26Eugi5yWbGbjynpy6LWRowH0j8LVFhFBb11xW6mtU7
	 OLMhXCQ3/vyugY8DWX5jHEE1ULF60myDO3uMCsjj+PWk6l7SGuVAHfmdi9IsC2BH8r
	 Rl1QFfITEOWLw==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b429f71dbeso1701998a12.1
        for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 10:38:03 -0700 (PDT)
X-Gm-Message-State: AFq9FYIx1uQSZiZDB5p399jex0wtXafDStmGkH9pGJy4d+iQ12pH6NL7
	7jjeSaT5ryXgSVtKFIalIkWODjSzdFTRZuilH/iE5J5coPfOGcPqhYqE9tipOXYFgfzDictwryy
	y1DALGm+X5QkLw6p0aY86k4IsYYW0gGY=
X-Received: by 2002:a05:6402:270c:b0:6b2:20b:aed4 with SMTP id
 4fb4d7f45d1cf-6b4430199aamr3326303a12.38.1792863482981; Sat, 24 Oct 2026
 10:38:02 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
 <777cbe6f740ab2e371df856c716ffe41117940a6.1792428130.git.len.brown@intel.com> <atjsOHX5Uibb-CqK@ashevche-desk.local>
In-Reply-To: <atjsOHX5Uibb-CqK@ashevche-desk.local>
From: Len Brown <lenb@kernel.org>
Date: Sat, 24 Oct 2026 13:37:47 -0400
X-Gmail-Original-Message-ID: <CAJvTdKk=SPwCOYLCV=C+-5DiMt6qzAwrwpGh4kh2BdVGzuHHMg@mail.gmail.com>
X-Gm-Features: AclHuK-wWS3rZ_xq_OCVM1rsSj2v8MoWLHQtiRVGS0oJvKMn97P7Cg5ZrXqsf_8
Message-ID: <CAJvTdKk=SPwCOYLCV=C+-5DiMt6qzAwrwpGh4kh2BdVGzuHHMg@mail.gmail.com>
Subject: Re: [PATCH 17/18] x86_energy_perf_policy: Fix write_sysfs() return type
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-pm@vger.kernel.org, Amarjeet <amarjeet@intel.com>, 
	Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"

> Wouldn't it be better (but I haven't checked callers of this) to have
> other way around?
>
>         int ret;
>         ...
>         ret = write_sysfs(path, tmp, (size_t)len + 1);
>         if (ret < 0)
>                 return ret;
>
>         return 0;

I too prefer plain code over ternary operators.

Your comment made me look closer at this patch and re-write it.
Turns out there was a bad error path return value hiding in plain sight.
And the callers don't care about num_written, they just care about
success/fail -- so we'll return just that.

thanks,
Len Brown, Intel Open Source Technology Center
