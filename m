Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5E72248B4;
	Fri, 13 Feb 2026 03:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770953851; cv=none; b=NaR4lYDBqUQB6qFK5ZE0RMR4ZMy6NQdyY1KP56PgE2ZHXuZ7ZYKBS+ofne1OluleV8YSBLLD4mPS9/Mf9SaGDTIk4sw2C1TBQfs7IxYYPRLkcSuaz8su9iVxKuY1keUNK9gY0e3AayAoJ04tcpXW6AbkZXxNZ2b86rkkmuEq7w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770953851; c=relaxed/simple;
	bh=dy7Po0av5ljXLp4uvLTjdU4xUl/t+U3aK4iH2q9kyRc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kdUcpJ7jZW8K8ckDyKB0aum5K+twz75xVVxgwvh2LQqKniMfdtTGqi6dHyFUcOAaiDToHZSpGCrovjhVIxYUmZJVFyoopJxECoEFyhHmvJHQ0JdTuZFO6lTXNvpBt9tdoFvWkTQb2pdcqWRKjzlr593K7g4Hy+W6dJRIxlIpkjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qq4/3kEg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qq4/3kEg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D17C4CEF7;
	Fri, 13 Feb 2026 03:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770953851;
	bh=dy7Po0av5ljXLp4uvLTjdU4xUl/t+U3aK4iH2q9kyRc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qq4/3kEgwlsFhkQ8xpuYRjyhQzWPMG9jE+WBxZ4S6JiAa1jstDpQGqZx0NL3vGX+L
	 L7SvaAjGVk4LdSDPdzzrv7hlYYxRhZrcixyC4IzzvjVvs0TrYN+IVSoAPnfDdFbSGw
	 cRyK6DuBjXW1Htos8yJ1RMTh0aqGq7Ouo4gOxKQInoli0Qo+a3OHjQddzohFG2B4HJ
	 pJv0sRiRcbpyMKGjOgCbX338K2VDnq3+9QU/5WqMMX4Yz0SQsb9HTd4cIQluFZ87eB
	 +8TcmQ+IfBagapQWBon2gAV+C+k6sB8/Xahdb7iWQ5LCu1Nhco6CyeBGPRDaL/DTIY
	 lOk7QJcT+Zm9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8546B3931093;
	Fri, 13 Feb 2026 03:37:26 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <aY5Y09CgG1iUvWQZ@venus>
References: <aY5Y09CgG1iUvWQZ@venus>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <aY5Y09CgG1iUvWQZ@venus>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v7.0
X-PR-Tracked-Commit-Id: 12bdf471e374b34cb0e48b29bb9eb9127ed26fc5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7563f7e0e9fc79c41b2aea045a87b8de942fd616
Message-Id: <177095384519.1834955.6885119311332006514.pr-tracker-bot@kernel.org>
Date: Fri, 13 Feb 2026 03:37:25 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Feb 2026 00:00:07 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v7.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7563f7e0e9fc79c41b2aea045a87b8de942fd616

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
