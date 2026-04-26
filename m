Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993352D1931;
	Sun, 26 Apr 2026 19:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777232178; cv=none; b=S0hTHppNMMYWOivkAMdydj5TObiWPFIxDtvzK7w58wgV2DirjYlkXPIsUO4GKxvrG4RWQ80uwDVa//yNeCiACdNxayiDAGD04uu4BaKXRtryEhrkKFe1wbEFPuztMKIFH4LZz9rKAn2roTpeYILmHPB3LFe4pLnjFCgOGseNa6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777232178; c=relaxed/simple;
	bh=DbOrMK5btb8CfD/jkV6wuwf4Oam5T8ViN8rJ2aGyBu8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EqKTlh3iN8sVei7DZkepWf9lGI4zZjxV8QP6DcmMEMxbFO8UIvQ062irBz1DlyzEIdNhMC1AEmfwUwc6ReulbwCeELs6CtsiupThfiEIkLgnbLXY2GzEyfRxW8WCOrk6oIR8lD9GGaApXG4hbHF1qAtBv8tnOCVY5u7IVGkEfRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoSK3jZ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoSK3jZ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCE5C2BCAF;
	Sun, 26 Apr 2026 19:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777232178;
	bh=DbOrMK5btb8CfD/jkV6wuwf4Oam5T8ViN8rJ2aGyBu8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QoSK3jZ16KQ4Zww5qbjC7kuzZLUmi4P2OZkkYnj9LpMxfXOhcdjUBsXzBUNSOKDTX
	 CgTduwEVrIvWaYcDGfx3kdD4LgMr7Tzu0RACfKtJb/gLKRNm2EgjLEQRajs6XnUcA9
	 FdmvORB5nBTiODvgbA5PI8oCwoxI91oh59A5FrKSPJ2xEmIHBs9PdOjlV0/qNyF0Ag
	 CrPAk2w0nghGpWFmJAcVs74c0Ro9rMv0PMSrZdREtIrW5JmLU2znEF8BfuiPW3OieC
	 XliE0NtIjtNuTQrbHkTEti6clpsR2AchJHI6OCDexE5UEHsdQivzzjnkPGafrZpTnl
	 +wNM22P/USIYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE7638119E5;
	Sun, 26 Apr 2026 19:35:38 +0000 (UTC)
Subject: Re: [GIT PULL] Power Utilities update for Linux 7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJvTdK=twbYaC3pdQoAsrHwU61F3h-rLRrAtD7EjaUamzWhzug@mail.gmail.com>
References: <CAJvTdK=twbYaC3pdQoAsrHwU61F3h-rLRrAtD7EjaUamzWhzug@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJvTdK=twbYaC3pdQoAsrHwU61F3h-rLRrAtD7EjaUamzWhzug@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/power-utilities-2026.04.25
X-PR-Tracked-Commit-Id: 6112da1ea4a7cfac35e51a20d17ca9cdf946c368
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ff1bc41ef9133a52c116b36e5e88430353a8ba5
Message-Id: <177723213671.2364874.17387836225111602711.pr-tracker-bot@kernel.org>
Date: Sun, 26 Apr 2026 19:35:36 +0000
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 25 Apr 2026 14:53:26 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/power-utilities-2026.04.25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ff1bc41ef9133a52c116b36e5e88430353a8ba5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
