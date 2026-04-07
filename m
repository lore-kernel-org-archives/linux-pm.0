Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98466372B38
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 20:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775593246; cv=pass; b=Ypr+V6zDjhn1yVodCQZH1+9XFUnaE0TAIpm8JdEDx5cHsSfAWMWI0MiIecyulNG5cnbOn2CxZf6KOMxqXvxlyw0nX36EGjlefKyvH7y9rNBVOPMu4pHFZVfS2KZ85AeQ8G6clFUfgIdqJUG3KuVQ3gtXw4cGhp5LCbKeK9Q64j4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775593246; c=relaxed/simple;
	bh=cjT74Ocy+s/QiUPJBz2L2D9lT8JxlLpHzuEDVDl9Xlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmwD9w+GucWFHXSZlo8MCskynEqHzTcpRrPbNSdAOcasCEqkLMHr9PUu+61gniKSLrRpWZlQTtjnp3+PoCHuJ8RqFExXftNF4nTzTKJyItd00hGf9dw9lgMdh+BvYwui3gi4Izo0L/6zlXMvgRizIh25g/i9MbBnclo05qimsMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tEFDH9Ri; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tEFDH9Ri"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b9825ba7e8dso706982266b.3
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2026 13:20:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775593243; cv=none;
        d=google.com; s=arc-20240605;
        b=Ojrml+3rJ6jzVYbvIzYiqt5cmExADvBkCdS/mtEwhVl1znSDG/giMcXicsRvHLDGfD
         VLFScFqQfkGuCNCtjqcYUZA1/FPhZvSnc9CuFEsOu1eKUpEBL9YOlgKc6uJQirxyknwQ
         4JcEd284iIF7cCLkW9ps7Jw0n+KZSINogWALL7B3uGnP36xHwojhLL02kLYj2lQFUQB6
         i8u+o/5hrkMWpz/4ElCNLdj/BqTgR2CSiA56BTYrXfaN4vW8BhA7PIcdWdjmMGkNuRg3
         egXpZpVmlcQCwW5TnTcUtDKsPYo82gU1jGoK5RF+LuCWf/nZ0rWUlgB8LWf54ZKQdofx
         4KIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cjT74Ocy+s/QiUPJBz2L2D9lT8JxlLpHzuEDVDl9Xlk=;
        fh=FaQndctQUVBzHaibKFRRyoFERe32FKOGkFf4cK7N3uU=;
        b=cjtkYTi3PxuVHre+lXE165/BQHBpBG82A57y0ys3GxPsNkiYIgoiLJZJx8FhjufGxc
         GtOD8PaCaUy93sdHDeGDhbvvcSOerFlb2jIT16eLjZIBULpoPKBogdWHz3cbg+gbH5CD
         JdXoG67xOsNmBQ6Qlh6M7rCm40DwFSbyQMNU24hOpkaHsxDLvrrWCols0UMO8JD2Ti1h
         qRJfzv+fNEL5g4EAHoHyXGFrsUtYgqZFCxXcHxohOJTp2zNw783spzVhuuzPpVttEPA0
         y8yXUtHovNvcbkAphikUiK/EscYMSemjT8CBfCeMY2FdMKWyvxNHMaoqjy9F50yQ6cTz
         /caQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775593243; x=1776198043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjT74Ocy+s/QiUPJBz2L2D9lT8JxlLpHzuEDVDl9Xlk=;
        b=tEFDH9RilULLpzbXtcJhRp8eKc/U45MaQeEOCBfP57R01x9ZQhnv2QSlBiNawt+rEJ
         WiTV88m6PGXaYhIpTj/LSkIFYMe/chWzskINUuXjOM7t6JB3pWTrScrcJeqSQVs/6DII
         /XXEyNRNTG+JAmAq45oL6wOAVNI2H6FB7Dvg1rMPox75U9dOY71OUIoGl7fGezIil7ij
         PtLGGbMfAGpkBVFNy5NEoUlxu5QL/iR4PAc1jOp82gw5+JHVYTQlogiJMXIBFNs64m3n
         ocoSUp/QC0/vaqDTAmVvNDk9W9qTOXoR7KCIXmOg3fceNnW6IaEgp16oW/aoz8FcolHU
         En2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775593243; x=1776198043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cjT74Ocy+s/QiUPJBz2L2D9lT8JxlLpHzuEDVDl9Xlk=;
        b=iCUZ9vWuVKsWYTlb37A1H89wY2w5/+uXmVpvUXjNYuxvT0J5NX21iyoxptH43X2BVH
         yqnlJTrG6sUP5Rm2hAD9mNQgKav/fNJV5S6rbrG7HX9eIAx3X5A5izFnm/ESgHotI2cy
         lC7qoZH8/tjyuoyC4V7F/bf/tgUSrouzhfxABaojx/yTHlwsOg9eLHRwUbIloyHcqaGN
         JZ059c56iQ1isTpWo5VR0iKKReks4kQenSuf4lnmi/1U42Q3bw5I/xeu4Az2XzenjxUd
         Mhzii/CLaQiCVwKT5c89u3I+a17BEj3V8TQzV9wXzNlLvkbtQ8ROwUK90wkUIvBPFR3t
         ZarA==
X-Forwarded-Encrypted: i=1; AJvYcCXbaAoWRzK1b67KlkkR6V4tPO+l1SVA28r/82dM3kPkP3B643KPae4oCoK9zHrz1BDhUejMmq09/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQBojng7yz/MCTbgxKqfpTsuj5MKu2ZebJMPUjSyd2DJZ1vSmK
	D27SDMuacdVPloY/81ZluaZFPXrB6rstvNVQh7Cx9vpvgFivRro+VxpI/YXgz2e0fuHrmLTYnIp
	4md6M9lbwHvlSpHtDQnnOo1e5sw/aUeRjQLmMpe8=
X-Gm-Gg: AeBDieuZjbg52VLttQTCu+yiADr0xOefysHda/t1hvIgKcnY/F8JUYdFvluFKfSOSm3
	Ub4YmNPuKcwKNB7y0ZJV6PNvYQMJIBHaCnAF/sSok9inhwY3S2P4fBJ1Ssl2cp9/PeORCkxpxLi
	80sAzM+g0bQdMFSaaMqkiaQ61lh4UpqAi7fjG7pmRVm6ZXEwvJV1UWWi0H+dag+gZEdPIK/srg9
	5p94wGgMNT0Pc2HW7DQrBeA10PgthymhZw0+sxzDs7OSWXTW26XuFiEuABrM9Dj352rTZJfpEAQ
	+qnQ4vXfIa7TZz0rgLOgPZVD9PJTVWryTp3F
X-Received: by 2002:a17:907:8b93:b0:b9b:ddb2:b1c1 with SMTP id
 a640c23a62f3a-b9c6780cd71mr930525866b.21.1775593242554; Tue, 07 Apr 2026
 13:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407083219.478203185@kernel.org> <20260407083247.763539663@kernel.org>
In-Reply-To: <20260407083247.763539663@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Tue, 7 Apr 2026 13:20:30 -0700
X-Gm-Features: AQROBzD-zfvxt2CXKn7k44eSW_jC6hzwik2D295qjg-xw73ZHrijJ7W3y5q868U
Message-ID: <CANDhNCrPm0w6sFADMY_6-Ne3XeHp5aDXU9a8QNt8WPbeLWX5gw@mail.gmail.com>
Subject: Re: [patch 04/12] posix-timers: Expand timer_[re]arm() callbacks with
 a boolean return value
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Calvin Owens <calvin@wbinvd.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 1:54=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> wr=
ote:
>
> In order to catch expiry times which are already in the past the
> timer_arm() and timer_rearm() callbacks need to be able to report back to
> the caller whether the timer has been queued or not.
>
> Change the function signature and let all implementations return true for
> now. While at it simplify posix_cpu_timer_rearm().
>
> No functional change intended.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>

Acked-by: John Stultz <jstultz@google.com>
