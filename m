Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371FB3128B8
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147676; cv=none; b=r7L3ncpcTgSJm9cMZ7UMFA3Qx+xGwAIQnjV1U1MeCGxWNs3FqfA827XcYt8oPQlG6kU39uwSJezI87neu6kQ740/x0P6wmPrWUObC6UWF5om4+panA7p05woS+ylmd0o5jOr8XLPV1q4/WGtGDCQgqVnn1awRL08qS0vScHMDyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147676; c=relaxed/simple;
	bh=nCRx/5ltE1thqHW52wlO8I2onmnKpGiRW7ARBoZ9zdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KM4zENzVeRJhErDWYRq0fg5/Yq9x+IIS4AjVEa/es3Np4iqjvGtwjpCFekN+6TJwdXfR8iG5MSoLO2QZAgqp7li8sz1aoyOGEWRUrpEweiZgG4HkDFsPbvKocYrR7hoNvbiWTQv4pNfMv1GmQ7HTplb550W+oHh+k5L3dbL/acw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enL9W5W6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enL9W5W6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3CE1F00A3A
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 17:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782147674;
	bh=i8KExULgfQGOVsxqjz0sW7HL2BUhDvyV9QWCcrlgG+Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=enL9W5W68n5sZBuRJnX4ZzTnI5zzMovd9h2PuqINy64E4a7ByjQaj9yIHVu7RzxVS
	 jIfXKj9bmwWiQ+Vhvvpd+etSQ93RdapEbVsVqaYpkIzVzSNHXZv+xlUX2CUUMLsoNo
	 RdCBhrJHHVTqvOkC/xXt7kdkh6k2ieJcDkIpzc1vY94iscskfRa7DwFquq303tEv8C
	 C8+Zqh/FsXlvt+aXed0mPVsAP4ecx52IjuYS7XuCvVFQTx0DtZguBNCtA+sjqBL+cX
	 /G6GOqrRRaci0D6wLc7IRfckF/lBst5Md1Y6hjRLYuzqVBXwgfvGBVEiLyTFqxjWu/
	 bChffdQtm894w==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa68d9d56fso5231956e87.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 10:01:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8cd68IH5R2joMLmX9dtdZSi1MPZrj/g21QEqouxGdaO9hQSpzSdQwBNzhufOWs7DgOqvTWwbOdlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxImfw+9g2qe1Sb4LKrEVSdETy6HAXGEmYbxFvsLjzyNCq5svK3
	YZ/yfjSepvH0hMfymlVz231vZDQ2V4bEpVy3dPW/8Zau+HXv4oNya3ix5g7p/FZZt8IdgEu5/sA
	3V6JD19ZwghhSKLKUPSjIDp/TEj3RQ+s=
X-Received: by 2002:a05:6512:440d:b0:5ad:4f8f:e8fa with SMTP id
 2adb3069b0e04-5ad58f4d400mr2868705e87.27.1782147673188; Mon, 22 Jun 2026
 10:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12920597.O9o76ZdvQC@rafael.j.wysocki> <1372adf9-2356-4d0c-915d-3660efd99988@intel.com>
In-Reply-To: <1372adf9-2356-4d0c-915d-3660efd99988@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Jun 2026 19:00:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iZpqWBLorjQ+U4GdrmFd5bxZvaZR1LDAaxFh9LeSjAwA@mail.gmail.com>
X-Gm-Features: AVVi8CchrGQTRxNjtYpIOORiyiHp1xJl2gth_FRT2yVxKILQaqyYV9HoYR40jr8
Message-ID: <CAJZ5v0iZpqWBLorjQ+U4GdrmFd5bxZvaZR1LDAaxFh9LeSjAwA@mail.gmail.com>
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Skip HWP_CAP reads in Broadwell mode
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 22, 2026 at 5:16=E2=80=AFPM Chen, Yu C <yu.c.chen@intel.com> wr=
ote:
>
> Hi Rafael,
>
> On 6/20/2026 3:24 AM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > When running in the Broadwell HWP mode, the turbo, max and min
> > P-state values are retrieved from MSR_PLATFORM_INFO, so reading
> > MSR_HWP_CAPABILITIES in that mode in order to update those values
> > is pointless.  Moreover, using the MSR_HWP_CAPABILITIES value for
> > updating them in the Broadwell mode may be harmful, so avoid doing
> > that altogether.
> >
> > Fixes: de5bcf404ace ("cpufreq: intel_pstate: Clean up frequency computa=
tions")
>
> sashiko[1] reports an issue that hwp_cap_cached remains 0.

Right, it will.  It is used in a few places that I have overlooked though.

> Maybe still use the value from MSR_HWP_CAPABILITIES for cached value,
> which was what we did before commit de5bcf404ace? I fed this
> to AI and was given the following:
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 5a0eeb84d382..a373a199c9c6 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1189,6 +1189,8 @@ static void __intel_pstate_get_hwp_cap(struct
> cpudata *cpu)
>
>       rdmsrq_on_cpu(cpu->cpu, MSR_HWP_CAPABILITIES, &cap);
>       WRITE_ONCE(cpu->hwp_cap_cached, cap);
> +       if (hwp_mode_bdw)
> +               return;
>       cpu->pstate.max_pstate =3D HWP_GUARANTEED_PERF(cap);
>       cpu->pstate.turbo_pstate =3D HWP_HIGHEST_PERF(cap);
>   }
> @@ -1199,6 +1201,9 @@ static void intel_pstate_get_hwp_cap(struct
> cpudata *cpu)
>
>       __intel_pstate_get_hwp_cap(cpu);
>
> +       if (hwp_mode_bdw)
> +               return;
> +
>       cpu->pstate.max_freq =3D cpu->pstate.max_pstate * scaling;
>       cpu->pstate.turbo_freq =3D cpu->pstate.turbo_pstate * scaling;
>       if (scaling !=3D cpu->pstate.perf_ctl_scaling) {
>
>
> [1] https://sashiko.dev/#/patchset/12920597.O9o76ZdvQC%40rafael.j.wysocki

That gets a bit messy and also hwp_cap_cached is referred to directly
and used for programming HWP_REQUEST without checking the Broadwell
mode.  I'm not sure if I want to change that after 5 years though.

ATM the Broadwell mode only affects initialization and while it
prevents __intel_pstate_get_hwp_cap() from running in
intel_pstate_get_cpu_pstates(), it doesn't prevent that function from
running anywhere else and effectively it only really prevents the
hybrid initialization from being done, so after all I'm not sure if
it's worth retaining.  It might as well be dropped altogether AFAIAC.
