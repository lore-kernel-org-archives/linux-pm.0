Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5893396582;
	Thu, 12 Mar 2026 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346419; cv=none; b=gqbw5j9cwkC3XwNg2p2d8RuO01pbPt3sOFcL1/wxZdtn+pWQkKbrEDHmlm/sg8pBKG2PTqHwGZulQXbOzZtzHi1BeMvPqxkDskX+svsy7ZQyX9zd9zC+OgqGkTmIIM1NjDzlJEGsVlhbrj7uyvFAfTug46JSMzThDJamUiiWbsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346419; c=relaxed/simple;
	bh=5pQfjspSXVRs6CBUVZ6dsJdFEKAp88wAqpwRAuiEoBE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IP7E3sfqjly7jri6Ox1+AWg5ru0WseZajYXv6SARY3PAIeUX1fgxEBd0ur9v8aj0ixnEt/ge6nc4Fm7B7qbW8Qp3gLBcCew/TCEMO99nyJSvoOT3WnDhuEhi3zqTkiIfly5fY8tgbIGU2TIwcDTrPwlYiwie0dC4L7gHUrz04Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCRj4rxm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCRj4rxm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1401C4CEF7;
	Thu, 12 Mar 2026 20:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773346419;
	bh=5pQfjspSXVRs6CBUVZ6dsJdFEKAp88wAqpwRAuiEoBE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rCRj4rxmbCfXsIieCKtfi8x3I9zRevyFmAvazzDPsant+XyyGG+Mk7xIq4j6YRZFE
	 MbcKfjj+XVmKbeRQn/yG8C+A/hzG49M1OabDrD2lyGXJikHdc+8NKZIzyr3qQX5T/p
	 gocKv/P3XdJYKA4DifyRQR+r1evBVO2zytwd8PHMQJjnDwlwilcCDeJTtOjS9x/Nh/
	 BF0V+h1WXCw9wDISiG7TQRMmcD8BbvcYibFUBizRq4bDsgJ0e2NvBc28pvzVN3K32D
	 qdKDSak0vyQR4zwqPMsj2o0GPf77YRh/gbukF8kiF4qIg3w7PfDTRRr5CI33ew5y1j
	 4KO76Mn2JkcGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF763808200;
	Thu, 12 Mar 2026 20:13:36 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v7.0-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iXTPTMm8k84CwTPUBRmiDNVA3CnFsg+xHYWCApP38=EA@mail.gmail.com>
References: <CAJZ5v0iXTPTMm8k84CwTPUBRmiDNVA3CnFsg+xHYWCApP38=EA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iXTPTMm8k84CwTPUBRmiDNVA3CnFsg+xHYWCApP38=EA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.0-rc4
X-PR-Tracked-Commit-Id: a076cc74744d83fb9f70147a154b99278945a3d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0257f64bdac7fdca30fa3cae0df8b9ecbec7733a
Message-Id: <177334641495.540061.12939927301704762246.pr-tracker-bot@kernel.org>
Date: Thu, 12 Mar 2026 20:13:34 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Mar 2026 19:19:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0257f64bdac7fdca30fa3cae0df8b9ecbec7733a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
