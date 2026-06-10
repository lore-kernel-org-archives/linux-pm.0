Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDD7348C70;
	Wed, 10 Jun 2026 19:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119351; cv=none; b=sqexH12U6mte5b/rM7U7EP7OxNxrNDES6wXViVoNOZm/LquV0aNpI+8u574yXN99sJE6FIfprLPlXUFxqotngD9xcE5QlT1D1suD2axTUoFDqzv7jdhmEorpCQT2OJDRaiTOtFUL5SQYmxwpeqPIn2aGK1Ksl/tY9s73qAs+8c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119351; c=relaxed/simple;
	bh=0ki8e8jxlHgyYSRcrwgGvtjmJpxwqc/wx3GZuVIjuAc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=s047i1tGlDwNiiwauY17/4YkP6s4B0c5V16FC222y5f8sNO2donGu0clGchXdNVU98B/XlbOoFv/8xZr36c+zpqS1CGHcDFsD0trwvKk+O+xtqRTJRQlcUL4s+vNvHI8eTUfv/T5FXJg4PLB8uYJ4az9UXMG240d0ikukvYXL7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHtxNJOj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHtxNJOj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8991F00893;
	Wed, 10 Jun 2026 19:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781119350;
	bh=lyEfoBhyBTqh1iVOPWYNQ8REWpuz0PonboAvzy7K2Z4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=JHtxNJOjrW3KZazvXToIW+fbwKM9QUwDwKZOrmEfxNE2Ac2pxG5C8rQ86wYtHLW9/
	 Un0v037EWjFqUEw2UZ/KHBlJKeQsP5yY5I0ceehhx+ZkTl1dqis7dhv0pvOMZy4ZrI
	 Pn1X1fCJvgXwWBbmTetUBbL4LcvjNuEglXHfBk4+FFS+r0nTpNSgYRG6Avg0plQ8wc
	 h0YpBLSoJ/FPaApSCFs4woyv6bMN38RCUXGtR5sFzSm9jqeouJ7bE23VrszhdEYM7t
	 X7X3oaDuSn5ok6jvD5dF/AHdLFHMwOjcsZZkkbHSr9b+yD/9pWKvWPY80om0+BMovz
	 osFqCYszQKE7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199923930DEC;
	Wed, 10 Jun 2026 19:22:29 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for final 7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iYVY_Xjt5v7GFuOp4CoMC4_TMdvYKr9+TspVUw4h-gyA@mail.gmail.com>
References: <CAJZ5v0iYVY_Xjt5v7GFuOp4CoMC4_TMdvYKr9+TspVUw4h-gyA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iYVY_Xjt5v7GFuOp4CoMC4_TMdvYKr9+TspVUw4h-gyA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.1-rc8
X-PR-Tracked-Commit-Id: 6100a82e34cb75571feba920a9c18f60698d598a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9716c086c8e8b141d35aa61f2e96a2e83de212a7
Message-Id: <178111934757.3601381.472171738483096532.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jun 2026 19:22:27 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mario Limonciello <superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Jun 2026 19:40:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.1-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9716c086c8e8b141d35aa61f2e96a2e83de212a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
