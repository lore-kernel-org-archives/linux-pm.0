Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA65F38331C;
	Thu, 30 Jul 2026 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785438950; cv=none; b=MukZ3VoYfbrZptGKdHJPg1YVjcanYhSmsPicz5TGNdNavqrKkIonpn61yg0MQx7ck6UKSWi9Mld63XKTWoMFxG/N9822IYjt0I7675MnmZ1dFexyCgg2OaMGgVc0hRuAXmOCgOQbpYYmGc74VTI1f9Lj57LDtXQ65nETzv28r70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785438950; c=relaxed/simple;
	bh=bNVfqn1xUmAqvXhjX0jZ9K+7XFzOclk/LBlOvDdd2ec=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qWWRK3O9h0+f6sMCdtH9kyvN5X2o5hXy40lZX8PdoFd+EfYtqmmq7Ocwa2ucBeB0rQbzj/5Kv1Qogmz6uXzonPd+hT5SDdMm4VccpnlKCsxFlNXIMU1/ISZmlbMWkV2hZIEwC9zNcfccJ/34Yudr+9d5eAx+Z/hajmr1CgIuu/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cx1lyU3t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cx1lyU3t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFCB1F00ADB;
	Thu, 30 Jul 2026 19:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785438938;
	bh=4Gl2i05JxnZ7oX9ngvnQNanfRggbAEnmLd6rAec8RuU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Cx1lyU3tCQ0dU+1BlVipPPqXr61MIquA4WZr9uaYBemznYMCCl5mNo+/8tPUgwY3P
	 9747e6EJrsshpooVAJnOTYPGsRQdG0hTZtdIThHJbz9HFVTAtzaNOi5W6sBWBKKLYD
	 8N8dgBbtAFNKygiX5+z8s7WNRfS4UaHIJuy4iHbn6nudIS3I9owgRgSZ/gZH9C+Bex
	 YUdWtagttd5mk9ZME1EuXVnmuxBDFKhqyDpxDvoDpELmg8Gj89RkP7UVFK/Y0Dex+2
	 WyuMjiUpHy7AvOkSyGH/jkvyDIqQe/683847N07LxizU0lgONQ7pPsghkLNBegVYxB
	 xhFqIollDNatQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9397D3811A6C;
	Thu, 30 Jul 2026 19:15:03 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for 7.2-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hnQknRyf1YW9gDiyuh+S-Rpb-_cL-1jayO9R8Uq9G_Zw@mail.gmail.com>
References: <CAJZ5v0hnQknRyf1YW9gDiyuh+S-Rpb-_cL-1jayO9R8Uq9G_Zw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hnQknRyf1YW9gDiyuh+S-Rpb-_cL-1jayO9R8Uq9G_Zw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.2-rc6
X-PR-Tracked-Commit-Id: d5f8e5f6040d052d44fcbf4f31dd35145c0c8d7d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3708dd9488440e35a165aee2bb2a1a7b1d0d5777
Message-Id: <178543890228.4145507.9539143889435232593.pr-tracker-bot@kernel.org>
Date: Thu, 30 Jul 2026 19:15:02 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mario Limonciello <superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Jul 2026 20:39:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3708dd9488440e35a165aee2bb2a1a7b1d0d5777

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
