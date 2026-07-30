Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51A93BA237
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 07:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785396174; cv=none; b=oR/MAum3ws8pLscHp5F4JKScAkoYurtiVloHFKBt/JHdidgOuYVwfSS1RZEC/spgIWq4GjIlifgzEZUmfepBjahBNRS14E/9CJj6aZAewnGfj9xNWT08UTR2ACYdlOifNDY8J5qFp/CtkNR8GLuwZpTkzrloRQcmDiYso1+DUi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785396174; c=relaxed/simple;
	bh=iz/v7m4Yjz0F1RKs9gFWrMFT8LvTUrD97PW0JF60rzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKWygjmIBL5afODWSUiTlCmA3LDYVGBxCHmhCoo03pzraImPd7oJUg1aBzMtflgf79nhP4RMuIvDTOdsk8YAx/6CHYB4QwSRijzRS6V2COwtfkvtCpMxNomnor9F/yKp98C7ZuTwfnrXtmt32j6bFhxENRHPmmWWs1Ud2AGShh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=manifault.com; dkim=pass (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b=jQWM+KdH; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manifault.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b="jQWM+KdH"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7ec58fa3e01so908935a34.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 00:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=manifault-com.20251104.gappssmtp.com; s=20251104; t=1785396170; x=1786000970; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=U71dM3kNKqx+E5PqLF8vQcIsE7YvP97iwnDstvqdXBc=;
        b=jQWM+KdHnfY4wgm75kPqQKCudloyWAn0UBjGqnyzjyoItbKZ6eCci1ZAd/x6TAoLzh
         vNGPUgwWMyC5EE3xSoBoXltuYuSGZiKyN254EktPy2cpwaig2cxHQneyaksOQ0VejxaY
         nfI/YPkOnhL7UP2kjV3JCmGRa37oL9fG8Hcd/qEPzkzpVxeGL+TU+Gvv9refrMHU8icT
         +gmuh3L3EXlmX8+pQ8Eho5X5jTHY1B48eTvwgEiLyy6WLiOY0J+S8GM6fDoyQcnFa/62
         sqvpU/SqOnHOlqzjrSRG7x4GILbgDs5VXOVZQkumonUjR2fElGITzDM+JAHqwtrC81Sm
         AamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785396170; x=1786000970;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U71dM3kNKqx+E5PqLF8vQcIsE7YvP97iwnDstvqdXBc=;
        b=qWud7xobcP+Kouywb2EEJSycQ+N3hM9WzjJP7LMTKWhMvPPr9bm23s1YB9Mv2JNjWR
         WbTO0CXkBp3l8TFKmd2qgCr4mBkPZMwg9G463ZEloQ6OifQ7JLnCgBvzjLfeW1MpnFh9
         HwKgnOsaX5gbOHVyiPrMtgOQ6RYKdD85UWYFmrAg4Bpa+aGAnxycfoCbFTipx106ufPO
         6/Grd0kuj078ue+BsCuyX+kQM1Bt54EZGN3Bca+eN6NWGK3Tgho2ah/Rz2iCb309O15s
         0QTGV6indra1wJclNHEEpvEaL68Md8T74YRv7UBSs6CAMvbGZuGv1Rrf5AASmNXdPjUq
         vQfw==
X-Forwarded-Encrypted: i=1; AHgh+RqlhmNAm87UhkSHndSt5WZpDzcDnWky0s+atuTYKh8SbPgZvXKVNY59VCfuWSisbQRHLU8M605ykA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKkM/En2lXIAAo6tQtBwQbEz39Morto3SuQli4vxAnox764UPQ
	LMyAQ/2luwz1BF+9g9mUalHOrEbdIEQyj+6n5Yg6N/nAL9HdCvNBxpGXqgwBEy5V0Mt+
X-Gm-Gg: AR+sD11dPIkKDO1/FgGAzYL7YLBO+J6aJP1zzyIKFYdsDNZrzHFYs8HYik+VwHfBbkg
	box+DJPrshZNpb50e6S2GQK/WJkWo7UqEFxQTzirok6m6i4sIUNIbcMbXMQZOwcrA/Z2tQOX+f0
	QW6SKa5YX7wIiSQLXj1xKrs+We8k8XoLFh7M37d4sq05yFo8vUVaLXdkTN4qqE4/ooMCYRXYcGp
	piftHV9gq9SgKS6fYH8wJ5m36g4oHDcUpHucG23pXc6f9358EkunuffTuYdAG+2/5fEInbxDA2S
	AFw952l8heelXwHaMCUwIqAQER9Z+lmLCmmXHQ8JFGd4eIKrpyMXgxy9fuSlPn0kjo82nBaPLf3
	CrKYtILoGsUpcKZnmq1E/mf+FqyXnZ7xAsX0dKRn3bln2g6lcgopAoUsoGrYz19NO/sG/I+6wLH
	EGKlQv2Aa0d/SOM7SsseboKFtlfDqqJqEBmAePWYbOqwG8Smris1ffS2xc3IqXJSEfR8vV8v9M7
	vFHwqf6s3HVl2ST92dUxfOt
X-Received: by 2002:a05:6820:1a0b:b0:6a3:e11e:1a17 with SMTP id 006d021491bc7-6acbc12d7fbmr820159eaf.39.1785396170356;
        Thu, 30 Jul 2026 00:22:50 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6acbc5d0273sm875162eaf.14.2026.07.30.00.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 00:22:49 -0700 (PDT)
Date: Thu, 30 Jul 2026 02:22:48 -0500
From: David Vernet <void@manifault.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, Changwoo Min <changwoo@igalia.com>, 
	Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC PATCH 0/4] cpufreq/amd-pstate: Per-core EPP boost for
 recently-busy CPUs
Message-ID: <amryoRIuKC3olg9b@maniforge>
References: <20260728073150.54964-1-void@manifault.com>
 <700ebebe-f4ab-4329-ad43-716d74d6621c@arm.com>
 <40ab4c65-faf5-4a85-8761-bc6ebd1aec90@amd.com>
 <528d4cef-3c79-4b84-a99a-5566f246a4dc@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h3gzubwajo3jmzun"
Content-Disposition: inline
In-Reply-To: <528d4cef-3c79-4b84-a99a-5566f246a4dc@amd.com>
User-Agent: NeoMutt/20260105


--h3gzubwajo3jmzun
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 0/4] cpufreq/amd-pstate: Per-core EPP boost for
 recently-busy CPUs
MIME-Version: 1.0

On Wed, Jul 29, 2026 at 08:42:45AM +0530, K Prateek Nayak wrote:

Hi Prateek!

[...]

> >>> This series instead adds an opt-in, per-core EPP boost. When the
> >>> epp_boost module parameter is enabled, an update-util hook samples ea=
ch
> >>> core's C0 residency (delta MPERF over delta TSC) at most once every
> >>> 10 ms. If a sample shows the core at least 50% busy, the EPP field of
> >>> its MSR_AMD_CPPC_REQ is set to performance (0) and held there until
> >>> 300 ms pass without another busy sample, at which point the hook
> >>> restores the request that policy management last stored in
> >>> cppc_req_cached. Both writes happen only on the busy and idle edges, =
so
> >>> the CPPC_REQ write rate matches that of a global EPP=3Dperformance
> >>> setting. min, max and desired perf are never touched. The mechanism is
> >>> only available in active mode on MSR (X86_FEATURE_CPPC) systems, since
> >>> the hook does local MSR accesses from scheduler context which the
> >>> shared memory interface cannot do. It composes with dynamic_epp, which
> >>> selects the policy EPP from the platform profile and power source.
> >>> epp_boost temporarily overrides whatever policy EPP is installed and
> >>> restores it when the core goes idle.
>=20
> I would also like to know Rafael's thoughts on kernel modifying the
> EPP to something other than what user has programmed.
>=20
> There are a ton of userspace tools that have currently profiled a bunch
> of systems and use the EPP interface to program a good default and their
> expectations may diverge if kernel starts modifying EPP underneath them.

Yeah that makes sense. I figured EPP was the right abstraction to tune
if we're going to use scheduler input to provide hints to firmware but
yes it is indeed modifying EPP under what was explicitly configured. My
thinking was that this is an opt-in parameter but I agree that it's
maybe not desirable to change it underneath what was explicitly set by
the user.

> This almost feels like putting the ondemand governor into the driver.
> Perhaps, the active mode drivers can be made to support the dynamic
> governors as opposed to just the static ones? that fits the overall
> cpufreq subsystem better but I'll wait on Rafael's thoughts on that.

Good question. I'll defer to you folks on whether that direction makes
sense. If it does and would help facilitate this, I'm happy to help
explore it.

> > Have you seen the series from Prateek that reworks how dynamic EPP
> > works [1]?=A0 It becomes an energy_performance_preference that userspace
> > can opt into.
>=20
> I feel like that will come short of the expectations here because we
> would like to do this per-CPU based on utilization metrics as opposed
> to system profile / power status both of which are global and can lead
> to faster battery drain.

Yep, +1, I do think we need per-CPU tuning here. That said, I am happy
to test dynamic EPP and see how it fares. I can try to find time to do
that this weekend.

> > I did have aspirations to hook into more changes than just platform
> > profile and power source eventually, so it sounds like we're at least
> > thinking in the same area.
>=20
> Ack! We'll at least need more input to the dynamic mode to cater to
> this specific case but it is going into the governor territory at that
> point if we want to use CPU specific signals.
>=20
> >=20
> > [1] https://lore.kernel.org/linux-pm/20260727072056.1248-1-kprateek.nay=
ak@amd.com/
> >=20
> > Can you rework your series on top of that and see how the mechanics wor=
k out?
> >=20
> >>>
> >>> Precedents
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>
> >>> The closest precedent is intel_pstate's hwp_boost. It has the same
> >>> overall shape as this feature. It is an opt-in update-util hook that
> >>> temporarily rewrites the HWP request from scheduler context on a boost
> >>> edge and restores the unboosted request after a hardcoded hold time
> >>> (hwp_boost_hold_time_ns). It differs in two ways, both deliberate:
> >>>
> >>> 1. Trigger. hwp_boost activates on SCHED_CPUFREQ_IOWAIT. The waits
> >>> =A0=A0=A0 that matter here are futex waits and amdgpu fence waits, wh=
ich do
> >>> =A0=A0=A0 not set the iowait flag, so a C0 residency trigger is used =
instead.
> >>> =A0=A0=A0 Residency also naturally covers the "mostly busy with short=
 gaps"
> >>> =A0=A0=A0 pattern rather than only the wakeup instant.
> >>>
> >>> 2. Knob being boosted. hwp_boost raises the HWP min.
>=20
> I think that is why it is acceptable to be used with FW based scaling
> as it leaves the user programmed EPP alone.
>=20
> >>>                                                       As described
> >>> =A0=A0=A0 above, a min_perf floor measurably regressed the tail on Va=
n Gogh,
> >>> =A0=A0=A0 so this feature biases only the EPP hint and leaves the pla=
tform
> >>> =A0=A0=A0 free to drop the operating point during the idle portions o=
f the
> >>> =A0=A0=A0 frame.
> >>>
> >>> On the thresholds themselves, the sample period, busy threshold and
> >>> decay window are hardcoded rather than exposed as tunables. I'm not s=
ure
> >>> if this is appropriate or not, but it seemed like it followed existing
> >>> contours.
> >>>
> >>> hwp_boost_hold_time_ns for example is a hardcoded 3 ms, and schedutil=
's
> >>> iowait boost decay is tied to TICK_NSEC, with no knobs for either. The
> >>> 300 ms decay is sized so that a render thread which is only 50-80% bu=
sy
> >>> from periodic vsync and GPU-fence waits holds the boost across its wh=
ole
> >>> busy period at a couple of CPPC_REQ writes total, while an idle core
> >>> sheds the boost well before it can matter. The energy exposure of a w=
ide
> >>> window is small because EPP only influences behavior in C0 and an idle
> >>> core sits in CC6 regardless. If folks want me to make these tunable I=
 am
> >>> happy to expose them.
> >=20
> > In a lot of ways I feel like you're fighting with the hardware (and
> > active mode) by doing it this way.=A0 Did you look into using passive
> > or guided mode instead?=A0 They might be better suited for what you're
> > trying to do.
>=20
> Ack! Seems like UCLAMP_MIN + natural accumulation of PELT signals when
> running with passive mode + schedutil can achieve the desired results
> here but ...

Actually, the first thing I tried in general with this effort was to
raise min_perf to nominal on busy cores, with an idle-path restore
(answering your question below). It reached the same 3.5 GHz median as
the EPP approach but surprisngly regressed frame-time p999 by 13-21%
which I was of course not expecting. I'm not 100% sure why this happens
but I _think_ what's going on is that on this APU, the CPU and GPU share
one SMU-managed power budget, and holding a frequency floor through the
micro-idle portions of each frame (vsync and fence waits) takes away the
headroom the SMU needs to keep the GPU fed.

I'm not sure this is what's happening but in the traces I was looking at
where this occurs, I didn't see CPU pressure so I'm assuming it was GPU
hitches. I'll validate this again over the weekend. I also haven't tried
using UCLAMP_MIN, so I'll put that on my TODO list as well.

With all of that said, something I did realize while looking into this
is that Proton doesn't actually implement the functions to tag the
render thread [0] (Changwoo please correct me if I'm misunderstanding
something here).

[0]: https://github.com/ValveSoftware/wine/blob/proton_11.0/dlls/avrt/main.=
c#L57

If we were to leverage this and be able to configure these high priority
tasks with the correct UCLAMP settings, etc, I think it's likely that it
would give us as good or better results, yes. Though, I guess that's
still assuming that the SMU will do the right thing w/ the CPU/GPU power
budgeting.

> >=20
> >>>
> >>> Testing methodology
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>
> >>> All numbers are from a Steam Deck LCD (Van Gogh APU) running in active
> >>> mode at EPP=3Dbalance_performance, using the Civilization VI graphics
> >>> benchmark as a single-thread CPU-bound workload with a repeatable
> >>> built-in benchmark pass.
> >>>
> >>> Comparisons were run as interleaved A/B tests with 6 iterations per
> >>> configuration. For each run I collected per-frame frame times and the
> >>> busy core's frequency, and derived average fps, 1%-low fps and the p99
> >>> and p999 frame-time percentiles. Deltas were evaluated with Welch's
> >>> t-test, and I report the p-values alongside the deltas below.
> >>>
> >>> Results:
> >>>
> >>> Default settings
> >>> ----------------
> >>> The busy core's median frequency sat at 2.43 GHz despite 98%
> >>> utilization, which is the frequency droop described above.
> >>
> >> Two things to confirm for my understanding:
> >> -Median frequency is the 50th percentile when weighing the OPPs by
> >> residency, right?
> >> - You're also using busy_pct =3D delta_MPERF * 100 / delta_TSC as
> >> utilization, right? (Not util_avg or anything like that)
> >>
> >> Your observation looks like a firmware or SMU issue.
> >> Can we confirm the (short) sleeps reset the demand-estimation, i.e.
> >> by tracing cpu_idle/sched_switch and sample APERF/MPERF alongside it?
> >> Also rt-app might be helpful to get a feel of how this behaves (and
> >> create a similar pathological case like the single-threaded game).
> >>
> >>>
> >>> Global EPP=3Dperformance
> >>> ----------------------
> >>> Globally forcing EPP=3Dperformance lifts the median to 3.5 GHz, cuts
> >>> frame-time p999 by ~40% and raises 1%-low fps by ~16%, but does so on
> >>> every core and for every workload.
> >>>
> >>> Raising min_perf to nominal on the busy core
> >>> --------------------------------------------
> >>> A variant of this patch that instead raised min_perf to nominal on the
> >>> busy core reached the same 3.5 GHz median yet regressed p999 by 13-21%
> >>> by perturbing the SMU boost management as described above.
>=20
> ... this is interesting. Isn't Steam Deck a Zen2 machine? Does that
> have the MSR interface for CPPC?

Yep. Van Gogh sets X86_FEATURE_CPPC and amd-pstate runs the MSR path on
it. Also, FYI I just realized that in the cover letter I said that I was
using the LCD Steam Deck but I double checked and I actually have the
newer OLED one. So all of the data in the cover letter is for an OLED
Steam Deck.

> Also when you say you set min_perf on a busy_core, do you restore it
> back on the idle path?

Yes, I did the same thing there as the posted series (meaning raise it
on the busy edge and restore after a decay window with no busy samples).

> I'm assuming what happens with min_perf method is that SMU is more
> aggressive at delivering nominal_perf and beyond, compared to the EPP
> performance route which perhaps starts off lower but has a steeper
> rampup curve compared to EPP balanced.

That reading is consistent with everything I have measured so far. The
trace data that informed my reply to Christian [1] shows that under
balance_performance, any block longer than ~0.2 ms resets the busy core
to a sticky ~2.4 GHz plateau, independent of which C states are
available. So the EPP hint seems to govern how the core recovers after a
sleep rather than preventing the reset, while the min floor prevents the
drop across the sleep entirely, which is seemingly what perturbs the
shared CPU/GPU budget here (again I'm not sure about this but I think
that's what's happening because I didn't see CPU contention in the
traces where this was happening). The synthetic reproducer I'm putting
together this weekend should let me measure the two rampup curves
directly, and I'll post those numbers in this thread.

[1]: https://lore.kernel.org/all/amrZ08BnDP4OriHa@maniforge/

> Could you get some turbostat traces for both case with Civ VI to see
> how the frequency scaling behaves with the EPP route vs min_perf
> method?

Yes, I will do this too. It's been a crazy oncall week at work so I've been
pretty tied up, but planning to put some more time into this over the weeke=
nd.

> I'll try to compare your method vs min_perf =3D nominal_perf method on
> my Zen3 laptop over the coming weekend to see if I'm able to repro
> this SMU behavior.

Nice, yeah that would be great. I'm not sure if it will be fully apples
to apples given the whole shared power budget thing, but would
definitely be good to see if you can reproduce on your end.

Thanks,
David

--h3gzubwajo3jmzun
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCamr7xwAKCRBZ5LhpZcTz
ZAXMAP4rwdlD/lPP1GhQRNBR7smPkf+hbVMlUIYfMAUsCN+nQQEA6YYVfjejGR0r
afwU01DkGW1F4UqX9xqoUXkxabEN/gE=
=Kbst
-----END PGP SIGNATURE-----

--h3gzubwajo3jmzun--
