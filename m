Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B72A184524
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800522; cv=none; b=YhDhKicBaoMYyuuZMuWalBYcg+gmhBUuQns64LOvAP/vt0Ep7vuKC8+4q3QZYXgE+096vKolG4PfJagFOkHyJyijFIh4v644LOCbHS1rxjpy1bfXAypIj91gYxUQAHYkKhrxNL5Ey8MfOk/wPcBAH702H/yN9cp4wZA6CbXY+do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800522; c=relaxed/simple;
	bh=YT+OYr9XxiyZ99if4238JKt5MqaGz69BvfxHxSTxhXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjmMRIHCkkml5vH6hUak4dcd7lqHSjroq8EUbwqyq2pTH605nGT4SmTpUvH5Wvk3cOqwRt5mKPDnxQ43MTaCThgG99DAtp1kXijycdXlbSwewxW0rJP0jammhlgohiM67c06ZadBZqIPj1p7LqxoT0hxZmD3i9yInZ/SuA2duW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5wYeCKT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5wYeCKT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9E51F000E9
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 13:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779800520;
	bh=rlVO70wkp6RlnC9qpuNuk/y90iJvxr3kRiMWQmURXWk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=L5wYeCKT0cx5omMkGKU38ONvHWbcTgNjmNndmSS8OWWyLK52xlPpg1H7l6cvb4m4y
	 7u2iJNGLW7EulLX9i8sOuOiEFInr62wiiERIeE9BcZhVfnCPrfnmK1Xdfr3nP3aijH
	 TZkNeUT2fsBad2tE8KHX7ZCgD5BKABbnl/v3qZJ+AvmJAu9QQ26FFZyJ6Ilkw0PftX
	 bPHlI+YeV71yHzRK7vo9ky6dI62HR1uEQptX6rM+DUcCxHNAyegqLaiwZ0fDx4BJOK
	 5mHEZfrI53yU+d3V2UPakHhY1Ot+jT4fiP9eTgw+aU5HknOINq82xKDcQ3oFONr8gU
	 2k5HJDydcY0yg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a8c6fc5fd3so10236305e87.0
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 06:02:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9RpjQRKOh4KtOoH1Zm2P4x1UYEXl54+rh4xcNHZZR64h1soqSnZQHn3NfY5NnC5BrHceFBVRktZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1apdCFyTreDHU7H88Jr9gPY6roReNFlHKfJ5nSd1tRWSvgLzD
	xCXTEMZitwX82Ecmhw5+85NEHIcjSnAIui+yYDTQaVYxevs6e1uhC8Ocbz/x92lbEhlkMumCE1a
	YU7cJ1t/dRjzA1O1GVFtDyUk/4W6jNks=
X-Received: by 2002:a05:6512:1444:10b0:5a8:6def:7e38 with SMTP id
 2adb3069b0e04-5aa32308639mr3257779e87.15.1779800519094; Tue, 26 May 2026
 06:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515182616.227707-1-sumeet4linux@gmail.com>
In-Reply-To: <20260515182616.227707-1-sumeet4linux@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 May 2026 15:01:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jC_7L5k=x28j-j-Fky=QmD3jivX3iVfy6Fw=p-v8zo+w@mail.gmail.com>
X-Gm-Features: AVHnY4Iubk44p8KYy-RyN1AqDgmbEIxSNOHrMJ-ySdqg0yyK3RKAv8hWvM76s0s
Message-ID: <CAJZ5v0jC_7L5k=x28j-j-Fky=QmD3jivX3iVfy6Fw=p-v8zo+w@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: Fix memory leak in rapl_add_package_cpuslocked()
To: Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 8:26=E2=80=AFPM Sumeet Pawnikar <sumeet4linux@gmail=
.com> wrote:
>
> When topology_physical_package_id()/topology_logical_die_id() returns
> a negative value, rapl_add_package_cpuslocked() returns ERR_PTR(-EINVAL)
> directly without freeing the rapl_package structure that was just
> allocated by kzalloc_obj(), leaking memory on every failed package
> addition.
>
> Use the existing err_free_package label so that the allocation is
> released on the error path.
>
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/inte=
l_rapl_common.c
> index a8dd02dff0a0..f8afb4461e45 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1770,7 +1770,8 @@ struct rapl_package *rapl_add_package_cpuslocked(in=
t id, struct rapl_if_priv *pr
>                          topology_physical_package_id(id) : topology_logi=
cal_die_id(id);
>                 if ((int)(rp->id) < 0) {
>                         pr_err("topology_logical_(package/die)_id() retur=
ned a negative value");
> -                       return ERR_PTR(-EINVAL);
> +                       ret =3D -EINVAL;
> +                       goto err_free_package;
>                 }
>                 rp->lead_cpu =3D id;
>                 if (!rapl_msrs_are_pkg_scope() && topology_max_dies_per_p=
ackage() > 1)
> --

Applied as 7.2 material, thanks!
