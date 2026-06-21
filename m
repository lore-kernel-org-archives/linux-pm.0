Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5223C41C71;
	Sun, 21 Jun 2026 04:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782015825; cv=none; b=XIxtYRLL1OZi9oC6gXggwcSrxMPnGVNUGQqL02WWTDSGYuvLYR3MZ5TkO8ojsGer+KM5IRN2KjpiDbsPFsA59GoGsrmX1ZxRntMPApeXlnOV6T2t5fHi6MBnt7krd9KzsOlwlYP4URg3eXwYRbZh5DXp8/de1AjweyPd3YkIsHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782015825; c=relaxed/simple;
	bh=mALHnvjtOqI96o1aDAF/r/qXpkNArcugyQ3V7nJeXa8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ppoSQ97gNYpkq18aAepQa1ewxY3BTxEhU9WOyCKzuDdS9jfI4H6joTcpkfpwnTvq1CxBwFFC9bExjYl94kxIQJf7gXW2OPIVfcVT1b21Rj+EYdXuO2pcg+6hx12IpzwHHhj+eKm5n6MAFMGzvDlrKFSn6AVjdOhldDGRkrr3rvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9GLApjE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9GLApjE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B2F1F000E9;
	Sun, 21 Jun 2026 04:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782015824;
	bh=9zJ6IDns0hTrz0r4p+TQnG7k9hqix7tFzlgOwg3ThMY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=k9GLApjEr9wWCS4o+YrXw5kKLLwIZ9+m9BMie8c0osYUWilLHgmqmPmDV7GAIK6Vo
	 rihiUZsOE+vJEjSbpEcsgHeVJZHOjWVhgvDC6uTxAdtVQhERSs30gYVGha23YJmGkR
	 T7HWVXXvwT/ZIiyhb3ASvzgqU/zATy2UZW0makq9H7k/b2znbWTz2oprwkJU41VR5s
	 z+HPmbYrh8VqPWzzvropbClirvUsa6TSYHf3WxmUie7oHv0s2ATo/OAT1QVbQv9twn
	 jKeTWQ2ugbGt4ANVNc6FOL73DtGujkuUS00velpmiJ53jxsWIPLD3aexaFGxY/rAMk
	 ulECnYQM78h3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A093AAA6D6;
	Sun, 21 Jun 2026 04:23:37 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ajU34j9bIpuC_JkI@venus>
References: <ajU34j9bIpuC_JkI@venus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ajU34j9bIpuC_JkI@venus>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v7.2
X-PR-Tracked-Commit-Id: a888754e51e915731c8974c4d6d62709facb35d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 390d73adf896bf4883c7d3bcd13c1b53d64351e3
Message-Id: <178201581584.277607.6498899618749741268.pr-tracker-bot@kernel.org>
Date: Sun, 21 Jun 2026 04:23:35 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Jun 2026 14:44:03 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v7.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/390d73adf896bf4883c7d3bcd13c1b53d64351e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
