Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405263DEADA;
	Fri, 10 Apr 2026 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775839556; cv=none; b=beVm5czO5/uUHjKgD+xuEFZQAWQFDmFEptEupLeRX2mfaelRtZQIUhcGioNcfxojHA/g8edobFRui4wyFB4+3YBDd5r59ezDxthjd+QeHcnK5E++DQiJqrN/hEIvP6jZxRQuZ9PBzd2bcRE/AJP1+fIqojVWOTJwnLqP3TRDUsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775839556; c=relaxed/simple;
	bh=pFxRGhy+NVx8/LfZlgxE/k13Ro1ZBBKw+g0gdqIRrz8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mulZERLioSVguIsL+3FSc4Hoezp7PECCJ1hWtXYhTZz/4t2Dv+z1ZpLnAmxjW1WkjCU7iv66E8xJ95AvEeWoeb5S36VPDH8kkbwUcrX5N4gg79QjRsH3OEwCMbOgFduhwf45g7jsKXP5/A+U6ncEgcNtA/upPUGY28/BUsTjhXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mk1UZvlY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mk1UZvlY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42E2C19421;
	Fri, 10 Apr 2026 16:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775839555;
	bh=pFxRGhy+NVx8/LfZlgxE/k13Ro1ZBBKw+g0gdqIRrz8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mk1UZvlYTdYuxxPhnfPHoQ2aFQZlWiYzUbbRKpqqIpEjzSvMEHE26uhYtfWvqkpXO
	 HHJO6TgQSqfFFXIsun8uEpp8X5RRb6pi5DOHUMLiTkMuKDSC0LUMrI0/69MEr0l/xO
	 F0o6z1CwPoXORIcHYu6oiD2/mw5ZgUdV2+zRDwliJBCj2CFh/zs9v4C4s6gkmZk/yY
	 5vogYBDtnYlOOUxZ++/4FtE/5N51V7XUssB9alsxoO1/p5feVW8D/YcM4XPdMGXld5
	 ykiDjlDiWM9jOxCpJstqZAkmYGDrOpCqXbXf+YHfCuHPuk13fXKNTzwFq88TIEf0la
	 IYLb+BD8KrNEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1D63809A87;
	Fri, 10 Apr 2026 16:45:31 +0000 (UTC)
Subject: Re: [GIT PULL] turbostat fixes for 7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJvTdKnLmCFKQevH7-Am-TQZcvtgRhhMbyfrb5zG6EbEsQheqg@mail.gmail.com>
References: <CAJvTdKnLmCFKQevH7-Am-TQZcvtgRhhMbyfrb5zG6EbEsQheqg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJvTdKnLmCFKQevH7-Am-TQZcvtgRhhMbyfrb5zG6EbEsQheqg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-fixes-for-7.0
X-PR-Tracked-Commit-Id: ba893caead54745595e29953f0531cf3651610aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 96463e4e0268dddbdb60fd1b96800736aa2bade9
Message-Id: <177583953048.2559624.4012143403689958152.pr-tracker-bot@kernel.org>
Date: Fri, 10 Apr 2026 16:45:30 +0000
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Apr 2026 09:40:59 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-fixes-for-7.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/96463e4e0268dddbdb60fd1b96800736aa2bade9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
