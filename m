Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047B73BBA01;
	Fri, 14 Aug 2026 22:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786748346; cv=none; b=tmzSbnd9XvUSjGjPVD7R/BRRXW2peVzcf4dR1PLGRPMDEP1pQv/yup24zCjIQZVWjlr3Hb5N+7hAhIupC6aXp51r5x+rBb2/mVmBzf+yeLXli7QY4VGN4XeUn8MHLMifYDUEm1F7GSEsIJ0D6LsbMDv+x4IKLrI6YC1ahcEZXfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786748346; c=relaxed/simple;
	bh=6AWnkw0f5IqpdGgfKAfzeX1FeJYI6c8+H/To6iifyKo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Fnh0/6jsTfbGWVfJGf6vxkjcWcJ4Vdk5r6U5PqFa1tDHVhLHDjTG7K5vU3DENFD/w5xcD485WM1zUUjC5h/FRFOfbG3Pp3AUKNWDF3oh1mZpx3i4yYF2I6rZS8MrgbsACFioF3JqsmwkLVhArnvJU5BYm4Jxu0cVwRkQyvcKiQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZ678rqf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZ678rqf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB8B1F000E9;
	Fri, 14 Aug 2026 22:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786748344;
	bh=GFMyEhDW4bvFif6qLOHnrHmnWRiIQ8epg8yOJqyNpxc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=NZ678rqfzIFy2XU7bawtM7T03MEmjy/CiNZM/Db1tYxAQjNkhFWPF8IfqgJddhtvh
	 7KCZIo/czaQKcbwWqqUI+98pcIh02bwVeki0AKMRue3GDFSAbDkuO+wh6ASjxogCIT
	 gjMIM71L42EhCOtXBQt/tcxmm337b/xHf45RbFtA+ERubLhcS8XUzliyHEuv7EboMp
	 XQz3HPPNjo9rP1p6jqoJi59t7nh4mvJNWt+Yyfc5ZAiNG/1vtkcLh/tf4tKRBwvk3t
	 jjUhHPGggZjpcOPKwIgfAb3tDu9rzLpL3HGp34CeiLz3GLQeSFQCHk6EWPQ7HDND1m
	 25xuxp1HCB9zA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1971E3924460;
	Fri, 14 Aug 2026 22:58:20 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v7.2-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260814141504.127436-1-ulf.hansson@oss.qualcomm.com>
References: <20260814141504.127436-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260814141504.127436-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.2-rc2-2
X-PR-Tracked-Commit-Id: 090a95dbe13df9965279b588d97eda134831769c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a823c9da52b2cf81e2203870d758871470b3bcfc
Message-Id: <178674829900.3991221.293792173327152525.pr-tracker-bot@kernel.org>
Date: Fri, 14 Aug 2026 22:58:19 +0000
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Aug 2026 16:15:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.2-rc2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a823c9da52b2cf81e2203870d758871470b3bcfc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
