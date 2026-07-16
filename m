Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152BC3911B6;
	Thu, 16 Jul 2026 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219505; cv=none; b=TVAFdBuZLPcGnzrk8St3jVQHRqeujDw43/DzaYxbmyJH+GenVjDaH67w7hDcxle1zDpZgjb/1SCXft16IGiIXeCGNsgYXR4mluNYq85z8kttlvY8uD20WufnR0IWFw5H3Qrzug1+u7wze2BhXeGD8Yv0grBVx5YUISE0kOktdXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219505; c=relaxed/simple;
	bh=e1Or3J3nGIbcxIDabwp7ESW6rUKSN8vJDNEioV+VWPw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=X6H3Wl/+sFOVm6hOF9fMY2dkYqfs/CfkDA9QhZwquaXNvOOmEQ65uXlRtcnNgv5hfVPTyx3tjUBdF+Fg92eQNytKLUkNxudunxzXJnQsFg40eXYSzdOIFJcfb365tcxemSM2eoKLVwzUNWSqggsOG3tsLWa5USJjhTBndagY2cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HF0OJXeU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HF0OJXeU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472C71F00AC4;
	Thu, 16 Jul 2026 16:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784219487;
	bh=OCtL8fxq7QczO5m5qNgmDEdneRg0DpL9pdY78ki4lmw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=HF0OJXeU9MBtJ+ciBfej1Q2eKAzgMgsmRecsDEbogSSrCsqu5qGuXvu29LmHnU8tg
	 z6kFk0uVEUcUWlOHKfOmRYRLNihEA+Rx11haVrOyCxdNERetL4lu/gADUyyWUZ5bmQ
	 wygl5DQwLiQ6D9BfYKGFXKzew/VJQikM0nur0z3bfwuJP+JjhNjvwUPW4nAEg1m5Zr
	 iwDSpVsG5BACyE1FFlPV4GMso+w4etczI8ZSNJ+clbCYuTIcgPGaPGdb75+NFZw1KI
	 5sRGHvQcbY5HIHGB723ThLox0TjPCixK+DqjKwyEcqfcnHAE6giJTwgW8h4cp1LxNt
	 BYaHLaBtXgvsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B783809A19;
	Thu, 16 Jul 2026 16:31:01 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for 7.2-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hDM05rLL869aAZ+JSd_7VJW1zC88CgrrRb=X28UqeNhQ@mail.gmail.com>
References: <CAJZ5v0hDM05rLL869aAZ+JSd_7VJW1zC88CgrrRb=X28UqeNhQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hDM05rLL869aAZ+JSd_7VJW1zC88CgrrRb=X28UqeNhQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.2-rc4
X-PR-Tracked-Commit-Id: d2d5c129d07ea8eb91cd8a8633b5774116c4d171
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f5156d7a31a8c3b0f34af4675c9299c8f877cbe
Message-Id: <178421946024.1334695.1950120525052875415.pr-tracker-bot@kernel.org>
Date: Thu, 16 Jul 2026 16:31:00 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 Jul 2026 15:48:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f5156d7a31a8c3b0f34af4675c9299c8f877cbe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
