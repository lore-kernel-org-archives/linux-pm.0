Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E21375801;
	Tue, 14 Apr 2026 03:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776136224; cv=none; b=AOh+jbUWsov7X9QFr474kfpNOa8GrvEcoQ/4blGWM36gpDXk63j2WC/ADq88/N0NFYZLEs3HG7khCOWRCKKVOjjlOUOldSYVy4iaLzs4+PDyCxsowxlqRnTqbR8JINtdaJVmlEVi8rY1ofo0jaL2iVdFznj/slwpeJH64VGcT+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776136224; c=relaxed/simple;
	bh=97VwrCxzdlJ/FDITDZGV3nkHAomHIZczhl3ZVs9YSZQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iXAiQnIxLKMFruKOKP2XT518dLdXeZbNe1Fp/gXT+Grq78m68HA3cRGYs0aJV0+aqk7J4fEArx52tqlsm9g7VMh78N0tZuBWxamRUNnY6gghlCvrrRZnhQFSgP5htBDjdBlvOCfSZtnH0DW+WXgdikshdZGJ+iGQJ0fy6A8FAvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAJpX06a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAJpX06a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1FFC2BCAF;
	Tue, 14 Apr 2026 03:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776136224;
	bh=97VwrCxzdlJ/FDITDZGV3nkHAomHIZczhl3ZVs9YSZQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CAJpX06a36LGQRRvS9eIz7CZ/uaFGC3GsdoACXN+pStfTswPjdg7DwaHEaxuiub0X
	 ZNM1E7wz9+9icvnqDtdhbO1M1SdSH0qk6QQCgd7+xiFj6UIW/gaCRFSiXoePidR+3S
	 if4o5npY0SnOcs9e3Bi9L50VvS+CNc946x6sKu18MG6Nyi0CklN1j2c0sk1HaTSwqc
	 dXPN9ERJVkdZj7VqGFv72t+G2RYDmHFXrloQgfey/Qme0ZwbMGkZr83ynIBa4A7Jh3
	 dw1GMdmrn+wphMMiVGAIyL0hO1PJqbukap5gDhWTIL716l7hhNuaGupERzcjhAl4Ec
	 aRg8pWaS8qxhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE703809A0B;
	Tue, 14 Apr 2026 03:09:56 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gdx4Gy3j2NBUtC+z3X7ZJ+GDg-R27pJ5AkZk7j8-36TQ@mail.gmail.com>
References: <CAJZ5v0gdx4Gy3j2NBUtC+z3X7ZJ+GDg-R27pJ5AkZk7j8-36TQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gdx4Gy3j2NBUtC+z3X7ZJ+GDg-R27pJ5AkZk7j8-36TQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.1-rc1
X-PR-Tracked-Commit-Id: d923f70e37310fe613883a3a4c2ea2f31246253b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7c8087a9cd8979d70edfe7c7feda9423feae3ab
Message-Id: <177613619518.668097.10095357921815572165.pr-tracker-bot@kernel.org>
Date: Tue, 14 Apr 2026 03:09:55 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Shuah Khan <shuah@kernel.org>, "Chanwoo Choi (samsung.com)" <chanwoo@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Apr 2026 16:24:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7c8087a9cd8979d70edfe7c7feda9423feae3ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
