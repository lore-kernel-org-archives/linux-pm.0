Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B76F2BE03B
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780155275; cv=none; b=RfifafvX4aFo47PCUimfyQLuMLG3eyUNywpDJYksSmm+Vf5+YVB0bq6m+veC+oBFnjX+6JlBwPtXyQxSowOXfmFigDpouKLwuSamS+XwacbQlqcdvLz4hettbNg12PONN8BY9l0HKTUTEHWRVb4S2njUNyingiJ86v912hx9YpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780155275; c=relaxed/simple;
	bh=SoJfFynpvgGNYiiKXsOCgbWLalMyZx57WntzAfgTkD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIVxr0im1RHAdQ5n2pk1DxYwDqGEMJ7aWyWI9GcGZsQQ8wLlAC+JgrnUSSFYDjTZtj89Nc3fNPj/KCU6VH9htk9aG4hVkdkMjHpYM0tsjbtsKpkBoZJsD3hx8xL3iMMToMu3I61tV//a5tuypFzJbhdNW77sygoJMPKZfYMUAJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8We/0MS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8We/0MS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331201F00898
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780155274;
	bh=SoJfFynpvgGNYiiKXsOCgbWLalMyZx57WntzAfgTkD4=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=n8We/0MS1fLh76o5MVXDyHb+W8leu5I4eSA9TlIW68uYh++2IWgPu2liN0iFRWQTs
	 hzjfzP7MLtr0UwlklqciRKRUx54t+ti3TWDcXls/VOCKHVRqc/k9Gyuod35fXqvSCu
	 M2iJiNasZLotxH3W/QKPR1K2UVteqHcUMq/IGRx5Ja9vDh1+kb3ifu68qzVKbHpUgw
	 lrR0FJqYB/oNajgoxp5iBo2ZgDjeZwLYeNDDQzvagJhOUc08txNy4uWZSL8V/QvqhI
	 MgxLCshJZW7ioZQQgGOW7Bagw+bqvpPnjOPkrOD7k5eqB1bnukrC9RqeUwCUJ+Vgg8
	 Mb0ZJhknWjmcw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-393da8f389bso125531581fa.1
        for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 08:34:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+m2NTQIfkwQ2avX7Mn7EIcQKJAtvMaNY7Iw0094GqA3tYmxO9pYQw7OsME0uO7tRQ9J3v1vvKyow==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTVqLN0xndQZk6x5hsTlsRXcE+pkMlnUAFjk2INe/cCUmIMPoQ
	0zR3bm0N57PVJLQgDN7veQy9p2fNZ7hFCtsArOZ9uTy4IQ4gzoUPewvZw96//hFcCw+Otcd9dzt
	FIngMKnikLI/Q/inPCpgVt6NQOcmpJ8U=
X-Received: by 2002:a05:651c:1a0b:b0:38b:f632:e0fc with SMTP id
 38308e7fff4ca-39664e97ca2mr12466421fa.1.1780155272707; Sat, 30 May 2026
 08:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780048925.git.u.kleine-koenig@baylibre.com> <d840a6f83e3736510d7d859bf48c9bce04876b0c.1780048925.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <d840a6f83e3736510d7d859bf48c9bce04876b0c.1780048925.git.u.kleine-koenig@baylibre.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sat, 30 May 2026 18:34:18 +0300
X-Gmail-Original-Message-ID: <CAGb2v67hi12F6L0k+tc+_F9ycYkew8E1A0Snt2etDyOnAr33mQ@mail.gmail.com>
X-Gm-Features: AVHnY4JvesIl-euuqDWS2f7Ry3yv8CkdOVLzxvuyLxajt9txmd3vFbN0JX5bTBg
Message-ID: <CAGb2v67hi12F6L0k+tc+_F9ycYkew8E1A0Snt2etDyOnAr33mQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] power: Unify code style for platform_device_id arrays
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 1:18=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capable =
Hub)
<u.kleine-koenig@baylibre.com> wrote:
>
> Use a single space in the list terminator and remove the trailing comma.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Acked-by: Chen-Yu Tsai <wens@kernel.org>
