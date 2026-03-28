Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340C729BDB1
	for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774698672; cv=none; b=O+CNlK4syH2SiOKU6EXDrcJvAA2K3g+UUruiNh42oYRmuPdkjcFRi4bbpXgCxMo9N+PnwNZMO1YzNVnfBej7wl0k0rReKwxmwmjYt7AuGkaOfR94Jm/caLgaBYsDTy1LrEdz54xTnmSyDP/qnWeyVhHwBaOOx2d1k/IJM3ITpwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774698672; c=relaxed/simple;
	bh=m1UQ6A6/nyzOvMaXawlTdhUjXddjW5mxh8Ovi3r+whQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8Zdma9rg5143aFzoD4nspIWy42teseMyCKfXdQND/8s3hpkriE7NTfE+vOLRN8J3NV4VgKi85jocnMKgM6O9A10kbztmPs5uI6f9fDiwuS5Zn9jUr/pD1XiMWkjbukScqySZyvFHm/g4EZKX7dWuqy4jYeUhkd8jYsEn0aJ5Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYXbTuSS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYXbTuSS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FEDC2BCB1
	for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 11:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774698672;
	bh=m1UQ6A6/nyzOvMaXawlTdhUjXddjW5mxh8Ovi3r+whQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dYXbTuSSItTLDJzIzwmKw3wB4cCnWVcjHSwrS/zTeAjrZ1DpiyG9V2NW8EUNXExwW
	 EvGIFyEaW3Y5qArQAPdlm/aNRZEmzp6fLEBXKrAoXYLvu/xf64GoDQD+hpZyonVtKZ
	 TvYuH6nmT6WWd901D9n71eY5END+ups35tRwha9FJexNHN+rUdb7zYxN6BZGDnenal
	 daj94KWYnU4QK9Xh9EDEYsdV6Q/XWtrnAJj0kros7DiCqDay6rB5Tgv4x1lp6U6yEu
	 gOzfIabbtauGBH69YgATH2QkxsIoVonH1nGvC/mdPmwKSVhdC/h3cIWoeMvmphLcP2
	 m3Thh2EOrUGng==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-467161c4b89so1679964b6e.3
        for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 04:51:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkUEwpwTLP174cnab8T99bQ7C35eoUqK+Im7ipIfvplfetJZ3ZUNsReU+wbo2bggzw6JkRec3gVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgNVoAcRZQOzJZEFyAnAQvFFe89oDa94Uugvwod1TmC6Uy/l2k
	BOKIkrFSlk9bAYOQcwFaXRmB9ucX7Pkt0QxY5xJVJl+dkuNkU+IG63X0mex+29EAmenc3bRQitG
	ui8bAn3fdAP1ojw8H/YLoZBkukXp1ako=
X-Received: by 2002:a05:6808:1787:b0:466:f25d:3289 with SMTP id
 5614622812f47-46a8a59ada9mr2555190b6e.36.1774698671112; Sat, 28 Mar 2026
 04:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12876512.O9o76ZdvQC@rafael.j.wysocki> <202603280307.P9324SuS-lkp@intel.com>
In-Reply-To: <202603280307.P9324SuS-lkp@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 28 Mar 2026 12:50:59 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jv-qk=GS5GxULV-XpY8_8iNCtL-qs1j7O-wg3775-WNA@mail.gmail.com>
X-Gm-Features: AQROBzCoO8RbHvi91ay3Tbm0Ce4dhfcdhPXZ9-MSHP7fVv33wA0072HY5xcFZFU
Message-ID: <CAJZ5v0jv-qk=GS5GxULV-XpY8_8iNCtL-qs1j7O-wg3775-WNA@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: core: Address thermal zone removal races with resume
To: Dan Carpenter <error27@gmail.com>
Cc: oe-kbuild@lists.linux.dev, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, lkp@intel.com, oe-kbuild-all@lists.linux.dev, 
	Mauricio Faria de Oliveira <mfo@igalia.com>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 28, 2026 at 9:03=E2=80=AFAM Dan Carpenter <error27@gmail.com> w=
rote:
>
> Hi Rafael,
>
> kernel test robot noticed the following build warnings:
>
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Rafael-J-Wysocki/t=
hermal-core-Address-thermal-zone-removal-races-with-resume/20260327-222101
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it thermal
> patch link:    https://lore.kernel.org/r/12876512.O9o76ZdvQC%40rafael.j.w=
ysocki
> patch subject: [PATCH v1] thermal: core: Address thermal zone removal rac=
es with resume
> config: i386-randconfig-141-20260328 (https://download.01.org/0day-ci/arc=
hive/20260328/202603280307.P9324SuS-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0=
227cb60147a26a1eeb4fb06e3b505e9c7261)
> smatch: v0.5.0-9004-gb810ac53
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Closes: https://lore.kernel.org/r/202603280307.P9324SuS-lkp@intel.com/
>
> smatch warnings:
> drivers/thermal/thermal_core.c:1913 thermal_init() warn: missing error co=
de 'result'
>
> vim +/result +1913 drivers/thermal/thermal_core.c
>
> 203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-1=
7  1900  static int __init thermal_init(void)
> 203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui         2008-01-1=
7  1901  {
> 80a26a5c22b90a drivers/thermal/thermal_core.c Zhang Rui         2013-03-2=
6  1902        int result;
> 80a26a5c22b90a drivers/thermal/thermal_core.c Zhang Rui         2013-03-2=
6  1903
> 755113d7678681 drivers/thermal/thermal_core.c Daniel Lezcano    2024-01-0=
9  1904        thermal_debug_init();
> 755113d7678681 drivers/thermal/thermal_core.c Daniel Lezcano    2024-01-0=
9  1905
> d2a89b52839597 drivers/thermal/thermal_core.c Daniel Lezcano    2020-07-1=
7  1906        result =3D thermal_netlink_init();
> d2a89b52839597 drivers/thermal/thermal_core.c Daniel Lezcano    2020-07-1=
7  1907        if (result)
> d2a89b52839597 drivers/thermal/thermal_core.c Daniel Lezcano    2020-07-1=
7  1908                goto error;
> d2a89b52839597 drivers/thermal/thermal_core.c Daniel Lezcano    2020-07-1=
7  1909
> f777132b791874 drivers/thermal/thermal_core.c Rafael J. Wysocki 2026-03-2=
6  1910        thermal_wq =3D alloc_workqueue("thermal_events",
> f777132b791874 drivers/thermal/thermal_core.c Rafael J. Wysocki 2026-03-2=
6  1911                                      WQ_FREEZABLE | WQ_POWER_EFFICI=
ENT | WQ_PERCPU, 0);
> f777132b791874 drivers/thermal/thermal_core.c Rafael J. Wysocki 2026-03-2=
6  1912        if (!thermal_wq)
> f777132b791874 drivers/thermal/thermal_core.c Rafael J. Wysocki 2026-03-2=
6 @1913                goto unregister_netlink;
>
> result =3D -ENOMEM;
>
>
> --

This has been fixed in the v2:
https://lore.kernel.org/linux-pm/6267615.lOV4Wx5bFT@rafael.j.wysocki/
