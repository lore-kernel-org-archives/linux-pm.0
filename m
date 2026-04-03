Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCED3D7D66;
	Fri,  3 Apr 2026 19:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775245977; cv=none; b=UtI2ZL38NtED6TJ3FgX7mkn4/kevYrRs0ciJ3y4sKYIUoJ1DgJh9L20FkAyb/CKmNeVr2wZu4jM3A39qxdQBtbuy+a5I0U7hycp7cUSnRQ/8SDZrGSqZvqHvQKhMsWKEUVkibGU1938wcA4P1IY2fr9Q89Z/4dth7TFKAes+n9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775245977; c=relaxed/simple;
	bh=1Q5TNFcWIX1NGS6j8LoZArE55dBpCqMNYLd3oscvw/c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=R+LMctbiFGl2RrzJvsS6ffZCm89UsFVhXQ30aP55w2FOdk3lXJe5x2AASHCjpdiqtJDCLU8Yz/6VC59KmDgXZUh4mq4j1JjZ3t9/znYpAC4M5tKcOzMihCIQULEKlA7/sCxvy9iapvCU7dO4EkGIoJhrAie/u9CCZr70hp8Exi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdFM9LJt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdFM9LJt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90429C4CEF7;
	Fri,  3 Apr 2026 19:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775245976;
	bh=1Q5TNFcWIX1NGS6j8LoZArE55dBpCqMNYLd3oscvw/c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KdFM9LJtyRwcr8/60a/MJcnABFwwgqZmAjutj1FuFeZ4RaQj6v704yn7aOTwhV/k6
	 +jYrkSEXdi2ge4GrRY+V57YProsBY6iPEhkSzN65Xddt+6xm+LAxYKV8iWl6/aYRey
	 CadmQlr9VIUfh9s6aTgrhQUIq8QWpWU8V3MFgGUtlH1b0f1sQd7iQop7gOJiJYtez6
	 /nsSEWTFnBBBEHSQLtEOppofXSCUqADA7QPbxRamudcEi20xx7YRiuPMdAGe5+OV8A
	 zlzqEoN4fExrqD58fQ28SQ424hWpYk571G0VyZY2JGghtS4QPK7Mv+gHuXpSaYpp0B
	 7hJsb1OTqGbcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD9A3809A14;
	Fri,  3 Apr 2026 19:52:39 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v7.0-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hh83q-F1Y-13a_3-AopnRRmhM91FCnNrMrKYwjqAiJcw@mail.gmail.com>
References: <CAJZ5v0hh83q-F1Y-13a_3-AopnRRmhM91FCnNrMrKYwjqAiJcw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hh83q-F1Y-13a_3-AopnRRmhM91FCnNrMrKYwjqAiJcw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.0-rc7
X-PR-Tracked-Commit-Id: 744d5721d2d7abc84e5131c16002039c53465c89
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1270605fd2d8c3d2f0a050f5078e56cbc9b755e5
Message-Id: <177524595817.1431632.8359010647184592531.pr-tracker-bot@kernel.org>
Date: Fri, 03 Apr 2026 19:52:38 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 3 Apr 2026 14:34:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1270605fd2d8c3d2f0a050f5078e56cbc9b755e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
