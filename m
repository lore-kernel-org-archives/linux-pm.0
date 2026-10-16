Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629514DD3C7;
	Fri, 16 Oct 2026 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164264; cv=none; b=NOTpKpP+edE37ZtK6DcEObe7p0H5jgStU6xpXUX4HgCfxMOJpfeAgqN31i+eUG850tf+ef9RvTm/0nf4glwQtBT8s/6Qc2EbPhS1rv0fgnSmd3OyKCae2n7qMi9YELbsisFIWArL52X0AcGdDOhaGdMwvG5ZvfC4ANHmGUy56S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164264; c=relaxed/simple;
	bh=ntLaVLxoLwnDkgYFfdTBxNlYDcDpuELLRD9xdEIRfLY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tKrYQ7UeVHu8/SI9xBv9l7VIaz2lP7+0cZhq10uJKNglYkvsV5vTrzbrApfse8eIXW8Olnt9BEpw7zgrNcxqX/afqIp7UlFV5PTPJteD+UfeKVAIe1G+0OX9wFMXQmAE7pS097EJAzxfWiO6/beW4KWxWwu4YiMIVnu1n6Be6Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zu4dbh4P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zu4dbh4P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422FC1F000C4;
	Fri, 16 Oct 2026 15:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792164258;
	bh=hDWbbVVi2qLs6KV7M7k6CAEeIIw56CeDrYJ7B2RsfzM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Zu4dbh4PDOJ3AbiOIvX4YxaKXjE4+gBz12K9IfUUX3RddDXP7RHA0pGd7VagkHpfB
	 TBvIsKn6eIZ1e+UgxhskU+V7l1ciTrlFR88oZ6VYDjGhOYdutUeG/1U4peVaVriURV
	 8R0Uf2cWO+fP6adtMsfHXhcNz0zc1JrIokMbdeatQBKtDSHuj/oVw2rOQgg8ftY1O9
	 2+US3CaRTAmf+qHEE3PhlSgYFUm8iuFsKEG/nAggnL+KcK3S3b3HGhbXdhwUeZMGhC
	 wLu5C+xuLP2PmUyOa2ksJSN9iHSOKP+s9wBWIbrdLZSvBmUKrMh1hpDz661xvqZneZ
	 bQg1KiXdQ96mQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A38D380A96A;
	Fri, 16 Oct 2026 15:24:18 +0000 (UTC)
Subject: Re: [GIT PULL] power sequencing fixes for v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261016084933.39924-1-bartosz.golaszewski@oss.qualcomm.com>
References: <20261016084933.39924-1-bartosz.golaszewski@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261016084933.39924-1-bartosz.golaszewski@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-fixes-for-v7.3
X-PR-Tracked-Commit-Id: dbd674ccf30f66f5eccf637964a93910df8dbf84
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b441fe5a6c6455cb91fdf8330abc752e7e247df
Message-Id: <179216425685.816915.9631067286065363067.pr-tracker-bot@kernel.org>
Date: Fri, 16 Oct 2026 15:24:16 +0000
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Oct 2026 10:49:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-fixes-for-v7.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b441fe5a6c6455cb91fdf8330abc752e7e247df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
