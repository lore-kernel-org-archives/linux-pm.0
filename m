Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D7D389E1A
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785436774; cv=none; b=bfqqbMY6HGx9IJDnLJgFNSNvVO+/79+Y+ertscHVSt9as5Yu+QjuSWRH96QLAKxuDKtoF4jPkttwn47ZyPFLPGI0mi5JyzwiwrpR1nVIyTTHRyZ9mIE1YjlLY9mbEZjzwvn6VELAuxsLTRe6yjitoulUY02JqrAX71oZoqnQKYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785436774; c=relaxed/simple;
	bh=o7Zs3rW8txeV/V0zoJukhZiiwj1s4zdR0EtWiCkExYU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EYw4jw9H25Say7aejnWcpdNMhEbDXj11iSAcVyBFV93BNko2l8iQ+xtC/twfLMR4Za3Ko2OuV/aQX/8TMipubhdlZ4Cgnt9z4JspV4iputVLf772q82JrmCzstGTr3DKJ8UhDB4jS3E29nPNEB3l2ZAyVVh5Zn9uP8aUsQ421QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+wlB3NY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+wlB3NY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815941F00A3F
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 18:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785436763;
	bh=vKmPmVdEPdqULXbzUMCT0q0e8es2Au23/dD3XMpcKpc=;
	h=From:Date:Subject:To:Cc;
	b=e+wlB3NYw33ZemRSLNIENO2uo8KoCQ3xXJRzjP1+erMXiMFdDsBPV7Eau0ZxqduKY
	 fqSXW9A1DFnavo8QJoFuaQWQWARVzZUIdmuMsHhEX77FYf1OSXTy46J/i/30J6ooWF
	 3xInaIjlTr8b0ooE9C/qCkibdPHHxCsqthEkJVZg9SwznFPAneV62Vb/ZTzAjkni5x
	 FWvGlTnui6CU9qF8WI75G2W4NBtVkBvYKessZp5eF97JLyAbkBgYjj18klbIY/Mh/g
	 JHxp3U6X2wiu6qXts6pzqbXbOjpGvpHUHToGKAxlyMMsUKa0z5XJIPIfDiT6HzO6FB
	 FrRK04bvXHIcg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b2b92065ffso97622e87.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 11:39:23 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy1pzCORrF5yFGw6LW/rAyRp/INWNg4y6fU67nJKAWVaeCY23CP
	QtIbzI/oZaSRE+o0+rJpPPyIecOg0gPqmS/dEVwBfd2yvZGyxV91mFpbryE5kakmg0LXRI+V4a8
	+vmB9d+2s2yJlnBgl5m2j3RGCKhgOsgM=
X-Received: by 2002:a05:6512:68b:b0:5b1:5457:a930 with SMTP id
 2adb3069b0e04-5b2db34f392mr833060e87.16.1785436761949; Thu, 30 Jul 2026
 11:39:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 30 Jul 2026 20:39:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hnQknRyf1YW9gDiyuh+S-Rpb-_cL-1jayO9R8Uq9G_Zw@mail.gmail.com>
X-Gm-Features: AUfX_mwBNgMFYzwFdU5u8SDk_FinSikcyDKCDlKjTnF47fj4lmJ60S6lq7J0r2U
Message-ID: <CAJZ5v0hnQknRyf1YW9gDiyuh+S-Rpb-_cL-1jayO9R8Uq9G_Zw@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for 7.2-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-7.2-rc6

with top-most commit d5f8e5f6040d052d44fcbf4f31dd35145c0c8d7d

 cpufreq: powernow-k8: Fix possible memory leak in powernowk8_cpu_init()

on top of commit 1590cf0329716306e948a8fc29f1d3ee87d3989f

 Linux 7.2-rc4

to receive power management fixes for 7.2-rc6.

These fix issues related to cpufreq, in the ACPI CPPC library and the
generic CPPC cpufreq driver, in the powernow-k8 and amd-pstate drivers,
and in the schedutil governor:

 - Allow fast frequency switching in the ACPI CPPC library only when
   every supported control used by the driver callback has an address
   space already accepted for fast access (Christian Loehle)

 - Skip writes to unsupported performance controls in the ACPI CPPC
   library (Christian Loehle)

 - Update cppc_cpufreq_update_perf_limits() to read policy->min and
   policy->max once and, if the lockless snapshot is inconsistent,
   reduce the minimum to the observed maximum, along the lines of
   cpufreq_driver_resolve_freq() (Christian Loehle)

 - Fix a possible memory leak in the powernowk8_cpu_init() error
   paths (Abdun Nihaal)

 - Loosen the requirement on lowest nonlinear frequency != min freq in
   the amd-pstate driver that is too tight for new systems some of
   which actually have the lowest nonlinear frequency identical to the
   minimum frequency (Mario Limonciello)

 - Prevent amd-pstate from loading on unsupported hardware (Rong Zhang)

 - Address an initialization race in the schedutil governor when it
   runs on multi-CPU cpufreq policies, by making it initialize all
   per-CPU structures first and only then publish the per-CPU
   utilization update hooks (Zhongqiu Han)

Thanks!


---------------

Abdun Nihaal (1):
      cpufreq: powernow-k8: Fix possible memory leak in powernowk8_cpu_init()

Christian Loehle (3):
      ACPI: CPPC: Check all controls for fast switching
      cpufreq: cppc: Sanitize lockless policy limit snapshots
      ACPI: CPPC: Skip writes to unsupported performance controls

Mario Limonciello (1):
      cpufreq/amd-pstate: Loosen requirement on lowest nonlinear
frequency != min freq

Rong Zhang (1):
      cpufreq/amd-pstate: Prevent the driver from loading on
unsupported hardware

Zhongqiu Han (1):
      cpufreq: schedutil: Publish util hooks only after all sg_cpu are
initialized

---------------

 drivers/acpi/cppc_acpi.c         | 29 +++++++++++++++++++++--------
 drivers/cpufreq/amd-pstate.c     |  8 +++++++-
 drivers/cpufreq/cppc_cpufreq.c   | 33 +++++++++++++++++++++++----------
 drivers/cpufreq/powernow-k8.c    |  1 +
 include/acpi/cppc_acpi.h         |  5 +++--
 kernel/sched/cpufreq_schedutil.c | 11 +++++++++++
 6 files changed, 66 insertions(+), 21 deletions(-)
