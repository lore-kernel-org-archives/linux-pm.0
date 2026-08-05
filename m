Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D40448B92
	for <linux-pm@vger.kernel.org>; Wed,  5 Aug 2026 11:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931015; cv=none; b=LW2cvZvlZ3ehWgSI5OaJxo1LKeVDSajcF/K5HfNsqjAmPyWX5LP00OUhS6U8dBtvqJjJXiGLfVHkHq1TN85WN4BXvF8I/HPrqHfraT65h2O5U+XZTK3CgnJm1Yfat1/TdJ6IYLhglLgdnxbm7Y8zpMc40gFumM6Kwk0TpknWtms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931015; c=relaxed/simple;
	bh=I7qg8ZHjT6aP3EdkzgxQ5wD7De1vxy79GN86MwMPs5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSzIv8f3IbDAnLsMzZ9IZ/4/yYKLT9DCZ8ixdXm5qgQSlPMGTAJCcktCvGyRhGkMp6F5VlQ9Xd2QOu3nQFn3+rtLX/HlSyBoE9DpDGZT6cB8AHE7sM8PEfExzl7t3WQY1hwhP4UThaGlzC7dxzvHAR0VkDVpC2q50qWyMyeVUpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hnh/Vr32; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hnh/Vr32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E795E1F00ACA
	for <linux-pm@vger.kernel.org>; Wed,  5 Aug 2026 11:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785931013;
	bh=v3j6SSWGBWbZMku2YVU1lSgFa1zeRknBYo04mpyzRcs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Hnh/Vr32RfiHJeNIfTkrZJAujSS5nalOxsFa0HGGKXuWaGDhJeyyblLG2O/Y52mrD
	 vyQu5Vr57APpzCKhCmWrn0eLnyrUmA7PG8pzMbVveG9VNVxBMiTbXxXBeHbPmprNGU
	 DO2lzW3DouPdtV/O4U5hhta8iQ7ddGvi5pSccGNZURzDCh86X53OcEE+ITpuep8anA
	 2mzzMISrQDAcMm2YU8g8rkRIdLp6I7OmWXmbsr09Vp4cas3Npwe0chzZxxE9IuywJp
	 2y2litu7h2fjR7CMMWDxIMFtsiuoCR/x0zhOXibbpQF/t2xQQ2R02h9d7YA8QyUXOE
	 Fzcm4MI1xzNaw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b01cb18515so859114e87.2
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 04:56:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpZ6p0PZiyj1tgyoIG2Tv0TpQY/c29YyVFSoJ9ACJ0/Ca4YNnaZUpXfMeHla0f19cC2CZQtIUz8iA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaUvmTP0/IkgIU16zlIUNKi2MgJ+azZVsv3aCC5N32O4cbIuQe
	KCJe1USiFc0TZlFjpftJz14t9e9eb5sCTiQ5CLSzEmR/eys8mGwImC66LqN+jUqc8Je3aVfq8Fh
	Y1nQmjASu7FRb1QH2n5P6REAlYHm2T5Q=
X-Received: by 2002:a05:6512:3e1f:b0:5b2:f211:130e with SMTP id
 2adb3069b0e04-5b2f4cd2825mr836974e87.37.1785931012383; Wed, 05 Aug 2026
 04:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <962d2e30-9270-4652-b802-1676966b7968@linuxfoundation.org>
In-Reply-To: <962d2e30-9270-4652-b802-1676966b7968@linuxfoundation.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 5 Aug 2026 13:56:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j-akqqEh9MwG2WiPngrz+-SX2th+-GY-12dn0MzzZwfg@mail.gmail.com>
X-Gm-Features: AUfX_mxZedSA0T9ug_gOWqiYEbtW0MoWoCNTAWHoGnIeSOCihHjh-zyCyhoGb8s
Message-ID: <CAJZ5v0j-akqqEh9MwG2WiPngrz+-SX2th+-GY-12dn0MzzZwfg@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower fixes update for Linux 7.3-rc1
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>, 
	"John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>, Thomas Renninger <trenn@suse.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Tue, Aug 4, 2026 at 11:31=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> Hi Rafael,
>
> Please pull the cpupower update for Linux 7.3-rc1.
>
> Adds support for generic CPPC display that depends only on standardized
> fields, improving AMD specific implementation for the same.
>
> Removes conditional return with no effect as part of tree-wide code clean
> up effort.
>
> diff is attached.
>
> thanks,
> -- Shuah
>
> ----------------------------------------------------------------
> The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e524917774=
82:
>
>    Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-c=
pupower-7.3-rc1
>
> for you to fetch changes up to adfe0057326ffbc2cd5ff69a57ec0e50b5e74095:
>
>    cpupower: remove conditional return with no effect (2026-08-04 13:12:0=
6 -0600)
>
> ----------------------------------------------------------------
> linux-cpupower-7.3-rc1
>
> Adds support for generic CPPC display that depends only on standardized
> fields, improving AMD specific implementation for the same.
>
> Removes conditional return with no effect as part of tree-wide code clean
> up effort.
>
> ----------------------------------------------------------------
> Jeremy Linton (4):
>        cpupower: Add generic CPPC performance display
>        cpupower: Build and call CPPC information on non-AMD processors
>        cpupower: Print kernel and hardware frequency information
>        cpupower: Add libm to cpupower for generic CPPC view
>
> Sang-Heon Jeon (1):
>        cpupower: remove conditional return with no effect
>
>   tools/power/cpupower/Makefile                |  6 +--
>   tools/power/cpupower/utils/cpufreq-info.c    | 11 +++---
>   tools/power/cpupower/utils/helpers/cppc.c    | 56 +++++++++++++++++++++=
+++++++
>   tools/power/cpupower/utils/helpers/helpers.h |  2 +
>   tools/power/cpupower/utils/powercap-info.c   |  2 -
>   5 files changed, 67 insertions(+), 10 deletions(-)
>   create mode 100644 tools/power/cpupower/utils/helpers/cppc.c
> ----------------------------------------------------------------

Pulled and added to linux-pm.git/linux-next, thanks!
