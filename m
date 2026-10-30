Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793391937;
	b=xZjUsY6Abfuan15Cy3FwHjMF0AeVZuGFgPleKrVJZX3J9N0+uj+7+ryZ0ZfNdaoVVEZx
	 JQ/iiM0f2woaXEC1u5VMuAMnFXEKGfFFYmtG0L/iRipqjkZ472Ispz3s3VVBy4XchACGJ
	 OcMx40eZ0obm+Fk3HLhK2Ax8BjoJRdFow6e9yDb5bofcPwnxUzdIrmPJzHlP1HM71YrtG
	 O6jW5Vp5Mlbk74ezg+L57upxmPhSjNylRSVht8g0Qu0chKxr6roE0yjOADE6CUAfWEYHa
	 9cWkrDKZXYT/R5/feyPQxG+0xA18T53HwVzG/0DW0/20NVr6stc6qa6D6FgrkugzBbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793391937;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=h+S/iwpWTJ5inQBvcILucyNzwuBfB9Qt4tcm6aWtHVM=;
	b=lLWC1ut3u4Nc7/2U78Th69K3/hJE+SLH7KlC94hOYEM51Bt5f+hu1XFf/b9SQYn+30ZA
	 +52HZh2Sh1rBUzDV+P3SOShFEZxlgtZjZRzzmww3WIFVlmWpZ3TcgYmH/Nx5sMZ/B0MYr
	 XWfeYxDyb8nD55onCWMxVlzh6NIMoDwmVEVxVNvSstBlsx2ekYh7wB6b2el6Bgow2fPnu
	 fKlsPQ74olhO7lJJTdoocoRtwwn3HD8UTWhZX6N3HAZ5RcurBocnNpHStXI1wL8JVDg7+
	 +qVSRXP9OnbuZkf4NtoiMguyizz530dNxdUtTLK3+ZdE5KeS1OoQ1wNYP1P+immZaBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ixOsJxxF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F263C606A31A
	for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ixOsJxxF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852941F00A02
	for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 20:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793391936;
	bh=h+S/iwpWTJ5inQBvcILucyNzwuBfB9Qt4tcm6aWtHVM=;
	h=From:Date:Subject:To:Cc;
	b=ixOsJxxF4fgDarUBZlmlz8RmvYGp90V9e1SWyaAqC5FghdiLIozPJNWpjzSJtcIHN
	 bMNVxlmjIhxs0T5rnYKXBgECC5neV/rOOvV0BX7/3zLvKhiJIeaw6Q2wHmDepBW1Pa
	 feCcpjXXhiRs2nGUmF7rKCwElk0kJ0hoI52+zkS1Rm570HbIiPHFaYcGHz+lnXQD72
	 jcGtAItAxtP/1qHnSrO3MuXAa96OfAeyRNzyoAAOgYJJn+moA2D2KiBKQyE0mhvSnx
	 72Rpcm2NoMbOU8eKmSlbqaJb2aA2JZaUZKtOpmsDz2PSkoLgP2CTV2504QHQ/XUFac
	 /I8Nno+Yfhthw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5be47aa555cso1168048e87.3
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 13:25:36 -0700 (PDT)
X-Gm-Message-State: AFq9FYJl1uAbPzIaP15Kqu5oaSQeeHp5Awph20T5P0a21PqXdBsx/HYr
	lZKKLCPuhjjmFkP0JZ85qGcwDIf6a5jdWr7JrgCO2qTVe2pKjRPuK52Bc4R/UK8B6pWH99l7GcZ
	kt6qmJdnOmX2C7WCE6FknEAssck9duUs=
X-Received: by 2002:a05:6512:b9a:b0:5bf:b8f1:80dd with SMTP id
 2adb3069b0e04-5bfd9583a29mr1226796e87.54.1793391935000; Fri, 30 Oct 2026
 13:25:35 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 30 Oct 2026 21:25:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jSxPop-hQ+2+cDRihaUWB3ubNJEcW-p5VC--W+Xfr0YA@mail.gmail.com>
X-Gm-Features: AclHuK_lN9lxHG82WFu8SnI0fZmqRuMJe_aC4_DNFq31H3OntBN_qfbal4jvSsY
Message-ID: <CAJZ5v0jSxPop-hQ+2+cDRihaUWB3ubNJEcW-p5VC--W+Xfr0YA@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for 7.4-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-7.4-rc1-2

with top-most commit 018f42c9ac5fa9701fc09514ed0739ab72708331

 Merge branches 'pm-cpufreq', 'pm-cpuidle', 'pm-runtime' and 'pm-sleep'

on top of commit 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614

 Merge tag 'driver-core-7.4-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core

to receive power management fixes for 7.4-rc1.

These address assorted issues in the power management code and update
documentation:

 - Fix potential out-of-bounds access in deferred reset in the cpufreq
   statistics code (Zhongqiu Han)

 - Cancel HWP notify work in the intel_pstate driver cleanup to prevent
   possible use-after-free from occurring (Tristan Madani)

 - Adjust state names and descriptions for ACPI _LPI idle states in the
   intel_idle driver to make them follow the driver's idle state naming
   convention (Rafael Wysocki)

 - Document the new pm_runtime_use_autosuspend() undo mechanism that
   triggers automatically on driver exit (Joshua Crofts)

 - Do not call suspend_ops->begin()/end() for suspend-to-idle to avoid
   driver confusion (Ovidiu Panait)

 - Make the energy model management code allocate the cpumask for
   non-CPU perf domains to prevent out-of-bounds reads from occurring
   in the EM netlink interface (Karl Mehltretter)

Thanks!


---------------

Joshua Crofts (1):
      PM: runtime: clarify pm_runtime_use_autosuspend() undo mechanism

Karl Mehltretter (1):
      PM: EM: allocate the cpumask for every perf domain

Ovidiu Panait (1):
      PM: suspend: Do not call suspend_ops->begin()/end() for s2idle

Rafael J. Wysocki (1):
      intel_idle: Adjust state names and descriptions for _LPI states

Tristan Madani (1):
      cpufreq: intel_pstate: cancel HWP notify work in driver cleanup

Zhongqiu Han (1):
      cpufreq: stats: Fix potential out-of-bounds access in deferred reset

---------------

 Documentation/admin-guide/pm/intel_idle.rst | 12 +++++++-----
 Documentation/power/runtime_pm.rst          | 10 +++++-----
 drivers/cpufreq/cpufreq_stats.c             |  4 ++++
 drivers/cpufreq/intel_pstate.c              |  2 ++
 drivers/idle/intel_idle.c                   |  9 +++++++--
 include/linux/pm_runtime.h                  |  6 +++---
 kernel/power/energy_model.c                 |  4 +++-
 kernel/power/suspend.c                      | 20 ++++++++++++--------
 8 files changed, 43 insertions(+), 24 deletions(-)
