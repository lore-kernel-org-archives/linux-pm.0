Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4442839183B;
	Thu, 16 Jul 2026 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219508; cv=none; b=Z8qcWjmg8bY8vzTijLwNX3SnLO4rImzszPpk4C04wogl+VstgsDse17kT+3WKX9UUU77eOesxmzLRSq2rzpEWATSo3nPfViDf1Bi7O4juZMQMF5i3wQdKtRvUYAUTOBUh83dBAkA0AsjVjVN2GamS9WQwQNWXQrVUWa7TRiXVSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219508; c=relaxed/simple;
	bh=ENj/e7aIUmVV74N2VzME+aa8yVZt8dtKNZ/v8KyRutM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iItDd0ZnM9pH6wvDkUH2+OTipC4lvLaoiDMJPvpsyb0pforPuL7lzgyS0GIuT+p53TvBjRX+RD0TujCtxFPzh//z9P04X/Gwlw0rxjtI29vvLC0ToLlB2Fv+Q8Hb0RjWHHVSAiXykLSr9gZZCgVg1Kc9VwQWEWD99kHNj4rdNg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZWxMS6N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZWxMS6N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF301F00A3E;
	Thu, 16 Jul 2026 16:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784219485;
	bh=RUaLGPZ5j3VqnvxuPFbCeedwozNP234RROFK3oar0Uc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=iZWxMS6NrN+WHoqYEOSeK7kTT60ZJAscfmBaoAeHo2eAwJjoLyeiQkBnRmmbnflVT
	 hWENbn0V6qZhsmzb/nDgnIUm5CzLLl1Ez0LM+JTcKYAFe/3WHQYy2BUYgjjZMvbKbo
	 EXKUAy10ZAu3O0VYVXeUd1JUHULC0jdrnwGjrn021UT9/+jdQTwlOvqSiCXHOSteGH
	 QugFB8VBq9ZgpMSHHt+929d0q5ll3Lc+a5mpxQ6fmJzlrBEcHUGiB9P2rcQXrruQms
	 G59HhNyxt5kAKLdMufrDq7yO45UXNrpJnuX4ErtY9bCIczrunGNY3WA3g0G9BQC3xP
	 oyaon2r+YLSfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199CB3809A19;
	Thu, 16 Jul 2026 16:31:00 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v7.2-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260716124635.45302-1-ulf.hansson@oss.qualcomm.com>
References: <20260716124635.45302-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260716124635.45302-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.2-rc2
X-PR-Tracked-Commit-Id: a4876f11aa1d076802676e23f8af500706e780e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4302c3503cbe00c54900105d15eeea3b1a8030fa
Message-Id: <178421945874.1334695.1376180464929495873.pr-tracker-bot@kernel.org>
Date: Thu, 16 Jul 2026 16:30:58 +0000
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 Jul 2026 14:46:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.2-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4302c3503cbe00c54900105d15eeea3b1a8030fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
