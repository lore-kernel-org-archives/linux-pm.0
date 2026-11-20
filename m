Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202293;
	b=Ry/RMbPkfOc/akSnXJzxRBjVrX/tznI5x+iB0nER1D+JGFXGKt+VPo/aXtxYAwo1+b29
	 kmu7dZ+ghwSIHuIkt8YhHBLuUb+M0Iu6SSz8NERrnOZ/Nt9K0eGq/Qi/zxk74o8vYf1eS
	 B63Msv/ga7RE1rU7eHJ1/UGzpKNW3L8CHrL0OJ5f+76X3vRlGsAimQPlcHtTM7JFuajGU
	 slxz48OvJus51xbuiKd1X0UXNATaPaDE8AW24VahCfc2z0rh343AQGim4Zg6xLrE7QzQS
	 eOAizG9mZhOVDB3qlINepjWNOtIqM3MjeEGAflES2co2ipCfi5h9l3H/XU+3UlmF8yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202293;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=D0aacaaucLazBzamGaNcpBWXLJSLR5Zsq+QZIkHcA28=;
	b=e4bRiE2K0S0VdPb/yRu3A54ufrS5/+WThnQ6wDbdK/By1Cqy8DYOQFqe/p0UwbFuZwNn
	 upWp4954Y4FGRE5YdF7a395LiNFIsR9QwRGSAZ4GjX2nExNvK70OivepV16XiEPInS1Tg
	 Scebc9+UXpsOc6VeANhfY6A8I7z+CU7H4B53zorP9qhyJ/fQqUUEd7vSBVpWFm1V6d9dH
	 K1GgUsYTRbLijcBDt3mspA4OJjaKA7hIgxEsKxaBfsJSMC9s8tTbTSpX2qOk140DCJ7c7
	 vDlPDdiWSms1BeUlNi5rbnspytsMl7TyBNabowDJH6U38aE/6heeGL+1L8hS9wCiDVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MHy5TQQh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AC2606A336
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 19:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MHy5TQQh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1321D1F000E1
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 19:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202293;
	bh=D0aacaaucLazBzamGaNcpBWXLJSLR5Zsq+QZIkHcA28=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MHy5TQQhuQENlW9zWAX/8Qh2ErEMxpjVrDs5fDwxCcveRklEdkTLcxk1fWEmYARs8
	 875mkhukfgGSCbeuC357Bd9638/MFGzqLp1iAcj57Nb0vLDq080LAnKZYCTowgENCM
	 sxMEWILYa6AHg1pa9FiOabJukGDsSSbXw8M4ebB4GEjqw3vrg2Mfuh0iQeHMYa+qPR
	 pos1lVkjxxkA1dBKJgro3hRJZ6w8wNJ3G/3GwVcSeeCY+2VRYsTmZKbKN+k2gsgLTT
	 lkoL8eSAhpd9/FkxTRv7gW+bwfBubqCJA8Cz4iHfrbGU2Dwu11yM/XGS4eZUWnmhTF
	 zkAE7aavtx8Jw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3ae5ab4fcdcso8374071fa.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 11:18:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFHGeF6hVUOEK/iels+yKaBRuAD7vDbFjCa9TAqOcUJA7HzcXiJfckqysxADgS1kInMHzzmzhX7RA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9gVw0RbQbZdbjQJaLg/iM6GqTBfNhQnsa3RvFC/lL1HqxNI3Xl
	Tg4XnEWJ7Ah3iFH6ZobbC445QsuYEjw8/fnYMwoe5b6nKY3ER39Xf1oAX9xFUiSPQa491Rdkq9/
	ohrCLUdxYKlfwxNxojZ0DFXMlwlOlTeg=
X-Received: by 2002:a05:651c:419b:b0:3ac:433c:6ab7 with SMTP id
 38308e7fff4ca-3ae7f9f2550mr11211681fa.16.1795202291354; Fri, 20 Nov 2026
 11:18:11 -0800 (PST)
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
Date: Fri, 20 Nov 2026 20:17:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h_kRcqpfM=8wnEXSnwB5+MHHUd2wK8jruQSRoTYnuXew@mail.gmail.com>
X-Gm-Features: Aa3M54oLwSoxOTZL4M8rcFfriin7DTrg-svIenSNy9jdlFieUb2umtCsC8Amt5k
Message-ID: <CAJZ5v0h_kRcqpfM=8wnEXSnwB5+MHHUd2wK8jruQSRoTYnuXew@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 0/2] powercap: idle_inject: Create threads on demand
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rafael@kernel.org, tglx@linutronix.de, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Ziljstra <peterz@infradead.org>, Bradley Morgan <brads@mainlining.org>, 
	Heiko Stuebner <heiko@sntech.de>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 5:16=E2=80=AFPM Daniel Lezcano
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
>

Applied as 7.5 material, thanks!
