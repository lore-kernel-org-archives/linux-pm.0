Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB35A303A37
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562626; cv=none; b=FMQniZ3t/hcx9tMpzaG16YW8+hFCdE5doEH7iM6Tio0L7i2wHOpm8t1lnht7WrAdlBPVpevNqHJeEM3dLF03GNmErThm+gcicRY7o7ZUdg+NVXhbojAi0i0y1psjiPQPTCrKxbeY1DQSsjAtg4lj/sXy4PTBiPyI1zfYYercxOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562626; c=relaxed/simple;
	bh=vDX7fbQson4Ocbu31kG7w1ejYsvRdCsxRVGz7V5NjCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYolNVymMDlI3EVRKWwK6kn8XSEUAkq5Fup6cxtoNnB6o97b1Eba9glNtQB7MD5SssfiHbFL59z4HSdf60mu4306zolTScq7GT2p2Q4b8CbCdg7MfpooGz4v+WW3cDkVYCd0mC0P/M1y4qE/+akTp4PUAYN7AhxyBtpOdrX5C3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZluABlE7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZluABlE7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7310DC4AF09
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 11:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775562626;
	bh=vDX7fbQson4Ocbu31kG7w1ejYsvRdCsxRVGz7V5NjCg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZluABlE7fef7GUapWehNqLKPsufxZG5g2KF/bpZ6rXFoEHg3xqxSO6PpSAy/y8W+W
	 1t7l9jv4hmO9Ns6uXI7g3b0V0VwA34jrXtppr+h8KO0UDaHQ2RS3bCkqnjHqSvA40+
	 p5QITPUTq7yGOD/fn5UwBfrTepk2tM7Uc8j2sWwnbOpth5SMLvqzXILG3fWNFFsH/W
	 gIwOvXF5yR8GxQLPkykFtIvIrtCwMkc0jmcLTtbRKu8ZkbrKYTCGGWZfT3JJe4204L
	 dmpTMt9dfoAuSgV5ckO1P8xY/qJjHoczR1nxMS8qpIyxnerOswM/FzWgMvez8ry++2
	 hZ+2CQVofAqBA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40f1ffba6a0so3295538fac.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2026 04:50:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxTS8dF8EPYHxC/JYIhF0Wg4omEiB/6KBmxD468JruZj48o7GwFnyj5/hfG4Ztztz+1Y8jLg4G6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNSAuU2Nh3wKeZWoR9XiBuLc32qgj+eEOebYGGyQ5G4xYllmf6
	ov+FOROaD3ftkfpIq5vz/21QQoZi83uccxdI0a/hGXcYNUswvSkODjd6KYbOnFsDNu555VaAhEn
	gy9XJO6+j0R5PISOwAC+jtpl4OlfBwdg=
X-Received: by 2002:a05:6870:95a3:b0:3c1:68a1:6b10 with SMTP id
 586e51a60fabf-4230fc89682mr8887869fac.6.1775562625509; Tue, 07 Apr 2026
 04:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407093529.4527-1-nanmu@xiaomi.com>
In-Reply-To: <20260407093529.4527-1-nanmu@xiaomi.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 Apr 2026 13:50:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hzhgf3mvdtHgT4Hwiqv22=P=xsWO8QZpeSGayOP-HO3w@mail.gmail.com>
X-Gm-Features: AQROBzBWttgPW2QwKTMuVtDkTS6X3S8N91HOL3rc-8eFj6o1JNXVI9pfBXzkD3Q
Message-ID: <CAJZ5v0hzhgf3mvdtHgT4Hwiqv22=P=xsWO8QZpeSGayOP-HO3w@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Fix race between suspend/resume and CPU hotplug
To: Tianxiang Chen <nanmu@xiaomi.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lingyue@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 11:35=E2=80=AFAM Tianxiang Chen <nanmu@xiaomi.com> w=
rote:
>
> CPU hotplug operations can race with cpufreq_suspend()
> and cpufreq_resume(), leading to null pointer dereferences
> when accessing governor data.

So how exactly would CPU hotplug be started during a system suspend or resu=
me?

> This occurs because there is
> no synchronization between suspend/resume operations and
> CPU hotplug, allowing concurrent access to
> policy->governor_data while it is being freed or initialized.
>
> Detailed race condition scenario:
>
> 1. Thread A (cpufreq_suspend) starts execution:
>    - Iterates through active policies
>    - Calls cpufreq_stop_governor(policy) for each policy
>    - Sets cpufreq_suspended =3D true
>
> 2. Thread B (CPU hotplug) executes concurrently:
>    - Calls cpu_down(cpu)
>    - Calls cpuhp_cpufreq_offline(cpu)
>    - Calls cpufreq_offline(cpu)
>    - Inside cpufreq_offline():
>      * Stops governor: policy->governor->stop(policy)
>      * Exits governor: policy->governor->exit(policy)
>      * Frees governor_data: kfree(policy->governor_data)
>      * Sets policy->governor_data =3D NULL
>
> 3. Race window between step 1 and step 2:
>    - Thread A is iterating policies and stopping governors
>    - Thread B is concurrently executing CPU offline
>    - Both threads may access the same policy->governor_data
>    - Thread B frees governor_data while Thread A is still using it
>    - Thread A accesses freed governor_data =E2=86=92 null pointer derefer=
ence
>
> Similarly, cpufreq_resume() can race with CPU hotplug where governor_data
> is being initialized while hotplug is trying to access it, leading to
> accessing uninitialized data.
>
> Signed-off-by: Tianxiang Chen <nanmu@xiaomi.com>
> ---
>  drivers/cpufreq/cpufreq.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1f794524a1d9..8b03785764fa 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1979,6 +1979,7 @@ void cpufreq_suspend(void)
>         if (!cpufreq_driver)
>                 return;
>
> +       cpus_read_lock();
>         if (!has_target() && !cpufreq_driver->suspend)
>                 goto suspend;
>
> @@ -1998,6 +1999,7 @@ void cpufreq_suspend(void)
>
>  suspend:
>         cpufreq_suspended =3D true;
> +       cpus_read_unlock();
>  }
>
>  /**
> @@ -2017,10 +2019,11 @@ void cpufreq_resume(void)
>         if (unlikely(!cpufreq_suspended))
>                 return;
>
> +       cpus_read_lock();
>         cpufreq_suspended =3D false;
>
>         if (!has_target() && !cpufreq_driver->resume)
> -               return;
> +               goto out;
>
>         pr_debug("%s: Resuming Governors\n", __func__);
>
> @@ -2038,6 +2041,9 @@ void cpufreq_resume(void)
>                                        __func__, policy->cpu);
>                 }
>         }
> +
> +out:
> +       cpus_read_unlock();
>  }
>
>  /**
> --
> 2.34.1
>
> #/******=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=
=E5=90=AB=E6=9C=89=E5=B0=8F=E7=B1=B3=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=
=AF=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E5=8F=91=E9=80=
=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=97=E5=87=BA=
=E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=BE=A4=E7=BB=84=E3=80=82=E7=A6=81=E6=
=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BB=A5=E4=BB=BB=E4=BD=
=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=AC=E4=BD=86=
=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=A8=E5=88=86=E5=
=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81=E6=88=96=E6=95=
=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B8=AD=E7=9A=84=E4=BF=A1=
=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=
=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=82=A8=E7=AB=8B=E5=8D=B3=E7=94=
=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=
=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=81 Th=
is e-mail and its attachments contain confidential information from XIAOMI,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you re=
ceive this e-mail in error, please notify the sender by phone or email imme=
diately and delete it!******/#
>
