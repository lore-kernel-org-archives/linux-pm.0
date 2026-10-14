Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97A91FC0EA;
	Wed, 14 Oct 2026 00:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791937006; cv=none; b=bRBM8hZYloQkftK1L1niAwAnVqZZaL67IwVVQu2RWQOPAdeR61xGMYFE6VKGKUueiHrRm8hc9IjIG4tFHf13HdOJOuqMHjVIf0SAld+PNsWe4/rVbdA5T0LGKg9g46JGDhH+eFIQFonxtJqjmQ3AlXQLgrOxGOOLY9GhJE7OqJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791937006; c=relaxed/simple;
	bh=L1/Sg75wSvjXMidePwLNHMFtx7ujj4r7Vh7fEkV3Eg4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QHfASajRdlxWyFlx8K1esL1YSXmnMq488Fqc0Ibefbb0MVaqTXYTOCsPByn4Qz3rux4TjXIvVqSMzmvR2qi/RP+J3hgboB6PvI+TN7Scme2O00LBe1qIR5Ad1zbo7XDq7cr4tQf/haEF/xFkv5UQDHpN8MLiOs+6aWncj4wOvgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyAUyl7M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyAUyl7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B2B1F000FF;
	Wed, 14 Oct 2026 00:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791937005;
	bh=RzzmTOpifvUgH0X2J7VvkaVANK6Ap1ynKsZvHgdzh6M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=GyAUyl7MCWFYTfiOmiuRLS5d4h80fLflXuD7CONGdSyQpQJuQLxKdN4zB7LuSKMLB
	 dEY2GaJgSur542VHoG+QAtxPeYd1RMXLX/s0OxQkzRshadwss6JNh4w67oDWE/EnYR
	 yP3WL9IcW8xcHMnxAs6bSGQXynsJMrXqulC+Y/6wjrM2bYlLquxQi2RZ6gp3cxbGBF
	 PPJWKZtA9PeGriR+0ldYz1fRaRB+dR55gSqQ6d5r9PTZr9pwV3JTGcXDZdaZL3VsHb
	 DpAqIcd2UvB1CvlDt2G1TlZoxQqaQLsm4/VoseJ9qX9fTbAROeIJS0Wz9c8biWP1IC
	 jJiWG8iHLsghw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 775A239E8A57;
	Wed, 14 Oct 2026 00:16:45 +0000 (UTC)
Subject: Re: [GIT PULL] turbostat fixes for Linux-7.3-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJvTdKmxHEXJppqNcBDNv_5E8FZt-faB1Zh4G=L+j=iABc=tRw@mail.gmail.com>
References: <CAJvTdKmxHEXJppqNcBDNv_5E8FZt-faB1Zh4G=L+j=iABc=tRw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJvTdKmxHEXJppqNcBDNv_5E8FZt-faB1Zh4G=L+j=iABc=tRw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-2026.09.28
X-PR-Tracked-Commit-Id: d3eea584b56fecf5c3fba0979f0da28a6600d6a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cbc08c20479c6da3db077f9b170bb8cc2d09df20
Message-Id: <179193700400.1530094.8292715342041943553.pr-tracker-bot@kernel.org>
Date: Wed, 14 Oct 2026 00:16:44 +0000
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 12 Oct 2026 14:40:19 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-2026.09.28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cbc08c20479c6da3db077f9b170bb8cc2d09df20

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
