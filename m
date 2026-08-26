Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF97E480DD5;
	Wed, 26 Aug 2026 21:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780469; cv=none; b=EGC01R6QbbVrCg9gOCeWr8cyWfrOmHEqPexIXYZXvtL2g5j7yWwElHJL9RHxOuBmYYjXP0gJAH2TQWf498Z3IPf8YQjav1vbMQgK/Yl2v5QgRXEFPi45Q3B3pMTkrtkXWp0E2Vn4yUSG1Eci8bRUJU5YBIy2UQ6puDs5soIRPLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780469; c=relaxed/simple;
	bh=ijsakQGAWx589zr+mFmrnXEoWTUpLsZfXBQ/2uxTLG0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Mjtv3eBOK5rNYzqu2CWHjTz6r+2XB0xLRuyesjhdGtxXpD0IV+HUcsElVGn9uHf3uG/1rdHHunDol/ICB9YFagrcT7DstoZzvpZKIr88fCJtHYhQHZha+Cw83mS973idVKkJ+uXsIsJjUYP1q3JKfj6MDJvyzmjHIGaC+RX/rIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDjB8gjs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDjB8gjs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7212A1F000E9;
	Wed, 26 Aug 2026 21:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787780468;
	bh=xJgmlLE7feoQxgS91vJ3PjYZOWb1gIX5DYbfSdT4A5A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=RDjB8gjs0PkKjcc8k3BihXZjhU3q+y6S+5s9ParE+CivMWIq2kaLXI/aYXj1damm8
	 YtTc7cqTO9yEhvgcozxmEc1ZOE1RCDtdh/tdAd1+0VmlJm8hQlXUxqHbuVOYcKRWZl
	 /Q0lQ8TIc9AKqPioCMXCFFb7kAkmEHCByTTe4SQ/4PUQ/q76ulhDJLjTqg2/n1B1eL
	 X29FtS+/KoGdmkn6w0ROcj1DNVdaVnzF4RnIKJXoWxC5WYHXf4Xo5EpS5dP1D73Qvx
	 CBSU0SMURawAi3prfPdZK8nDtCgT1kROIyvu4qM4LfodwUT/bRjqdgiVatqhBRt1vE
	 ppPSI16MIo9YA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B52513809A08;
	Wed, 26 Aug 2026 21:40:15 +0000 (UTC)
Subject: Re: [GIT PULL] More power management updates for 7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jKcZV5a8MZSDP2saeS59v-qhNv82RN2-CWtHuM=jff0A@mail.gmail.com>
References: <CAJZ5v0jKcZV5a8MZSDP2saeS59v-qhNv82RN2-CWtHuM=jff0A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jKcZV5a8MZSDP2saeS59v-qhNv82RN2-CWtHuM=jff0A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.3-rc1-2
X-PR-Tracked-Commit-Id: 76854b339b3fbbc144f7ad6dd96e7495b94aab62
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85671b807f82dae7a88ccfc74e33a8374219841c
Message-Id: <178778041444.904445.13006669126086313812.pr-tracker-bot@kernel.org>
Date: Wed, 26 Aug 2026 21:40:14 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 26 Aug 2026 20:39:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.3-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85671b807f82dae7a88ccfc74e33a8374219841c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
