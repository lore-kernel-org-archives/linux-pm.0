Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3343A7F72
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773168672; cv=none; b=coc9OEJ6n3tueztcvBqst/ceVH1htDAdzwKMkiROqsr7Ozkfh/WJujbyPk1mWz6SCNmPQjn+IwHR97RZgx/RXcVqfUEOlepUVhi//pqKfpTcmXNfcavZ1tfJLagx2xiIYoGMRFBuNDsgLY5uZGPzzkypOnLRqwZahu3BCZ2/4ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773168672; c=relaxed/simple;
	bh=U5ZaNUhFTLpmbVg+qrtkWdQgJu4O5MbIFKDTUwa2R1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFhAIgc31pIws1h+eGeTtYWrD6jSWRB9sZ2JlYyxtBPzFPii3NLBI1XJuoPAHo5CKI78z3gALK+aC4X4ILm915oa5t3qAJhDVZqdoXQMyk5rNmjWo+6SH/Tok9RAqh2NAwd8YuVxcyr/Pkq2ZNbIyLWyNmf1RTEzSyhXBvwZMfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPCHsBsA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPCHsBsA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5176AC2BCAF
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 18:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773168672;
	bh=U5ZaNUhFTLpmbVg+qrtkWdQgJu4O5MbIFKDTUwa2R1g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dPCHsBsA5Gb76BjRTz7YvsA35P91yzFQsx5r9aZrz5tOWD4Lqk2ebTOWGQCBaWUoG
	 VnfFMpYfjEnfW0lt7vVJ0ovLtWaUzCVsXnTvIFofxhqlO8rjZt+2d99Q09E5+bgXjs
	 HQO/UYRpo11O8bVszGEUgH35fC+ECEBZpq0EM5ufJYzUXgWZG7HA0fi0joBg/Xsi/7
	 XtO6/9Yzl8hPnxyHa/8/xM655RFBqhOq/8xV7qsBqkeKQSYMMUjKqbxgyAFNWvMcBf
	 15+9UPMkgy7UPgxH7Yma8YJ5JxVdUbxPh894zpLoKIP5JUuqYbzpQcz1J6A+Xzgp+/
	 emy7PZw0k+HKg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66281b1018bso4155881a12.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 11:51:12 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywc6ko8MB9gUJV0adNQw+e65I8rDHbcs3B4aCtefkLhJuIOxBWF
	CV1x2hcH9EPqvm3pP28GNNbksPkBG143YVcXQ2Ny90GzjLml7mrTA9KM9ABWtayof/3tf95+uIm
	m/0AUhVppwX8yFIf7YVgv6fT+zYMwuvs=
X-Received: by 2002:a50:cc04:0:b0:662:8678:d59e with SMTP id
 4fb4d7f45d1cf-6628678d5e5mr3019896a12.0.1773168671082; Tue, 10 Mar 2026
 11:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224023719.65165-1-spevnev16@gmail.com> <20260225231603.33160-1-spevnev16@gmail.com>
In-Reply-To: <20260225231603.33160-1-spevnev16@gmail.com>
From: Len Brown <lenb@kernel.org>
Date: Tue, 10 Mar 2026 14:51:00 -0400
X-Gmail-Original-Message-ID: <CAJvTdKn_=HJaRdy_D-i_XtGT=qd=ycxQV35fixHcNzJH_EOFyA@mail.gmail.com>
X-Gm-Features: AaiRm50hRtw7b_kt3LhCRi5BYKHtddiyvwa1cEu8Yx-UjVAYVSMeOoD6Xb052bY
Message-ID: <CAJvTdKn_=HJaRdy_D-i_XtGT=qd=ycxQV35fixHcNzJH_EOFyA@mail.gmail.com>
Subject: Re: [PATCH v2] tools/turbostat: fix microcode patch level reading for AMD/Hygon
To: Serhii Pievniev <spevnev16@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks!

ps. I added a Fixes tag...
Fixes: 3e4048466c39 ("tools/power turbostat: Add --no-msr option")

That is in Linux-6.9, where this cleanly applies.  Technically the logic
was already broken before that in an earlier 6.9 patch, and the original co=
de
was broken years before that, but I expect going back 2-years is more
than sufficient.

On Wed, Feb 25, 2026 at 6:16=E2=80=AFPM Serhii Pievniev <spevnev16@gmail.co=
m> wrote:
>
> turbostat always used the same logic to read the microcode patch level,
> which is correct for Intel but not for AMD/Hygon.
> While Intel stores the patch level in the upper 32 bits of MSR, AMD
> stores it in the lower 32 bits, which causes turbostat to report the
> microcode version as 0x0 on AMD/Hygon.
>
> Fix by shifting right by 32 for non-AMD/Hygon, preserving the existing
> behavior for Intel and unknown vendors.
>
> Signed-off-by: Serhii Pievniev <spevnev16@gmail.com>
> ---
> v1 -> v2: Changed to single MSR path with conditional shift
>
> v1: https://lore.kernel.org/linux-pm/20260224023719.65165-1-spevnev16@gma=
il.com
> ---
>  tools/power/x86/turbostat/turbostat.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
> index 1a2671c2820..7545142b3a6 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -9122,10 +9122,13 @@ void process_cpuid()
>         cpuid_has_hv =3D ecx_flags & (1 << 31);
>
>         if (!no_msr) {
> -               if (get_msr(sched_getcpu(), MSR_IA32_UCODE_REV, &ucode_pa=
tch))
> +               if (get_msr(sched_getcpu(), MSR_IA32_UCODE_REV, &ucode_pa=
tch)) {
>                         warnx("get_msr(UCODE)");
> -               else
> +               } else {
>                         ucode_patch_valid =3D true;
> +                       if (!authentic_amd && !hygon_genuine)
> +                               ucode_patch >>=3D 32;
> +               }
>         }
>
>         /*
> @@ -9139,7 +9142,7 @@ void process_cpuid()
>         if (!quiet) {
>                 fprintf(outf, "CPUID(1): family:model:stepping 0x%x:%x:%x=
 (%d:%d:%d)", family, model, stepping, family, model, stepping);
>                 if (ucode_patch_valid)
> -                       fprintf(outf, " microcode 0x%x", (unsigned int)((=
ucode_patch >> 32) & 0xFFFFFFFF));
> +                       fprintf(outf, " microcode 0x%x", (unsigned int)uc=
ode_patch);
>                 fputc('\n', outf);
>
>                 fprintf(outf, "CPUID(0x80000000): max_extended_levels: 0x=
%x\n", max_extended_level);
> --
> 2.53.0
>


--=20
Len Brown, Intel Open Source Technology Center
