Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBA53C09F2;
	Mon, 15 Jun 2026 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509931; cv=none; b=uWfHp0gvSe22sqYcDO8iCRphCF2o/NtTf0HS/Cb2epfomwS6PwbdwgXZTeDNng18InKa2PWcVE9KtV6UNih34ndWOgPAa2dIBYleCVNrFnjlZCh4y//s0pV9m/J/fuzKtkEoLa0aDtXucurqKMYD419yMER+8jDB8BIpuCyawj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509931; c=relaxed/simple;
	bh=3YWdtKOBnqkdaULtoZw6n7R/WIRMQ8jqiRXeaG2yEn8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AjlEENnb11DO2qOK1SKx6leXqhhEXwiFz4yMmDw023KZiWw0VPcejLLehnLVeWykJrKqlijNGCw42vBUNLKBBrA1uNM4aLuI1wHaR+AsEXT8+MNFWvGXrGpT0IiHIcnAKE97SDioCAepRwHLR+AS/21r3bU7OyeRAgaeAV1fyL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzzPApMZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzzPApMZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459FE1F000E9;
	Mon, 15 Jun 2026 07:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781509930;
	bh=Q518NQ+KWrX88NN/wEj7RD9IQv5B+8b97QifxgMH4u4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=VzzPApMZOpOfdJnVykjVqTCf/RHg6gtFnRJ2uQNd8J5JDs6B2paH4m9NCAMq04IOj
	 45Hb2dV5HhVr7GK+ys9tL11oGyT1HiyRO888hHCbOxd3ITOozuuzSNlYThFJ7WBvnx
	 Hjy1Z88NKbcIAIL7A9TJ0o32POqp6efYGzXmgQp9aY9T0kGSUamJ1VbvjV0fKO9UOJ
	 SIHE5FgiyQePCDx3/nVJigVKsCooW0Bzd/fknkWPsmsUSrTMwUxcO4zz/Mms7f0r/2
	 xI/hXPWxftwRMTR2cTTmA8mfaqVfO6CrKxUwhlzNAJ33VOHlgfhGKXZK3ODHY0Sp6B
	 BOkOAT33u2w3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09433A56756;
	Mon, 15 Jun 2026 07:52:06 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support updates for 7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h-9HOj9ar1sa2oeJ1SJQ-CbtTj03EyLpuhpQOPHa2fSA@mail.gmail.com>
References: <CAJZ5v0h-9HOj9ar1sa2oeJ1SJQ-CbtTj03EyLpuhpQOPHa2fSA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h-9HOj9ar1sa2oeJ1SJQ-CbtTj03EyLpuhpQOPHa2fSA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.2-rc1
X-PR-Tracked-Commit-Id: 615f90d3b1b7900d591a9162793f616b051f07b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eed451031f6ac098ca04ebdd63d34e083ba2d6f6
Message-Id: <178150992533.2920647.9576147759442016871.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 07:52:05 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jun 2026 19:41:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eed451031f6ac098ca04ebdd63d34e083ba2d6f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
