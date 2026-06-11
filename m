Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009B7368D5E;
	Thu, 11 Jun 2026 20:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781211524; cv=none; b=e5jdzne6y4fR3PresIaDexAexiLd3PYepkG7LBXJ9WBMWoidXtTfucCaUn6jb0+7HXtxn4qTdHdDdfy0urpd8YtIqn81n3Wxyzk1jTAlhGsqbkrRxW3TIbLMpaEoy9RsQ4S8bX0V9GY90oKlPj7oAjqwhV7HVsKwI7VETejtWcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781211524; c=relaxed/simple;
	bh=nuDUE8OjosySXUOE4YFwRuHrQkH1iP4mY5kjysZwUOU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dXY/0o70NZE/aQJw3je/yi2b+KjJT1rLLvR3w1fM8qhA9VdNE91gaisJjqL2hwib5HHxZ8J0pfmhW/QNGyQlRd2Jbnp/Y1NmAulygWDZPy+17wjiyKRtOZpdRUjLz8Kc7GCgVeei5Gr/23lx908Ms5zhUa9hJ6IGOhqe1JHd5vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOM1yLeP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOM1yLeP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABF01F000E9;
	Thu, 11 Jun 2026 20:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781211523;
	bh=UFTtr1a4Nc6rMkWfly5OMHeOwOpj87d2rhEO9whfhRI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=kOM1yLePdZXw93nw6vS5RaE74CgJusUVEEanUXxwwzEXtujfm2ZdWloBk55fNmH8V
	 SpRaK9bYBmsvqXaigDw469yIxEQqU56sij0q6o8NH6+CwhH83tPksTF7dH7SbEgnW4
	 KFGGjLl1FTzgqCuXUDRKFGYo6XbJ6R8be81cjuODMqc9vNaFzoOrWpS8tUkfpaBXI5
	 7CRmfeaWSF29HWCsL8um7gStN8xblReXwshTQYp1Ej7jt23FLDwOCA9XXlgyUU8k3F
	 hphX+hBNwOznzE4PPaE6mS72/0tz4PpKhiBXdhbmc/TtL0HTHliX0WXP6sWcSvvpL7
	 y3EYrZXjQnY8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5691F3930FAA;
	Thu, 11 Jun 2026 20:58:42 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v7.1-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260611110557.120619-1-ulf.hansson@oss.qualcomm.com>
References: <20260611110557.120619-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20260611110557.120619-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.1-rc3
X-PR-Tracked-Commit-Id: fba0510cd62666951dcc0221527edc0c47ae6599
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79f2670da86722d075633d20fa57418994ee6940
Message-Id: <178121152085.362744.15549221223768274381.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jun 2026 20:58:40 +0000
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Jun 2026 13:05:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79f2670da86722d075633d20fa57418994ee6940

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
