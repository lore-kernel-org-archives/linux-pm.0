Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6E81339A4;
	Thu, 26 Mar 2026 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774554524; cv=none; b=LekcjeSDhMyCE/cAFDbcz5nrihaUlkwyFOYkVFlBDiLi+Skbl5JQ8GHliLScDYvr1EREiNhUcnKIZsxV1sGRtRh4hjq80t6VgFhUBKSss0gjdddOS+AjAbt/LOizJgCgFwgNIXmpoV6gRIuk2iiv+QgUSYD5q0P2UKcj1hxpHtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774554524; c=relaxed/simple;
	bh=K2TG6zV4vKVlHs28lVAStgUsL2qVBkfv4rEgX452ymY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HG2fmYhqS1oFUcHMPWs5/ON0O+jrLaI0pO/upcSzzC0+VdNJnNHNztZybh7bW6ic1vucCu/4GyP9BLMuGlyfwq7nc90UPIzU1QBTST/wndbQDzN8jqktVQ1kWlOTLqoaeDDrZ/oV4BSgqIYvUBm08NSYBH1hqi3L49O5Wv4Ub2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foxWmIsB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foxWmIsB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056F8C116C6;
	Thu, 26 Mar 2026 19:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774554524;
	bh=K2TG6zV4vKVlHs28lVAStgUsL2qVBkfv4rEgX452ymY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=foxWmIsBsTVDpg8QGB1QLW9qz9XF9W64R5pFYdLfg4e96yP9ZsHsK6oTsmOBwz14D
	 LLx6BYC6/Y3QxiC87tG/TsX4LtCfVO3rsX0YonNY/Y0/gMy/9n3Lu3ppjxNWjD15h7
	 TRhj5HY7bjfflEsSxh6UfV81B6K5s8323cy1IxrCkJ2m5zB1tr9LzbruB6XwARO22w
	 6DNddlaXRFF5K+KDtgB0Wy53W58NNyph8xJNo/dwiBrM8ce0mmwtB35lHsotLFHzAV
	 ZrOjLoJdML+dRAysUsX/6OPxINkvhM5eZvudz425CaQZqfSWJAiWR7PRBtkHN3tihz
	 pSvigoyCzoNkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F9A39F2038;
	Thu, 26 Mar 2026 19:48:31 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fix for v7.0-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ggLdfPQZSThBgNhErY7n66quQoo_uhiMZVFawRGpfA9A@mail.gmail.com>
References: <CAJZ5v0ggLdfPQZSThBgNhErY7n66quQoo_uhiMZVFawRGpfA9A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ggLdfPQZSThBgNhErY7n66quQoo_uhiMZVFawRGpfA9A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.0-rc6
X-PR-Tracked-Commit-Id: 7dfe9846016b15816e287a4650be1ff1b48c5ab4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c2b23a275ceb52c7a0eeab6556f56e7257b2230
Message-Id: <177455451026.3152977.7558900924407075448.pr-tracker-bot@kernel.org>
Date: Thu, 26 Mar 2026 19:48:30 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 26 Mar 2026 19:11:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c2b23a275ceb52c7a0eeab6556f56e7257b2230

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
