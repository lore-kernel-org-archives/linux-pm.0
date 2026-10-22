Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693891;
	b=CJxLn//p8V39OjT4zJUSOnrMwUXeDPD6x3qKMPQfQEOTmXO6KtELRwN5YPIfG6O53KCg
	 x10YJlghto3SFoiA7b2aj0sc29wF3YOI6Wpf6Hrb5FMBC04c4/iVOp10PL35MJ+VYYuQj
	 1hXyBNaq7gwn09VaMG6UnRE3QOa3W46gGjTBO84zIaBkQJrLLCU3kQIjk3dFiIgPPBVZt
	 G9MPvMqD8hxk6UAXkn7jbz50dlXa9Has9C5I1QnfopsDo5z3y1AC5kMmfxgKFbcKyYG8n
	 vmdvGEhv/IMSga1+PfUIHxjs+mU8U0/9aJk3UXieWIKA9Pq5hkcH/AeiWobt2nDRv/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693891;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=2idPHR1Z8ff2wIeirKiqI2ue5VlAcZHX8QmYv1FFkuo=;
	b=2+zAj3EuCWof3Rl/u6EXA6SPQo1LeHmAO+AbREUHlFqUn7BcWVWEhNy04ymLPi5zsL/o
	 FFKHHhP4weWgZ0sy5bn9CrK+gGeMndmQMqwIl4lKMs3JLKJG1hCr2ASBZz/YRQAedpG2e
	 +G8E3IArB4PpdsHQ/6MpEcmBTI1wDdwv+YW/vXZM2H7aWtD7oo5HmpWrO7u72kmcp0MnN
	 lt2ZbzOkcxAn6ntrcEogXEkLIdGs3QyK5EEKKUflG9yW6vhKzydieUlP0m8zInS/7igGP
	 W7bwZFCCeelIxzlkVJ9VhW3XXlIq4e0gdFIgCiqxR9QRLWUNIt5efh0DV+YcHXQG9Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HDNuAnjj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEBE60A5BEA;
	Thu, 22 Oct 2026 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HDNuAnjj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935D51F031E9;
	Thu, 22 Oct 2026 18:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693890;
	bh=2idPHR1Z8ff2wIeirKiqI2ue5VlAcZHX8QmYv1FFkuo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=HDNuAnjj9M5YThsjnWDBNhpnAjTJ4p7NJk3QlcEh3YGj42ZZ6gZY3q5JNb9Xop33J
	 DaO/F5w8gNa2LeZvbSuY98pm55TTNy0UyiZjOsY62Ugw2NVROBNjVES0al+1w1/kSO
	 LvR8uc69ZiF4Cz3Ftp+9TowvTTYfyh/VHu9lJmvaP+93ChseegVi0UkStyNwwIUrtq
	 I8LsltYnZ8JYymDkLU1K4WkLClb3nNBD3meP0wBEyrUCEfdAV3HgDRyRiEMDv4bwgo
	 +y6PjyqvUspxdoTrkvLyDWHImE1RVcru0td7eH/iaQ69mxkSJWUlH696pXwmpcepvI
	 31vonINMKiykg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 89707380822E;
	Thu, 22 Oct 2026 18:31:30 +0000 (UTC)
Subject: Re: [GIT PULL] power sequencing updates for v7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261019092228.11472-1-bartosz.golaszewski@oss.qualcomm.com>
References: <20261019092228.11472-1-bartosz.golaszewski@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261019092228.11472-1-bartosz.golaszewski@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v7.4-rc1
X-PR-Tracked-Commit-Id: eadea156f11b2c9a780b60c1699c2da145c9d1f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74b1dbf6f236f4fe88bd1077ae4657ca4b2c339e
Message-Id: <179269388941.87271.10249552793996067736.pr-tracker-bot@kernel.org>
Date: Thu, 22 Oct 2026 18:31:29 +0000
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Mon, 19 Oct 2026 11:22:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v7.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74b1dbf6f236f4fe88bd1077ae4657ca4b2c339e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
