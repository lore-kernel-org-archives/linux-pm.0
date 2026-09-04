Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57043D1A98
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532875; cv=none; b=gY6SXBdWTWX5bpllLo9ifRHk7IGGUVU7bmOLrQf0iwQj1BOLxGyUPZpbKUlAm9F9oogEf4Tx60ez+2vKKiG6LmJdYNohM3fP7K8Zd759Lusfj+PQgOMKjeMMTscoHKGQRVRIFypRN9lnHqL2kB04tnQ2LucMJoA7WFnJ5mqt7GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532875; c=relaxed/simple;
	bh=IthVxADGk6umLAnprPcr4e4rdF3DRQRSwjOy0AJBzuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2gn7jGVXkuglfXJLX6TkovBY3tTZ9SpV+7Z6angHu0DvKXLY1oUP28Cwd7iYDXjxYYVbsRrb7f5d/HSxFOLVQOckNBj30JF0lUH44fvDYy6LcCrOEzEeFLAA9W0lSINxojv4c85oKXX8syJkBU8gqPE2uSMfd/1PzJuW9HpoWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQ8lXlr+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQ8lXlr+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B721F00ADE
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 14:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788532873;
	bh=PytMsbFIV1veAD1P9COFSFKR+Qrmya7fjbIpJ63x/Gs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lQ8lXlr+Uk22qH9QdG0mfxlw8SIi0eGFRAznoeQlm/AHCpN3Xuwh9lH3bDO5HSPBg
	 eqDWigsl2OswnK7WDBCVrj6+i0+otqyQMmrJ3LYzddjiEYScASq8pbdvdGFDZCorWb
	 CrKtHSXqbnWpCU9S1iB0hLyqkFZXiuaRuy0PkRBgwYa/wSOxwbNvt/vwwE+A91YebV
	 dhg5ohu2H4lKjGtzEHGQNh/RcMFSsTq02+jBIUqTVDJ3i33tSLYEJf2uMJWkkop3e2
	 dF81mvEEksXkdawP1LaN/ZzLKi9rrXGt01AwoHCt02D7fc27rehYgH9mhF8mKYXOCS
	 eQ+s2pfD0SKIA==
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-59b074ec7ceso500779e0c.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 07:41:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByzhGT+38PX5hI0RvBBfjV9Xljv0lMPlKLhG5sLqnHRbNDCNsjfYahn3LX0yq0uApRpYghI3hsQ9w==@vger.kernel.org
X-Gm-Message-State: AFuF++kTBDt+pC7x8MxGxXjeR9xb/Uv4NjGnhso/8MIRPg3IcZvzfROg
	CcGGL23FtWThFBny2rmanKDobdtXmkTTOgX+OZS2FhCxeeg9KYRPu16ncJ3xRPkJun489ylTp/M
	Ilgna7dhzJ1/ahNn4i76ZwYXkr49aNXk=
X-Received: by 2002:a05:6122:2890:b0:56f:6cc0:681e with SMTP id
 71dfb90a1353d-5c7ed2baa42mr2863764e0c.1.1788532873004; Fri, 04 Sep 2026
 07:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820154339.47737-2-blum@kernel.org>
In-Reply-To: <20260820154339.47737-2-blum@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 16:40:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hNF=ayNEi84ev6BJwBgeGhtPfHcW7CBci96DuWyAm9VA@mail.gmail.com>
X-Gm-Features: AcwNN1V23JJCTAse3auywQg5RByWcURQH47266Ihuxi2T0GoVZAfhBtPgvwvCL0
Message-ID: <CAJZ5v0hNF=ayNEi84ev6BJwBgeGhtPfHcW7CBci96DuWyAm9VA@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: powerclamp: Simplify check_invalid()
To: Thorsten Blum <blum@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Yury Norov <ynorov@nvidia.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 5:44=E2=80=AFPM Thorsten Blum <blum@kernel.org> wro=
te:
>
> Return the boolean expression directly and use const for the read-only
> mask parameter.
>
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
>  drivers/thermal/intel/intel_powerclamp.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/i=
ntel/intel_powerclamp.c
> index bd7fd98dc310..f54cc6a29d16 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -143,12 +143,9 @@ static int allocate_copy_idle_injection_mask(const s=
truct cpumask *copy_mask)
>  }
>
>  /* Return true if the cpumask and idle percent combination is invalid */
> -static bool check_invalid(cpumask_var_t mask, u8 idle)
> +static bool check_invalid(const struct cpumask *mask, u8 idle)
>  {
> -       if (cpumask_equal(cpu_present_mask, mask) && idle > MAX_ALL_CPU_I=
DLE)
> -               return true;
> -
> -       return false;
> +       return cpumask_equal(cpu_present_mask, mask) && idle > MAX_ALL_CP=
U_IDLE;
>  }
>
>  static int cpumask_set(const char *arg, const struct kernel_param *kp)

Applied as 7.4 material, thanks!
