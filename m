Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E06489889;
	Tue, 18 Aug 2026 19:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787080544; cv=none; b=VE9uYHcsnf5AJZ95iGzVVx56+C/m/hcqNhX4YARv7i02XEQ21VFV1NiLUjj/ebQZCZimGr/avl5e6kalOV2D/DHelsOnLGS1ej64+xwPSbJ5f2QOzWT9+/Kpx++XFOMBVVCEpsSenWHNTRwTnXa0mBbqtuBLzp0j1KJANFAjSqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787080544; c=relaxed/simple;
	bh=GSWHD9Q6JXw3F+eOUifpIwxrVSbk12yDCV7fGwDC+dc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mizVXSx0hp4wAsUhs0sG+151Im1vwMHzhkxmnzC8dWeui6kJYEajTNF/okEzFnVByVpjAyvmEvopNd4rQ/4abuwHrs9cweOMonutN6piKSY+VWNj0NPeTopvEC5sc87TGOxNj9jz8P8ZS9ftaQ7g+7vnmOIvy85li38d72e82LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OglsKkYg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OglsKkYg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9FE1F00A3A;
	Tue, 18 Aug 2026 19:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787080519;
	bh=7mHexR8XIGD2KXFRGcfpmVbqm5UqFriBaZVbtBKOHQg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=OglsKkYgfzZzZnn0BTjcCY/JjS9sfyIhZPJIzPK85eYS4ZMQk9w3zxkXyEGyDhGAU
	 Cq+FA4IrA7UnHag6pTltVUh+BBkIm7YqQ4mtNstT5B3g0K/b0jwkGlILt2N0hLFd6R
	 7OtNd8NSnD4bAW6zf6QmMUqEaJ2q7v6f9/fCROY57418rzfpuaS0pKOVMBZkqe657p
	 +ZjlnUxnwesa2mMxeTAg1hfK3op2m2nJ2CdFtnNJoRRgoX4/VYKMJmsRC/lYhVOQ1o
	 LFyDC7J2qaSw22/hwr5QDjGr8M0rn7mdQ79ch/eIe1CQ17hbDWow0dLeq9hUiuUSNj
	 yQSVcCBjrEw6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938D73927051;
	Tue, 18 Aug 2026 19:14:32 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for 7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j=dZ8UjEDYjKs3WosMy=H8p8YwPdB-NRWu3qMUb9KCQQ@mail.gmail.com>
References: <CAJZ5v0j=dZ8UjEDYjKs3WosMy=H8p8YwPdB-NRWu3qMUb9KCQQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j=dZ8UjEDYjKs3WosMy=H8p8YwPdB-NRWu3qMUb9KCQQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.3-rc1
X-PR-Tracked-Commit-Id: 7544a367adc1ce5e9cc62315b4c32dc72b509451
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5778046a02570fd23bdf0b48dce330237d1996c
Message-Id: <178708047124.2235733.6700006601491205102.pr-tracker-bot@kernel.org>
Date: Tue, 18 Aug 2026 19:14:31 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mario Limonciello <superm1@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Shuah Khan <shuah@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Aug 2026 20:54:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5778046a02570fd23bdf0b48dce330237d1996c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
