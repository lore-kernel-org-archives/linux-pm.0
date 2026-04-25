Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC40A3806AF
	for <linux-pm@vger.kernel.org>; Sat, 25 Apr 2026 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777143218; cv=none; b=AUewQnO83TZzK9GSCw8pXnuerUy/aA+YxUmc+qZ+udxwhewfI3ekF4tMUd7Ob3GD6kT8euoPVk0nXmnnZZDO871hNtVJfnI7g/VT7U/jjlYq6LGquvKqy7fTFIQIaTE+hrHRrGAQm+KboWHp8G4lcoUOp8w/q1qjN1CBLNkHwow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777143218; c=relaxed/simple;
	bh=YO6JFcM4sVeqXL1x6ukDU3aVBbQaYQqlkXcDoBaU4hA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qEoMSnF8vwRXkOPhAuHexkvs5LJYRNHsvRg4gQnCC1kw57a0oXeqxBznp3uHAu837AJd/WwUxO29kDKhR81gu5QiQKJr8td8bKaS0lrFDN9Wewy0Imu4fYfaRkMxYsqpeR2dRZubD5yZLNKPCR5ZM6mxa2Zole2Ib105Y0miXgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCOz0ggM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCOz0ggM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70805C2BCB0
	for <linux-pm@vger.kernel.org>; Sat, 25 Apr 2026 18:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777143218;
	bh=YO6JFcM4sVeqXL1x6ukDU3aVBbQaYQqlkXcDoBaU4hA=;
	h=From:Date:Subject:To:Cc:From;
	b=QCOz0ggM0GFmBDti2dbnFjTXQjeFvbzMdD8GMKnOuhq/8DCpaQEafMDrcsqahK1xh
	 uP81CJXUZuRc4fvKcRlah3rf62Nk/TDcPG03HZp8/fNiW3xOg6rRfyoSMlZ1iliJ3h
	 436G6mxIfEEOaVVxONaBgl7doy1tSlAJb2SDhtff2pOeVVVroh514ipmP8yP6AbdI7
	 wiZJCel1BMoc8ylV5BCtO5wjSUE+MuxbduWZBXwAWJrxN29vnNKtGICVVA3KGDGAJ+
	 Jcp8G5e/Eil0cob6q299PQXRqwZ/cjXGUFUcMl1M1Rvx2gA8R4opr6wzcLM34A/BxE
	 ZxQl8SbYerINg==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67179ed133dso9905948a12.2
        for <linux-pm@vger.kernel.org>; Sat, 25 Apr 2026 11:53:38 -0700 (PDT)
X-Gm-Message-State: AOJu0YyjqeK5QFq4kQie//3jMzDimT6YcCaUADvatgERyROoNczZz0rG
	im/qya1S8qdWJE+PJShbGBz+GH/Eoeh4veRm4SbbwnHQlapf6TRwpxZoiutTcheWnui9SFHxQQ9
	doj+FVsfJ8xd4WNctqcGWkh7qeELnVeg=
X-Received: by 2002:a05:6402:d0e:b0:672:be92:e913 with SMTP id
 4fb4d7f45d1cf-672bfdd61d8mr16214075a12.17.1777143217315; Sat, 25 Apr 2026
 11:53:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Len Brown <lenb@kernel.org>
Date: Sat, 25 Apr 2026 14:53:26 -0400
X-Gmail-Original-Message-ID: <CAJvTdK=twbYaC3pdQoAsrHwU61F3h-rLRrAtD7EjaUamzWhzug@mail.gmail.com>
X-Gm-Features: AQROBzBaKUwAMOava7160fuzscwLl_B6HVyvhTcoDEPvvvGpi6ASejFulcqRmJE
Message-ID: <CAJvTdK=twbYaC3pdQoAsrHwU61F3h-rLRrAtD7EjaUamzWhzug@mail.gmail.com>
Subject: [GIT PULL] Power Utilities update for Linux 7.1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus

Please pull these power-utilities-2026.04.25 patches.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit 028ef9c96e96197026887c0f092424679298aae8:

  Linux 7.0 (2026-04-12 13:48:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
tags/power-utilities-2026.04.25

for you to fetch changes up to 6112da1ea4a7cfac35e51a20d17ca9cdf946c368:

  Merge branches 'turbostat' and 'x86_energy_perf_policy' into
power-utilities (2026-04-25 14:26:32 -0400)

----------------------------------------------------------------
Power Utilities 2026.04.25

tools/power x86_energy_perf_policy: v2026.04.25

Since v2025.11.22:

Initial SoC Slider support

tools/power turbostat: v2026.04.21

Since v2026.02.14

Display HT siblings in cpu# order.
Add Module-ID column.
Print Core-ID and APIC-ID in hex.
Fix misc bugs.

----------------------------------------------------------------
Artem Bityutskiy (1):
      tools/power turbostat: Cleanup print helper functions

David Arcari (1):
      tools/power turbostat: Fix unrecognized option '-P'

Kaushlendra Kumar (1):
      tools/power/x86: Add SOC slider and platform profile support

Len Brown (11):
      tools/power turbostat: Fix AMD RAPL regression on big systems
      tools/power turbostat: Fix --cpu-set 0 regression on HT systems
      tools/power turbostat: Fix --cpu-set 1 regression on HT systems
      tools/power turbostat: Print core_id and apic_id in hex
      tools/power turbostat: Show module_id column
      tools/power turbostat: Process HT siblings in CPU order
      tools/power turbostat: v2026.04.21
      tools/power x86_energy_perf_policy: Enhances SoC Slider related checks
      tools/power x86_energy_perf_policy.8: Document SoC Slider Options
      tools/power x86_energy_perf_policy: Version 2026.04.25
      Merge branches 'turbostat' and 'x86_energy_perf_policy' into
power-utilities

 tools/power/x86/turbostat/turbostat.c              | 231 ++++++++----
 .../x86_energy_perf_policy.8                       |  26 ++
 .../x86_energy_perf_policy.c                       | 399 +++++++++++++++------
 3 files changed, 461 insertions(+), 195 deletions(-)
