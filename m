Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB15542C511
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380811; cv=pass; b=LhtKjjhed08LW1xL2gxH5x/CtwyOvJc8YEQwZCLxijWYV+C4rWI71Rmj9u1YArbPjBq6LOTBMqAUbMhU7LBzRvyvHxwbySiAyd2ip3c6JWoNOaQzM9SfFTrKvJ0HlKQn0uVi+t2EcQVpdnBQwix8Ag3LI6KfF34TV7EWQEkenAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380811; c=relaxed/simple;
	bh=hrTBjMU5ss08E8NzVEAVH6LfpDvtAnBYsIwgUDaw6sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpZ3AS9OK2AA/Vr9+ts3+I00EJ+XO+4d7BWRS/fdlqruPezyC8IOWOMHmgT8dkyIdyLXAIoy2+EsdIUN339f+2xkUGQSy5ODFTy6Hd0VVHQRk/jfbb0BMCk484tjSXxu6q/35BUYUm/4GmWVIVNPNFIm3v6lecwSZxLOj3nOhfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/3125D6; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/3125D6"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39f9d4bed90so928471fa.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 09:53:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786380807; cv=none;
        d=google.com; s=arc-20260327;
        b=qc4xbjDOETb30T3hFis8w1b2V0jiLC+C7l3uv61X65ufAc3OKwB16OmywIpto/0jbl
         ee57/0N5ZEQxJhobUi8UgUG1jjJh5c/0xThCWE7CX3JsoOZC1GvmfDjpFfhdQNG2MQ8z
         SJrjQiL2wxqPIzOtiRSs8c/5Ze174dSksnUcn+4Fyy5CTCnXf7DJLtADbxu6jvaNj3P7
         hRVAL5mOuantH0e/6Wkix6u6eXQe7Ury3OZ5p5dP+AvaX7RujCGR3X2mHEMsDyyeDKL9
         EdBmesVFS2+B72bWJYjTZw4GJUyOV3M0dA/Cinl8RD6OKaQDMhL9O3m4nL4/Gf16oqMi
         VAaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0bO/4kz8Aib9NVgfYR/0fvWYSJJ+gEF2SgfiBtwRXyI=;
        fh=7b1FS91JfuvHuJy6CIH46rOY1LgdJdLo4C9DjfaD7JE=;
        b=P3eM1pVcur9K/T4XdS+Juw687s/4i4GijtLY2olgPDootqSFEAZRUtdqOopAkZRA5t
         vWBRc7PTwUXxjP8pVMqbbWvUrAGwPYnmlYLLc6mEN7z5anXTrRh4u1+y+50gzK+f3SQ0
         wSoqnM4xit69ZpxyIViPhWc84SSPuaSx9508bf/NOIkYEq78/JyyyCE69NAjvuH4Ggje
         9m6cvBnKKbNma8kcxIN108pWJrNwyy1vzC2KQVjt0qZQd03I+vD0Jh+KfF3/uv36LXP8
         VQYWG6BZqSZom4tURThzgR0U/RVZZxZOEiwMaWCoePWqZaJbbWD5rAqh+N2hnxh6Yr4A
         dl+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786380807; x=1786985607; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0bO/4kz8Aib9NVgfYR/0fvWYSJJ+gEF2SgfiBtwRXyI=;
        b=l/3125D6/+JkYuTGDdviT529e3skBZUjgHelNWQBqKyVHWClDOUViZg4O1tqvvTmx1
         ORHup6Xbwva4Ct0TI4LPF2uoDsyTMxyPBxQiHfXU2PujCHPV01eA4YrtJH0K8ORTFnTQ
         4+uWwch9JBSaE1hErh/5TEAff+RXPUG82EfpTbAAIupp7yEhSdKKcTc8C7D/aIAht2d2
         v9KtWSeNd5jDHyeIuF2yZHdAbimElKH10HAaBO5J4cBXrVOuBqae9elzwpXdU2WqgrKj
         u5fcf2E32U6o0tPnO08Y8/dh4T3xtgHaAdfh9Ns1vayvX301iWBzQXdifOsGuWC9wdYp
         PVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380807; x=1786985607;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0bO/4kz8Aib9NVgfYR/0fvWYSJJ+gEF2SgfiBtwRXyI=;
        b=mxDQylBBivjm3fumNSZGIwM2J2ZLjIdBXQVUuuR1OvLkho9EFCJkK+pweSbDWjrNdM
         jPdN/Z03z/F4e5uw8VCg2y8joAi/tl6xTcClCW5XrYIuCI6MYZeWNk3mDfSZBafC5u60
         z1jHLC61KTu9EFO9803JRvMt0XBGvXVP+6tITGadjIDfU+TtYv3zfdJvJ5yAFIXr7KSN
         pN/H+C6BT01SbUfZhH4i+iPsFZJ7JuyRauLf5XfMJeeRJUukYgPEYQWAGjl6DD+ITCuI
         Nd2LiQpggzvRtCJ9LwZ2fICSmSyKvtq7YpgB24k6aFiksel2IQjGwwgLyrG2AX/4L7rw
         lz6A==
X-Forwarded-Encrypted: i=1; AHgh+Rq1MxfE9lJYx9ZYnNulryIS7RUnTYj/XyZFfHCwEgUzPG2HVk0EKysO6mL3D12pmEv88QT0hKFHZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+LgbNN4dhoD2VlnAPFabaL3KLK69rGXqhe/BC49qyFY1mxxg6
	9ZcfP1yG1mDzdpG9XtF3qB9ygRVsBraka2+F21TB5ndtra4GqSWTn3oWnCe9ZzcHFKZHM40694r
	nYc3mKxV6rE6ND3t0c9ozHF6tByGk8Fc=
X-Gm-Gg: AR+sD12fb1fBA3Cub7yqXWCxby1J+AKN17ug6xlRlZtRRA0+P7PaI0BBu7C38jU1jCD
	UEvdv2PCX6C4L+OsB3tDHqDxsEBlhNE03FhgI0oixzi8zAA+mwzzYsgbeMbOf6lOpeeSi19+loV
	DySwsSAXDmIiio50leybDt9qrMpojWtxdMwprRexJfmArXcPdxByMOyiW+pVo4SO/aohQU9ShPN
	kL+vMpY9AUsqLkBpo6GjhIs1Y99/uh/FYl5EapMXGj6J1bk0iRWReUTEzpoo8aYbUg1Dl3nZG5J
	A6ZZYJPu0ClTcYv/0wTQzTE+Gu4pbHoE7QpcTEmcJomVQNENB6KoL+nTyT47Wj1pHyD3+wcCzxh
	8gx789HPlToqRqEUHCkrfwSq/Pzq6MsWMw2Vay5sNX+nRwA==
X-Received: by 2002:a2e:a589:0:b0:39f:af21:75d7 with SMTP id
 38308e7fff4ca-39fe8316b4cmr28346751fa.2.1786380807071; Mon, 10 Aug 2026
 09:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806170108.2100312-1-daeho43@gmail.com> <ann0OPPglToV_hjs@infradead.org>
 <ff74edb1-43c7-485f-ab78-ec13b500a0bb@acm.org>
In-Reply-To: <ff74edb1-43c7-485f-ab78-ec13b500a0bb@acm.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 10 Aug 2026 09:53:14 -0700
X-Gm-Features: AUfX_myHa-HGIxfGx31VEif489SQOdZ1JWJCG5M4SLT2WDWvbOhVQ3bd6pEJrl8
Message-ID: <CACOAw_zqOS0vHdQV6WoUJyxnDf=kdDAz27pNGDLdQLUdUYOzBQ@mail.gmail.com>
Subject: Re: [PATCH v2] f2fs: quiesce background threads during system suspend
 using PM notifier
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com, 
	Daeho Jeong <daehojeong@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 9:34=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 8/10/26 8:54 AM, Christoph Hellwig wrote:
> > On Thu, Aug 06, 2026 at 10:01:08AM -0700, Daeho Jeong wrote:
> >> From: Daeho Jeong <daehojeong@google.com>
> >>
> >> During system suspend, a race condition can cause f2fs_gc and f2fs_dis=
card
> >> threads to call submit_bio() while the underlying block device (e.g., =
UFS)
> >> is in Runtime PM suspend. Because Runtime PM worker threads are alread=
y
> >> frozen during task freezing, the threads become trapped in
> >> __bio_queue_enter() waiting on mq_freeze_wq, leading to a PM freezer
> >> timeout.
> >
> > That does sound like a general issue with our block device / threading
> > handling.
>
> Daeho's description above mixes up unrelated topics. A runtime suspended
> UFS device is resumed automatically by the block layer if necessary. The
> issue Daeho is trying to solve is unrelated to runtime suspend according
> to my understanding.
>
> >> To prevent this deadlock, register a PM notifier to set SBI_IS_SUSPEND=
ING
> >> during PM_SUSPEND_PREPARE. Background GC and discard threads check thi=
s
> >> flag and immediately stop issuing new bios, allowing them to enter a
> >> freezable sleep state cleanly before process freezing begins.
> >>
> >> In addition, check freezing() as a fast path to stop issuing new I/O
> >> when non-PM freezing (e.g. dm-snapshot or cgroup freezer) is requested=
.
> >
> > .. which means that we really sould have all the relevant parties
> > invited into figuring out whast is happening here, rather than
> > band-aiding something that looks like a horrible hack inside a
> > file system.
> >
> > Unfortunately I see this a lot with f2fs.  Please reach out to all
> > relevant maintainers for something that does not look strictly local
> > to f2fs.
>
> This information was shared earlier with Daeho
> (https://b.corp.google.com/issues/515470309#comment45): [ ... ]
> Register a Freezable Kernel Thread (Recommended) [ ... ]
> Why this works: During suspend, freezer stops freezable kernel threads
> before devices and block queues enter their PM suspend phases. When the
> queue freezes later, your thread is already safely sleeping in
> try_to_freeze() and will not attempt submit_bio(). [ ... ]

Hi Bart,

To clarify it:

f2fs threads are already freezable: f2fs_gc and f2fs_discard are
already registered with set_freezable() and call try_to_freeze().
However, a race window exists: a thread checks freezing() (false),
calls submit_bio(), and gets trapped inside __bio_queue_enter().
Because it gets blocked before reaching try_to_freeze(), it triggers a
PM freezer timeout.

Hi Christoph,

Point taken. Aside from this f2fs patch, I agree that addressing this
at the block layer or PM subsystem level would be a much cleaner,
system-wide solution.
I=E2=80=99ll give more thought to how we can properly solve this race
condition for the entire system, and I'll loop in the relevant
PM/block maintainers if a viable generic approach emerges.

Thank you,

>
> PS: I'm no longer subscribed to the f2fs-devel mailing list.
>
> Bart.
