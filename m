Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D50F43935F
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784751659; cv=none; b=P1SVirVGzkeuupPgIWXJ1+gLtuhcA3AC0PUuUP6/+nXT8yjWsyDiqG4/uRcbYCWNr98gdYpLluCG7B9fIs0Tj3jWrnV/h4Uhv6nKOOCVT1vS7CGMJYn78xoptHilVENIKVOXWi/la7zhZjmlt4U+j0Cg2+UyYtxZaICLPyCEEPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784751659; c=relaxed/simple;
	bh=JUhkIA6FkS8XA050tpJxgpNtl3u80xTZnSZx7T86nmE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=tsEBnBzbdASRDhXmZr6+zXI3F63bmtDo0xbMvj3izlbkJsGMx3vHPv63+GjBe7gyUdHrmpn9vdPprMDwcAshNzIQVMIwIgDmRsF7leScitC2b1ZgHUrVGIOgaLh4wPTLO43NSE095sckde9dm+tKi+iVLey01W+r7qE+gjGI9Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7g20pr2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7g20pr2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2451F00A3D;
	Wed, 22 Jul 2026 20:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784751657;
	bh=hE4U8/QZoCJYuK9Wo2W2a0F2IT63KeDgoUzSrIv5Uso=;
	h=Date:To:Cc:From:Subject;
	b=a7g20pr2JRsReSlHahSuRwyn1vOWk1KITM+RoLtMLDieQAf3a+ddbrsIG72xKFfSp
	 /fJzU3saXBx1JHV47EmfVWWhgaFdrWWQdS6FtE+1ysFhaLHOJuwZCl/cNogo7229x1
	 7nBZgFMolbHluRhOfVPFEv47RlBk/rMTEIQJSZXU0A/lOLk+i4+1h1n/HTZv4F8NbD
	 VMbGCwaj3v1Ygu1DpnRli121q3knVzmWpW1nZwThuXVmXA7jIxCD0aHle8091S/Eli
	 o3qvYJPKM53mz15MmPnO7j52hQyeUWdYZfeOxz3brjyJhUTIH+d7dlo3O0jj9v8Inw
	 YoJ5vYal4sTTg==
Message-ID: <a58cf551-1d29-4269-9be7-2dcba48c51a0@kernel.org>
Date: Wed, 22 Jul 2026 15:20:57 -0500
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
Subject: [GIT PULL] amd-pstate fixes for 7.3 (7/22/26)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The following changes since commit 1590cf0329716306e948a8fc29f1d3ee87d3989f:

   Linux 7.2-rc4 (2026-07-19 13:54:41 -0700)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v7.3-2026-07-22

for you to fetch changes up to 39c0cf62fc7851a17782e7efe8dfb2948739c681:

   cpufreq/amd-pstate: handle missing policy in dynamic EPP callbacks 
(2026-07-22 13:45:48 -0500)

----------------------------------------------------------------
amd-pstate content for 7.3 (07/22/26)

* Avoid running unit tests without amd-pstate
* Fixes for EPP on shared memory systems
* Fixes for dynamic EPP callbacks
* Avoid loading on guests
* Allow lowest nonlinear == minimum freq

----------------------------------------------------------------
EDAMAMEX (1):
       cpufreq/amd-pstate: handle missing policy in dynamic EPP callbacks

Marco Scardovi (3):
       cpufreq/amd-pstate: Fix EPP return type and handle errors during 
initialization
       cpufreq/amd-pstate: Toggle auto_sel in active mode on shared 
memory systems
       cpufreq/amd-pstate: Cache the firmware programmed EPP value

Mario Limonciello (1):
       cpufreq/amd-pstate: Loosen requirement on lowest nonlinear 
frequency != min freq

Qianheng Peng (1):
       cpufreq: amd-pstate-ut: Skip tests when amd-pstate driver is not 
active

Rong Zhang (1):
       cpufreq/amd-pstate: Prevent the driver from loading on 
unsupported hardware

  drivers/cpufreq/amd-pstate-ut.c |  5 +++++
  drivers/cpufreq/amd-pstate.c    | 34 ++++++++++++++++++++++++++--------
  2 files changed, 31 insertions(+), 8 deletions(-)
