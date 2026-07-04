Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32132433E84;
	Sat,  4 Jul 2026 02:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130559; cv=none; b=B5+tOcPCYT4FYHyzbVkAklcRLzvKA6ixbaAtJDiEZ8aTYX+HYHHsL0hNaXU3D8zEnFtEAyVFlDY5c85dvv8tMKa6A+IimC/uq8LXD3sIlBTvwM5Ya2hAM25iZL7KcHMUAW+6JAs1oueUbkhpqFgBRbQX5m0WV8RmiPrWlHYdCU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130559; c=relaxed/simple;
	bh=gbpUTi+7WEyD++tmgeuPE4SSMG0UFDEv0H9sfn7lEP0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HQ0YgwZrFaXUTqAWGxXPjQDvPOWtMZ7Zy1zhvdSwjNfg/TRNYYvB7EgYsfLzjho1jZgGp27lC4HmCNW1rFQEwggpVkmDAjinpWs6vDlvlPYTbHsjNmS33dHbXlf91FCt8t2TcgFK5s2odRSi+c5Ogq6g4VKL1DOqgNC5a8IRnPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hl3Z3oDb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl3Z3oDb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1925A1F000E9;
	Sat,  4 Jul 2026 02:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130558;
	bh=F6YXY5ifagrtssEjmUOiS6kqzKMijWpgVl4dwKrslN8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Hl3Z3oDbLfA4+Gv+zyCOfp5+fBiKWQaadnW3SBCZpueo26PkxPwGkMcbMA5Oqr+0N
	 12KFyekZLZEBtgHNJWSbwmuJXfgLnWVSTkRlqNNgY+SO2+LvmDrFaJuKQQK5UnWplO
	 gkGdi2jG6j214Ah6EOIlQxWxznMYsv68IDrJJKy7mfjqL5bW+6pGvrEQEHTSM/3P+O
	 S1Qq5IwQSsRvfkGMMh1V/iovE6XmqTihWi+gkamzpK/B+JAUcCtr3xfsJCG0MsLOTg
	 vCdJz8WUOjFoH0/aQ5bgdcTjK5vO7ThcYiEYnx4+a8B0BXMXytUWz3znECpQAGD3TO
	 wHl+eVYau+87A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A6A3939F31;
	Sat,  4 Jul 2026 02:02:21 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support fixes for 7.2-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ic0MROqd3-CEKvVpFPf9MPDoYHW+VU3cL2_Dwi37DJLg@mail.gmail.com>
References: <CAJZ5v0ic0MROqd3-CEKvVpFPf9MPDoYHW+VU3cL2_Dwi37DJLg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ic0MROqd3-CEKvVpFPf9MPDoYHW+VU3cL2_Dwi37DJLg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.2-rc2
X-PR-Tracked-Commit-Id: 973772c7cf647cf4da6badd86c484f9b350eea18
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6174e9b38e766cdfcfed41ffd8be35c504a9963
Message-Id: <178313053997.3392227.6353834032264243253.pr-tracker-bot@kernel.org>
Date: Sat, 04 Jul 2026 02:02:19 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 3 Jul 2026 20:46:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.2-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6174e9b38e766cdfcfed41ffd8be35c504a9963

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
