Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E473B19B3
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 09:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786612666; cv=none; b=m0uAdciYTKdHB2fEsx3o0SiMucSwkJnLpfMoNJFdLprrAdqTcXeJZMcCWID3x5/sFU3LWvwlO5AxpvWuMGjFKZP2aMK3twrYEeSF7U+mn0uqtKs7msiBGGq4Jm6LCcM24fmBqi89hnJ8NbrSPKOYCEMCZuOuzwXhe5VwftD3J6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786612666; c=relaxed/simple;
	bh=vygzK1PzLo4VlvwzJyRuGgJZ8O6+ZhIgdeFETeNv1ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=daSP8ykNwQ1CHn67RQn+HCkx0HzAbIdceVhxfn1epAEpwnbFUMWPSAlwrO3w8xEY1DF5ZXkL3mAQenBlUeA1RzQIuAMZjChGeybNzvNF8HJ/ICdhFiEw/Ku9SXiatvRYf1o7iln8Ld+wJaQ08WaIPrw78sic+mrxuvnOSsudncw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZHaL0Aa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZHaL0Aa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397FE1F00ADB
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 09:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786612664;
	bh=ZiQaHKlVZOojfBvj6et1RSp8Tbc+sex+QpH04i1UbGw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OZHaL0AaRub9hYkSwdklfpXJOk6O7XI0F0lZuStCZ3Z8W3O1NUMEZCN/1nT4X8CJF
	 LasyXpjl9UvAPXB06ZjZGrlWw+bCUupjcjSVxSObC1vkbv57HrzcD38pqcDWJO7uA+
	 WWVQXMXyzNfFemG/K+kibbWBsrA7yK0SvpqT4+2EPdcrcu89jpJWkyAl1lNOcTyzai
	 Zw+BG/ZcstRGXyJpzLc8zpVW3Jv3kb4bvef9bKXeOic+GVxFlbM76ro/yCM28M/z/V
	 AwcsHvdsKERocoUb2wBqHubXI+vg+eM7YIjshtbaf2/8GBEEeq8MJMXrziei6bxtpe
	 Jze4j9wmFW84Q==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b28c91fba5so1017196e87.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 02:17:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RroUmDunQ4QtBOftR2AKp7O3iwmYGLmW/8zc40Z73aQGc1U8uMzIeFpVT6RgDS43CzZyNEfhGdsDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1i02i6wyZJijzWJEfBFArtkRaSvbqHFh6u0yGLym6mC1zbi98
	DktHi1rlM1qor6ym9hizpENVooJyaGFqlub4Hxop38SN3pz3h7ovLb7ECiCwnEq96knvY3WRpFy
	3bcASRS7uCjCAaX5CgvaOY6LpiCV13vU=
X-Received: by 2002:a05:6512:6185:b0:5b2:aa6c:3214 with SMTP id
 2adb3069b0e04-5b453f66a84mr716057e87.12.1786612662639; Thu, 13 Aug 2026
 02:17:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <91946ecf-05a2-4479-bade-3d0803bdcba2@oss.qualcomm.com>
 <cf0365de-77ee-4ae9-96bf-0652c172f425@oss.qualcomm.com> <CAJZ5v0ibXHOsa4Pp=A00cKCOiBnk9SMpSk_n9JE2qSYTRZzYrA@mail.gmail.com>
 <86ba3abc-c538-4d56-ac2c-3154b95e00b2@oss.qualcomm.com> <CAJZ5v0g2G7L0hS64Eh14927P7g+eX_3KB_qUehBoa2OUfh+ung@mail.gmail.com>
 <61e48b08-1a91-4d3a-8617-f25980038bfc@oss.qualcomm.com> <CAJZ5v0gi9n4ZAf7YZsf_dXhqYKA3DHZpR_fLmxgukogNKVbb6g@mail.gmail.com>
 <55f4589a-5146-4f46-aed1-39a1c3a15ac8@oss.qualcomm.com>
In-Reply-To: <55f4589a-5146-4f46-aed1-39a1c3a15ac8@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 13 Aug 2026 11:17:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gwXQ3Y=6g=TnR5rpqAkdNCOsNa_yqGcMO5KHOOPuwQog@mail.gmail.com>
X-Gm-Features: AUfX_myM0pPwFGcBRhTN8j9G5HKl7tv6EmWLM6d_8dOr_iA-reuw_qSiVVcuEEc
Message-ID: <CAJZ5v0gwXQ3Y=6g=TnR5rpqAkdNCOsNa_yqGcMO5KHOOPuwQog@mail.gmail.com>
Subject: Re: [GIT PULL] thermal drivers fixes for v7.3-rc1
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux PM mailing list <linux-pm@vger.kernel.org>, "Bryan B. Lima" <bblima@usp.br>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 11:33=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> On 8/12/26 18:04, Rafael J. Wysocki (Intel) wrote:
> > On Wed, Aug 12, 2026 at 5:16=E2=80=AFPM Daniel Lezcano
> > <daniel.lezcano@oss.qualcomm.com> wrote:
> >>
> >> On 8/12/26 14:50, Rafael J. Wysocki (Intel) wrote:
> >>> On Wed, Aug 12, 2026 at 2:43=E2=80=AFPM Daniel Lezcano
> >>> <daniel.lezcano@oss.qualcomm.com> wrote:
> >>>>
> >>>> On 8/12/26 13:28, Rafael J. Wysocki (Intel) wrote:
> >>>>> Hi Daniel,
> >>>>>
> >>>>> On Tue, Aug 11, 2026 at 4:48=E2=80=AFPM Daniel Lezcano
> >>>>> <daniel.lezcano@oss.qualcomm.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>> Hi Rafael,
> >>>>>>
> >>>>>> please ignore this PR because there is a missing SoB.
> >>>>>>
> >>>>>> I'll fix it and meanwhile update the linux-next branch so it will =
fix
> >>>>>> the build issue.
> >>>>>
> >>>>> Well, the build issue is still there in my thermal branch though.
> >>>>>
> >>>>> I've now remerged my linux-next branch to avoid exposing the therma=
l
> >>>>> drivers merge I did previously and I'll wait for another PR from yo=
u.
> >>>>> Worst-case I'll skip the thermal drivers material in my first 7.3-r=
c1
> >>>>> thermal PR.
> >>>> There are 3 fixes on top of the PR.
> >>>>
> >>>> One is obviously to be folded with the existing series as it is my f=
ault
> >>>> I forgot to add the file after fixing a conflict [1] which led to th=
e
> >>>> linux-next build failure.
> >>>>
> >>>> But two were reported by lkp [2][3]. May I take the opportunity to f=
old
> >>>> them with the patches they fix and shall I keep them as is ?
> >>>>
> >>>> [1]
> >>>> https://lore.kernel.org/all/20260811145427.3089426-1-daniel.lezcano@=
kernel.org/
> >>>>
> >>>> [2]
> >>>> https://lore.kernel.org/all/20260811094935.2941313-1-daniel.lezcano@=
kernel.org/
> >>>>
> >>>> [3]
> >>>> https://lore.kernel.org/all/20260811094747.2940616-1-daniel.lezcano@=
kernel.org/
> >>>
> >>> At this point it's better to do additional fix commits on top of the
> >>> previous material as it has all been exposed in my thermal branch for
> >>> which there are no history rewrites.
> >>>
> >>> Please send me a PR with all of the fixes on top of the current HEAD
> >>> of my thermal branch.
> >>
> >> Do you mean linux-pm/thermal ?
> >
> > Yes, that one.
>
> It has my PR in it, should it be reset ?

No, it shouldn't.  Please send another fix PR on top of this one.
