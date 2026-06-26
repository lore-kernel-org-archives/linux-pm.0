Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D2F3BED79;
	Fri, 26 Jun 2026 20:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782505962; cv=none; b=U2wODZMsk53cJlriePYosf8kGj4hSU5+aT6YKs/BgLUl8MDhuzJpeFFa0+eGOtULqZQjJxQ6PwNg25zb2wq+s1zsSK25ft1RFiGrsDi4daRBfQSdeAJaVfx+H2XzarYpfpsZbgwfsEvcUwRNNnQDa67BNnSzardrhfVQf2SD4JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782505962; c=relaxed/simple;
	bh=rSLNQGlsWpFOfh+Il3rv++af2cLTJVKu/AY5q/zzKgk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mAXMBAx47ZPobGmSBCcRcNoI28SiAHRP8v3buDoZLqJ1ij0PEJHa59Uncci+UaCniX7Pk0fREATIlO6OCaTRIWlDVat9qZpi1pchsK2Tjg9Cd7kDKlDMWrjXmspDLySY8ngmkK2uk3ekuYWZOuikSv3WHvl0cbRkkdT1grF/qpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyPRfsUc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyPRfsUc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5801F000E9;
	Fri, 26 Jun 2026 20:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782505961;
	bh=JeZUNKiQ14OTuougRJ/ZJc5I1NcGB9ReLdFmrmILQbA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=YyPRfsUc15iQ6JEpDogY/yHkBU46+cim/LRfqGJ5N0gaO0Q8EtyjpDomcpO1QwLEO
	 ISCpBgOn4a0nW+7MvOU8uUcRa3ca6krbcu3jm6r8UwzT+xVuYzvS7o7CyjHjN3FvWJ
	 jYfK4LvnY0Q/H55hlt0KYeTPEVyenPz/bzw+/XmM2+uoHm8ToQB/GeAkUccsH372wu
	 ZkXzpsp/DIKWuPfgICGvjXzl6em+RiPKSE9JubaBJMRcmIkE/6Xb3517D0U7b6YslW
	 jBmNuOABw8bxm4lzzTCZIx3WcoliYxQACZCvxpS0QiUpkCQfST00WY4qe5UeZR/iO8
	 XE1MLFRYuikAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569993938C5D;
	Fri, 26 Jun 2026 20:32:29 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for 7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j7=MYemjObicteXH1u401Ru5Sjr1ZNPNzdHpDKsDrQ3Q@mail.gmail.com>
References: <CAJZ5v0j7=MYemjObicteXH1u401Ru5Sjr1ZNPNzdHpDKsDrQ3Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j7=MYemjObicteXH1u401Ru5Sjr1ZNPNzdHpDKsDrQ3Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.2-rc1-2
X-PR-Tracked-Commit-Id: 795f1b1a91ae13ebc012a364075e42f486a1cafe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2dec87d0b195463fc4ea4b0817d3049630aebf3d
Message-Id: <178250594795.1084729.1450460433499943874.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jun 2026 20:32:27 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jun 2026 19:57:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.2-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2dec87d0b195463fc4ea4b0817d3049630aebf3d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
