Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DB547278D;
	Fri, 22 May 2026 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459935; cv=none; b=DxJXpGbINzsN67F39BrWR5Gpb/h72pJPqEe6mvY6rm4euF54wn2L9JG4gMKODPm5lQC/9R8Uw3ALnYwtUAcy52izhfvr3fVob4Wd5VRFy7dt7p91DczjKQCIoAtbDMIZN/D/32/7ZLSIgiaCUJSBGbG6uX+xv6pMf9qQyutMbSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459935; c=relaxed/simple;
	bh=+agS01bZvb1KLhU97S7VWESmV3tLvNeA5edo3LoKfnQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IyOvX/HhX0gKgFgSytkrZpLW8YNrogy/oMxZ7MFBF2WuQTG8iDX2tyXMCn7Ca7jy6UpstBQw9rWvgn46uateXGD0Cj9f9yenwQc+YpZ5lxNMYwWr51+XF+lafD9k5tkDJw6+naOIzlsH4MVhO8wSxarmaKmffKrtPv4qsM+AgJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhapYsH+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhapYsH+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DE11F000E9;
	Fri, 22 May 2026 14:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779459934;
	bh=3vBcdvrI0XPx8e+SSHWkROk6mCDyxmkFWXaz7kTxmNk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=NhapYsH+CKbo5UQ1PJO4sMnPfJ17PAKB1lbYRQpusIZityrUNa93cbGTf/EErKg16
	 ZK/i4VDZgjhDbsEp11rKX30E7O4utEfuU15MVKnGOpz1dzJnY1JJfjBfYJcea7Zu8o
	 t6RkYShqynJvXpm646PjYv+F/tz5lVSIrxq/kPZsPPV4O42F0oLmwEjdVQVm+0iEaz
	 gdrBKwI6FHYq6ZBWRbHoSlc8FA29NlsrN7+H3T/fXU8hEuCgmhIdPZLGeP4BLxJXLH
	 ASFZvAVj/SddVKNY1XCk7pR24PfCQXi+Yq6LS/cAR7/CpaXWMKgNFlnao++vj2t8tB
	 TAytzreOv5svw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93973392E9B4;
	Fri, 22 May 2026 14:25:44 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v7.1-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jV993R+4XzRDLRE170myHSHhqwH4cDDmRiEMGwEdKfUQ@mail.gmail.com>
References: <CAJZ5v0jV993R+4XzRDLRE170myHSHhqwH4cDDmRiEMGwEdKfUQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jV993R+4XzRDLRE170myHSHhqwH4cDDmRiEMGwEdKfUQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.1-rc5
X-PR-Tracked-Commit-Id: a67f3113331d9fb3eb0664602d9b581cb2df7294
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45255ea1ca096b11b1303c9b54502a28f3a31dd1
Message-Id: <177945994306.1238704.2400771178606732700.pr-tracker-bot@kernel.org>
Date: Fri, 22 May 2026 14:25:43 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mario Limonciello <superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 May 2026 15:09:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.1-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45255ea1ca096b11b1303c9b54502a28f3a31dd1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
