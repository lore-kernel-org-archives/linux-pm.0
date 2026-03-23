Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9BA3B9D85
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282848; cv=pass; b=rgqoX4ldEid1wtQIj8TvbcnaUma+/hqvm4DcWyKkkHHsa7rBwYzUCbtG/r67LTAyM7rgxE1SwuXw+TVuML6Mbe9WTMXBmjibJEy32md131uiKwo9sjLV5Zs15+kso4+Q2HZG+kBVOuLpKEhGljkRmFE18uIL9UeUfYEcfkuLvkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282848; c=relaxed/simple;
	bh=V94g1pzKL5dHi5fv8nGsDMXp1c7cNO9ZtyC0nibAyPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fm3tvphOHUplsEeDSBZgS0pDHyydb328NXmcgE2L7RWxl2GHoJP+XwIp2xWNy49qaTS2zUkqJbDMD/2IkWOMLyrTUQnb0yXp8qxenVZ7O2ID3/khpZffby2OqLq47sbhMMftTqKzVZgAhvepKl/d2nT3r+OuaXsu5UNSpk9M7R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tAhw6w9G; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tAhw6w9G"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-660a58841d4so688177a12.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 09:20:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774282845; cv=none;
        d=google.com; s=arc-20240605;
        b=W5+hchdm/6UIM+vlsQnfTLr9i4OI5Xd0k0CdTfEXB5E7+BkXhtkYqJabouifULciOz
         dTddUfsztka9+qGe8ESw/FN85PmCf69hHUFIbV1CpZqp+XsUkvgdgaCkHg2AQaIdfwAL
         fw0apD3T+YCsWfnobXs1GCDXmlExTupP98Ma9eKcreXESeeCI4cLA1pBN4Jvv+gBtsR1
         YB7tkyclyne6C+UGhuu/ZE9bixwGNKy1ysu5j0m1CLdVc9SoBIY1L639kBWEWyDoXVNu
         XEPG2LBskdMrckMV0py924hl1eifajSiT/kOQdPju5pTclsCv6W28aSUgYn1uYvvO+xj
         GwDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V94g1pzKL5dHi5fv8nGsDMXp1c7cNO9ZtyC0nibAyPA=;
        fh=V/7MpjKzDhsOF9zf5/r8RRs6N5o+jXVvKVCTMFTeT7U=;
        b=bewoBczt6GAtAe4Y9RUD0Vykk21lrWjxquxir+PBLjr8U3G+NRwVRdPWcThLnSuWkv
         iiAAh+WvTgYy8Dh7H3jIVlVtOBc5yzvNspdYWps6TrKnP2zLRVWBzYGsFVFP2EV9W8On
         8wLBKYv2/p7EVkse/HqiWDMDSbAAsBr1BGRaT4bm+B7kkEh8lLoWJoXudUHRzL5VjSLs
         OwvVIrBFhtFpkA8px3WZmJEtqlUZDceWDM3AXpi1LWjk22QY/1cDbIbi1B9dtayXf1ux
         FwLdZ12V65FxRS7DRoxS6noHn/rV+R7as6P6/sfRfxbwVEZO9n6edGzB/6B08sHfAPm+
         IztQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774282845; x=1774887645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V94g1pzKL5dHi5fv8nGsDMXp1c7cNO9ZtyC0nibAyPA=;
        b=tAhw6w9GKdc3xo2aP/R1zmF2Bg6DHmgYENELQvZe5GZj7w+UyBENW0Z5anZHMfMh24
         RMxu1/frYTMQOLQG5jHMBFLRKL4TiK7nEcQuN8yjEJlurVUiLFmrFmyq58eXxFj7Rfz/
         zQzmqAt/pQfPrkmHiHaTw7NAI6czwsYBFMdWL7EadWwMHMoXGcaJheEJYX+cHn/nzkeM
         uhaIKUYdA6x8t9InJb7gIKXEJzoPSqkDVqsbYEUNF4OSzDb+j9k5yKZ10fol8gCu6ilI
         jFHokAKCJPcB89wn126XOjLiNFV86nNWpd4M+n0PdIRyYFBLsBujuAGUxnRC9c102arW
         uKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774282845; x=1774887645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V94g1pzKL5dHi5fv8nGsDMXp1c7cNO9ZtyC0nibAyPA=;
        b=ZOvD4QltukJAVtgAJUQUFwou0NXYdHDWP7+CJrXyORx3CMOk66w9NNR3Uye60GxeYf
         7fOvMAt/Hva5UHTKEX/2UlLDTAvCVfL5mWB/JjASC9EnUnnZ+br5EQALtzSHXoyz+H07
         xnzFSepkvbhY1Rob+XnMsM4KSJGiiW8+ViSOW5eVhc4ET+pp5nmjzRhBzgF8RRH3Zf3n
         i4Eay7PyLSqPIS1WBsMO5lGElVnZQ07yoPuSB/3CMVzr4uArS1Ti+44M7lt6bxlP3QfL
         O4YcNSgRAG7dwcAbf+rQwJtaSg2nV0Oz04Om0vJ36YtMw6agOe91nJN4fbhOkcPjXE8R
         oOCA==
X-Forwarded-Encrypted: i=1; AJvYcCWXKWnB1p4OvgCZskXCws2zYZZOjdqnA1E+AcqhRaFKO410T2llJ2EgEeG+wg5BLHcIojuKyGxm8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjgEJqEVJVsojb5fq3xJY9EWa2RE5n/+kMAdH7J3XMgNwMGInx
	wmiifD6oXg+1SmK6LqpwVCp0r4vnyIjNS3G+yw0MShZBcB3HN1Jhu+4BB/RgBhn0bYVgZPL8YI1
	3USV+jHeL1WJZIOq396Ieb6UwUuWjjdt3dMyWeY5Q8al3C6xWfn0rrCEc
X-Gm-Gg: ATEYQzzwJbVuRSioHvgLCezY3gHM0pbG/uaHmyjljd8L2kPuU01f5CQD+xz1+OrqlVL
	elzLyUPpYGr+8In78y+Hu7AtC34/IKqDeTJ8swPQbuJW6XtPaduGXhNzx9Iprscp7EjGNQThlY8
	CDY6sdXSr3AR85vp+LaoKpyACAYr1ihMOu+B26Jx8BP3BSm5dHuK5yr2Iaj+YYm5uvjSNCVgm7e
	y4XXtEZEp+k7pzeIeY33zZePezTMSOV9BQ/ErnYPYc61rnfsntsSlFMdk12DLJCxNMLukMCecXe
	ztFMxBp1s0flH4xgIKJIL9PRmhtzo8A19i6ta1UUlao7T5NZuaNp
X-Received: by 2002:a17:906:919:b0:b83:e7e:3732 with SMTP id
 a640c23a62f3a-b982f3630e7mr720689166b.30.1774282844692; Mon, 23 Mar 2026
 09:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320160055.4114055-1-wusamuel@google.com> <CAP01T77hy3j5BZMBcYdadLfPe7dYb3zEGDF9daUxJHYy=+fcgA@mail.gmail.com>
In-Reply-To: <CAP01T77hy3j5BZMBcYdadLfPe7dYb3zEGDF9daUxJHYy=+fcgA@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Mon, 23 Mar 2026 09:20:35 -0700
X-Gm-Features: AaiRm52TW1-EKDTCZ2bTgcJapMDIKftRA_vvryAeSsRy_n7c_tkgZmk8jNhLUuc
Message-ID: <CAG2Kctooz+1ywStvHv=wg0p6ZTbHGm4nf5nGUfcrOnDi6H6KSw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] *** Support BPF traversal of wakeup sources ***
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, andrii@kernel.org, 
	bpf@vger.kernel.org, kernel-team@android.com, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 10:52=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>

[ ... ]

> >
> > The initial attempts for BPF traversal of wakeup_sources was with BPF
> > iterators [1]. However, BPF already allows for traversing of a simple l=
ist
> > with bpf_for(), and this current patchset has the added benefit of bein=
g
> > ~2-3x more performant than BPF iterators.
>
> See, it ended up being faster ;-).

Yup, thanks for the suggestion!

>
> That said, I didn't understand why you dropped the test. We still need
> unit tests that ensure the verifier causes the bpf_ws_lock to be
> released before exit, and an example program (like the one you
> benchmarked with) to demonstrate usage. Both are mandatory. See
> various *_fail.c files in progs/ and RUN_TESTS() macro for running
> negative tests easily. I doubt we will have any wakeup_sources in the
> CI environment, but the example has value nonetheless.
>
> pw-bot: cr
>

Sounds good, in v2 I can add a test for the lock/unlock kfunc. And
thanks for the thorough feedback, let me take a look at the *_fail.c
files and test macros.
