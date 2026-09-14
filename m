Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3B437BE6E
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 18:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789410661; cv=none; b=eYfwR3NzBOFJo0vqvaL7fgXa/PqcHjGc0GjxQUw/ka96S9W0PkaPaw6PygVvDl5zsivyGyeJQL6dyDJt6udl53kZXF8tvrBmdHKzPh6DZEbxSJ+0L/ImL5DPq5N3/CO75j6Vh8+ACJzrT8hKy3L+GfW4wfemzLnw7Hnlkz1RlsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789410661; c=relaxed/simple;
	bh=0zjsOYLhvyRJ1pTm9DIcxSxZK4nF+A+ATxSzar0smpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAOeT/I1DQUbrGd8Ior9bna+0qgER47HwKsN7hreT4mqQWOd5AoHYggEMcdNW3mdHD5nkA1Av6xEIySjA+WIEcYVyPF/YKJYe5YuF+6yzhBUXoHAiga3I9Ky4WPAcJ+iEsHT1L83EiwcFd3VEAdJmBJtiloZ9vRzIV+zMbKrGzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOTI9oJi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOTI9oJi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373F61F000FF
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 18:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789410659;
	bh=Fl4PcAx6FdhNuO3+JAKo0artYlMpMraDuo4cBowVrVU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QOTI9oJiyHmRcM9yOB8MWgOies0hjSZtcKatCuHTQbW6b2tDu6rjhSGLuIR54Jd7Q
	 /b5fKgZdvoluC6XApZofY9BbJuOcUGWMHY+vEvL1BV85ezz9GSNkypGAKRijNxm1Ek
	 b81ljdMH0YVTMudURfyXvG+q6E+hkwyf8dgvRKioZxM/5+T5S9fHRPlVn83/xhpHXR
	 4dhC4qrGduieBX/Vs5KcRUfLE7b/Nu5a2ZCgKzggXCNzF3uWrwIluCMkQfJIyzWSTG
	 CO/FlWvcol2aqivGroTjoDmHPa+HcL6USxTrHCEE66lzHD0SwycL0btHaSfAhhLUr5
	 DDMfaSufkB4dQ==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f16f15so2674560e87.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 11:30:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzgz8sTG+gDSY2RLWp4Z5h80+LRS9yIJQNMxYBrB1frClRPk46/IpFPAl7KrVb7bxp0w72m5FA59g==@vger.kernel.org
X-Gm-Message-State: AFuF++nYPVipxwjLZln0KgO++gDyIfl0riUGs56PPogNjtFKRZnJ/DVF
	ghnxHScUlB38/oTiixkrUqA7zfwhSK5FW9OT3zzINQkZxWb8roUunc4y/vyLXaOPv5O8cbWxdv4
	WZcuOmV8USC92xVmNFoswI1T6UitIZwA=
X-Received: by 2002:a05:6512:3187:b0:5b6:423:7f0f with SMTP id
 2adb3069b0e04-5b8ae8a76b0mr1747521e87.29.1789410657560; Mon, 14 Sep 2026
 11:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <03c0a0d4-20d2-475b-ab7c-5b1a3742cf92@amd.com>
In-Reply-To: <03c0a0d4-20d2-475b-ab7c-5b1a3742cf92@amd.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 14 Sep 2026 20:29:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hu0pQZVvT5GZcpWt3itV6CT+ptMZyfGms3qdPW99ba4Q@mail.gmail.com>
X-Gm-Features: AcwNN1W4Qcp_p5NzZvoY4GbY3csw53hcDhS8mw4I86DVtk-qhPx-2Akhq2tB0rI
Message-ID: <CAJZ5v0hu0pQZVvT5GZcpWt3itV6CT+ptMZyfGms3qdPW99ba4Q@mail.gmail.com>
Subject: Re: [GIT PULL] amd-pstate 7.4 content (2026-09-14)
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 5:33=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The following changes since commit df2908090cda368b01ff43709f51890076c561=
57:
>
>    Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v7.4-2026-09-14
>
> for you to fetch changes up to c8663e0457e6e6c72006478f4b6da99060030ec1:
>
>    cpufreq/amd-pstate: Remove obsolete amd_dynamic_epp documentation
> (2026-09-10 14:33:59 -0500)

Pulled and added to linux-pm.git/linux-next, thanks!

> ----------------------------------------------------------------
> amd-pstate 7.4 content (2026-09-14)
>
> * Fix for amd-pstate-ut with 'Requested CPU Min frequency' BIOS option
> * New Zen6 tuning values for EPP
> * Documentation fix
>
> ----------------------------------------------------------------
> K Prateek Nayak (1):
>        cpufreq/amd-pstate-ut: Fix amd_pstate_ut_check_freq failure with
> 'Requested CPU Min frequency' BIOS option
>
> Karl Mehltretter (1):
>        cpufreq/amd-pstate: Remove obsolete amd_dynamic_epp documentation
>
> Mario Limonciello (1):
>        cpufreq/amd-pstate: Show a warning if missing EPP tunings
>
> Mario Limonciello (AMD) (2):
>        cpufreq/amd-pstate: Add per SoC and per core type EPP tuning value=
s
>        cpufreq/amd-pstate: Add EPP tunings for Zen6 client platforms
>
>   Documentation/admin-guide/kernel-parameters.txt |   7 ------
>   Documentation/admin-guide/pm/amd-pstate.rst     |   6 -----
>   drivers/cpufreq/amd-pstate-ut.c                 |  23 +++++++++++++++++=
+-
>   drivers/cpufreq/amd-pstate.c                    | 226
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------=
----------------------------------
>   drivers/cpufreq/amd-pstate.h                    |  16 +++++++++++++
>   5 files changed, 214 insertions(+), 64 deletions(-)
