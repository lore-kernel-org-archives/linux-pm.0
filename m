Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13FB3CC7CD
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797495; cv=none; b=MKA4ZeX5CaBuk01Sqw6Cg4sCAfnuJ9z4QekAhX/15ICkwcfVl1MK5ybSUlBkyTb//MeUCQRdQdPEa/I1U5QwPphk36Bwz+GX025fEW6SGBwvLZe029mNnuYhX5VIm0cmEiB9adTgfWbbmdZskJFAW83FNsLPa/CJsoBz57Qa2iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797495; c=relaxed/simple;
	bh=q+bWtDiDG6j9HrzC+c8m9pU40rXgpApbukotzqZv8H8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYXlxuYUzcEHPbxmbTe2xrO5ByryQ9TQulcAvL2YiAuoli0jhWaCPwNdSKI7f02pl+Zyjudm0CAEaI/zHD+fHENWQscOgr2bpoPIASCVaJDoOarJ2hnhnrPP2TwDWdkkCTMyATsUvUbQDYhNPBkxpt1tNceHmG1k94lIQhyNZnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5Ox4MEu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5Ox4MEu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AE01F0089F
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 19:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790797493;
	bh=VwKsTpswmlMVB+LMODH+J9Vdjg6BRBH7E4RDvw9O45I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=R5Ox4MEuEVna8olGNdw6Bty+y8M/4/yK9wxhjyx/HozvjvoZ34k+8wNMKZUqBDCK1
	 PwAVHX+iBHtdb/02em/EhpMYRXTkL8pW602hRy8bbr7Ut2GPAsPyXLfYBAbrKVqI1+
	 3etHPkLeJk2+OinlLpX6BsnCit/40HtJM7+Mjoe/MmOi7p2cpECSFc0ld8KHJv6TQ6
	 T6vte0VF0cXcNbn9PNRE63D+Ef+Og7Fv59AB1826OCNkD/ypdmUoit85G0Aq8QtLCq
	 glSL0FzcE0KFDjzcATgl5zGJ5Fsa8cYLGawjwJBIWx3Z7eCgJ0uSKqmGkBKxFbbCYl
	 IIJLPMgWXZgEg==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba40cb7246so761484e87.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 12:44:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxVHxGg+AfxIAwgc8TrOMmwOn4TvsT+CsdzflEZE3SocRwpecA8Ij75VeI701KI4Q4WW9E2rOMJmg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJqvjoMgoq/5zHWza6tu3cgamMnADUqmt3TN0UmUkSBAklfr1NR
	2vI1AcdyZUZI1YsmQkLvZ0fVp6z1tuUq7iK8yyPfjJStdW2v0MJ8nXN0KlSNuT7cGeMN6cs2rYS
	ja7DLD8fVIc9DbMmPTrqHQJutj7JoOOU=
X-Received: by 2002:a05:6512:66c9:10b0:5b8:f2bf:6b9d with SMTP id
 2adb3069b0e04-5ba406197f3mr806651e87.59.1790797492205; Wed, 30 Sep 2026
 12:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924160052.2858456-1-superm1@kernel.org> <20260924160052.2858456-2-superm1@kernel.org>
 <213bc2ba-2ee4-4a89-9054-3bd953546789@arm.com> <c20aa0b6-30a7-4c88-80e0-21bd5e97c0c8@kernel.org>
 <CAJZ5v0iYf1dXVX4LFeWnnsatA8b0LahRfJUe8hH7-978z+nKxg@mail.gmail.com> <01667c52-284d-47ba-aa9b-2b0ff685610a@kernel.org>
In-Reply-To: <01667c52-284d-47ba-aa9b-2b0ff685610a@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 30 Sep 2026 21:43:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ig_sfHd6iG0n4ZA=957+YuvYE3y08xbj93n6ktaV9PVg@mail.gmail.com>
X-Gm-Features: AclHuK9VJjaSDUCWTz5H8motFXKbHGpCXbJAGZbK9EJQWdg6WKHmNMzCrSOFlH0
Message-ID: <CAJZ5v0ig_sfHd6iG0n4ZA=957+YuvYE3y08xbj93n6ktaV9PVg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ACPI: CPPC: Refactor boost ratio handling
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 9:41=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 9/30/26 14:37, Rafael J. Wysocki (Intel) wrote:
> > On Fri, Sep 25, 2026 at 4:54=E2=80=AFPM Mario Limonciello <superm1@kern=
el.org> wrote:
> >>
> >> On 9/25/26 04:40, Christian Loehle wrote:
> >>> On 9/24/26 17:00, Mario Limonciello (AMD) wrote:
> >>>> From: Mario Limonciello <mario.limonciello@amd.com>
> >>>>
> >>>> Rename amd_get_boost_ratio_numerator() to amd_get_effective_highest_=
perf()
> >>>> to better reflect that it returns the effective highest performance =
value
> >>>> for a CPU, accounting for preferred cores and heterogeneous topologi=
es.
> >>>>
> >>>> Add a new helper amd_get_boost_ratio() for doing both for boost
> >>>> ratio calculations and update callers to use it.
> >>>>
> >>>> This refactoring is needed because on some AMD systems (Zen6+),
> >>>> the boost ratio should be calculated from frequency values rather th=
an
> >>>> performance values.
> >>>
> >>> I think I see why you chose to implement it this way (the x86 APERF /=
 MPERF)
> >>> issue, but I'd still prefer it to be spelled out here why this is nec=
essary.
> >>>
> >>
> >> Do you mean in the commit message, like spin the patch?  Or just in th=
is
> >> thread?
> >>
> >> Not all cores will operate at the same frequency and fixed scaling
> >> values from CPPC perf don't apply anymore.
> >
> > Well, CPPC is per-CPU at least in principle, so the above doesn't
> > explain much TBH.
> >
> > It kind of follows from the cover letter that there's something
> > missing in CPPC, so this is a stop-gap thing, but it would be good to
> > put the information from the cover letter to the changelog of this
> > patch.
>
> OK; I'll respin the series with the detail in this commit message.

Thanks!

With that, please feel free to add my ACKs to the first two patches in
this series and route it as a whole through the amd-pstate tree.

> And yeah; this is totally stop gap to allow other development that needs
> this.
>
> Once next ACPI spec is out I'll tear out the stop gap and put in the
> right support.

OK
