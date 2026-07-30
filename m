Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814EC4746D0
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 23:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785453408; cv=none; b=EL3JDLfQtEW4dSnpey2S0xFtvvNmMIeZFZkzIWTsxi13O84hSyvCj/noBl2pgMFGEv2I1AeuBmNmwwE81n//+jV5/JU6qpHfvIDuavM48uImuHd25s9nneLrn7lUfX9GgvcEOqUrabm6FmKQaFr+abvnfL3ZTt95cUnMd9eQntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785453408; c=relaxed/simple;
	bh=1cMQp0a/bhLIwAluOlqlwT1dcsdD4I+v7F3F2maTj+0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=LBFCqqrJmbvzVtt0RpNO2pj7AKX397ZAp2y52TxHepeA04zfakjTz7H9m9/kACBm/hey3ZyOlE56f+jkVXS/o1FqCm0aNU8oWqfya+QNVPjPy/sl9OosBW2Hi0psjUzFH63JdFnn6z1UisOYUXEKPmVtR+MIyTWUrULAI+aqP1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=is9eQmCb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="is9eQmCb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651611F000E9;
	Thu, 30 Jul 2026 23:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785453404;
	bh=844uTsn0jr/+HGIm48v9N2X2YozaNuqzHQ0df6Cg1tM=;
	h=Date:To:Cc:From:Subject;
	b=is9eQmCbiSNdEFXtu9TwPQR4xpHTIff/8WyJAETTCnsDlwTcaQtcSZmvzWVJem4K2
	 h/12H++Q2loSySPeqtsMcXk93iKByc+6misyS/36Cy2nk6LryazqNYi7Ob2u5TLEzQ
	 BEqxsUuzVuY5NvV5HDMSk8l883sfcOZPjPGxjnrLjBp0RLdJ3fz6ttsh95/qoc0foS
	 IPsb4ofMw4qNb1RA6VMVrtCSvOoTQ5qlAyL/6y1m2Mc4gIc5mN0mrdxMoa3/es1zEe
	 7SBlizp9gqQ62RJAuvEL24YxkHGkOQwcfo5kMoSlvD2/awPpCmxXn4Pm2koiMkkUww
	 RCWPFaUzxQqjg==
Message-ID: <7acd9274-390a-4806-b742-90e6a4a16572@kernel.org>
Date: Thu, 30 Jul 2026 18:16:43 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
From: Mario Limonciello <superm1@kernel.org>
Subject: [GIT PULL] amd-pstate content for 7.3 07/30/26
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This is the last pull request for amd-pstate for 7.3.

Thanks!

The following changes since commit 39c0cf62fc7851a17782e7efe8dfb2948739c681:

   cpufreq/amd-pstate: handle missing policy in dynamic EPP callbacks 
(2026-07-22 13:45:48 -0500)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v7.3-2026-07-30

for you to fetch changes up to d06c75c22d5c95ee27e01fedcaa07231c9bd5c88:

   cpufreq/amd-pstate: Document missing kernel-doc members (2026-07-28 
11:05:23 -0500)

----------------------------------------------------------------
amd-pstate 7.3 content (07/30/26)

* Changes for dynamic EPP
* Adjustments to the bios min perf feature
* Fixes to kernel doc

----------------------------------------------------------------
David Vernet (1):
       cpufreq/amd-pstate: Document missing kernel-doc members

K Prateek Nayak (9):
       cpufreq/amd-pstate: Set min_limit_freq based on bios_min_perf
       cpufreq/amd-pstate: Remove the defensive check for bios_min_perf
       cpufreq/amd-pstate: Extract platform profile to EPP conversion 
into a helper
       cpufreq/amd-pstate: Add dynamic EPP as an 
"energy_performance_preference" mode
       cpufreq/amd-pstate: Remove "amd_dynamic_epp" cmdline and 
"dynamic_epp" sysfs
       Documentation/amd-pstate: Update dynamic_epp documentation with 
new behavior
       cpufreq/amd-pstate: Reduce the scope of exported symbols
       cpufreq/amd-pstate-ut: Add unit test for "dynamic" EPP mode
       cpufreq/amd-pstate-ut: Add unit test for CPPC Performance Priority

  Documentation/admin-guide/pm/amd-pstate.rst |  45 
+++++++++++++++++------------------
  drivers/cpufreq/amd-pstate-ut.c             | 131 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------
  drivers/cpufreq/amd-pstate.c                | 243 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------------------------------------
  drivers/cpufreq/amd-pstate.h                |  15 ++++++++++++
  4 files changed, 264 insertions(+), 170 deletions(-)
