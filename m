Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2673C1967;
	Mon, 15 Jun 2026 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509939; cv=none; b=QhUsf4YmxwN4xlVu3Cq3j6hUERDd1eeoPii3ied7xyKpHaGQp/bswn0Bxhzi4lq7WddFHw8UWZxFbBdSGFfcfGXEbJwtUW2y7H8kz8CnlvDM/Et2oyBCRpiS5p0oThURxiLtv85eM6Yt8LRyb4xmbFFoU9TxmrHBRuVllbVgH20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509939; c=relaxed/simple;
	bh=IpQoMYEELlH/8uP23/kMf6u0dDWzv1K3t5/Vp2f+tOI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fDfbpJ9vJZArTdKLjnZZXO69GBMWKzsrOosXk2uupbqMWviiqsPKT80nZI1NBJ7bSwSP/mkfPiiebZAB6bMgGehKMuig0JJ8j8dDjQWFoRmo1NFdd/VxY3YSw43zw/4Wx+zjnh3goRJ11YIuyXkBWmvsDMT4nwtRZ/HLzCF8q84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7ihCQtC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7ihCQtC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AE61F000E9;
	Mon, 15 Jun 2026 07:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781509938;
	bh=BrhrtHflFTHQf+ez37LzNSgyNRN2ggdA3Ay9NF7uqHU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=M7ihCQtCLDACgEzadGJhY7yn8dQYdHb0ZcvCWSfq1pif0NeHg6DXcR3vuBJTs8dz4
	 e6xn01eujF7ntCQWcBgYmSHyJH5IfD3jf02u1u4Z8IOPQOJoOpcfsrz/DCa9ThS6d+
	 bmtVdikAeoy+y2c/8ZWi/zbtKJpAly4z3MD44P0LIvYdwlU9Q/6244cJj/3ETiaUvK
	 v1Q3yFzcwOBGV2y+yz4mz61hM/uMbFir4xw5y82sj9tJcsKZIG1CWw52hXOly4frUU
	 6eVtVBv7GxVvIep0eAIDgSAg/bqI8SnavQ+OLAhpVFo0yMESSKQ7dZ8XAQ9cN6GoBV
	 eVJYy+LhpoP3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A273A56756;
	Mon, 15 Jun 2026 07:52:14 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for 7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iKw2Vso0t19pq-ktLFGsyiHK4t2D1wyYL+r=nUt0_ksA@mail.gmail.com>
References: <CAJZ5v0iKw2Vso0t19pq-ktLFGsyiHK4t2D1wyYL+r=nUt0_ksA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iKw2Vso0t19pq-ktLFGsyiHK4t2D1wyYL+r=nUt0_ksA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.2-rc1
X-PR-Tracked-Commit-Id: 5ca48f6f2afc0a0c3f0584f95843451042ffc5ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5504ce0317f777dcf102751c3e518284226fc2e1
Message-Id: <178150993351.2920647.9397656649751758159.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 07:52:13 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jun 2026 19:48:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5504ce0317f777dcf102751c3e518284226fc2e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
