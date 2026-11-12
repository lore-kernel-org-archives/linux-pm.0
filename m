Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487495;
	b=sRXHTN6WKenWz5LKVDO7nNds/APJ6pGg+aDzLSK5ls/El7wX495NwjTk1IV+bueZU/OX
	 q4097kxTH+EG15lOfSGiwPuWioyTEemycsSX/VXB2M9VD+j7KP69pJ6QbhY09YeB5LJfw
	 dbF+YuPt8NV5vtan/VJ9QBoIPTLJ/JoaRehfH+rg43aU8aKd02uUZQwLgGWkZxNE9ERkc
	 vThQ7YhvOQM6wkO67btm4A5dmWldzHhhMnmCMKZMAcS9eRE6RxlEYOCr/vNuA89hnZ08e
	 WllLgn+Oy5zcggSjLzrS7oLEUjLDycZLWufpsGyigayN3wIYwm5oUPZ236VDHsuipaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487495;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=f1XHlG/1VgdvReV+lxl49g3+w+nT5a9aeMXBWrjsMjo=;
	b=pof98FutNglJeN7XwgPgabGsK8Y9M95S+GvSkOHHCo5AjQJ4nKVLZc5f3ktPJ0SgdF9K
	 dJmzQEl21JITZTaoSV5M0PeDYzq3NGYLKe6Bkr34PQSKzF0gsQpa2j2H+iLGLibhkPh5O
	 RZwmol00l7TKk6SWsQEQnSF2lsJdSbWgqTtJhhmJzV17e5cipazXjNz1bzqzHvbQ4DGLy
	 ltvGc9eIbb1JPj/D7IJhvL/fD0RZDzljO1f4POcNk6A8H1b5EnMM2J/7U6r7jPVhq+wvh
	 FVinYRn/yuxphifF4OdsfdVsWvZybrMyFjpfbiYLGA8IWiM1tNt8f38BT8IHFIl2VEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q3hNRoJQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDF0606A32D
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q3hNRoJQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39D51F00A06
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 12:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794487495;
	bh=f1XHlG/1VgdvReV+lxl49g3+w+nT5a9aeMXBWrjsMjo=;
	h=From:Date:Subject:To:Cc;
	b=Q3hNRoJQDx9CHd6O1fTX6knpyrBR2QtJFFaywz6lRPyhhG6OTY4ubAb05Wg6kMUMo
	 qpttarvtzzczo3sl8biSZIUUoYM7SGjAgj95XYvXRX97eXoKUtaM2qkOjLrfmikSrz
	 htmToMgG9f5Z9X/h6kA52asK3MS8wIzspawNpWdywLNpxS5/FfwVfEJrHSXSEVT3W+
	 wd2GntbDe8BkbS/VmSDf9VxMrKq3hYKM47EibRpUXwKd/V5anfCbQ1DAYrcuMf+us+
	 8Fbqk0Y5v0CqG16ClMq6XN5L0ytY55Mw/JXMaw3oBiQEYUBZpeH1vFfp/lTpcKHpNz
	 39wJozRzCii2Q==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bfa65c8617so2541400e87.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 04:44:54 -0800 (PST)
X-Gm-Message-State: APuU4Z88kLsO8JoK7fE53gHgO8edmfPdLPslKBLbbEO/MBGn/yXMP6sV
	PQ/eRpTWugK1/NHDJVdgv/tNdwTrtAiVUYZNJmedU2Wd4sBeUQs4j7/RXjmW1KHf1kRVcLpEkvu
	y3H5sAFzUMcLIO5Cz0bLKGzx7AyKyTnU=
X-Received: by 2002:a05:6512:31ce:b0:5c1:4a64:ca27 with SMTP id
 2adb3069b0e04-5c15d5a6501mr1787430e87.6.1794487493352; Thu, 12 Nov 2026
 04:44:53 -0800 (PST)
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
Date: Thu, 12 Nov 2026 13:44:40 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jbeLEdsBPW94yYQqxfJOyBBdGpq9x_OLcSyKzDHYoH4A@mail.gmail.com>
X-Gm-Features: AclHuK99WIgiDMoHkK_zotqn1drz6khEX4dAVoN5T-1Xq0Pcl4dpXw_3ipC3lEo
Message-ID: <CAJZ5v0jbeLEdsBPW94yYQqxfJOyBBdGpq9x_OLcSyKzDHYoH4A@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for 7.4-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-7.4-rc3

with top-most commit df42809bd599109660bd3f95e2e22330c80993df

 Merge branches 'pm-cpufreq' and 'pm-runtime'

on top of commit 7475ea8b58616b33c04afb976cf0fbaad9dd63fb

 Linux 7.4-rc2

to receive power management fixes for 7.4-rc3.

These address a few issues in the cpufreq core and drivers, including
issues actually seen in the field, a few issues related to runtime PM,
including a false-positive warning introduced relatively recently
and a long-standing defect in the runtime PM core code related to
autosuspend, and revert a problematic recent update of the intel_rapl
power capping driver.

Specifics:

 - Revert a recent update of the intel_rapl power capping driver that
   caused perf to return bogus values (Dennis Chen)

 - Fix the synchronization of boost state updates in cpufreq (Christian
   Loehle)

 - Fix issues related to system suspend-resume synchronization in the
   cpufreq core and intel_pstate driver (Rafael Wysocki)

 - Fix P-state index mismatch in extract_io() in the ACPI cpufreq driver
   on systems with defective _PSS (Li RongQing)

 - Fix issues related to target frequency caching in cpufreq (Rafael
   Wysocki)

 - Prevent a false-positive warning in pm_runtime_remove() introduced
   by a previous fix during the 7.0 development cycle (Zhou Minqiang)

 - Extend a recent improvement related to the handling of suppliers
   during device runtime-suspend to some previously missed cases in
   which it is relevant for consistency (Brian Norris)

 - Update runtime PM documentation to reflect new behavior after recent
   changes (Stanley Jhu)

 - Add last_busy timestamp updates for devices requested to resume from
   runtime suspend that are missing if those devices are not actually
   suspended (Rafael Wysocki)

Thanks!


---------------

Brian Norris (1):
      PM: runtime: Only queue an idle check for RPM-linked suppliers (part 2)

Christian Loehle (3):
      cpufreq: Hold the policy write lock when changing boost state
      cpufreq: Preserve global boost state on failed updates
      cpufreq: Serialize global boost updates

Dennis Chen (1):
      Revert "powercap: intel_rapl: Expose all package CPUs in PMU cpumask"

Li RongQing (1):
      cpufreq: acpi-cpufreq: fix P-state index mismatch in extract_io()

Li Zhaoxin (1):
      cpufreq: intel_pstate: Use rdmsrq_safe() to read MSR_MISC_PWR_MGMT

Rafael J. Wysocki (6):
      cpufreq: Improve suspend-resume synchronization
      cpufreq: Force passing target frequency to driver during resume
      cpufreq: intel_pstate: Clear last written P-state value on suspend
      cpufreq: Cache post-resolution target frequency in __resolve_freq()
      cpufreq: Fix updates of cached resolved frequency and index
      PM: runtime: Update last_busy in rpm_resume() for active devices

Stanley Jhu (1):
      PM: runtime: Update runtime_pm.rst for non-fatal resume errors

Zhou Minqiang (1):
      PM: runtime: Fix check_flush_dependency warning from pm_runtime_remove

---------------

 Documentation/power/runtime_pm.rst   |  17 ++--
 drivers/base/power/runtime.c         |  11 ++-
 drivers/cpufreq/acpi-cpufreq.c       |   9 +-
 drivers/cpufreq/cpufreq.c            | 162 +++++++++++++++++++++++++----------
 drivers/cpufreq/intel_pstate.c       |  18 +++-
 drivers/powercap/intel_rapl_common.c |  15 ++--
 include/linux/cpufreq.h              |   7 +-
 7 files changed, 169 insertions(+), 70 deletions(-)
