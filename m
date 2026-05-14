Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9D9340260
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776837; cv=none; b=eRQ4JJXrEMCpv81jaTzvMOYYWg5LqkLRad0REnm72/hEbGU8SpQzsghXpO4oMj1s5GJamOP09U4xSyb+NGgE5bAhqudkn7gmnVM/P5hn+YvGPMrADWiiOlUbpFbwMVm0HSDa2FSmViFJCpLYn3hlMEnyulvSlZqne6tEa7+ygW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776837; c=relaxed/simple;
	bh=NoanThhVjt/ByM0UJpHFWwj70cw/Xm5gu3Oorgfa+Nw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GYyfO9d52BPZLit8bSR4Xfb/FXRWc5qVBFN9iPgOMbYG1KLKxfbVOqkg4xMnYDYzwRMWYV3x06OWZBxoGXdt3nk7d99ivY9+iwH3aB0AnD8OdQ31jrZRFkUqAU9FN1YDpNdHKOnxpqWZ5MvM1tFbb/JUCRNcQIGp2/ro9NiKxWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8Yilw8f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8Yilw8f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A89C2BCB3;
	Thu, 14 May 2026 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778776837;
	bh=NoanThhVjt/ByM0UJpHFWwj70cw/Xm5gu3Oorgfa+Nw=;
	h=Date:To:Cc:From:Subject:From;
	b=q8Yilw8fNncain2dA4Adq0+1W03CEoGIvQrIVt8ma4w3lEY8bAGXwILyN/evqhieu
	 Ez17Jue6QwXiN14b5YTxhSl/IfhS+8/+NVF9ggMJcJWKk1z9++Z+ftA+0zjRMWa1cI
	 ylyJl2w1+w6hZwG/hSrXcTnq1GKIjjEQaG3/rfsg14LYAs6ejkoQH23anmOnw4NTwr
	 9GZdSFhEt/SBB7go6n6Ni7ZOYF5mmiDwpiZdXDYa/qiLzwF6zEIEfO8rZOHaHUCSR5
	 Hg1Zg1Vyfqx0qLf/8+7b18J1TSGDthiQuWHNew/unZ33ZTV2M9PPeBUIu3O+Rhuhf1
	 tzI37NfG6hOGQ==
Message-ID: <fc712ca8-253a-4a08-8ed6-4082fc50fff2@kernel.org>
Date: Thu, 14 May 2026 11:40:36 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: K Prateek Nayak <KPrateek.Nayak@amd.com>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
From: Mario Limonciello <superm1@kernel.org>
Subject: [GIT PULL] amd-pstate fixes for 7.1 (2026-05-14)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Some fixes for this current cycle, thanks!

The following changes since commit 7fd2df204f342fc17d1a0bfcd474b24232fb0f32:

   Linux 7.1-rc2 (2026-05-03 14:21:25 -0700)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v7.1-2026-05-14

for you to fetch changes up to e4e9b7b38d5db2cc6a8770bc0596bb8b36b92b1f:

   cpufreq/amd-pstate: Drop Kconfig option for dynamic EPP (2026-05-14 
08:47:48 -0500)

----------------------------------------------------------------
amd-pstate fixes for 7.1 (05/14/2026)

A number of fixes to the dynamic epp feature which was new
to kernel 7.1, including making it opt in only.

----------------------------------------------------------------
K Prateek Nayak (6):
       cpufreq/amd-pstate: Grab "amd_pstate_driver_lock" when toggling 
dynamic_epp
       cpufreq/amd-pstate: Return -ENOMEM on failure to allocate 
profile_name
       cpufreq/amd-pstate: Allow writes to dynamic_epp when state isn't 
modified
       cpufreq/amd-pstate: Reorder notifier unregistration and floor 
perf reset
       cpufreq/amd-pstate: Use "epp_default_dc" as default when 
dynamic_epp is disabled
       cpufreq/amd-pstate-ut: Drop policy reference before driver switch

Mario Limonciello (1):
       cpufreq/amd-pstate: Drop Kconfig option for dynamic EPP

  Documentation/admin-guide/pm/amd-pstate.rst | 11 +++++------
  drivers/cpufreq/Kconfig.x86                 | 12 ------------
  drivers/cpufreq/amd-pstate-ut.c             | 36 
+++++++++++++++++++++++++++++-------
  drivers/cpufreq/amd-pstate.c                | 27 
++++++++++++++++++---------
  4 files changed, 52 insertions(+), 34 deletions(-)
