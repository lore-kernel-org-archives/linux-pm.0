Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693880;
	b=tW6/y+6hR+b4UFAJrcRoM6RYP8qOPwoHoWmNJ35CGxmmyr+eTX6OrJF6+yxCxGn9LS1w
	 nqSXKKGnqPdn20aFHMjsPE5toB23xbSWmi9c9HwPeMSLhpu+xAgq3j9wR2vMmkGQfmtbA
	 oWLZdms3c2QLALEAr949rZgyBsLD1UAROT5cDXkQQLmrSPun9rFxxnLvHlMkr+ond0pHY
	 PUm+7Lg4gCo0WGTWwf9lcqI+BizqsSpKFR1agZn5pLWf21iLYed1ZVGQQX5W4OL5f+cEV
	 hk5Hbow+H11nl+WTH1HJP/61aFanhztrApMO1IMEgNrO49hNeVSj6m7bFYazWI6izJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693880;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=tRQv/YsbSLfKDwFmtbLb3Z9s+7jJznoOOv0CN6f2KZ4=;
	b=VAYxe0KdxKh1hQJs63nzmK21PelFZRYzyNfAGFN+M19mHf9gRo+Q9qIT0TE1MUbthXn1
	 w+PFLbEKUl/bV4QOaQ6cwGBemGjjb3pXWqC3z73ypFPGTLQDO5LDKDq9WW7wWsNIALWVQ
	 Z6Sl64IzGKARmwNqvbR7m0QMgEIJvTiGgc6t1FYOe8JWOiFi0NfgF4YgvKmdK2x6sXvBJ
	 Gbz3W2pdi+1f2IqF9TcPbDmB47aUYQC0ZYh7zSJYLB7PtcT+Zx5Dne5rj/wcGPWbfiNzj
	 IR5W/xodRcw/JOTEFnhXeWjr2zZVKkLMN1+XzgSyIV5xL+EmHNguhw3lVGseKTfL2mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aZzx/UeO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C30C606A339;
	Thu, 22 Oct 2026 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZzx/UeO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557A81F01825;
	Thu, 22 Oct 2026 18:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693880;
	bh=tRQv/YsbSLfKDwFmtbLb3Z9s+7jJznoOOv0CN6f2KZ4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=aZzx/UeOmJHtLa3quSIPKJF/Sr4+3N49XOHzjuwcHVyRqYqvoQmGm7JEp8GmKvf/M
	 Y+nDEWgVSQHYFiZY5K14PUzKC8WbXN8M5CNkdYuf70WlnCZ3eQ5TMRKV/umNI+44gy
	 KOmyHDJrIDS5J+SxQQUQg4UHdkeykFWGFEtN469dFhc8103WVMpro1j2qT/z8PVJev
	 wfEzT4PNkBbUOe5lAvMEmCF1ahxTmPOmzds1Yl0NhvfO2SxfbrPN3mKFo7apxhQQKX
	 rfmsQGPkVK6vDmOcXeY+d1nvSFg+gnvlInEC5EZeyvCEt522Wo7LqsUmVR/ZjCAx5g
	 hvTeYR6NQaFyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4D99D380822E;
	Thu, 22 Oct 2026 18:31:20 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain/cpuidle-psci/pm_qos updates for v7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261019132237.29631-1-ulf.hansson@oss.qualcomm.com>
References: <20261019132237.29631-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20261019132237.29631-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.4
X-PR-Tracked-Commit-Id: 6d318db9ffcb611f9b3b6b3201c963690541a943
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e557fc68a1667183b5f4649ee76e833160c6714
Message-Id: <179269387912.87271.10690902816098280172.pr-tracker-bot@kernel.org>
Date: Thu, 22 Oct 2026 18:31:19 +0000
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-arm-kernel@lists.infradead.org
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Mon, 19 Oct 2026 15:22:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e557fc68a1667183b5f4649ee76e833160c6714

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
