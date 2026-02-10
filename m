Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A722836C0DB
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770733494; cv=none; b=d0xAnEjn7HWe7Bn8+lcJ3UBPcBxV05jaQkSYAdXLiH+8ghXhj4QWXbNi15wO9KAZWiIAQJbi6EbS1Owm8d4w2/aEYpaLuRabqUEx+oZpcPSBVlISxA+XeSlr+ep4gP4LZRjrPU4ROlcmoTaOEKKVPY7gz+dcogDyACPLyWbd+Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770733494; c=relaxed/simple;
	bh=iE5gywKERunbgzXJaftgR9IipO+8a5Woc/+KRyEgdj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYJ9TqJVi11dvZB1/7CeEFflIDUIipyqVq3W+/7kF6jh4g2MCDvzVenv3D0GbzKX+QWutJ3U+QxUTpR0itxBDpPInt143KCFLZdX1IjjcMeyBakv9arquOXmSwYcmLpfF+9UEDL6SwCPf0qSkkG368t5It+BXDukc8eXSGigXno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQN8ab73; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQN8ab73"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEAAC16AAE
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 14:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770733494;
	bh=iE5gywKERunbgzXJaftgR9IipO+8a5Woc/+KRyEgdj8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IQN8ab73ts0uoLy5SWkSNZSPjilcJBg/jCaZCXKT5WKjKIFYtafTvi1zKJ2a8zvOq
	 FIQxs6ida8ZcHZ77eb0q6yGDHpv0ZzC3J3gQjtJiY3Iq+P1l+2hsfjo2VeMzgdQ62j
	 WpeyVWVoUpR4vzozTvEIFuSHR4PTYPuaQ3OIwFOdlLqbjx93PA9i+qNsXRiwYQAxmf
	 tu/zw8hTptAmYnwfhJfcaZnqBtKe22CrRdT0Wmkyd8DOdPr0OAS6c1W6Ka/8QRr4v/
	 Av32f8q7Y6nIDvriyjAnC8Uth3+XLFNlRYq/FbadfAmdHK0Gwu3TL6j/OG5jfbW3O5
	 PDK/vMgHO3NkA==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-45c9fdf2a06so3757676b6e.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 06:24:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWEAIZ+/AvkLEhPP2v84txxjvcjD4JaKCYqGQvjQ2atFakglkxqDPqT2aGZPZrTfajE8u93wwncmg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5oIbZ56ES0sTrTNKJPuS1961tynSr/83kQbXtzyPrC//rTwUt
	SgjhXIGlOnRWYjaf2FM4BkcfeDdoEgzMA54VfakjAJ/Jd5KwJ6T05na4TY2n9ETI2HNN01oCQNb
	UOI7RAksnFLwlNGjHx+PoSVoFPsgLAb8=
X-Received: by 2002:a05:6808:179f:b0:450:7df:e90b with SMTP id
 5614622812f47-462fd0aaaefmr7845678b6e.52.1770733493317; Tue, 10 Feb 2026
 06:24:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <006601dc965c$afe30280$0fa90780$@telus.net> <20260210093321.71876-1-luoxueqin@kylinos.cn>
 <67clm4sqv5cbqxjhjoyn4eodwocc2jm6piwky6cyv4zncfrp7p@izdkjc5db37j>
In-Reply-To: <67clm4sqv5cbqxjhjoyn4eodwocc2jm6piwky6cyv4zncfrp7p@izdkjc5db37j>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Feb 2026 15:24:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gxNdQG8O32PrBcSa3GGvQCYObrquuiUXyJ8kgPV=91Sg@mail.gmail.com>
X-Gm-Features: AZwV_QiZMtZJvYN-Ddn8-eQsn0RdQzvnX3Te4YF2JEC8OycBM3RvEupsJLgMx_8
Message-ID: <CAJZ5v0gxNdQG8O32PrBcSa3GGvQCYObrquuiUXyJ8kgPV=91Sg@mail.gmail.com>
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Xueqin Luo <luoxueqin@kylinos.cn>, dsmythies@telus.net, christian.loehle@arm.com, 
	daniel.lezcano@linaro.org, gregkh@linuxfoundation.org, 
	harshvardhan.j.jha@oracle.com, linux-pm@vger.kernel.org, rafael@kernel.org, 
	sashal@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 11:04=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (26/02/10 17:33), Xueqin Luo wrote:
> >
> > In addition to the cpuidle statistics, measured system idle power is
> > about 2W higher when this commit is applied.
> >
>
> We also noticed shorted battery life on some of the affected laptops.

Was the difference significant?

Overall, this clearly is a "help some - hurt some" situation and I am
not at all convinced that restoring the commit in question is a good
idea (with all due respect to everyone who thinks otherwise or got
better results when it was there).

Honestly, I'd rather stop tweaking the menu governor at this point and
kindly ask people who want to sacrifice some energy for more
performance to try the teo governor instead.
