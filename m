Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794517351;
	b=Wk1J/BLrtWzyx9TOeI5Ubcq2J9hezLhJSbbjLXHc45OAo89whF/A8q7uZuguHfuwC15x
	 jDBv/mjW8rh7KXmHdNQUMquVQ5Hxb2pHaX0QelHqkOzFfTUNvjozlY3bMtBlvnyg2wFzd
	 A6v+8vrz2Wd+cVfKtYRJQvLhyktaI7a3iBfVKN8LTlD1vyVeThEMZzV6PYjNF0llZ1OBY
	 JEdtzESw7pTtWW0ksAuwc05wi2jY8CqhczEc3krncTBvClRsL9ubbGlCA1CHTxrm/ZmWr
	 JvpZtkGSqpyTSQnMSTU2yMLM/2z0KMwiYjqyGJaT66tLshsRLKhMpsPKjsWVXsnMXBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794517351;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gY2Y4Rus8mhKZ9/ppXxnf5C5fvxQXW+I0/+PnGcN6Ak=;
	b=1QvDPiDAKrz9xYeG6KfUQTDWVkbfgxX1GGg0dAb/2t74agrVwX1XpTEO3hG7KdF2LfQI
	 b0J4abWLcGtIS3HmKS0bjExAfirsmm2heD/Gft1ZWIFemKdiR9X2wWNfuWqK6Zhxyb70x
	 eQAyXuM4pGrfO196Yt61e7o8cF6YM85vJT5m+3GL/GSy1xy+Nwps7wVBNzlpCWhO0wvzU
	 1Lwx2MT7b78f43sN9jywjLTdwfnYWnvHLzN6jza42Q/G4kAzRozeN+YLCEoAlHY6fRxMQ
	 7U3uyb5AYwQYXjoKDRwPiQFBXu1UBgV29UoUQQohtmuM82aSqbtq21HCBF0R7iwMcEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nEArZ1a1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14A2606A31C
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nEArZ1a1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8761F000C6
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 21:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794517350;
	bh=gY2Y4Rus8mhKZ9/ppXxnf5C5fvxQXW+I0/+PnGcN6Ak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nEArZ1a1PclAmNg/7IIop1+AjQlfuZmICwm2bMFfxB8Dz/n7wb8LaZkfn2nWligTO
	 C201nBJcQIW3mrVG3TVnr5utgK7pIdCn7+GV9qhDvjeV3FgsAOfXPP61w9ShAuLuuE
	 ozqKgLrZsSvgDFhphmcYZNquhrICeKza2rK7+tP6k3i4FWq76G7xJJn7D4vrKbuFvs
	 ME1XMVODIvHMTt3k/gfAm1l0iuxK/EYeT9QhD8Mj9HtgS6mQ9JweRGHNoML/Wtfjs0
	 CvU2Q1itkxFMesbZupVPTZiXY8dH8h3mAhyp9d8aUT327fBLDYcypYsCq1fJ/krbtA
	 yE6OZC9BQix8w==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3ae25c846edso1989691fa.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 13:02:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFJekUMHDuhfIcajOFbvHNJnXdx2u/4jEF6P3o/iG74dtxlkZzeB+KdXpkEKzRkBd8mjox4fytuJg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9nEnVBwuvKV2WQqbpuAyh9LquKsV844iK340flenu08AroD2nT
	lrrDyzO+/IrQpq6HffZS46pOgchWixp7gzw0ExEKnfDR3MGvguNhWUZDYIk6xJbBlvCy2sNpnOf
	5D4IMhzIvQw08q5R11ySyaHqHDJxGUpI=
X-Received: by 2002:a05:651c:1986:b0:3ae:25c8:dc78 with SMTP id
 38308e7fff4ca-3ae2b69178cmr2430991fa.22.1794517349043; Thu, 12 Nov 2026
 13:02:29 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <13049690.O9o76ZdvQC@rafael.j.wysocki> <CAJZ5v0gshFCfoscf=q6Hf+=VYP8bgwO1J15AdYAKcCFr8=TtsQ@mail.gmail.com>
 <91039d3d-4438-486f-926b-8befd5a530b5@arm.com>
In-Reply-To: <91039d3d-4438-486f-926b-8befd5a530b5@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 12 Nov 2026 22:02:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iudeZCOJEm_zepr8iZiShVHNiexOYrmNSCV-msXRW6jw@mail.gmail.com>
X-Gm-Features: AclHuK98imb2prwM0se8DZCsrZih559z0f9Axc2VFFC2Jne6fF6A2MvVgks9TVc
Message-ID: <CAJZ5v0iudeZCOJEm_zepr8iZiShVHNiexOYrmNSCV-msXRW6jw@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: CPPC: Drop two compliance checks involving
 nominal performance
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 9:55=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/12/26 17:42, Rafael J. Wysocki (Intel) wrote:
> > On Thu, Nov 12, 2026 at 6:39=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> >>
> >> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >>
> >> On a number of Intel platforms in the field, the nominal performance
> >> value in ACPI _CPC (which is an integer) is larger than the guaranteed
> >
> > I said "larger", but should have said "less".  Sorry about this.
> >
> > Will fix this when applying the patch unless there are other comments.
> >
> >> performance value and it may even be larger than the highest performan=
ce
> >> value (that come from register reads).
> >>
> >> The new specification compliance checks involving those values added
> >> by commit 32299b29a887 ("ACPI: CPPC: Validate _CPC entry and control
> >> semantics") cause the CPPC library to refuse to work for some CPUs
> >> on the affected systems which in turn causes the intel_pstate driver
> >> to overestimate the maximum performance levels for those CPUs.  One
> >> of the affected systems is Dell Pro 5 14 P514260.
> >>
> >> In this particular case, the fact that the specification is not
> >> exactly followed has no implications and the checks enforcing
> >> compliance are not useful, so drop them from the CPPC library.
> >>
> >> If really necessary, they will need to be done elsewhere.
>
> They would've made things a littler clearer but I don't see why
> we strictly need them right now.
>
> >>
> >> Fixes: 32299b29a887 ("ACPI: CPPC: Validate _CPC entry and control sema=
ntics")
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Thank you!

I will need to update the patch because the nom vs min_nonlinear check
is also affected.

I'll send a v2 tomorrow with your R-by if that's OK.

> >> ---
> >>  drivers/acpi/cppc_acpi.c |    5 ++---
> >>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>
> >> --- a/drivers/acpi/cppc_acpi.c
> >> +++ b/drivers/acpi/cppc_acpi.c
> >> @@ -2940,9 +2940,8 @@ int cppc_get_perf_caps(int cpunum, struc
> >>         if (!high || !low || !nom || !ref || !min_nonlinear ||
> >>             high > U32_MAX || low > U32_MAX || guaranteed > U32_MAX ||
> >>             nom > U32_MAX || ref > U32_MAX || min_nonlinear > U32_MAX =
||
> >> -           high < nom || nom < min_nonlinear || min_nonlinear < low |=
|
> >> -           (CPC_SUPPORTED(guaranteed_reg) &&
> >> -            (guaranteed < low || guaranteed > nom))) {
> >> +           nom < min_nonlinear || min_nonlinear < low ||
> >> +           (CPC_SUPPORTED(guaranteed_reg) && guaranteed < low)) {
> >>                 ret =3D -EFAULT;
> >>                 goto out_err;
> >>         }
> >>
> >>
> >>
> >>
>
