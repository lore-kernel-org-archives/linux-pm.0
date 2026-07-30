Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B92E2798EA
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785398467; cv=none; b=Mhbi/u/3zuvooIOVgulovbXXWXwhXTo1saSerHW3xPD2D9EWEw4u+FHbC9EimIPdaHRqKvlaLlHOw0os9hqiVGEdZxmVs5jascvZI3/rnZUBG2smKk1B9PzuQuCgSK0aF4t3xVrX/vB5qKDQo3SvksX/6lT922H03EqZazU9EG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785398467; c=relaxed/simple;
	bh=6GdWxadPOYk3nQGX/hrojpWutSQaxCe93qKh/dGaD0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxmiUGikjveh34VVAJ16YMq8BCmlmKPZ+tTuvAz0XB/HQ4tSFhdEO+zJBSi4GMG/Kw/YeMQBhTmjK0LaVw/XAqUg9dA0NnWbRtZcFokNjEZSMnhKjOvsBOEzc6h3ewMbbviczZC2QpTSzvBXpfKZVxd2PDFMR1LEMyYIW6EZ/z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=manifault.com; dkim=pass (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b=0t8aBmek; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manifault.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b="0t8aBmek"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7ec1e9d3359so1489328a34.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 01:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=manifault-com.20251104.gappssmtp.com; s=20251104; t=1785398465; x=1786003265; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aiu97T6FRUgxsycdVGsHGAg6QdsysVvNSbM8noRj+g4=;
        b=0t8aBmekxftJhFNzKOVzrvgy0fWR2UsmVJWbjBNkqAouqQOojRvRkW4uht2EZaGSPq
         sKwanHbUnGgSmobP1kIK2KJG7eGTTqm4scogQDkEiXGmlRtX7vjLlu/UkEefJmbBx7p3
         33g23uJQfMtaaie4WsaoKBLdrAYAMWJ8lhsB9b3gQ0VfEVW133NGnDnIHU5ocmR5oTb7
         nbnd2KlJHfnTN3xVnke1uSnuldaumOAW7KyN4ClNFO9T4UkpulM6/cZbMOT2BSKK+GWf
         hJwohm+sWa+q78ciBndQVUE9AJ2VcL+m2z45nyeoujZbuFP6VJGLe04Wf4rvBlltYOTG
         iHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785398465; x=1786003265;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aiu97T6FRUgxsycdVGsHGAg6QdsysVvNSbM8noRj+g4=;
        b=FKC8CKGt4S761j3DePNrC9IansTpqKnmgywnTFEjwoTc/D3ae4pYKgcx8ibZhY69dz
         gywyEa1NDBRWaveTZUdWrBvhbKyDGhrD15PVTHjvUN6dj+CdWUzP1WrCgMwGChtQT8fu
         NzbmwWwYzg8RLyTnqfz0lkJyq5ta9QL/QOnrTXXJY+iEqt+rTmQ+WhNoMsAwW/qeYWLf
         /EoYhsykQYOiCxuuJ2s/6uGnEbQ7Op1ByzOdDI0SraQYVKemDbG+m5pi/Oe6nZ8i/EQC
         rvKtdIo8c5s0GBbpl/ZUyBYik1QoIkUnH9qGn3V9ajDq8DgnGba7i47oRX026FyvfUu2
         sXhQ==
X-Forwarded-Encrypted: i=1; AHgh+RrhVc7eqIUYb7lrM1mLIYrTfWLyec4FN1aaVO05Zup+iekMjYFtmrdSOZvHFiUz2DRAxeTwheUIRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOLqmvIvgV1iV0RsiDZKRWOev/K92eVTO34OKx83NdMMfZ0ed2
	fECBaIr76409eQ69KVF8AqXVHxQjNqEp/ZW8uwG1MANIxMzc8cqSuonC/JWRzadta9+J
X-Gm-Gg: AR+sD13Tdcv1+LTnf00AgzPOVKXhcdzhmTcD1lu/QIssGyu1Sm5Rzwfp2YLm5gq84jb
	+fN3MRV8A3MQgvZ+CYSowxzLHyO6lfwqoLG1OOlr+sjUS3Be+C/VIMqKKplwD5+YG6hWDbppCnp
	f/hWgPvwI9LLeRgl4OlBRNHsBZQ4iZDQ3vKIwDymShpoBOwBzF0QZbSZ166ztz1yJaC5oIdoqe0
	j82+VjM3I2y2/rgcNmXw/tieEUHfCaDO3qT+T5NKL4PkXBxZN37uCeRBGwuMuLcB7s8zjI7Reba
	OodBIWXvwpyibzQXuNlUjbIBA/OE07pqieMBzXxxGoiVqgnZ0ns5+DJxj6rLXVpcjR9rtJE2B43
	nhSCwVG2c9olbFcxAoXaOU4Ju2mffFSNFdUh7ZOrzRAMyk6OQ8wjLBQ9D57KjWNNMU7eeBk3y2H
	kSCqCrXKw0XfxkGTjD9i17e4CAX+BTf0IA7cKwIoYq1qth5NvZxkUdYfuBGxce7vbdX6+qqyu+r
	e/zQvHeHHayq5lbzAwgLCwj
X-Received: by 2002:a05:6830:448d:b0:7e9:419:acd with SMTP id 46e09a7af769-7f02c10a3d8mr842864a34.17.1785398464712;
        Thu, 30 Jul 2026 01:01:04 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f00d94d404sm4174801a34.23.2026.07.30.01.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 01:01:04 -0700 (PDT)
Date: Thu, 30 Jul 2026 03:01:02 -0500
From: David Vernet <void@manifault.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, Changwoo Min <changwoo@igalia.com>
Subject: Re: [RFC PATCH 3/4] cpufreq/amd-pstate: Add per-core EPP boost for
 recently-busy CPUs
Message-ID: <amsCcmMflwkjTpCX@maniforge>
References: <20260728073150.54964-1-void@manifault.com>
 <20260728073150.54964-4-void@manifault.com>
 <0a8a28c6-8af1-4a6e-82d8-166356455aa9@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kks6xh4orkeajjya"
Content-Disposition: inline
In-Reply-To: <0a8a28c6-8af1-4a6e-82d8-166356455aa9@amd.com>
User-Agent: NeoMutt/20260105


--kks6xh4orkeajjya
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 3/4] cpufreq/amd-pstate: Add per-core EPP boost for
 recently-busy CPUs
MIME-Version: 1.0

On Tue, Jul 28, 2026 at 04:02:34PM -0500, Mario Limonciello wrote:

Hi Mario,

Thanks for reviewing this!

> On 7/28/26 02:31, David Vernet wrote:
> > In active (EPP) mode the platform autonomously picks the operating point
> > between min_perf and max_perf, biased by the EPP hint, and the kernel
> > only rewrites the CPPC request on policy/limit changes. A workload
> > dominated by one mostly-busy thread that takes frequent short sleeps
> > (e.g. a game render thread blocking on a futex waiting for the GPU or a
> > worker thread on every frame) can defeat the platform's utilization
> > tracking. Each sleep decays the hardware's performance signal, so
> > post-wakeup bursts start at a low operating point and the frame-time
> > tail inflates even though the CPU is ~100% busy during the frame itself.
> >=20
> > This is a common problem in gaming workloads, and is not easy to solve
> > at the cpufreq layer. We have to toe the line between running at a high
> > voltage unnecessarily and draining battery (and potentially contending
> > with e.g. the GPU for power draw), and lowering frequency on the core
> > that's running the game's main and/or render threads (thus materially
> > increasing frame latency and causing a tail increase in stale frames).
>=20
> I have to question - is this really a good use for active mode?   You're
> basically fighting with the hardware and trying to game the behavior.
>=20
> I wonder if for gaming it would be better to enact guided mode and then l=
et
> userspace limit the range that it can act within.

Yeah I think this is a reasonable callout. This is being discussed in
some of the other threads, so I'll defer to those so we can keep the
discussions in one place.

[...]

> > The mechanism works as follows: When the epp_boost module parameter is
> > enabled, an update-util hook samples each core's C0 residency (delta
> > MPERF over delta TSC) at most once every 10 ms. If a sample shows the
> > core at least 50% busy, the EPP field of its MSR_AMD_CPPC_REQ is set to
> > performance (0) and held there until 300 ms pass without another busy
> > sample. The hook then writes back the request that policy management
> > last stored in cppc_req_cached. Both writes happen only on the busy and
> > idle edges, so the CPPC_REQ write rate matches that of a global
> > EPP=3Dperformance setting. min, max and desired perf are never touched.
> > This mirrors intel_pstate's hwp_boost, except that hwp_boost triggers on
> > SCHED_CPUFREQ_IOWAIT, which the waits at issue here (futex waits and
> > amdgpu fence waits) do not set, so a residency trigger is used instead.
>=20
> I understand using epp_boost in the context of a module parameter to easi=
ly
> activate this behavior, but I don't think that's the right way that it
> should be triggered because it's going to end up effective for the entire
> boot even when you're not running games that you want to use this.
>=20
> I'd think a sysfs knob would be better to activate it if it's going to be
> dynamic

Ack that makes sense, I'll use a sysfs knob in the next version.

> But also - dynamic_epp isn't the default behavior.  What if you
> only activate this when dynamic_epp is set?  IE when using dynamic EPP you
> use platform power profile, power charger, and this running algorithm.

Sure, that might be an option. I'm planning to rebase onto Prateek's
patch set this weekend to test this out, so let's see how that looks and
then we can evaluate further.

[...]

> > +static void amd_pstate_epp_boost_update_util(struct update_util_data *=
data,
> > +					     u64 time, unsigned int flags)
> > +{
> > +	struct amd_cpudata *cpudata =3D container_of(data, struct amd_cpudata,
> > +						   epp_boost_update_util);
> > +	union perf_cached perf;
> > +	bool first_sample;
> > +	u64 busy_pct;
> > +	bool active;
> > +
> > +	if (smp_processor_id() !=3D cpudata->cpu)
> > +		return;
> > +
> > +	first_sample =3D !cpudata->epp_boost_last_sample;
> > +	if (!first_sample &&
> > +	    time - cpudata->epp_boost_last_sample < AMD_PSTATE_EPP_BOOST_SAMP=
LE_NS)
> > +		return;
> > +	cpudata->epp_boost_last_sample =3D time;
> > +
> > +	/*
> > +	 * Counters can reset across suspend or hotplug (so their values would
> > +	 * be garbage), so just recalculate baselines.
> > +	 */
>=20
> This comment confused me.  I at first thought you weren't doing it, but y=
ou
> are.  Basically on resume you treat it as a fresh startup.  I would just
> drop this comment.

Yep, in hindsight I agree this is confusing. I'll drop it from the next
version.

Thanks,
David

--kks6xh4orkeajjya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCamsEvgAKCRBZ5LhpZcTz
ZJwqAP9dUTe5xHTeMxKvtvedC7NOcghe1IAjuutDZYOZVqehigEAiG7Fea2goGiA
EZ+uIMWgsNj14a8q0TTo7B+IH8pp9Qg=
=ycbV
-----END PGP SIGNATURE-----

--kks6xh4orkeajjya--
