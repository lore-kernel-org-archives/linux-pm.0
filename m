Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CE2352028;
	Thu, 28 May 2026 20:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001919; cv=none; b=Zu3Z4QXhNfpvIxSZ6vjAS+0RaL0jBbXzC2MHCmb7L9fJ7p0XQXEJ2P7fx8j0oPKEz7UXeNi1Ha5v14LIFEUADc7i2/eFb7C68wwfVPhR0nfcCEIPoxmhE+Wdq7y9WtfhqSY8tzvhd/3iyO+Kc8ZSdivQ+t9MA1LTRbsDqKCa7gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001919; c=relaxed/simple;
	bh=LY9ogs3HvJfsTAJ2+zmf+x/h4XFBELWzVgmU5JxkIlc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fDYY3A1tKyibtf8WscVUNyMkbh1IHjU1D1hoO+v5EEuew53zI+FQdocuuQBs2KIrkpZ5WuD+sqEpBX6j0lZQpzyjAOo8cih2t2jJJuym3b/yrRl3rG0rrXAo6ju0wuUu6mQpLyBoncyKzPz9+apHprE9wHslP2/dAOgycIJiipc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nb0pKU05; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nb0pKU05"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C36F1F000E9;
	Thu, 28 May 2026 20:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780001918;
	bh=x3h7pZHkSBfetTGNxzB2NFvNjyXVFyAJp4ulEIGSMjI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=nb0pKU05TvylDS9aMNl6Mmwn3OfICdQY0LPYM2wVrFOp6icNlpERKO+9bjKxE3VQj
	 8dUGsUgNn9qXmBf04nZN61QUaSVFoFljWop3IeNxFREJYnw7fhGO0dXcegISoEuaPQ
	 BQR52mbPb7j+aCPIO5uWjv5OuO2yjeqJAcGxTc/pUsGj4arV9U71EA/dtISKok55IB
	 HkSo5JqASjIf80zUdHbMcn5e9G9OfvBqyILhfrvMSNFKC2o3QIopKaaG5Ocid4pDzP
	 MWSqjZRoU9Tq0RtmFZcf/Zgt3kB2UT99L+yX4D68UY5D4CqVfasosgst1CApSYi8oS
	 8mrvF5UkTTYWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9396E381196D;
	Thu, 28 May 2026 20:58:43 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v7.1-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hpExkjuQy5ezEo8WGBrqMG5BssPAorP-d7mRk-2Nsv5Q@mail.gmail.com>
References: <CAJZ5v0hpExkjuQy5ezEo8WGBrqMG5BssPAorP-d7mRk-2Nsv5Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hpExkjuQy5ezEo8WGBrqMG5BssPAorP-d7mRk-2Nsv5Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.1-rc6
X-PR-Tracked-Commit-Id: df488cac6140aa04ae52af9b4507d8f99a3762be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de85416e95c9cc9b18a3710e2554630f842b8334
Message-Id: <178000192223.1510087.17336413839598351417.pr-tracker-bot@kernel.org>
Date: Thu, 28 May 2026 20:58:42 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mario Limonciello <superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 28 May 2026 20:24:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de85416e95c9cc9b18a3710e2554630f842b8334

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
