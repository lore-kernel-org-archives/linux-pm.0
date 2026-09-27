Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EB5C8CE
	for <linux-pm@vger.kernel.org>; Sun, 27 Sep 2026 00:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790467408; cv=none; b=DW2gko1ZPs6V6ZSmV2h3fITz3S4Z4Enxe3lCc+KIJfxgIA/I9H3EIdbwgJJ/FKxgeg5wVxk2gCdQJSXmpexARYv2RroXUEfjHo7CoN3F6hTpmvxMrTXzB81pPOdcFzDucTeQDtPe3HMu3FcZmQdi0sUbyX8fIjfFYt1qIlEE7Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790467408; c=relaxed/simple;
	bh=dM60/lQJZNJbWoteFqu6uPH785ljbJ4v68GljKAZeM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEwoGQODFAQ17mp1fbH/TVTj9y+X7GpuVA4iWflhc52TMifpnfkZaxawZ4b4lZ9W2N4xRz03LkMg3NCZAO21qu4NiJLw3DX4Nm98kwB3YKgeui2q/crsgcBdUADZ5uqGxGfZcHYmbf3LpeS8djCeEgGSr5loPbDJKyOG7I8d4S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOIJTaat; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOIJTaat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A6A1F0089C
	for <linux-pm@vger.kernel.org>; Sun, 27 Sep 2026 00:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790467407;
	bh=dM60/lQJZNJbWoteFqu6uPH785ljbJ4v68GljKAZeM0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iOIJTaatkNJ/Rx0KAosWsEwaSeM1/VzOcFaAXAR27F0Tghc6tEkwXrLZLSxZEofLE
	 r2Dx50NWbwE+0HSrIyUzc2guH3dCCZXbEqPI7RuyOdOfnKMteagodLQPrevjon41v9
	 Dtf9Lxy4aPDYrhMWgQCZIUG/QmvbX27bI1HhTmKKiBkbNRiXvNAyEHiEKg+u2C0EHs
	 gt5HUb5YZUq5D/Ka+Dd0RKLqtVNKcts0c9yYCa/iClMmie/d+ZbfkHElnsovKJu0dt
	 yvJoCqBPz82kyHXp7mVgU9FH9lw9/lV7+e8letvdUnQkAqw46bQ4ZX/sT/j4L+KY9D
	 Urf6jZIxQuU3Q==
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29d50b7cf9so298670266b.2
        for <linux-pm@vger.kernel.org>; Sat, 26 Sep 2026 17:03:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxq8XLapmezITXfnJOLIzPkn4ZLN0qi5++jc281/GNobvAPUAyRbr0oYNJJvlW+ySj9A0Y0iKQ50A==@vger.kernel.org
X-Gm-Message-State: AFuF++kFOHqKYhKUaLudan1Ibv28XEoYtm3/h/Tpp3kLaPR+uah26JrD
	3qDSx24Finl7cgAACcE80sjeJznpQ2wWUKo8DKUS1C0jORktZqBnUUDGvRbb05XOfBB2dNVdGcX
	zpdBBL8Gsbqrfotm7xKE88c3kA8L3Hy6OIcc9fSpBFQ==
X-Received: by 2002:a17:907:970f:b0:c28:e01d:1d08 with SMTP id
 a640c23a62f3a-c2ac268a3b6mr767904866b.49.1790467402757; Sat, 26 Sep 2026
 17:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926045517.3458413-1-matthias.goergens@gmail.com> <CACePvbWPLegjMtF4jYN4+_1ZeoEuBHwZuwNyMpYwPZaA0edO5A@mail.gmail.com>
In-Reply-To: <CACePvbWPLegjMtF4jYN4+_1ZeoEuBHwZuwNyMpYwPZaA0edO5A@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 26 Sep 2026 14:03:11 -1000
X-Gmail-Original-Message-ID: <CACePvbU_6o_9fEFU6TJ9VaZ=4yBsDG5qXcxFkrGHBSD69m5ZXQ@mail.gmail.com>
X-Gm-Features: AclHuK-ZyMX3KOF420HwXlAK4cpZeFQwMK0gQ_EG8K18s67LKRQ8CucrkEWbQU8
Message-ID: <CACePvbU_6o_9fEFU6TJ9VaZ=4yBsDG5qXcxFkrGHBSD69m5ZXQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] mm/swap: reserve swap areas for deliberate offload
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-api@vger.kernel.org, 
	Alejandro Colomar <alx@kernel.org>, linux-man@vger.kernel.org, Karel Zak <kzak@redhat.com>, 
	util-linux@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 1:32=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Fri, Sep 25, 2026 at 6:55=E2=80=AFPM Matthias Goergens
> <matthias.goergens@gmail.com> wrote:
> > The series fixes zram selftest device tracking and error reporting, add=
s
> > the swap policy with DRM eligibility checks, and tests routing, working=
set
> > activation and retained-entry write refusal. It is based on mm-new at
> > 995829088503.
>
> Hi Matthias,
>
> I can't find mm-new 995829088503 anymore.
>
> Your patch does not apply cleanly to the current tip of mm-new
> mm-unstable, or mm-stable branches.
> Do you have a git repo with your patch applied?

Never mind, I have the conflict resolved on mm-unstable.

Sorry I usually need to have the patch appliable to use my own review scrip=
ts.

Chris
