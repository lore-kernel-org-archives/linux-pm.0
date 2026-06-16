Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EE33B2FC7;
	Tue, 16 Jun 2026 02:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781575908; cv=none; b=MCArFk+Srvg5lvC/DON3qphpJ9fbd3boCWEzS7J7iken6g5GJvLI+Ar1wyFhaMPrZ8/nUUBd6IkzlZeiOnpI/YSPks2NkNK9IyCZA44IpnCbd0rsnk+Lux8h0a0GK3T5DWlEUMnd7k9mo44kO7Dmum1DjeSYfVYK5+I59zIrQAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781575908; c=relaxed/simple;
	bh=juBGnO/XwLTn+/o64DkZHQv5Nrbo/oRhELcYPIWUp9M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WAl4FPgctWutxHpV74DVfgWdAMZxvidUpVEq1qNZrvbn8CrpTidWPKla8Lg22D8tUB1p6ZoYFoxjt1CV8VtyomKiR3nFxGcFzgZriJriWsEWZy01y98/620mVGYsxN6lpbbIuZCEBsxagd0bIYWlVv6PvVT5ABTQLuO8fk6NzgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRDH3AS+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRDH3AS+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD591F000E9;
	Tue, 16 Jun 2026 02:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781575907;
	bh=U5s8/SQuNV8nPv8r/jq0Hgi6cjzqeGmttpSZAyvMZeI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=JRDH3AS+vlCaJhuB8S+Q5UmBVFdPOIW3frDle78rgqxxj4b3uczmMfM8a4nGKBR6L
	 m8wBOJ1sVo5H5iOU6KN7xoMHYYFmelh2HiAdLhzgHjymiTUvVKmoYtgmfAZvCejcMl
	 Lnt7fVdjLo6NPliu23oFIrVuZYwsg0cOu5xmqkppjCG6j/UOQS7M/bvJcktJBmu3AB
	 STlUyC6BNdiU3ka6fs5AEWZi2YL5oQpame1OlgzI6hnhnTCPgm9vGI8jJ3OA7hZSgt
	 IYVneQCr7qAmv8vN+z9p5gF7S/01zOuQ+3iV9CTWuDJRumFEQzONzhZVbyAA1PN/PN
	 9mSiu3YyBZUZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568AF3839A26;
	Tue, 16 Jun 2026 02:11:43 +0000 (UTC)
Subject: Re: [GIT PULL] power sequencing updates for v7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260615083214.38846-1-bartosz.golaszewski@oss.qualcomm.com>
References: <20260615083214.38846-1-bartosz.golaszewski@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260615083214.38846-1-bartosz.golaszewski@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v7.2-rc1
X-PR-Tracked-Commit-Id: 2abcfdd91e6acc9999c1a38a6a077835a9db380c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 31e6aeafcdde965aa10e10e93ee186520555ec3d
Message-Id: <178157590192.390807.2827322974576168111.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jun 2026 02:11:41 +0000
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jun 2026 10:32:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v7.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/31e6aeafcdde965aa10e10e93ee186520555ec3d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
