Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794150494;
	b=OcWzCbfmSWCado47N/uZiWkfXgaA94gUDjP0ZAjRZbHWYLHexbZ89I+vmC2rruM7Nuzx
	 9Yhsh9duM4YAc+rlhD85r48KebT/teVErLphK6mMiMCbv8kNZAji7hobGIuEaN5ZaipTq
	 MnjWS4OhHI9tafRgL7r6ewoIPqjOw8jRBoxcr5z+H/XObzuvwMCjYnNdG6zWRvU5W0K8+
	 O/aUWygGkp4iiUOCtCqSIJvzuMYNwysRwcGK7hFSp65dz02BkhREAUbKGHgoTwAph+VKG
	 gt4SJt/hBiEV5QIfX+EXOgEZahvzg3v968+MvYzNrVBXw/LK97pNLhfWUdTpVsqwGNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794150494;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xepa8tn8s6xYKIcCXkAtbeV099R6rMyX0LFl53/KC/E=;
	b=YA3RYLhA8t8e/nRUFUWH5CskSM+5JmfW+nh70gwWyHWtHARHnI9UpZuDLW783ekx2jdd
	 RPKWTdO7R5Wdy5gV0D4uoFn5EER53+L3IedQlBxP+FAZ1N9iM1RkGwIhndlvSYqpa2v/k
	 FGmEW3cRxrudNu7YXCjg21lrE8ChI8RfEJ0XX1dZ10JS10tvP6rhYaFjw9/Hr4KrCEe8J
	 fHlyH9gsQiZm7GK1Pnl0fFSLrQMQ2jnOPHY5CRbVMn3TqgMyCup4eKLB2tXa+AJK409AJ
	 zWlA/MLqP01WAZixHgg61/n5tlJXv6Hbrl46HafkdK41otf+ysRK2gxdVu4jT/ETv6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bUA7Fx6S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1496C606A31C
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bUA7Fx6S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BDB1F0089F
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 15:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794150493;
	bh=xepa8tn8s6xYKIcCXkAtbeV099R6rMyX0LFl53/KC/E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bUA7Fx6SXQ/qIpjRLIe+KpELT9LX2LUHXZty7YutCGmNbpqDXtsKVBT1IdLqo9AbI
	 CjiPTexhuiNJ8q+G7bDuLG/FR6UJYwZ3EIPI2+tBPwzf32gokvtcMevx4avBabbHyq
	 Bd2QHs4zODUpCjlFqDYtCK1FX/3PC0I/SWdgvJNQkJe4kXfca6o6vKcGBbIWw+FGMr
	 /7xhn8VrwYbzE3gIw/gSF5xzM74SdJiHjodlR6419aVjOHdyLHXCpRcM2vyekdOADE
	 p8sQpXkMPloLm8K6najfi99p/9lvFqtOo5GE+MTBGyjUkkhGvHUi8QGJLvnJrvAveQ
	 wWoMDdk5hjjzA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3aced9804e8so1004691fa.2
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 07:08:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEQ3LSHzinU6yKF+59MXnkcrAo/TFvUWREUVM+KtVqYUo2XjX6RMKbZG8hGyO6LemQhyTlK8KZkIw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8+6dYr3r1A1y6ec187FJWTjPcHNeXh++RZY3Ihhs6D4y6O9Kjt
	T1Zc8GMTbhm3ezOY6jFMQwb+7MBptajBLLWOQAg9oIQwrpHOjx/HufYHLC6te7n4VgEmtZRzbJP
	VtjORDDqW+oaweC9Qk2PYfVEwcRRtWNQ=
X-Received: by 2002:a05:651c:4182:b0:3ab:2d6a:1a18 with SMTP id
 38308e7fff4ca-3adfa3f5a5dmr3237561fa.10.1794150492428; Sun, 08 Nov 2026
 07:08:12 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-b4-arm64-teo-defconfig-v1-1-5e3763385f89@kernel.org> <50f2a108-0963-426a-a6c9-06f863f9de48@kernel.org>
In-Reply-To: <50f2a108-0963-426a-a6c9-06f863f9de48@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 8 Nov 2026 16:08:00 +0100
X-Gmail-Original-Message-ID: <CAD++jLmzYo4CxcMGDooBOxPcs0Jx-HUv_UGOkh1mkuVKRgKuqg@mail.gmail.com>
X-Gm-Features: AclHuK-65FZNd5SjWhlAKT5BS26Rt4g9KDFZj_La0kuV-nLr8RPhoN2XPwANDxE
Message-ID: <CAD++jLmzYo4CxcMGDooBOxPcs0Jx-HUv_UGOkh1mkuVKRgKuqg@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable the TEO cpuidle governor
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 10:15=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
> On 06/11/2026 09:48, Linus Walleij wrote:
> > The TEO governor introduced in commit b26bf6ab716f ("cpuidle: New
> > timer events oriented governor for tickless systems") takes a different
> > approach to idle-state prediction from menu. The governor gives a
> > better behaviour than the current default for tickless idle systems,
> > and for the multi-platform configs that enable tickless idle, this
> > should be the default governor.
> >
> > The arm64 defconfig enables NO_HZ_IDLE and ACPI, which enables
> > CPU_IDLE. Selecting CPU_IDLE_GOV_TEO suppresses Kconfig's automatic
> > menu selection, making TEO the default governor for this tickless
> > configuration.
> >
> > Signed-off-by: Linus Walleij <linusw@kernel.org>
> > ---
> > Prepared with OpenAI Codex assistance.
> > ---
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
>
> All three defconfigs could be one patch, honestly.

I've been smacked on the fingers before for modifying arm64
and arm defconfigs by different patches in the same branch even.

But maybe I should be more daring. I'll squash the ARM32
defconfig change into one in the pull request at least.

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Thanks!

Linus Walleij
