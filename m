Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881093;
	b=UQFuvHYuj/+kYtnjzLqnWicm9kKA6Uq5JZxfWQRX2P8IaTGVvFGPrljFtJutBZ8TLnvt
	 7zO7cOKyqp2mv5Zb2iyKMpObEsmtK5LgckTJwe43Mo2u0e4AvJPkhFUXFvyku4V2S5rud
	 9ba1X3TU4LGJU8smKZUsAdGvMqKCHI1gnnVEtYSFLt9fTPcuiwi60M408XhFsvAscsf9l
	 3Qd8fl13EcO+TgGjfY7eBtzoNTG5yZbl8yH+mi97/g6xXOJWpJLDSUWg+qLd3sTjvIQKD
	 a6rvJVv9aGs7LcCO0WOyKTNwtIw8mHzlNT6090n+JXATfKrFKH/F1BxKNGJBYb1brGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881093;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LYwKJrBAnJtHxiDkBCxn9IhfjGpNulq61w4ODpcgG9I=;
	b=xLmu50+vQa+wC5z4pzkZuFWvQfazVn9sLCPQVqqOW5lnxVZ6K59luNqjUFOkSLVcgHWW
	 Ekn0Aza1hYkDSD/xXQHeZP1w1OA+euqd675Pvh/ZCgLYBG5522weW8YpzDu6Y/5C9B8L3
	 26161D/rZHD0BBe5DJA48BUKJPw6nJuydXsg6s4My3JGiWQVX0BtnWFtNLUmhGKLxRjSI
	 0V28U4p/SKFNApaYHOoXxxYUTbE9JBjwI/n7D1jjUdqzsDyF6YTDuTB5WZ+69ps+3B6qW
	 3S4fWDaYbJ9zTXSEBM3vn7PYVdguVI9LnpB/j4oxiil9KJnB3Bwk/T+1efLs50nPdIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5oN8F5k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF63606D818
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 12:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5oN8F5k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE1E1F00A16
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 12:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881093;
	bh=LYwKJrBAnJtHxiDkBCxn9IhfjGpNulq61w4ODpcgG9I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=F5oN8F5kbkIU5oDeMSLlUZsZ2036p1iGjuQgjTFWyb8klHswl2ZVaUkZ/Q1y8ye3u
	 OgAutOQiDQELs1LstWzqE9PSP4EXLZCMgD2Y31DcuTg45IX6h+KrOFwdWGi//Wp+N4
	 QgMdq4uFSmoLH305pbvChaOf5Gd6wL4xoVWd5NUF1Sh1RU2Kg2SJLZmQBYMtuxwDMi
	 geySOYLgnph4I83BNLcSjYMJC39bxFwdBlYkVUbKRzycd1Y9Uvy2KCAtJLTjwJxpn+
	 suJVJ0Mb9geF/FNsh8z9UIh8+/im8K2Qrwy3YQcnR+dlKA5dpTMRr7fjpUs05Thclk
	 rCAkE5wHsB3XA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5bfa7c09c9eso1283955e87.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 04:18:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxIm55vDm4z7XHPJ5Dv1KIXISahKkx0f2fgYN5bQyV9mMDtN4EjK5i3g3EKzKhh+HFAziH4nBcS7Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z8nbmcwA0qUr6nHyvK4wc5OZM115Q/1NiF/CqaBb51lGpggQ5J9
	CuBuq84ZCCr2O742oWMvYmSF/M1dlV3G+khTjv8lGAvE1gX9IjEyKkAVsMSdQRV32AzabNxAwV/
	MOx+FIUru7gW2utJ/aQtZRznXubCxS4E=
X-Received: by 2002:a05:6512:688b:20b0:5bf:e901:9e31 with SMTP id
 2adb3069b0e04-5bfe9019e66mr2798186e87.2.1793881091737; Thu, 05 Nov 2026
 04:18:11 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030083633.1699270-1-christian.loehle@arm.com> <be158e9a-a4f8-4ce4-8183-85c747af2129@arm.com>
In-Reply-To: <be158e9a-a4f8-4ce4-8183-85c747af2129@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 5 Nov 2026 13:17:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hHhRYihhssF1PSqbNRKH6w_qBbWR6G1YWdJeMtAfMNbg@mail.gmail.com>
X-Gm-Features: AclHuK87hEG2KlXf3FE4-KhWNYZlNXaavnhHlGAASeP6reyN9eLnBhYb0iuyXG0
Message-ID: <CAJZ5v0hHhRYihhssF1PSqbNRKH6w_qBbWR6G1YWdJeMtAfMNbg@mail.gmail.com>
Subject: Re: [PATCH 0/2] cpuidle: idle_miss accounting fixes
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 9:11=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 10/30/26 08:36, Christian Loehle wrote:
> > These two fixes exclude timer-broadcast fallbacks from governor miss
> > accounting and respect the entry-time latency constraint when looking f=
or
> > a better deeper state.
> > No functional change outside of sysfs above/below and tracing.
> >
> > Patch 1: Exclude timer-broadcast fallbacks
> >
> > When tick_broadcast_enter() fails, the core forces a shallower state.
> > Exclude these entries from governor miss accounting while retaining
> > residency, usage and governor feedback.
> >
> > On Orion O6, traces with menu and TEO running schbench, tbench and hack=
bench
> > recorded 6930 cpu_idle_miss events on 8172 broadcast fallbacks before t=
he
> > fix, and none on 7763 fallbacks with patch 1. All matched fallbacks ent=
ered
> > WFI.
> >
> > Patch 2: Respect latency constraints for below misses
> >
> > An enabled deeper state may violate the latency QoS constraint, causing=
 a
> > false below miss. Save the governor latency limit at entry and exclude
> > states exceeding it, without an additional state-table walk. Disable fl=
ags
> > continue to be checked at exit as they are expected to change less freq=
uently.
> >
> > Christian Loehle (2):
> >   cpuidle: Skip miss accounting for timer broadcast fallbacks
> >   cpuidle: Respect latency constraints when accounting below misses
> >
> >  drivers/cpuidle/cpuidle.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
>
> Rafael, any opinions?

I have only looked at the patches briefly and I don't seem to have any
concerns ATM.
