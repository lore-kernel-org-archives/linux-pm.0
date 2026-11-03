Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707406;
	b=KGgmf6rRxJ/fPlyOMbFU3SD6HtJ0l6FxjckV2+9GfP0znmqyUpFChPIsK3jVfFGhIEoQ
	 cNulEsLvjMSGTHQtErB67BOVRs1dyYYumGY+MSsoKjq1/XjIw3Zgst0LvA+lVrcaDd81k
	 1P8SIMG+sNyi/2B9ZS4pNk/gEQk7Unv5q+VFDgLcZN6iNOgXiwcPtX4pdlvapRFzWFp5W
	 9T/1GLvNgewdsN21stNZgQGH2V8EuTW2REwEXbDM5Zyng2mmqJxWhcsxAOp0y+RtkF2R0
	 uD700a5dju2dLpZzFHuq+ubgGIAl8bf1QbWDqXXEvxidBTUa3xuDFNTjpkD/lI3gWmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707406;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1W8WQTZ5SUcFsDBxO1ZqR0UOzcPZPwc/WbH72Pz9/TU=;
	b=OdKRO4bpce8JFs2yE85dzBjAlAtgmb2PaVttao9oHGROJIkbFLCL+FvZriHNge4odp1S
	 dBVGXc4U5xgtVNbJMTbvDNZpPSpGyH8duNmo3WwQn1Sk75uYU7Pmwv1j/CYtl9Lh0/LKj
	 iFVaPnwwVC0rDIxgbOdf01brDdG4pK99UyQM5zbQcAD75Nd2djSxG6Gc0sYlRROfkgu6P
	 eMgwxPYXkYFXAxA88MZtp6DkcCOePqpK2nlPNL78M5qY49hlEfH/JcO7BDMOq4mz8Q70Y
	 wTlf9GP0J+ECqw4T1gd9tAKWfskx/S0289LyUia8ODHlE36sT3fmbmKqkDJs0yv7HZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hkjoK2SH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D269606D813
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hkjoK2SH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E33A1F00ADD
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 12:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793707406;
	bh=1W8WQTZ5SUcFsDBxO1ZqR0UOzcPZPwc/WbH72Pz9/TU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hkjoK2SHQzMyKz56lL2k5yD9LiKWA5VjxItgmgGYwSfvdq2BPWTgfFwYneVEp117v
	 OjjoS9uLLRcKA1l/J112eqPuPORHNELJtFgfQKGc6e5X2Ms+5L8KbhgSts6Bf2auY8
	 QNjWNfEaF7l539G1993YA/C7XyVN3osmgZCDozUD/0jNgSNzxSUU51PFCXJUBl3TFH
	 W+VV5ovwkzIfO+dUN64PnJj3oXXXgm4Ma/NPE6vtGXG9ZpJGU9R3/kok3kBA9Xl0D3
	 FP2W1UuJuos0Lc3q6VH/ro8FeSMZx1bh8oF0/T8NGXZ7WB9OdxTe47ayWRY++izoSi
	 j5loTVEaG6bew==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5ba3ac592faso4599861e87.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 04:03:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwr/O+i1iDhPoruRJvNWcoKgGaVVZ6KAijTaS2gZvjfXHnumZNsCR9wwqChovxpyMZtmAgDK40/3A==@vger.kernel.org
X-Gm-Message-State: APuU4Z9/2KhKrYgexJud1W1X0+ok60PYrxDvDZsYNH+wsPptvxcT+8ft
	BnIl4sWvBq0vuczsKAs7U1JOHubzffBDnQ8ow7NLiJXyFk0wUuJNlL0Ir4NvzD3ERfhL9aWXsk5
	wN1it00NxOMdvQM9dSynJ62MhJOdyAMA=
X-Received: by 2002:a05:6512:68b:b0:5be:494a:f966 with SMTP id
 2adb3069b0e04-5bfd9571e12mr4209091e87.44.1793707404521; Tue, 03 Nov 2026
 04:03:24 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <5162355.31r3eYUQgx@rafael.j.wysocki> <aumJ6AmowyjSUecq@vireshk-B250M-D3H>
In-Reply-To: <aumJ6AmowyjSUecq@vireshk-B250M-D3H>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 3 Nov 2026 13:03:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0isDprAo98fhXb8zuKSHS62S6ybMT9ZF0hn_5dBknbwjw@mail.gmail.com>
X-Gm-Features: AclHuK-gNa06fJWnwiow8SDkM42YVX_rdgL6DOT52DEfKhUnpFXz7Wd0cEtqsPQ
Message-ID: <CAJZ5v0isDprAo98fhXb8zuKSHS62S6ybMT9ZF0hn_5dBknbwjw@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] cpufreq: Fix synchronization with system suspend/resume
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, Doug Smythies <dsmythies@telus.net>, 
	Zak <zakbrightonknight@gmail.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 8:15=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 02-11-26, 20:48, Rafael J. Wysocki wrote:
> > Hi,
> >
> > This series fixes issues related to the synchronization between cpufreq
> > and the intel_pstate driver with system suspend/resume mentioned here:
> >
> > https://lore.kernel.org/linux-pm/CAJZ5v0hT6aoX4tuJM+rO_5iequFc_7rEXCoaF=
nHoJBaH3JP4KA@mail.gmail.com/
> >
> > The first patch actually prevents governor operations from being
> > carried out on suspended cpufreq policies.
> >
> > The second one forces the driver callback to be invoked on the
> > first frequency update after cpufreq policy resume.
> >
> > The third one causes intel_pstate to invalidate the cached last
> > P-state value during suspend.
> >
> > The last one is a cleanup on top of the previous three.
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Sashiko has found problems in this one though:

https://sashiko.dev/#/patchset/5162355.31r3eYUQgx%40rafael.j.wysocki

so I'll respin the series.

My current plan is to restore cpufreq_suspended checks in addition to
the new policy->suspended ones and call cpufreq_exit_governor() during
resume for the policies that were suspended during system suspend, but
are not inactive.

As for the issue flagged in the second patch, I'm going to limit
setting force_target to the drivers implementing the .target()
callback without a .get() one.

Thanks!
