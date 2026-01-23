Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EA63EBF28;
	Fri, 23 Jan 2026 21:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769203491; cv=none; b=FkogW1Vy5UZsMJpXaKe8/9i6I6MytUQ43Klr+EyoRtZW/p/KZTGHvvjHCB2TkswqjLyBEVkBAT9nJ9mN2CacUqjMGNdmuVXrvAqS0UqwOfFiV5wSmC3m1hktfrb6tcwM23KLiobUZGdeQYgiEqw17tkPpDYX+QvLLcliG+tSwU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769203491; c=relaxed/simple;
	bh=VNE+m3Pfw/5+DeSp+zS9BpD2eDtyYG3WMUZep7z42kk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RsTKMgFLZmbHkLgZMCeONjK/bl5SCb6OLHeXmwzilefenSrctFRPOXeeXgRDcYWUkyBk4SX9PLQO8jhSNDZ6I+dd98pdLJ3idtopEkPrDzYhvyp4xTUjxAfys0mccDckOHHPtUKR0SOyROokVDwEm7UMDcgZ/avHfa3P22DeopM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRU2es7K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRU2es7K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E540C4CEF1;
	Fri, 23 Jan 2026 21:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769203491;
	bh=VNE+m3Pfw/5+DeSp+zS9BpD2eDtyYG3WMUZep7z42kk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FRU2es7KDBQsIuGPn/Zwj/zskcTTWOFBo7wXszdenmmDoS82otCCJjnCgrE/qh0fH
	 katSaRxM3a6b2D5aO2mhWIMfYrNap8jxC6v63bsnL64JHxMAxFFF/tvn8l3nY7tVsn
	 DjZpZv58jbEdgUzg1AEj0Uljw6Io5dse6V3atpAkYpo/T5djglhmQPnfJYa3cmGe1d
	 OTE6NmcobUHSqOe7hIiq6xR91QJ8qOt9BqxRFR+QsTHL2osbkJx21aCrqSD4nksQMj
	 HqzXVaL7+P43LV9OyBbO0HofT5RNPXeyNlFmCCoEKrL5fi1nJB5TFU8j8GkDpDcqD1
	 k519Lg0mBvhzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BA0B3808200;
	Fri, 23 Jan 2026 21:24:48 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v6.19-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260123121435.245253-1-ulf.hansson@linaro.org>
References: <20260123121435.245253-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20260123121435.245253-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.19-rc3-2
X-PR-Tracked-Commit-Id: 861d21c43c98478eef70e68e31d4ff86400c6ef7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9731fa48beb346bb9804cb81e34b3260ce65e561
Message-Id: <176920348722.2720183.9624545632206323526.pr-tracker-bot@kernel.org>
Date: Fri, 23 Jan 2026 21:24:47 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Jan 2026 13:14:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.19-rc3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9731fa48beb346bb9804cb81e34b3260ce65e561

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
