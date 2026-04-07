Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211FE2222AC
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775569390; cv=none; b=XzaPxD/i/QRwJ2Lfiw28P4tdaNvi5ni8HFJJ3IxkGPwr2vTkxkR1rVLIH2Mk+0OKhxa8O5iQDMHBK+hSRTmYJJU8rRBgJvx+OnIpWyCV51ijx/4DjcTZzYNagSYvTHbClxTO/aJXN8mdpDHcTx9M+bz4yeI+FTvMU7z7eqkQpjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775569390; c=relaxed/simple;
	bh=uErRD7XgRZQNBFUCJ2Vi5whpxyCfGOAmyddmbGlc3Ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOGSp0AWGxhEVFDsF04QjQWgJnwWt8O9OECGcwLpXOevX4rW2SjUFOoLe291v/C2IPJRFnn8mGFFcUsUJmfKdqkXo1KoFB5OuAlFOK3onFfI+8B6d3pHywBt/h08DqsTqm2bVpPkrWbyO4udZsflN1/mlfYZx0PxpsCtTnGex7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8WpXKUC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8WpXKUC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBD3C2BCAF
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 13:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775569390;
	bh=uErRD7XgRZQNBFUCJ2Vi5whpxyCfGOAmyddmbGlc3Ig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X8WpXKUC59VXvQX7kGiLDW5AQahkL1j9hU1fHusSF22tzLK8O4md0gZHuX42ga26p
	 ivzhfDQAfPoeieLcLE07GEewqw0PXAS2Ur2L5LiERM4DKw68pBSF+NfgC1I7oVnJl4
	 /VoqlKv9/bCcks0oI2TkyESuMObFRpxItwvaCEbmDLH/j+0+0DWcSsehtNZJiQEyej
	 LchmNTZVVJvMIzxqXEAewmGQ8G5ORHgdb5IO7yPz26U3MhZUY/wS8ZtsprFne5tB5A
	 hEmdExZbfZsCnG36Q9Z9wXaoVD0P4jAaCMZ/aR2CArjcx7JXblTo7dzyY3zby/6r4f
	 /1sZ7XV0Hi8SA==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4043b909ed4so2783229fac.3
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2026 06:43:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUivQ2ct7nrQpLRgpochheYdup95lsao8PEAUTzUZKFvI58scQwhurcHIdqZ9NsAC+CmZQlHXrQmg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhqtm9DW0/wrrEMLQQGCbdKDMyfQXrvRRrLl7RZaxCtHgkb3sf
	AA87uZ/M6ZEOgcJltqEePjKdFSAlTY+eU/qcOQ9hG9axLpGZpipGRy3uh72oTUU1Wkxi47IUz9l
	xMN28deC9Wl352y3fBOL3i86BkABrckg=
X-Received: by 2002:a05:6871:4d0:b0:417:7b1d:1b2 with SMTP id
 586e51a60fabf-4231022b7abmr9032695fac.42.1775569389130; Tue, 07 Apr 2026
 06:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <651e317c-dc31-4895-ac09-2f12398ed3be@linuxfoundation.org>
In-Reply-To: <651e317c-dc31-4895-ac09-2f12398ed3be@linuxfoundation.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 Apr 2026 15:42:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jemSd-h+0HKkN=8rnygX+zA4u2cbb+VufrcjU74M=hOw@mail.gmail.com>
X-Gm-Features: AQROBzAgudxDY0AK3nZxjkO6is309zE--tWMJsTS9zN6fwDsTWuUHX461ho7XzA
Message-ID: <CAJZ5v0jemSd-h+0HKkN=8rnygX+zA4u2cbb+VufrcjU74M=hOw@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower next update for Linux 7.1-rc1
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>, 
	Thomas Renninger <trenn@suse.com>, "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Thomas Renninger <trenn@suse.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Mon, Apr 6, 2026 at 8:40=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.or=
g> wrote:
>
> Hi Rafael,
>
> Please pull the cpupower next update for Linux 7.1-rc1.
>
> - Fixes errors in cpupower-frequency-info short option names
>    to its manpage.
> - Fixes cpupower-idle-info perf option name to its manpage.
> - Adds boost and epp options to cpupower-frequency-info to its
>    manpage.
> - Adds description for perf-bias option to cpupower-info to its
>    manpage.
> - Removes unnecessary extern declarations from getopt.h in arguments
>    parsing functions in cpufreq-set, cpuidle-info, cpuidle-set,
>    cpupower-info, and cpupower-set utilities. These functions are
>    defined getopt.h file.
>
> diff is attached.
>
> thanks,
> -- Shuah
>
> ----------------------------------------------------------------
> The following changes since commit c369299895a591d96745d6492d4888259b004a=
9e:
>
>    Linux 7.0-rc5 (2026-03-22 14:42:17 -0700)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-c=
pupower-7.1-rc1
>
> for you to fetch changes up to 2fd3b83cacfb9160b896fb26117328eeb0598c54:
>
>    cpupower: remove extern declarations in cmd functions (2026-04-06 11:2=
5:32 -0600)
>
> ----------------------------------------------------------------
> linux-cpupower-7.1-rc1
>
> - Fixes errors in cpupower-frequency-info short option names
>    to its manpage.
> - Fixes cpupower-idle-info perf option name to its manpage.
> - Adds boost and epp options to cpupower-frequency-info to its
>    manpage.
> - Adds description for perf-bias option to cpupower-info to its
>    manpage.
> - Removes unnecessary extern declarations from getopt.h in arguments
>    parsing functions in cpufreq-set, cpuidle-info, cpuidle-set,
>    cpupower-info, and cpupower-set utilities. These functions are
>    defined getopt.h file.
>
> ----------------------------------------------------------------
> Kaushlendra Kumar (1):
>        cpupower: remove extern declarations in cmd functions
>
> Roberto Ricci (4):
>        cpupower-idle-info.1: fix short option names
>        cpupower-frequency-info.1: use the proper name of the --perf optio=
n
>        cpupower-frequency-info.1: document --boost and --epp options
>        cpupower-info.1: describe the --perf-bias option
>
>   tools/power/cpupower/man/cpupower-frequency-info.1 | 8 +++++++-
>   tools/power/cpupower/man/cpupower-idle-info.1      | 4 ++--
>   tools/power/cpupower/man/cpupower-info.1           | 9 ++++++++-
>   tools/power/cpupower/utils/cpufreq-info.c          | 2 --
>   tools/power/cpupower/utils/cpufreq-set.c           | 2 --
>   tools/power/cpupower/utils/cpuidle-info.c          | 2 --
>   tools/power/cpupower/utils/cpuidle-set.c           | 2 --
>   tools/power/cpupower/utils/cpupower-info.c         | 2 --
>   tools/power/cpupower/utils/cpupower-set.c          | 2 --
>   9 files changed, 17 insertions(+), 16 deletions(-)
> ----------------------------------------------------------------

Pulled and added to linux-pm.git/linux-next, thanks!
