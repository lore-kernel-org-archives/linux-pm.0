Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D8E3FF1A4
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782735790; cv=none; b=kbBZTHaX590p4gt3+sNYUHc59lzeLSyMIx3FwzjMQFWw7FTcBebdadrjkb5oykB7srRWc6nB3v1IIIAtYUjbL5FFctdUbtLg8/SZGMYQCjBu7JsZiH5v5Iz9bEMnSl3sNd5w5rpjrQAufckFfoskt5F9vOGDYo4qFodsa+gCobo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782735790; c=relaxed/simple;
	bh=rSLFYTW2ojmOthgxA2ZHN+NmrbX7NcJoq1VRZq+4dnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxSsQn70Wj35/FhDwsorXZUoBVPlW8rLtndt3XIFhKQPWO3QlM9HzV7Vm7ugxSpvncD9p8OnIvkVadJ1WF1qmCNiw4Xhc6KGChhHYasjvbrNRtNaTIec1OZvnGw/iAcD/FSou1cUd0FwWaRq/Kq2FIqIjkcmwtn9H0VP56pBqL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzQqUip0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzQqUip0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E85C1F000E9
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 12:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782735789;
	bh=j4bnvpPfXAnQ93uII/PKn2BcLce1TAn8fBNoVDdRa6Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mzQqUip0sd1rtIycrBmSBE1ouhmjql/x+QYqDEfVulCsh8FP3q4ivOEhy/hi7Zpaj
	 Cx69eroUzxax2xxsXRale2xakQqgK2BnljYUhLTHjKdq0Ln3CQ+0Ls3XUPiThZG5v/
	 xPL8H2tuYoYpd5MX/iYGqhuuEwNc+e0RCR8b1aDoiomo2OKm2X5knGsJojtmqRMQST
	 LCgdJnCBLOlJ/eWlIeNz8W2Y7x0KcTPdv6fRfGq6oiV6JLFzsmrDhA8B6C1ZqZaQnV
	 PPx7I6JMCf5WO/v/uz/hxNrJcF/F5vY9an/zl9OpL3AfKW43W0iZ8q1v4rOT2zs2VO
	 n2FaV0okq4GGg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aea3417c6bso2167014e87.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 05:23:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrbrS4/UaMTTFvuFlNRl+F1UL4JqgoJFcYa6cmKooXBqyPgdR87aUGShy3JBnCjEyuvTF+W6wXnhg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5l3UaNbaBr904LpIAIyugiULFO0/EjTQ7+Gy8CqkBK0VpDx1y
	4mf3vRnvCEM0YS8Hh/aCi2Tk/NmrvkOqdrjwvz0PEhRsVkkKRrOVO2g4UaDEZEMBDRqxf0sSFth
	BlooeK8cwHT0HgXnAqmslCw3UDy03lPU=
X-Received: by 2002:a05:6512:4616:b0:5ae:bbe5:2073 with SMTP id
 2adb3069b0e04-5aebbe52166mr355136e87.49.1782735787975; Mon, 29 Jun 2026
 05:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0juZ6YJVALVEi1s_O0qgcr_o880TJbRHXWsd-Drb-sUXQ@mail.gmail.com>
 <CAHk-=wjS6CuKne+v6t3J=ppXTJj7dwRE0FiuXjT_O_wBiW0yVw@mail.gmail.com>
In-Reply-To: <CAHk-=wjS6CuKne+v6t3J=ppXTJj7dwRE0FiuXjT_O_wBiW0yVw@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 29 Jun 2026 14:22:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jQyELy6Zyqn-ngTmVG7Gj+CFMtL_t7qDEQjWSjgcLCmQ@mail.gmail.com>
X-Gm-Features: AVVi8CdHrNoikZdTRZBGS7jpbNZYpbEqNjg_QTKiQ23U5jYrygtMldRU5GI355c
Message-ID: <CAJZ5v0jQyELy6Zyqn-ngTmVG7Gj+CFMtL_t7qDEQjWSjgcLCmQ@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI support fixes and cleanups for 7.2-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 10:14=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 26 Jun 2026 at 10:54, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> >  - Unbreak ACPICA tools builds after switching over to using
> >    strscpy_pad() that is kernel-specific (Rafael Wysocki)
>
> Ugh, honestly, this is disgusting.
>
> I've pulled this,

Thanks!

> but this file is not in some kind of "tools"
> directory, so the fact that it then also gets compiled in user space
> should be treated as a user space problem.
>
> I had to really scratch my head how it's even build by user space at
> all, and it's due to absolutely disgusting code in
>
>     tools/power/acpi/tools/acpidump/Makefile
>
> that uses a vpath thing to find that C file for that tool build.
>
> That's just crazy.

I don't dispute your judgement.

The background though is that the code is shared between the kernel
and the tools because the output of those tools needs to match exactly
what is seen and used by the kernel.  Otherwise it might not make much
sense to use them.

> But the fix is *still* not to add horrendous "let's use strncpy() when
> not built for the kernel" in code that looks and acts like kernel
> code. None of the other acpica code does that.

No, it doesn't and the change in question is more of a stop-gap than
something I'd like to be there in the long term.

> How about just adding a trivial strncpy_pad() to
> <acpi/platform/acenv.h> or something. A place that already knows about
> the whole "I'm building the app side" now.
>
> Hmm?

Something like that or define acpi_ut_safe_strncpy() as an alias for
strncpy_pad() when that's available.

I'll figure this out.
