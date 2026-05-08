Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BDB379EF0
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 19:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778267090; cv=none; b=Ac3rwYpUwvNORrJowORxu6vVoz/3/DMCKkBkXsBBnZ95EK9R9N6qCFY6pYskBbuqdT8M2LVjKdwwr49MlSKtBcgD1ktkZXpFWo+6uYhEyyDc906AJQlerw6X30Q8hY3pN2mtN9pHsWkbvjGBzHhDqb7q5bDBMo97E6BRt6mNb5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778267090; c=relaxed/simple;
	bh=JuCBIWbnjv/QHSeclvxS58oWCNPLxU4hJ6XgJjekXLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYm4uR27xUjqNU1e/wWMJuib+1tPsF8xm5qc1pzaLp4XwVinrigHU4chbkvgbOWzLnydJJY6SxsrHRGEKJzm5hLwqSGZWvXqvZDUqqpCHhxCKZIX/SUtEJKFWvdoVbaZyJ0scJyjpK05WnHnvO0BQ9Tdw7ZFye2y/07aDYWkZD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4CAkIiA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4CAkIiA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01B3C4AF0B
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 19:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778267089;
	bh=JuCBIWbnjv/QHSeclvxS58oWCNPLxU4hJ6XgJjekXLs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z4CAkIiAfyTKAosC6czfa68+ji+R48BjMMnCFirZTvJrDM6vlHX4lryMgtVVrC0uv
	 U5Zb9gFNa8YbhoPPLmXDBHbr+OfjQDZUH7Pp65FDc5CMHolki4oUj9NFJKhMoFZINf
	 1pzXodUYv1qkUAHV2xxdxHdOordqV3qy4NAYKw96EVi6H2c+bYISu0hRhvzpDpP6Xm
	 9iq1W+5ZaKHpMniY3XkerSEdSqyVWAio1SjuI7MtAVr06mGNi+q9zqNcamh3zbdAKq
	 /xWur6HDHdV9Rx59GWU118J7X5p1wXhVp6sms/oIQ8zeSFJHxP90sm9l2EdcTWJzQn
	 y1XbDDBlxDN3A==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so3521983e87.0
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 12:04:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+POOUYRHlJ650LvU6K3O8skGv1pgxfeU/qcwmR4Y0TQ0HQmmvR4P+ju0ew8FFzNAzsDrRbgv52Bw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ku1osH8mgNr+H8Bf20HJVz8Pk0EPWhh3lmZM9X0fxi2pOSUN
	Kz8GNZuMVKlu7ofsGZr24rwNRURhlaP0Y/py+arKp9X4pwgKQWspZv25c2MTXQWUw6JoOrVYMi+
	xbZZsziXm7KnQfDE35zjlNJSI0REqcIY=
X-Received: by 2002:a05:6512:3d0b:b0:5a3:6731:910a with SMTP id
 2adb3069b0e04-5a887ae1756mr4708775e87.11.1778267088209; Fri, 08 May 2026
 12:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504230141.484743-1-mario.limonciello@amd.com> <20260504230141.484743-2-mario.limonciello@amd.com>
In-Reply-To: <20260504230141.484743-2-mario.limonciello@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 8 May 2026 21:04:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gBTxzkQU1EduyBNx2fCYfVU92XcNU8+AbSZziymBdJJw@mail.gmail.com>
X-Gm-Features: AVHnY4JniMvibyMorBAgS3rttqq3y4-3ArgURY5ggycizySwR0ixYrXfJr22L5Y
Message-ID: <CAJZ5v0gBTxzkQU1EduyBNx2fCYfVU92XcNU8+AbSZziymBdJJw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] Revert "ACPI: CPPC: Adjust debug messages in
 amd_set_max_freq_ratio() to warn"
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org, 
	Kim Phillips <kim.phillips@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 1:01=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Some older systems don't support CPPC in the firmware and this just makes
> noise for them when booting.  Drop back to debug.
>
> This reverts commit 21fb59ab4b9767085f4fe1edbdbe3177fbb9ec97.
>
> Fixes: 21fb59ab4b976 ("ACPI: CPPC: Adjust debug messages in amd_set_max_f=
req_ratio() to warn")
> Suggested-by: Kim Phillips <kim.phillips@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/kernel/acpi/cppc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
> index d7c8ef1e354d3..be4c5e9e5ff6f 100644
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -88,19 +88,19 @@ static void amd_set_max_freq_ratio(void)
>
>         rc =3D cppc_get_perf_caps(0, &perf_caps);
>         if (rc) {
> -               pr_warn("Could not retrieve perf counters (%d)\n", rc);
> +               pr_debug("Could not retrieve perf counters (%d)\n", rc);
>                 return;
>         }
>
>         rc =3D amd_get_boost_ratio_numerator(0, &numerator);
>         if (rc) {
> -               pr_warn("Could not retrieve highest performance (%d)\n", =
rc);
> +               pr_debug("Could not retrieve highest performance (%d)\n",=
 rc);
>                 return;
>         }
>         nominal_perf =3D perf_caps.nominal_perf;
>
>         if (!nominal_perf) {
> -               pr_warn("Could not retrieve nominal performance\n");
> +               pr_debug("Could not retrieve nominal performance\n");
>                 return;
>         }
>
> --

It looks like this could be applied without the rest of the series.
Do you want me to do that?

Also, do I understand correctly that the rest of the series depends on
Sumit's patch set at

https://lore.kernel.org/all/20260430142430.755437-2-sumitg@nvidia.com/#r
