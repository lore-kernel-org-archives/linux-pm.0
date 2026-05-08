Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A863264C3
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778267841; cv=none; b=QjchpxhOGjOQ1d7dSr7Hm0Z2C0inFU3m0mGroUF/bK1HxBsBQuriP3YNZ8Iaf1GZj8YPF6olxucymGEmt3CFtgFeEJ6MS2Sfjfh94rThl36Un+x9dIXFa2hnz7Fxv4+H44rUCu4Oprfuj3setF9qFpqtkF867a+Qc3nUo2rQhNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778267841; c=relaxed/simple;
	bh=GTUxtQBzUTRVyOkQ5bCBY1qoUmnSXalLGcYTrKbySWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUUg5rxpSk5A/jasJEwHO0rTlJRsxn9Ar0yRQ1BSCm2zNgr4Z+Za+bPdeH8uKnxVTs42h+bF4NXShlK/ckgbqicb3hSnkY6jP0K081Sr78G1UOvj23PMpjTqgsGpcF+jh9Ad79pPg+LK6A9UnmWKHfMdmf0nd+FchptEttmpW/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHlC6Dls; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHlC6Dls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6FAC2BCB0
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 19:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778267841;
	bh=GTUxtQBzUTRVyOkQ5bCBY1qoUmnSXalLGcYTrKbySWw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bHlC6DlsfTHrtrjQfzx09kZNMIIC9cs99yla8SjcvesJbtWg7JJgtSll4WnJOyLmm
	 4BLlvsB9Neuqf+p8JVLY3UJ76IKbOjOHf17RNIKZ5rsIxAl3pNnypaJpl4Owesyyve
	 y0DA9aJzKWbTDx/o2w1P4Jye3URBL4aNlSLsoYEepR9/jNARj4M7eB9FHyEg1yj8cV
	 +bosyDFHtpxuQJhPZPMx07Up0/6OEyW5Uyf9kGMPOuFH5fDE9PVdNVxXS53FlVoW0R
	 fHeqtJrgnDfIYlsGq6iSE6uZv7SdWH8EpLTbc1ku+U7zmp1idwMRaHtdkaPsQaUu+w
	 6LoBrhDfp4s/Q==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a88db610ccso2650621e87.2
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 12:17:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/DYN79fK/qUFhZ717661mXNC4925vPygINrcJ7Q0o5UIELABafSReBF3fTtMVtkvWSVFBtkvRrLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRqXFfxu39Tw3qFokGx3eSq7JHFnmvNX2Qz39qrC7Qs73KzFgK
	dko/NGJFANyG21PIJ6zkQiNjRIwn2sasvCBhGu8uJyggNPhQOPp1p/oaw7kp/Wix2yoE5nYjTX4
	Y/ZsUGWL9OberRH2GjQnI9cNilgW63j0=
X-Received: by 2002:a05:6512:3b0a:b0:5a8:a558:63b3 with SMTP id
 2adb3069b0e04-5a8a5586493mr1944574e87.30.1778267839918; Fri, 08 May 2026
 12:17:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504230141.484743-1-mario.limonciello@amd.com>
 <20260504230141.484743-2-mario.limonciello@amd.com> <CAJZ5v0gBTxzkQU1EduyBNx2fCYfVU92XcNU8+AbSZziymBdJJw@mail.gmail.com>
 <8e2c9db5-fd24-43a2-af0c-cb2cb54f5102@amd.com>
In-Reply-To: <8e2c9db5-fd24-43a2-af0c-cb2cb54f5102@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 8 May 2026 21:17:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ima4+ieyE1Jem=PRpk1JgZvZQ2sZWBv43=ARWde8jipg@mail.gmail.com>
X-Gm-Features: AVHnY4JZFJJu51VWW5Tu1Dk1TaZPavN065ies9bkFa_MR1S8lfvWyQQ5gLf3s2Y
Message-ID: <CAJZ5v0ima4+ieyE1Jem=PRpk1JgZvZQ2sZWBv43=ARWde8jipg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] Revert "ACPI: CPPC: Adjust debug messages in
 amd_set_max_freq_ratio() to warn"
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org, 
	Kim Phillips <kim.phillips@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 9:09=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 5/8/26 14:04, Rafael J. Wysocki wrote:
> > On Tue, May 5, 2026 at 1:01=E2=80=AFAM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> Some older systems don't support CPPC in the firmware and this just ma=
kes
> >> noise for them when booting.  Drop back to debug.
> >>
> >> This reverts commit 21fb59ab4b9767085f4fe1edbdbe3177fbb9ec97.
> >>
> >> Fixes: 21fb59ab4b976 ("ACPI: CPPC: Adjust debug messages in amd_set_ma=
x_freq_ratio() to warn")
> >> Suggested-by: Kim Phillips <kim.phillips@amd.com>
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   arch/x86/kernel/acpi/cppc.c | 6 +++---
> >>   1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
> >> index d7c8ef1e354d3..be4c5e9e5ff6f 100644
> >> --- a/arch/x86/kernel/acpi/cppc.c
> >> +++ b/arch/x86/kernel/acpi/cppc.c
> >> @@ -88,19 +88,19 @@ static void amd_set_max_freq_ratio(void)
> >>
> >>          rc =3D cppc_get_perf_caps(0, &perf_caps);
> >>          if (rc) {
> >> -               pr_warn("Could not retrieve perf counters (%d)\n", rc)=
;
> >> +               pr_debug("Could not retrieve perf counters (%d)\n", rc=
);
> >>                  return;
> >>          }
> >>
> >>          rc =3D amd_get_boost_ratio_numerator(0, &numerator);
> >>          if (rc) {
> >> -               pr_warn("Could not retrieve highest performance (%d)\n=
", rc);
> >> +               pr_debug("Could not retrieve highest performance (%d)\=
n", rc);
> >>                  return;
> >>          }
> >>          nominal_perf =3D perf_caps.nominal_perf;
> >>
> >>          if (!nominal_perf) {
> >> -               pr_warn("Could not retrieve nominal performance\n");
> >> +               pr_debug("Could not retrieve nominal performance\n");
> >>                  return;
> >>          }
> >>
> >> --
> >
> > It looks like this could be applied without the rest of the series.
> > Do you want me to do that?
>
> Yeah; go ahead and pick this one up.  Thanks.

Done, thanks!

> >
> > Also, do I understand correctly that the rest of the series depends on
> > Sumit's patch set at
> >
> > https://lore.kernel.org/all/20260430142430.755437-2-sumitg@nvidia.com/#=
r
>
> That's correct.

OK, so changes are requested in that patchset and there will be a v3
(at least), so please resend this one when the dependency is
finalized.
