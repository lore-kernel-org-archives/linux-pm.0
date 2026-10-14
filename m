Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E482F30;
	Wed, 14 Oct 2026 01:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791940123; cv=none; b=AXxlireHeaRKtMUdEzzljdoup/f+yevdcqqcZRXwT4fdhSU2XoRy2dKt5qfSf4KlKGOW4LBsxvgOt58GO9jBGChbMXNgFO4QHnPfk8nWWS6CayPmid90f8eSs0v4rbxEKTlPqcgXGwsmAJ6fKmiNGHN6a5jZfL6iZXQnigy8Mlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791940123; c=relaxed/simple;
	bh=xe5I9USZq0NzjRBC7co1qlXZ3qQwSIdc/rSR/F1oNlQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eAYYDAu4RFu8qo/k1tzccGFZ0swOUQW3oDdxIfUzkVahGxx/6toVutxC7SJlGRU4kfkRBdr3jTxORAFElNi1dp4TLAdUDTPn8RcXyFdF5LMQBzfabTKJFfss2CP6D/uYfzb/RlvvqSJU/eU2FLwQwWx6PbWTCGjaH61HwxM3Nqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M525/WwW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M525/WwW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091E21F000FF;
	Wed, 14 Oct 2026 01:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791940122;
	bh=GRIp7KhwCAi0ClV148cvmSOD3OjIvcolOyiXiMGHIhQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=M525/WwWXVoqKvapIlltgdazum+HpzAarUqVCCCe9mNJP/1zLr8O6KWoIGBs2Ljl+
	 OTutJkmou852zBRUNoJh1JJSqvoh9F3KjlgnkotqqXHokz6pI6APX2ViQILCZYUXCy
	 Wn2nzgE7T2zJoz+ORCIkuQs5kun69woxqukr5zy62tsMeq6fbLtn3O4pFibUwBnZT4
	 vQQEeJkaGRJA3c1KXg7HjgjrSIFmqjXq0Z3IvTzyr/E+/mg6azTvTLhCx876wllC3R
	 5V2KhiIe58zJHDV7edVXHDU6EtsV8lJc++3JrHWG5YYvvlMjrLYYTUV2N7Ta+NlZjj
	 YwS9Q5tX1r26Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15F739E8A57;
	Wed, 14 Oct 2026 01:08:41 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 7.3-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <as7BWpR9ytU4Ihdd@venus>
References: <as7BWpR9ytU4Ihdd@venus>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <as7BWpR9ytU4Ihdd@venus>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v7.3-rc
X-PR-Tracked-Commit-Id: 5b4bd13e0552926648a46c2c9a12a24dfaee3715
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d77bd0d469e1923e587bb919301c0bb29093e30a
Message-Id: <179194012048.1544263.8307529566537051165.pr-tracker-bot@kernel.org>
Date: Wed, 14 Oct 2026 01:08:40 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 14 Oct 2026 01:40:34 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v7.3-rc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d77bd0d469e1923e587bb919301c0bb29093e30a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
