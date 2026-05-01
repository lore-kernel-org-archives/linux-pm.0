Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CEF30C34E
	for <linux-pm@vger.kernel.org>; Fri,  1 May 2026 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777658773; cv=none; b=KZ6A4tQSEzNfD8hRdNX3d/Njv39qEF9KWR6mMW3YcAvEgeSvfUcQhEoTS9zzOiAqQfImpRx6lft/mM/QJctmfU/rKZwv4ZCergV5dJJcqZ8jbVgJ1vKxbdhYprqqDgvKAEjKPnIJ1CV8HRTBcsDSp9nR6Wko3IW0bP3tpM0SWR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777658773; c=relaxed/simple;
	bh=8L+AJLWAAO5U+MofkQtpBKjEAlAiu+8zhqpanDmWb9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unXwQWMkiBXZ8XzSR5zCo7RL9R9+ydMSmyNMePlOOmqKef2qv/MsDiHBa2VKi23K8ZYHc6ImaMyjMgeK/ZNC2AA04LYo+nKiNGxdeC+9K6rLve94pbs6tuZg+mMNxea2ei26HwWG4VpWqPAY4LQOnRmM50CnxX5GIRDIB9dPshw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coVPx/A6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coVPx/A6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C773C2BCB4
	for <linux-pm@vger.kernel.org>; Fri,  1 May 2026 18:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777658772;
	bh=8L+AJLWAAO5U+MofkQtpBKjEAlAiu+8zhqpanDmWb9Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=coVPx/A6AjHBTRX88JlLDcSdCfYnbFCYIgoi953xlS+ZOa6VSrh8rAFD+aWv4W6Ej
	 jrCJsX5v7PGCtNMnpv0x0XX2vku4MiermYneqcQbdy/LzVVp0Bdo5uoFIyKrILHgVC
	 Xw3qqbScFHlnNA01YLKDHVhMOlEt+nApGf6zbDy3T6G8USsNIMp2K8gI1hhRI96MOp
	 GwXgMzm901Kk4L/FpJPGVClSSt/4R/pzMo7WRG92N+6/WO4cfoAaukTmGpGCPuNAsJ
	 Zugo2T5OzakgRmdPFRJyGmsX+2VRPrWQHop7xaUZIamD3JD9Mtdd4m4S71NdqY9ekU
	 xnycF9lm0dTzw==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7bb0d18c7f9so23387707b3.0
        for <linux-pm@vger.kernel.org>; Fri, 01 May 2026 11:06:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/LKGc5S33M31FFzpVZGGj6zcyYHClAluGA1xampTImtn799xMBCJy4ng2Ymv+5J92RtJRbFr19CA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4aI9DJmJk9Pnr4m7B/BDEfHzn+QreiXbDCYKKq8e+q7WStyPP
	Gu20DDKbDtRSX1hfShU3MbR9uyj3DH5V+yEPL3jUzcseE2rLeBtcy912ERrb75EYoNdQij5bwmS
	IzAItr0KQMkdG4uCbAsG95lz9XE8B2odaMmWyR4MxCA==
X-Received: by 2002:a05:690e:c41:b0:64c:9ec3:d71a with SMTP id
 956f58d0204a3-65c3db8e48dmr133308d50.48.1777658771980; Fri, 01 May 2026
 11:06:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430195651.287659-1-devnexen@gmail.com> <20260501061816.5d59d1eefb0a41a3480a3a11@linux-foundation.org>
In-Reply-To: <20260501061816.5d59d1eefb0a41a3480a3a11@linux-foundation.org>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 1 May 2026 11:06:01 -0700
X-Gmail-Original-Message-ID: <CACePvbWNh_Xb63NkKtQX4t=kvmZdv_--LnTbum6hKHipAKGq6w@mail.gmail.com>
X-Gm-Features: AVHnY4KmNdTKU7Wh0RhCDGtXkLakhnbgtvyibCflHyo0CKnj_VeIUitePRIOtds
Message-ID: <CACePvbWNh_Xb63NkKtQX4t=kvmZdv_--LnTbum6hKHipAKGq6w@mail.gmail.com>
Subject: Re: [PATCH] mm/swap, PM: hibernate: atomically replace hibernation pin
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Carlier <devnexen@gmail.com>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 3:18=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Thu, 30 Apr 2026 20:56:51 +0100 David Carlier <devnexen@gmail.com> wro=
te:
>
> > The race was identified during AI-assisted review of the
> > SWP_HIBERNATION pinning series.
>
> Thanks, I'll queue this for testing.  Can the swap maintainers please
> do a detailed review at some point?

I'm looking at it right now. I might response slow due to the traveling.

Chris
