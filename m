Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505364;
	b=heqfBQS3HX8b86WWGEDrW3CEL3F/QSivGml1yCVLNLtDAdOBnGYR1CsE5qtjQlXhEaw0
	 lw1iPfTePGKP3bMulIw42bSwkfg30qnZP8xyt84F8ofhh8X6bj9xKArILNeIqygxghIqb
	 pTu69jAmP2K1BCNb99Zs6vCM/e5rdX3ZQpXUJvBpMWv4ezkSy+gREn8gKlOtovCmNOsBY
	 1zWhqMfzlVM36S4hrJHdq2GkANBvAIRo2YY9ywF9PqD1YLSeOpYivcL7FiEOojqQm44ZE
	 J3mZ8DQWBWKf9N0G4agyZnzP737dhGuEXQ+kN8YLeSGD8i309tcvKhvmci9GP2GzquQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505364;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=dzWJEFgvdT+vHRtnGux6cMYJH+knM9Gr6vtgOh5tUQs=;
	b=IXvibNcbEkBa1AspPdIxlepc+i8DttD6eMEcF3os5gsI6e1ihiMvQUBLJFaUltUA5mON
	 J/DxLL/7tjJtSqbM200TFxQRdGjd42w9e4YJz3dp/jhutaAir+UgNqKUmYSvMJxBiFlSK
	 RsF4h9Pqe7NZJH7bbqDshgH/o1yGUnfPiqUBspiBGbqQqAtPvNO8aBFV2kOOyVSaivaKW
	 DDKKEipdg8ORLR2EPxHVyl7jxZMtFbeTyDCttcyiLLVWkvbHf5kAkAfHZBz30dAlIL6Az
	 yXki8wkNAYBoFk0CDX0X2D1r/BqCe7xgQ7HiAn/MSRkyU2ocpbtCLAsMvYjfK2Pn5Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cfyjjQyu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563BF606CFEF
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cfyjjQyu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C869A1F000C8
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 17:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505363;
	bh=dzWJEFgvdT+vHRtnGux6cMYJH+knM9Gr6vtgOh5tUQs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cfyjjQyuczet0nt0DwhDdEictwt3nSHiMm9lPgyLiD8nDh8/xcZcJISvkTYKYf1op
	 fhQOU+iVyRh9Hss86gMDjFaF8gBA/rLyws3WvKI4UMtegfrr5zCva7ZjqZt8CKaj5y
	 BO4AGVJ4IeF6F+3H/1dlRwUEM15osL0RPtZ8ZXP3cDlN05dZJX6xdqDKiqLr5RLwiT
	 ay8Hg7b+kq2UpdXtJV2pXxHhMShr/oO+PxC5mpnj+LY7IkRN8lInxaErdMAk7IU8kW
	 +8xJIVZu5WUBA1T9zfCxqFi0nUuJVRuz1lYW1MkF2rr3pImxqef66wLX5f/dflxggk
	 xqq8HO38q/ZyQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5c146cf35ceso37592e87.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 09:42:43 -0800 (PST)
X-Gm-Message-State: APuU4Z8dutYXK9A5E5NTb76Tq78cF6OeAlKn+z1yb9I43uGN7v0kP2bA
	oIBn3i68NO2d128kpdRjIrCwKgutd9ABJM7rv39hQpDI7WxJsyI79UgykvfVtTurgec4mJOg21b
	C/JwyNdio8EUT520JJ6VEzswTeB0P4vM=
X-Received: by 2002:a05:6512:308e:b0:5bf:d1e4:a034 with SMTP id
 2adb3069b0e04-5c170b1c321mr22971e87.21.1794505362241; Thu, 12 Nov 2026
 09:42:42 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <13049690.O9o76ZdvQC@rafael.j.wysocki>
In-Reply-To: <13049690.O9o76ZdvQC@rafael.j.wysocki>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 12 Nov 2026 18:42:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gshFCfoscf=q6Hf+=VYP8bgwO1J15AdYAKcCFr8=TtsQ@mail.gmail.com>
X-Gm-Features: AclHuK9Bd2DHl5E847k92KIt96ido52lXPqqLSIJUvnnTI75NP7Kob5DIdXh8WY
Message-ID: <CAJZ5v0gshFCfoscf=q6Hf+=VYP8bgwO1J15AdYAKcCFr8=TtsQ@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: CPPC: Drop two compliance checks involving
 nominal performance
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 6:39=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> On a number of Intel platforms in the field, the nominal performance
> value in ACPI _CPC (which is an integer) is larger than the guaranteed

I said "larger", but should have said "less".  Sorry about this.

Will fix this when applying the patch unless there are other comments.

> performance value and it may even be larger than the highest performance
> value (that come from register reads).
>
> The new specification compliance checks involving those values added
> by commit 32299b29a887 ("ACPI: CPPC: Validate _CPC entry and control
> semantics") cause the CPPC library to refuse to work for some CPUs
> on the affected systems which in turn causes the intel_pstate driver
> to overestimate the maximum performance levels for those CPUs.  One
> of the affected systems is Dell Pro 5 14 P514260.
>
> In this particular case, the fact that the specification is not
> exactly followed has no implications and the checks enforcing
> compliance are not useful, so drop them from the CPPC library.
>
> If really necessary, they will need to be done elsewhere.
>
> Fixes: 32299b29a887 ("ACPI: CPPC: Validate _CPC entry and control semanti=
cs")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/cppc_acpi.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -2940,9 +2940,8 @@ int cppc_get_perf_caps(int cpunum, struc
>         if (!high || !low || !nom || !ref || !min_nonlinear ||
>             high > U32_MAX || low > U32_MAX || guaranteed > U32_MAX ||
>             nom > U32_MAX || ref > U32_MAX || min_nonlinear > U32_MAX ||
> -           high < nom || nom < min_nonlinear || min_nonlinear < low ||
> -           (CPC_SUPPORTED(guaranteed_reg) &&
> -            (guaranteed < low || guaranteed > nom))) {
> +           nom < min_nonlinear || min_nonlinear < low ||
> +           (CPC_SUPPORTED(guaranteed_reg) && guaranteed < low)) {
>                 ret =3D -EFAULT;
>                 goto out_err;
>         }
>
>
>
>
