Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EE9421251
	for <linux-pm@vger.kernel.org>; Sun,  4 Oct 2026 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791119410; cv=none; b=BV1bI6a8RvyFE4niOupibgjd+2NUTBEqYk0aOIl6zl8IIF+SKEULFQEDEEt4Yi2aUzmWIGDVlj/rxFXU5DN8xdGvGK5MTPTDZj8w87evabQLFhez832barhBK4q/gwYtpESsoZ8C7SyPAxibzZx0dPwlS9w+h2pO9OomhQHwONM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791119410; c=relaxed/simple;
	bh=v5PukMoiBGeGbdbpjUcWb4RbvGAqnIonoMxIHNR54rc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QKNBR6uPTB02C5lrA6alfZdyyzB3ItV7pt3ZI4zVH0WpfgxMYrSSVcI70rj/dY08G4KGOlbfZXfYDcATqFZ6A9o8D4rneTCDzJg2qxbkB/NXWvqglzwNUWVsh8TkK/29cFkZ7bkP2gFjrbaXkpDX1OCRpt23ERn1lYHnJAM/2qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyYWwpUm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyYWwpUm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4365A1F000FF;
	Sun,  4 Oct 2026 13:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791119408;
	bh=y5qkMSfExKqXr5r6muP5C6KxaKa3lnXxcNHoDLvgHXs=;
	h=Date:To:Cc:From:Subject;
	b=UyYWwpUmgkNkKXmI4FkyhEWD8+bLOeCwZGEY9csdn+rIG7IStWVvflgPdjsok7hqt
	 3QCm/qUHvYEBHfZgXhiPVNrJxWaHFSvF4GwJGpWXnmZ+vQMqDlpsmhJwnSKoz8dvfo
	 h0q05K8VqCe/0PmT/G0Lg4isLq4zbcne8G8XRnrupZj9b+voe2EMJgNS0M1Iszuo2p
	 aOr95MgW+uJJ3TbdHoytk7hkYgjFOsJ3uI7S5kv8NAnT0FDCi/7kfCewBr53HygGwQ
	 grry1qb3+8koPdABQ/ThzldFvDwa+j/E6tDkC4RhM2A1dx1PRDzkDjH5Or/FNoYKkJ
	 2C6zaolFHlzSQ==
Message-ID: <4bc0e16b-f8a8-49a9-aaab-c7161ffdba89@kernel.org>
Date: Sun, 4 Oct 2026 08:10:07 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
From: Mario Limonciello <superm1@kernel.org>
Subject: [GIT PULL] amd-pstate 7.4 content (10/4/26)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The following changes since commit c8663e0457e6e6c72006478f4b6da99060030ec1:

   cpufreq/amd-pstate: Remove obsolete amd_dynamic_epp documentation 
(2026-09-10 14:33:59 -0500)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v7.4-2026-10-14

for you to fetch changes up to 6b64d65c83688db2e58fbd9de7c74090f15271b7:

   cpufreq: amd-pstate-ut: Fix max_freq and EPP test failures on Zen6 
(2026-10-01 13:05:07 -0500)

----------------------------------------------------------------
amd-pstate content for 7.4 (10/4/26)

* Fixups for a few bugs identified by Sashiko
* Initial support for maximum frequency capacity handling on Zen6 / client
* Updated EPP tunings for Zen6 / client

----------------------------------------------------------------
Mario Limonciello (7):
       cpufreq/amd-pstate: Fix TOCTOU when changing driver mode via sysfs
       ACPI: CPPC: Refactor boost ratio handling
       cpufreq/acpi-cpufreq: Use amd_get_boost_ratio()
       cpufreq/amd-pstate: Get Highest Freq for a CPU
       cpufreq: amd-pstate: Restore previous mode when changing driver 
mode fails
       cpufreq: amd-pstate: Propagate cppc_set_auto_sel() errors on mode 
change
       cpufreq: amd-pstate-ut: Fix max_freq and EPP test failures on Zen6

Vishal Badole (1):
       cpufreq: amd-pstate: Update Zen6 client EPP tuning values

Wentao Guan (1):
       cpufreq/amd-pstate: Skip auto_sel write when it already matches 
the mode

Xueqin Luo (1):
       cpufreq/amd-pstate: Restore previous EPP if profile_name 
allocation fails

  arch/x86/kernel/acpi/cppc.c     | 166 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------
  drivers/cpufreq/acpi-cpufreq.c  |  17 ++++++++---------
  drivers/cpufreq/amd-pstate-ut.c |  54 
+++++++++++++++++++++++++++++++++++++---------------
  drivers/cpufreq/amd-pstate.c    | 116 
+++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------
  drivers/cpufreq/amd-pstate.h    |  44 
++++++++++++++++++++++++++++++++++++++++++
  include/acpi/cppc_acpi.h        |  14 ++++++++++++--
  6 files changed, 264 insertions(+), 147 deletions(-)
