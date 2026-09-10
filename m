Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9B93E3160;
	Thu, 10 Sep 2026 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789077228; cv=none; b=NEvzfMoHKSTVNdZFfqX0zpNf9sEgVoi90TbjERlwzPoEb9V1QwGaW5umCpCYzQNWBbkbwJLEPyLVFpK7sV1STCtObia2LjUMYeCWGISarVoJ5aWzv3avkKKA7N5B5MuMsJkjm5WYYgncacEYt676FessvsSSCjmmSl+jpTUrVbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789077228; c=relaxed/simple;
	bh=XTX2QGhdN7C0oOkQeI37p5YC4hSrUrxEGkNla4vpa+U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GMkv0MiU9TpMbn3cyYILHG5CaaC6qLICX2hHrXH5l48oJe9UJWiMIScWR7DdM9JGaOizSMy3F3/DWPI9WeUKox8bB3vHnccF3S1jU5eQmgbo7iWoYWsa/asnQ319hJ5K3o577KX3CF0UcoRq+D60146tQU0zC6ihThnJiNYJQM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7myp9EE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7myp9EE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526F51F00898;
	Thu, 10 Sep 2026 21:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789077225;
	bh=CI4jxEeg+03ItoI1U8QkM31wc4C4yj+CQU4t17xpGI0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=K7myp9EEQV81dhotMZG09ynTCY1NSMSOy46yqburIXfznn0STOC2q4dFgt5dz6R+q
	 lorvhLpfjZGO8B2NxnWKfvM9fOuWXeLKxlwphfwP0Oo7jIk868BueMRiqQFfeXCJag
	 4zSmzRBjKz3vbPiFBanjeYvix++ZdsK4S+Lpe7ujgDW6xN8jjPChy7URaVYCzH9EZJ
	 W7S/xrXyzfIgxrlleFEt0P2upBbtob31xhHlP0pPqsw/4l4uFAuW+CmDVldgMIQBCd
	 WUk0DKqyadZFLPpnRgak+wy7FU183XbJFdW6HmV73UnLjBqm/T7msJwJ8dVBq1UnL4
	 cKS5yGVT+v4YA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A3A380DBDD;
	Thu, 10 Sep 2026 21:52:43 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for 7.3-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0idsbo5VDkhmZrNJVz9=XnpYSwCntiD_YoZ6NzGwTZubg@mail.gmail.com>
References: <CAJZ5v0idsbo5VDkhmZrNJVz9=XnpYSwCntiD_YoZ6NzGwTZubg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0idsbo5VDkhmZrNJVz9=XnpYSwCntiD_YoZ6NzGwTZubg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.3-rc3
X-PR-Tracked-Commit-Id: 13b3dcbcfed1d0c8c1d3b5dcfe306f9992452ae9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5897d0546f8abbe5d57ef1e65a096f5b9ed8312f
Message-Id: <178907716243.2100681.8756656077142115653.pr-tracker-bot@kernel.org>
Date: Thu, 10 Sep 2026 21:52:42 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 10 Sep 2026 20:41:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5897d0546f8abbe5d57ef1e65a096f5b9ed8312f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
