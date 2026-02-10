Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2628A2D0601;
	Tue, 10 Feb 2026 03:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770694809; cv=none; b=ou+UKLXypUj2xCwWegZavbA1/34OAYuhZxDmzXJdHkw+0Gtq8rve0co03kWsPMupAEhXtwuXoGB4LanO4Jd1PbyrAF1If80W/lFnSgVRR3pojCLG24bOSPI8K3/kwlvHsQBufn5RUkIs2SxdGksAplfM9mZN6kEmjph0Wwredx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770694809; c=relaxed/simple;
	bh=85g67HjY/CKEeWxPKTqjQ612hlMC2Lt/JkoPbuSq08E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WiFdSCj5CxjglOXHzr+P3tyC1VR5a6ehJXvl3OsSz4jjrh1ml/vVkdkNsW7N6RKwMgmsIZ1oV5LUi19irDwGkBk5h8e81QgathwsMtAHBru/PaFYMyhZTaWJmmdu8S0a8r5ODlXSSWqMHawJ5IUp7eJHbKWE5YmHZOChPAJro+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvC+EnKg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvC+EnKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCCCC19425;
	Tue, 10 Feb 2026 03:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770694809;
	bh=85g67HjY/CKEeWxPKTqjQ612hlMC2Lt/JkoPbuSq08E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RvC+EnKgGxgvN+ENWMsQ1FnR/WGXFtlqjs2QTfvupGqYakRScOUN2IJGPI4P3h1ss
	 B7rmYyQhZdl9i6W1S4YkFNJHJumhvD6lnJALzduFMYdAyNZsiV5ZMxOoMeR1nd+VIX
	 vfD9yusp9zlUfsLBoaKEXCnrxXF5fBZUt8oC3XksZuFmuaeIk9oWzpDjQV3mULd0TW
	 xwf7JAELALWAUOYMcXw9R5fkH+syHlmNpdazDSfxcACcenK/TNfCtgXID/wwDS3snW
	 BBGrbRb8htpwfEn6NSTLqWJXzQRIqcaZ5ErT8UVhick5FUmEiMZLJfAwynw1JgfDRW
	 ssHbDXxSv6LPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E48E4380AA58;
	Tue, 10 Feb 2026 03:40:05 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support updates for v6.20-rc1/v7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hP_9QeMbeB=oa8+4GaO77HuhpdqEngHsd2K-sF_yQ+Ew@mail.gmail.com>
References: <CAJZ5v0hP_9QeMbeB=oa8+4GaO77HuhpdqEngHsd2K-sF_yQ+Ew@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hP_9QeMbeB=oa8+4GaO77HuhpdqEngHsd2K-sF_yQ+Ew@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.20-rc1
X-PR-Tracked-Commit-Id: dfa5dc3ad3b15a519101f134ed76c068526004e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d84e173311c4f0b0300755e6445f3224d252eeed
Message-Id: <177069480489.3327783.5607057782875341035.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 03:40:04 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 5 Feb 2026 20:40:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d84e173311c4f0b0300755e6445f3224d252eeed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
