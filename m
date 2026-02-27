Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF492C0296;
	Fri, 27 Feb 2026 01:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157404; cv=none; b=Hvik0QQRjdTOp0RBfUIXJgNgPatB+rl1Yr8P7X3TJl3YXz5mOPsPnYAz/j5+BmUJT3m9SZcU38qiVr86LPgFDRvH6ZmK05JB1aBTFQX58yor+OFjmmQfTU9btJ3GWz2yAzfKWrD05ynlss41HZ8giurc2j+3CICgtTbUiKx3onE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157404; c=relaxed/simple;
	bh=8G4nnr74N8/YaGFvEIs8MwR1Lt9ot+rtDsbLojIJ3js=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fo6TpiW2XPCyIGKAwcmSDB7+ymQL2mccO3reP85LC5gI8awg29lshabovTK7MZ968NeG30IWFL1GZ7hq1JLCzP+rijmBbiK2iXuh//rLwk91X3x7tj/2TygW3VwiqesVpBog4Zd4VKxcGOknBpsSdYg2ouOiWaznRZZH/t2FVo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aikxwxMs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aikxwxMs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5644EC19425;
	Fri, 27 Feb 2026 01:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772157404;
	bh=8G4nnr74N8/YaGFvEIs8MwR1Lt9ot+rtDsbLojIJ3js=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aikxwxMsqZmVHsaBtGftFjLOi6smOxEFbNvjt5QUKcaBxM4CCYDrha9qRUN+JM9jm
	 HcvvWsZ9AqC3b1ECCX7tHkS7MgQztZuibxvJ8WfpUJX7Fowh8YSwYjmBmr/SyszJXe
	 6w/euqq6xn52yv1jU0h4mSX2EyHH+zjLFgW98Ui/LKOzB3RATemIa+QO4Kk7owEU9z
	 YC8SNxD1NiLDe4gesrb3m6oyP+luUCmCuA/quYxy7Oy2OyZJWvyW25XtpVvBFM61Hp
	 Wn2zO1pDelykNUHn3D2IJpcupuwgnNlUOPzBvCfCg0T2eVbm7ArFTxDPaVCKMl/9SK
	 /FyDbdIJNOBdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F41393109B;
	Fri, 27 Feb 2026 01:56:49 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support updates for v7.0-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h9VMwNSMrb_w2BGrv+fRDcUCJ-_1pYeDJ+oYigJovDLw@mail.gmail.com>
References: <CAJZ5v0h9VMwNSMrb_w2BGrv+fRDcUCJ-_1pYeDJ+oYigJovDLw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h9VMwNSMrb_w2BGrv+fRDcUCJ-_1pYeDJ+oYigJovDLw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.0-rc2
X-PR-Tracked-Commit-Id: 3d9b8b00da184f885c4db08fe5521f6a3e3f964e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e094883b508bbcb54f9dfbbd4cdae66c25d86c81
Message-Id: <177215740849.1937342.16732094894602686178.pr-tracker-bot@kernel.org>
Date: Fri, 27 Feb 2026 01:56:48 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 26 Feb 2026 22:11:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e094883b508bbcb54f9dfbbd4cdae66c25d86c81

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
