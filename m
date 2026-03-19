Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F963E3C42;
	Thu, 19 Mar 2026 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935563; cv=none; b=RwhDcDAbHn1Juvy/qzbS9v1t9olsQ4DS2IigsBL2q0InDiGC4MffWyF+qVQ8gcoEOHqLo8ViX60f78uaJNT6vPMNB4WNQN8NljslwdSwv6nHaxNodsLimVB4KGssVIgXqQ42c6xeVd93zaFkZmAaGCAae65FDSxHzK9oc8GAemU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935563; c=relaxed/simple;
	bh=ZUupxWSfiEi8ywAqAoJ+ZUJYYXTV27J6b8C/QauEZJI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bRBfXxj5V4QXv9XDTaAGyOKGE2MUhnH931dfFTFhj6xMRErjRtbeKXVFuwcyFY+XW6/+wIdlDMGWrD6KBJFp5H3he+9eyb9zi7xtTY8PpKewW5WxKqS/7/ZFfI2KvEofRJLRg1KO5PuBr63R+RGtxjQF5YD2IxIt5gp9spEa8S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSblEpzG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSblEpzG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A641C2BCAF;
	Thu, 19 Mar 2026 15:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773935563;
	bh=ZUupxWSfiEi8ywAqAoJ+ZUJYYXTV27J6b8C/QauEZJI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qSblEpzGgOK5SYnFJ+AOzm1Dwq4R0PQ/H/oIpGNKBoy5kOwlT9Hy2bno+Hd3VvX8q
	 jQQgIfoVjVEOZnMh2pmsBIsgrJ5lrjVO58yXa2YWvouxXFqFQiy3Y1ICu7+IXe0iAe
	 xIxO8IqPyJKvcf93JuuX307ppZlAJYgzrWfYd8xTxEd0qD5hb1soJJal2AujbB8CQj
	 iqYV7YQRYGa2kYqsSVtLKTCdv3hgIkWivbEQ5DB7bY3ILiLdWuvug1/eFknBS1C0k7
	 KrJI/ompNENLMjMidNlcUho2QAiPl9HlNQ5X8GiuJTh2rw3O0u7rU2mKkAIOgZPuiK
	 z2ky+yz8y2Sxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 40131380692A;
	Thu, 19 Mar 2026 15:52:35 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v7.0-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jQxkAKLgx9e7FqdWq67EO_97=A9kyT_Yd2QQbDZakUjw@mail.gmail.com>
References: <CAJZ5v0jQxkAKLgx9e7FqdWq67EO_97=A9kyT_Yd2QQbDZakUjw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jQxkAKLgx9e7FqdWq67EO_97=A9kyT_Yd2QQbDZakUjw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.0-rc5
X-PR-Tracked-Commit-Id: 9633370653151a0d5637634d1887d2f32511e69f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e9825d1c79570b4c11259e826b3f7c1511544a85
Message-Id: <177393555380.1677649.8125922465374047601.pr-tracker-bot@kernel.org>
Date: Thu, 19 Mar 2026 15:52:33 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 19 Mar 2026 15:53:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.0-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e9825d1c79570b4c11259e826b3f7c1511544a85

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
