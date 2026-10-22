Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695643;
	b=ZjmmKSgkLrAjawAEjE1zZ6rYpFUEjIg4Dz7JRJiTcuj3eTFmZq3blHKiEYbRV2+iZXeg
	 Jyfyd3Oc4AV0WTsyjaibfXEEumvGyU/TCxik6QlX70hFmfMR0pxdRnvqWDrO9ivYVy/QU
	 rtRU61urjLuZcrsv5oJEAJ+jUSORag8guLx7XPHefo5rUfUE1aLrQg7Et9i5vWi/Cjta7
	 pS3gZQL0uJDpeX+hw8TAf2B7ihibhHgMrpTmXfKjanLBeikPfQt1tVOenmLfcTdpdKPa8
	 z+MU0G4tiJOCNZrogDyc/shBANOq2i90Bp7QO2i5uv2H8mXDKvqsbsoO9N7aErcuq+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695643;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4F0OHOXs+sIl1YfcJm+UKxYFBwz92ofyleYV1YpiAl8=;
	b=WZl4kprbeQF5bx0J0ann7axCMyxCb2ndQSPzeZ02ZAuvqd1nTXrWQKqJd51sGf6GBL1S
	 QNYOjIhJJOk48t45aGYlt70kxPpgnW1A2ECxXQkCm6shXBxVp4zSoRL+xqp8h/ngUb6To
	 5XkxYLGXl2lLzB7Pa5EgMo+OtXD0OjX2VDrR/M74Be7iU/CSSec2d4ddoIW9BQHw7rI0r
	 TjwfTpqlP9HDQYvDxfhasrg+ZR1KjL/ZikQXujiJE7TKo38OC0DsTsCLaItPr4DO66//A
	 b2aQILOrHz4WVNTa2/P4txxnS+vyu0WlQ4dfzWlJwtPP5Rbg3CR4S/Z33m3svxR5odw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dZeMr/uY";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB9F606A31F
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dZeMr/uY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7541F031E0
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 19:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792695622;
	bh=4F0OHOXs+sIl1YfcJm+UKxYFBwz92ofyleYV1YpiAl8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dZeMr/uYyHtwlTv/pFnxxJxuLJE4Qw2o5LdUy9fEmtbqoi/bbqWul2EuZ8sgDBS2s
	 WZyOsiwD01L+SEK6nLEowZw+pndELX7MZxtb37m1eLXlaSm//z/+dLQAdoNlVie6Jb
	 y5SpwTRBZwpezuxWAt2cRxlMJGVAIEI1oUVoMrTPf3d6KsSaltCyEpmuw9iniaylUc
	 JJ7k9ZNRQeVnxhMW41deluIqND4mLwlUb06ugAI46DjOKtCYWzii28gylVNfTkTYVO
	 c/LLWZduzjkiZQyMBRDk6y5KT8+sBTMDpMhZXqhJCahICpx1g1yejJIcKo1fRxzXIS
	 ETc2u1CDWX0TQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3a595487d43so129371fa.3
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 12:00:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzhfWYj1LSGi7agXCYzIgcq6Lz9QBrHZ6WQljR6OMXfrtceirqtL9YDatbnvvu5SGSVAf6mbhMEkw==@vger.kernel.org
X-Gm-Message-State: AFq9FYK6IUYh9nOAiFZNB7q1a0N4aErdL8Ga3mDTThAbN1UrtPZEbTye
	hdE5QOUR/kXQbqgWvIZute4fDcgaRj6+ImorgnKGjlH7azHIURERfqagoLFAiOlRZdqfOyPxTSA
	gNTPmlbUjZkvdofHvjVdmufKQ5jE10KQ=
X-Received: by 2002:a05:6512:3d93:b0:5b6:1a7c:fd8a with SMTP id
 2adb3069b0e04-5bfa1c03950mr2560524e87.48.1792695620695; Thu, 22 Oct 2026
 12:00:20 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019222635.1741146-1-tristmd@gmail.com>
In-Reply-To: <20261019222635.1741146-1-tristmd@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 22 Oct 2026 20:58:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jSDRLj_OsVJmy4ZmAZNxjnp54ZLKD=RF-7PMqae9zx_A@mail.gmail.com>
X-Gm-Features: AclHuK-n0nRJB8EOQOON4ajoH2SlXhLIEohQFjhU8v5gidnIX8nR-o91INI1DqI
Message-ID: <CAJZ5v0jSDRLj_OsVJmy4ZmAZNxjnp54ZLKD=RF-7PMqae9zx_A@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: cancel HWP notify work in driver cleanup
To: Tristan Madani <tristmd@gmail.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, stable@vger.kernel.org, 
	Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 12:26=E2=80=AFAM Tristan Madani <tristmd@gmail.com>=
 wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> intel_pstate_driver_cleanup() frees per-CPU data without cancelling the
> pending HWP notify delayed work. If hwp_notify_work is still scheduled
> or running when the struct is freed, the work function accesses freed
> memory via container_of().
>
> Call intel_pstate_disable_hwp_interrupt() before kfree() to disable
> the interrupt source and cancel the pending work, matching the pattern
> used in intel_pstate_suspend() and intel_pstate_hwp_offline().
>
> Fixes: d0e936adfe84 ("cpufreq: intel_pstate: Add HWP_HIGHEST_PERF_CHANGE =
handling")

Where did you get this commit from?  It is not a mainline one AFAICS.

> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 17158cb25dd89..0e6ae4cdda5de 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3436,6 +3436,8 @@ static void intel_pstate_driver_cleanup(void)
>                         if (intel_pstate_driver =3D=3D &intel_pstate)
>                                 intel_pstate_clear_update_util_hook(cpu);
>
> +                       intel_pstate_disable_hwp_interrupt(all_cpu_data[c=
pu]);
> +
>                         kfree(all_cpu_data[cpu]);
>                         WRITE_ONCE(all_cpu_data[cpu], NULL);
>                 }
> --

The Fixes: tag replaced with the following one:

Fixes: d845cd901b28 ("cpufreq: intel_pstate: Support highest
performance change interrupt")

and patch applied as 7.4-rc material.

Thanks!
