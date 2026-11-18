Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017487;
	b=5VYBVC8bv68AJcyXYXvP8aIM3PCk5E2RcXjQvQrZlZVL6hKcZvq+WDUWbkGbFlGUStmY
	 o1F43mYoJ416u6rA+cGEZPwF+WAOAx49+Y8zbAuoUneHN4z0nbCtxMUen/z5mF6uFoAI9
	 HqZEELYFgT5Sczm6k3QkfRDpcViTHvFnYZfwVybuEXc+COPSq1TfCcPzSPD85igqmjl4A
	 KHfEG+g30xwQoNEVqA/5wTzliNuLF7i/GZPoCJYEViAQ7f5dQQ43DPOE8zZf6sHe/0ILr
	 8OjQIyHPlfKCytMquEKIDp/l0/K3BAN+TtjJ+rfYlFX5UbvHNzqYdgGZ3a8L+8Q6GAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017487;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=me4+qTl82YgNzGoxWyEsprjq4fF403Or/YIKNaUUYpQ=;
	b=O6oH5wbzXt+xhskUIo5zLG2igU25t65ORNwUHrVJhD4yG5CFK5HkDeekO8Q/FCr8eylc
	 asXrkSbEHqyDRWkxLcvzjIOPtEDDkZqSO1CQrDINQFUpKwKNC6RNmQNZLSaILqh51Usia
	 9uKshDwH3LdVyDw9fn9LQqG8LQIE29+Sk6zTMzwlha8zhEgSC9f6o/Ph96V2k7XlMN7St
	 /R2NYot8hl8wLrmSGhCvJWWts2V6QPugFMmAg1PQKW/0fTF3DAprdDbpB9iKDzPi2cIh3
	 SfssvauRK58kMTCq49ghRz7l36sZC/1noHjYmTjiO3K2HQ7/6XNBvgo05j+KEcDfQVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nR4xwkhR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2433606A320
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nR4xwkhR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06461F000CA
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 15:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795017486;
	bh=me4+qTl82YgNzGoxWyEsprjq4fF403Or/YIKNaUUYpQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nR4xwkhRI/v0pirr69rC2d3WKCnJTP4lIle5SWKjzRn/6ZsJkm24z38aBNEOeFFkj
	 2Vx4NoUbgVLujCUM9Es41pAVcgg30YsN7lJPElJem+fAiOZEfFbpNC8hu4zk3ZPI8L
	 wyHNo6dHrT8Mw2BsSTkCo5PTEa1Z66q53DszEQfKHStlEEzC0M+3b8r4HVO30BdQ99
	 TwYkgEjgE8ZzHAZlE7ba6Bx4XfVI4z69YGwmLHjqgP2AiE5yIWOq+GsRBAzaUtmezU
	 Rcybc1skq2dGcuDD/uG5h+4m2kJRWqyitpA+8GyKvCdD/Rf9J6npBHpqSB7h2blnz3
	 6TJ9ol3BFwetw==
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7777fa8f1ccso417642137.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 07:58:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErERlYXD3JUPT4Jx5J0zY9hUoExaqqSJVLEWrF+o0d6ynLejNRexmhvUI7ZfQXUEsagbZKyvKVYlCQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+PGHWR7cxcLgkTO5XTEijmXbfKyCEkFwCtWy/sz9gPu5CqVWxY
	XHtQcERjRMf/NAWbUAZfziVYezbJpWcIfZfoa2uWEixsBrYUfmZF/P5iuKQmMsZ+S0Odd49Az6w
	HfUpLuYEZJNX1uDLpNpjX4fk13zVwvBw=
X-Received: by 2002:a05:6102:1612:b0:7cb:288a:b66d with SMTP id
 ada2fe7eead31-7d6ba40e058mr1004520137.20.1795017485944; Wed, 18 Nov 2026
 07:58:05 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794992905.git.daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <cover.1794992905.git.daniel.lezcano@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 18 Nov 2026 16:57:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ghznYScteMQzFkcJsMfOTDPRE+JWBoeJg7NurfcfC57A@mail.gmail.com>
X-Gm-Features: AclHuK-WQPlonzR9YQhr-Qu9V32wHoz2Spuu5LyQI3pgmeJNe67xVbxgzHuFNm8
Message-ID: <CAJZ5v0ghznYScteMQzFkcJsMfOTDPRE+JWBoeJg7NurfcfC57A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] powercap: idle_inject: Create threads on demand
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: tglx@linutronix.de, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Ziljstra <peterz@infradead.org>, Bradley Morgan <brads@mainlining.org>, 
	Heiko Stuebner <heiko@sntech.de>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 11:34=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> Idle injection currently registers per-CPU kernel threads during early
> initialization, including on CPUs for which no idle injection device
> will be registered.
>
> This series makes thread creation follow the lifetime and CPU mask of
> each idle injection device.
>
> The first patch adds an optional CPU mask to smpboot thread descriptors.
> The mask restricts thread creation, CPU hotplug handling and teardown,
> while preserving the existing behavior for descriptors without a mask.
> Registrations sharing task storage are checked for overlapping CPU
> masks under smpboot_threads_lock before any threads are created.
>
> The second patch uses this support to register idle injection threads
> when a device registers and destroy them when it unregisters. CPU
> ownership claims, registration rollback and thread teardown are
> serialized to prevent overlapping registrations from sharing threads.
>
> The series was tested on Rockchip RK3588. The updated smpboot code and
> idle injection code also build with W=3D1. Concurrent registration and
> CPU hotplug runtime testing remains outstanding.
>
> Changes in v2:
> - Reject overlapping smpboot registrations sharing per-CPU task storage
>   with WARN_ON_ONCE() and -EBUSY, as suggested by Thomas Gleixner.
> - Default a NULL CPU mask to cpu_possible_mask at registration and
>   remove redundant NULL-mask checks from the lifecycle helpers.
> - Use scoped guards for the smpboot registration locks.
> - Document the overlap restriction and registration return values, and
>   update the core commit explanation.
> - Add Bradley Morgan's Reviewed-by tag to the idle injection patch.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Bradley Morgan <brads@mainlining.org>
>
> Daniel Lezcano (2):
>   smpboot: Allow restricting per-CPU threads to a CPU mask
>   powercap: idle_inject: Create per-CPU threads on registration
>
>  drivers/powercap/idle_inject.c | 69 +++++++++++++++++++++-------------
>  include/linux/smpboot.h        |  6 +++
>  kernel/smpboot.c               | 45 +++++++++++++++++-----
>  3 files changed, 83 insertions(+), 37 deletions(-)

If I'm supposed to pick up this series, please resend it and CC both
patches and the cover letter to linux-pm.

Thanks!
