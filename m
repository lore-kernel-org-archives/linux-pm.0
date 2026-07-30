Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D040B318EE2
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 07:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785397804; cv=none; b=NbMyTmKtvwuigQFiJXzPiucxqJubic9v64JQN4DprpqE6w/o5AGW7WKd8QfaBoNUXf72s1PQ5P5BzwjbDh2bs7ovS/jec++rN/SBNDFTMIwMsAHRENeG4ZM1myxdCWJHYVoR3xEQBkSw0PArdkDj2BOApbCF8oIKO+WE/fKHaE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785397804; c=relaxed/simple;
	bh=V4XB6Z2WcelOH80PVFy0hXEl/U5gL2srcXIIlGS3z3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noChlnnl95dFXIj5nIdvO+FSSO4jOjzzW60sfVc5ElC4ozu69O7Sxp0mTFDHuM5RuzKzT+Ix6ecTtq0IM9Ns1FvTL8vihtJYSXVRSFxS/q1D4FY/6TVu8VCOqLa3StYGg9pxSyGryPc29B7VdLYBVqIK07gxLEcuzk/CyyZvb+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=manifault.com; dkim=pass (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b=GbrFp0cw; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manifault.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b="GbrFp0cw"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7ea9c6ea7deso1133197a34.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 00:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=manifault-com.20251104.gappssmtp.com; s=20251104; t=1785397801; x=1786002601; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MMcX5Rjc2WXkq4n3CTVj+weAnFVZCpuT2pl5NdS61yc=;
        b=GbrFp0cwSmiDlI+9M3vZc8FYmzHSoEky3BmI111BpM9k9T/XzqSUMRmjrcx2aD2hft
         9hc9ytVhvm2jsL/fxnDSw4SWE/jyH0PMQc5WdTqfKamT9q3+diwTs0vwVfw4F3AUPo87
         Ret8X4KY4Y12lkTBbDImUQlaU7AOqqVnLCabikrrzg3UdJcPkUSE8cnnO44X4bGMRb9d
         1tvAzRHVdx/SmeItSN1tk/0f/4mTJ9UIySMgg1h5PVamqOAA21cuFsmd/ErRXNYgeNqY
         4fAUojpmYEv1UGLcJ9L3qyR3vgFiWxV5J+ZDww91qwG5WFY3CJlV3/ld4w445MFYhH7x
         xJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785397801; x=1786002601;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MMcX5Rjc2WXkq4n3CTVj+weAnFVZCpuT2pl5NdS61yc=;
        b=XA7XhsIHJA/Tv5BYDZ4GuLz1/CDF0brDXkivwc9VJ11+VtUensTChx8+h5SBicTFn6
         QQVVGAGLeN7QIIPqpRf2iQWPnNB0V28FakhkpyaOAtkfQvb5UFnaclwg7efD9BTeYaYT
         U42GFNOaTMpJ5e0nHvP6M358o3zpmGN24GkGfLAJrAAPoFgKTDTsIfupxOIqDni0pMUx
         LoyI9oaU3AtoJw/00sAgn2KuH/i0hqgZtMCMFx3Bzq/GBUFoadklrTu8UdQV1Wsjb4IH
         xvfIGx0mAq3kZdtqxnfUUpd6PBM3KoehXFuXfU75lsdl3N4KHtHL/TNu4EdkapkLtd/C
         vefw==
X-Gm-Message-State: AOJu0YwT58RldkfgvPm6/sFaosDNfE/ESiTvxlydXltbI5XVX8nJNr2e
	+WBgX3VWeUFPjfJqgun45oS9ub+MLJ/fvPrBioU0hr+1JENGrm6T5DDtBXaFYQUP6QREhH5Qcpk
	0qGsxz8cJ
X-Gm-Gg: AR+sD11+RwV4idlEtN6/Se9o/HmBMgAr9SIx2fc8xNJ/KXWx1TerI1tdh9GAxaEUCk4
	v8aG0EJ+1fQC0QQ5A44L/HIrGtXXhs8f6bDawiG5CBoNm5yg5wrPOIH0QrmTm/TxurKo0pQq2RK
	307+AjxFFTkHsU82Cl8y7i0+tU0HRGcIZlEg5tvJ8GavYSE5YPoJWzoIUL2gURjqnXh50/rETfF
	tEPdGSo+djwKveyP8UEmfeO2Zv+AH8j0P8LWhEj5OgoQWx7alZPgpvsybsdNgMp63cBOxznP0bT
	fmK+qGEArRHdunwiMV9puuKKVd9aq1DHDPPtnW5NyfDOVzpiUzk5bNtlvdLMTN+8W5471mK3YAb
	JoJMF6p9b2VyQyE1SKMWehpwiYouBAyWrebvtMVcMA4csB28QdWDfAjc6jyvJ0tspcDnW5BAdAj
	Ls4esH89M+sNTgMnPhF6I+1gac2aJwQBizOCjWvuD1ZbAJny0oGUTPDOq6X1U6UmhFx4nEJsoEw
	5MVqxQ1Z3vZep4HsqWSEdf9
X-Received: by 2002:a05:6830:6aca:b0:7ec:2fe:1ec0 with SMTP id 46e09a7af769-7f02becbbd2mr799133a34.4.1785397801583;
        Thu, 30 Jul 2026 00:50:01 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f00d94d7desm4234393a34.22.2026.07.30.00.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 00:50:00 -0700 (PDT)
Date: Thu, 30 Jul 2026 02:49:59 -0500
From: David Vernet <void@manifault.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, Changwoo Min <changwoo@igalia.com>, 
	Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	K Prateek Nayak <KPrateek.Nayak@amd.com>, Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>
Subject: Re: [RFC PATCH 0/4] cpufreq/amd-pstate: Per-core EPP boost for
 recently-busy CPUs
Message-ID: <amsABQU2GiJqSNsS@maniforge>
References: <20260728073150.54964-1-void@manifault.com>
 <700ebebe-f4ab-4329-ad43-716d74d6621c@arm.com>
 <40ab4c65-faf5-4a85-8761-bc6ebd1aec90@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dbbisx2ty3hhe5sk"
Content-Disposition: inline
In-Reply-To: <40ab4c65-faf5-4a85-8761-bc6ebd1aec90@amd.com>
User-Agent: NeoMutt/20260105


--dbbisx2ty3hhe5sk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 0/4] cpufreq/amd-pstate: Per-core EPP boost for
 recently-busy CPUs
MIME-Version: 1.0

On Tue, Jul 28, 2026 at 02:43:46PM -0500, Mario Limonciello wrote:

Hi Mario,

[...]

> > > This series instead adds an opt-in, per-core EPP boost. When the
> > > epp_boost module parameter is enabled, an update-util hook samples ea=
ch
> > > core's C0 residency (delta MPERF over delta TSC) at most once every
> > > 10 ms. If a sample shows the core at least 50% busy, the EPP field of
> > > its MSR_AMD_CPPC_REQ is set to performance (0) and held there until
> > > 300 ms pass without another busy sample, at which point the hook
> > > restores the request that policy management last stored in
> > > cppc_req_cached. Both writes happen only on the busy and idle edges, =
so
> > > the CPPC_REQ write rate matches that of a global EPP=3Dperformance
> > > setting. min, max and desired perf are never touched. The mechanism is
> > > only available in active mode on MSR (X86_FEATURE_CPPC) systems, since
> > > the hook does local MSR accesses from scheduler context which the
> > > shared memory interface cannot do. It composes with dynamic_epp, which
> > > selects the policy EPP from the platform profile and power source.
> > > epp_boost temporarily overrides whatever policy EPP is installed and
> > > restores it when the core goes idle.
>=20
> Have you seen the series from Prateek that reworks how dynamic EPP works
> [1]?  It becomes an energy_performance_preference that userspace can opt
> into.
>=20
> I did have aspirations to hook into more changes than just platform profi=
le
> and power source eventually, so it sounds like we're at least thinking in
> the same area.
>=20
> [1] https://lore.kernel.org/linux-pm/20260727072056.1248-1-kprateek.nayak=
@amd.com/
>=20
> Can you rework your series on top of that and see how the mechanics work
> out?

I hadn't seen it before posting this, thanks for the pointer. Agreed
that we're thinking in the same area. The way I see the two fitting
together is that his rework decides the policy EPP from system-level
inputs, while this series temporarily overrides the EPP of individual
busy cores and then restores whatever policy management installed. So my
expectation is that they compose rather than compete, but I'll rebase
and test with his changes and report back.

[...]

> > > On the thresholds themselves, the sample period, busy threshold and
> > > decay window are hardcoded rather than exposed as tunables. I'm not s=
ure
> > > if this is appropriate or not, but it seemed like it followed existing
> > > contours.
> > >=20
> > > hwp_boost_hold_time_ns for example is a hardcoded 3 ms, and schedutil=
's
> > > iowait boost decay is tied to TICK_NSEC, with no knobs for either. The
> > > 300 ms decay is sized so that a render thread which is only 50-80% bu=
sy
> > > from periodic vsync and GPU-fence waits holds the boost across its wh=
ole
> > > busy period at a couple of CPPC_REQ writes total, while an idle core
> > > sheds the boost well before it can matter. The energy exposure of a w=
ide
> > > window is small because EPP only influences behavior in C0 and an idle
> > > core sits in CC6 regardless. If folks want me to make these tunable I=
 am
> > > happy to expose them.
>=20
> In a lot of ways I feel like you're fighting with the hardware (and active
> mode) by doing it this way.  Did you look into using passive or guided mo=
de
> instead?  They might be better suited for what you're trying to do.

I didn't try passive or guided mode, but I did try raising min_perf to
nominal on busy cores in active mode (with a restore on the idle path)
just to see what would happen. That reached the same 3.5 GHz median but
regressed frame-time p999 by 13-21%, per the numbers in the cover
letter. I'm happy to test guided mode out and see if I observe the same
issue. Passive mode w/ UCLAMP_MIN I also haven't tested at all, but I
will.

R.e. fighting the hardware, I think the concern is valid, though I do
think there's some precedent given that Intel has their hwp_boost thing
(though as Prateek said it's a bit different than what I'm proposing as
they don't muck with user-programmed EPP hints). The way I rationalized
it is that EPP is the hint interface the hardware gives us for exactly
this kind of bias, and the boost only moves it temporarily for cores
that are demonstrably busy. But active mode wasn't really designed with
this kernel-side dynamism in mind, so I'll defer to you folks and Rafael
on whether this is an acceptable shape for it (or whether Prateek's idea
of possibly having the active-mode drivers support dynamic governors
would make sense).

Thanks,
David

--dbbisx2ty3hhe5sk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCamsCJwAKCRBZ5LhpZcTz
ZESmAP9b7c/CFO31jEfL1itlxzNJD7VaLM2P6TiRjx0o8ojn8gEAsAci+0CySmxf
bIB9TXmsupm1IP/NX4VRnDUH2OR6CAE=
=6IxJ
-----END PGP SIGNATURE-----

--dbbisx2ty3hhe5sk--
