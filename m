Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31684AFE12
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531076; cv=none; b=JBrqAgn5fb9xZlXAaTyMzI2EEopQI7goRCeIgom7gSjL1KgL9zoiNa5A+yBdYAdZB0UXwZoYLHGnflen2Z9h+5BEMu/AZbK2a6CPjqo1AA0b2TwxFLh2yYWtoOCVUJRm/Cq6tYOeTvPulsv2YdOe9u2rPAmLov+G5tC2sKFFj54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531076; c=relaxed/simple;
	bh=X0atmNFkIGOlm/wbV2nmqdKXsTvlRmrm27yFK3q/mDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxJ8I7Mj9YEm26sC5ErcAOzIoX3kP1kb/4s+5Hr1EEZ0hr5mAcfc81yeunqC0qGMWo0cMF846FbmgD4IgUehIrqAovC9Z++WvDJDE+WvSZkg+5sjQaLgcMAHTh5iNjsDwHN2HNwql17QsDEDVpZkadm0dmiEFz+4LEI54LZKhR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtkFo/Oa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtkFo/Oa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D601F00A3F
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 14:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788531074;
	bh=q792a3zbg+4mRnzuoAtlpFbwlchhX+xb4t/lUvkPFBU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EtkFo/OaK2w3rCwvIaYL4wQfLvHpMxBcAKol3+OprDqnheNgUCBgDd70QIO8xo1Bn
	 jsVtHUcILPkN0QrPj3nuZrdM1utDu1pEeKTnO9dPmWG7vg3BHpSw5JIXhETRTfZR/c
	 8Jn3Z+MzM+Ezf9i3SAtA2zBKlkBpWBsE8xbJFhgSiTXqaf+6voYfmeLtg3AU2T2ero
	 DoFJTkXj/v4AQWpYkvROrXXHXwV0llzs+vnrpt/CqrpO4RFFpfTGZ3e7XJ7Saqr5E0
	 5773p6+5PE2qh1oGOy42LTrgOVFml/fO+wW2i0C8V3oqev7ZiJE+55j6cLdwBNsUex
	 hY7Gu2fVY3XXg==
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5c6559620e3so475439e0c.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 07:11:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzuJepQuzT3o4VSNhhCpTlXMTuRBgd6YyzFHK8HOrMkY5+mWJZiTqjRpKUZJDxIZE28Cj5aWoIfKQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mtzLqZoYiuIAJ7loxZVtmUvZXhry3mNZrSVdKzZY5g0DxaTw5B
	9haelTU9ymePIgME2b94OMdkXM7+aMF0SPctpoXuJwQ86kd2OFvqB3tHF4/VgpoGDo0hFneE7uy
	rTE44fYFPw5yDPdX+6BIoO7VyLshn7qM=
X-Received: by 2002:a05:6122:2909:b0:5bf:a181:d46d with SMTP id
 71dfb90a1353d-5c7ed4201ddmr2603039e0c.3.1788531073538; Fri, 04 Sep 2026
 07:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813082624.2650581-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260813082624.2650581-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 16:10:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jHPTxcuR3iot-vhPFZxQNjha4nNm=xiRFRJh0NsUdreQ@mail.gmail.com>
X-Gm-Features: AcwNN1VaAHSYRqmco5XkJtTVwTBTwwsFX_gktQEWVeGDdEYLq2_hmEHqgk3Sy04
Message-ID: <CAJZ5v0jHPTxcuR3iot-vhPFZxQNjha4nNm=xiRFRJh0NsUdreQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] intel_idle: Use 2-argument strscpy()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 10:26=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> From: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Use 2-argument strscpy(), which is not only shorter but also provides
> an additional check that destination buffer is an array.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/idle/intel_idle.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 699665f24ecd..01a68f5b9020 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1904,7 +1904,7 @@ static void __init intel_idle_init_cstates_acpi_lpi=
(struct cpuidle_driver *drv)
>                 state =3D &drv->states[drv->state_count++];
>
>                 scnprintf(state->name, CPUIDLE_NAME_LEN, "C%d_LPI", index=
 + 1);
> -               strscpy(state->desc, lpi_state->desc, CPUIDLE_DESC_LEN);
> +               strscpy(state->desc, lpi_state->desc);
>                 state->exit_latency =3D lpi_state->wake_latency;
>                 state->target_residency =3D lpi_state->min_residency;
>                 state->flags =3D MWAIT2flg(lpi_state->address);
> @@ -1954,7 +1954,7 @@ static void __init intel_idle_init_cstates_acpi_cst=
(struct cpuidle_driver *drv)
>                 state =3D &drv->states[drv->state_count++];
>
>                 snprintf(state->name, CPUIDLE_NAME_LEN, "C%d_ACPI", cstat=
e);
> -               strscpy(state->desc, cx->desc, CPUIDLE_DESC_LEN);
> +               strscpy(state->desc, cx->desc);
>                 state->exit_latency =3D cx->latency;
>                 /*
>                  * For C1-type C-states use the same number for both the =
exit
> --

Applied as 7.4 material, thanks!
