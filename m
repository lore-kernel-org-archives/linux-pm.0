Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E0A3009D4
	for <linux-pm@vger.kernel.org>; Thu,  2 Apr 2026 20:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775162037; cv=none; b=sWtOVOJ5RRtN+VWwfgKUgX9hxUmvdPnCHIeufA5EVeismQAv4FVBm4Z/xj8foaOcuE7fWtH5fWxaCe2J2sgItlzKMP61JZ4+AnRvGmiRjL4HiqYCIXE7maUY4YcxWczU0Mk+Hu5ss1lf+DgXhYl1HdD6S8WDVCMrOBRgAV231BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775162037; c=relaxed/simple;
	bh=lPF+svh7psiW9stHWwv+CbPBzOnIY0oWqKAmyac6zKQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=THlncObcS670v+hMyD8fqyojLUXEnhh8NWIokFpoWX135wkmte3K5RPQpzrx4BEzvokwDVGTvLlHugNr/vpvneuRE1+53JVPR4/7mAcO9v7ksiRySTn/Mt0zIj9QjyvbaDVT2chaHBeu45xf8SHwLyWXV0RlAPI4Z55je5Sk6uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlBSX0qG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlBSX0qG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D9AC116C6;
	Thu,  2 Apr 2026 20:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775162037;
	bh=lPF+svh7psiW9stHWwv+CbPBzOnIY0oWqKAmyac6zKQ=;
	h=Date:To:Cc:From:Subject:From;
	b=XlBSX0qGtrNnYxfW40L7IwDtzQgOtd56NRgTIWgWGDGKis+RHYJPsmdKnwnvzyLDQ
	 fusmuecKtl22l//yoLdrEcHR7rJEO3pDgnQJ7KGFiZjQJCGa8XO1QPHPeC7YarmjGq
	 U3x3azkC5dc5DsU8qgBKoauwQQSXcCzypZzSbzv+ovPTvPsiyn0iJm4M4sdXdxBCls
	 GjOkIhOLNo8M4hjJI11kH6L36YirTp3ha2ij0U+s0oMlAUsuKtsxF+Lt9ISL3s2v7E
	 hxLegEA7su+LE6ZezBa1ETHzcuO95v1NxEqV1hY7pXtyhZR5Ox9kJAXYZTbCFs466H
	 7uL3oFEEvVKhQ==
Message-ID: <8f7a08eb-26ae-47a5-bcb5-b0db7c8f771b@kernel.org>
Date: Thu, 2 Apr 2026 15:33:56 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
From: Mario Limonciello <superm1@kernel.org>
Subject: [GIT PULL] amd-pstate new content for 7.1 (2026-04-02)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The following changes since commit c369299895a591d96745d6492d4888259b004a9e:

   Linux 7.0-rc5 (2026-03-22 14:42:17 -0700)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v7.1-2026-04-02

for you to fetch changes up to 9487e2a00e7b3c6f258c5c99953f470eba6fb61d:

   MAINTAINERS: amd-pstate: Step down as maintainer, add Prateek as 
reviewer (2026-04-02 11:30:24 -0500)

----------------------------------------------------------------
amd-pstate new content for 7.1 (2026-04-02)

Add support for new features:
  * CPPC performance priority
  * Dynamic EPP
  * Raw EPP
  * New unit tests for new features
Fixes for:
  * PREEMPT_RT
  * sysfs files being present when HW missing
  * Broken/outdated documentation

----------------------------------------------------------------
Gautham R. Shenoy (13):
       amd-pstate: Fix memory leak in amd_pstate_epp_cpu_init()
       amd-pstate: Update cppc_req_cached in fast_switch case
       amd-pstate: Make certain freq_attrs conditionally visible
       x86/cpufeatures: Add AMD CPPC Performance Priority feature.
       amd-pstate: Add support for CPPC_REQ2 and FLOOR_PERF
       amd-pstate: Add sysfs support for floor_freq and floor_count
       amd-pstate: Introduce a tracepoint trace_amd_pstate_cppc_req2()
       amd-pstate-ut: Add module parameter to select testcases
       amd-pstate-ut: Add a testcase to validate the visibility of 
driver attributes
       Documentation/amd-pstate: List amd_pstate_hw_prefcore sysfs file
       Documentation/amd-pstate: List amd_pstate_prefcore_ranking sysfs file
       Documentation/amd-pstate: Add documentation for 
amd_pstate_floor_{freq,count}
       MAINTAINERS: amd-pstate: Step down as maintainer, add Prateek as 
reviewer

K Prateek Nayak (2):
       cpufreq/amd-pstate: Pass the policy to amd_pstate_update()
       cpufreq: Pass the policy to cpufreq_driver->adjust_perf()

Mario Limonciello (AMD) (6):
       cpufreq/amd-pstate: Cache the max frequency in cpudata
       cpufreq/amd-pstate: Add dynamic energy performance preference
       cpufreq/amd-pstate: add kernel command line to override dynamic epp
       cpufreq/amd-pstate: Add support for platform profile class
       cpufreq/amd-pstate: Add support for raw EPP writes
       cpufreq/amd-pstate-ut: Add a unit test for raw EPP

Ninad Naik (1):
       Documentation: amd-pstate: fix dead links in the reference section

  Documentation/admin-guide/kernel-parameters.txt |   7 ++
  Documentation/admin-guide/pm/amd-pstate.rst     |  87 ++++++++++++--
  MAINTAINERS                                     |   2 +-
  arch/x86/include/asm/cpufeatures.h              |   2 +-
  arch/x86/include/asm/msr-index.h                |   5 +
  arch/x86/kernel/cpu/scattered.c                 |   1 +
  drivers/cpufreq/Kconfig.x86                     |  13 +++
  drivers/cpufreq/amd-pstate-trace.h              |  35 ++++++
  drivers/cpufreq/amd-pstate-ut.c                 | 279 
+++++++++++++++++++++++++++++++++++++++++++-
  drivers/cpufreq/amd-pstate.c                    | 625 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
  drivers/cpufreq/amd-pstate.h                    |  37 +++++-
  drivers/cpufreq/cpufreq.c                       |   6 +-
  drivers/cpufreq/intel_pstate.c                  |   4 +-
  include/linux/cpufreq.h                         |   4 +-
  kernel/sched/cpufreq_schedutil.c                |   5 +-
  rust/kernel/cpufreq.rs                          |  13 +--
  tools/arch/x86/include/asm/cpufeatures.h        |   2 +-
  17 files changed, 1009 insertions(+), 118 deletions(-)

