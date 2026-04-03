Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4906B3D6CA7;
	Fri,  3 Apr 2026 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775245975; cv=none; b=JLW1nP4v75ysn9xPXFpGVRauQ51q+EpmCCNWvk/RYvd7F8K3d6R7v891+8OrXpveLfxc3m1v41BdDD2/Vvq63ngEwCxdIZQKLznZDdytTHAIRVN9NdkzZmEZ80++ECiuXHmplqJTjFGU/Uu+XbEt9Se5Ig4wB8AIzJwoF20pu/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775245975; c=relaxed/simple;
	bh=o8PuMWO3LaHmQh5VM8jHU+fMXP2fEyyQNFw9cKQ5rTQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MfEbT4NHOhu2GW/GFnZAwv7uODu3BiKLSDJKmEAKCjHwlFB1y1HNlfhQleTNCJkgEFO4D+fE+qhBrJb16J7ODEd3al52aV5coYOp9rZvOMkCf8UgkVGgz/5+BC42SMUAjnKhlVYXuPhIlVvVgTgEswzzuJZj+dSpUBbmh4zyud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erDGD0Ni; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erDGD0Ni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C486C2BCB1;
	Fri,  3 Apr 2026 19:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775245975;
	bh=o8PuMWO3LaHmQh5VM8jHU+fMXP2fEyyQNFw9cKQ5rTQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=erDGD0Ni9bU7/5MuUKJjwQ551BSzJ7FDxlJexJhswPKoPuqgf8f2sjcvaPjn6U4TC
	 2lE6f6CJTKd4CBtppDT0kYp+KepkAzg1ATnvCVQo9Hw8nSXgiVqfiRWZ0diMsARasn
	 ahDL4d33tLtkAJiKXpfGud6ox+gFf6o6ZlzzSM2tXOD4/W7+krLRINSxv4Lr7h8pof
	 iIDygLEBViRrXg3LyqyHqaJ5EQTRvRqYsWVX8NJb0U1y4VRo63qqvjf7eYzDb6vqj8
	 Xr+vEXL99Jzz3zsx648bPZpdwZ1L9mV5R/Xx4KeM9zFHkzep920buWXTD83OmgHD2w
	 PrfCgf4DfHs5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0C1EA3809A14;
	Fri,  3 Apr 2026 19:52:38 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v7.0-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g23pA9urxBundpRAb0O67=UFSM29SDiudXNa2S18sBZA@mail.gmail.com>
References: <CAJZ5v0g23pA9urxBundpRAb0O67=UFSM29SDiudXNa2S18sBZA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g23pA9urxBundpRAb0O67=UFSM29SDiudXNa2S18sBZA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.0-rc7
X-PR-Tracked-Commit-Id: 9e07e3b81807edd356e1f794cffa00a428eff443
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 576db0f37549a05d7b1d9b5d6ad9fcce9ad7bfd6
Message-Id: <177524595690.1431632.17257932958016802903.pr-tracker-bot@kernel.org>
Date: Fri, 03 Apr 2026 19:52:36 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 3 Apr 2026 14:32:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/576db0f37549a05d7b1d9b5d6ad9fcce9ad7bfd6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
