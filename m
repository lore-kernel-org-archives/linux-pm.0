Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F417E4E3EF7;
	Fri, 25 Sep 2026 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361792; cv=none; b=cSehwL3sHZ1/Xfv29Mi9rzcYwVs4u28+ae2UnKwvjvtB9uIjpD0cuS/OuiKY/Du0rn/PtFB2SVZpFdeO+ocSIIWAkf14++VNFugtDfsOgNI9wT95zpcbfE44qQ/8fhA7wcekqyQTSZmigZfYvVeRrgfKZVXFiNv4G9aVmvmoX0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361792; c=relaxed/simple;
	bh=hRfOttLxnetz2KLjoPcZmLIOMMIYkHsD4Nxt38fRET8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=njG3jvS8tnKb1RiFbMSFCK4e1xgPxFCV3JAAX/X6jCGFL4w20HY5icuVAk9Xc8pUJwdLL7GQ25jd9X8ZTrtZ0hZhIaK8mQV4pHOy62GO3GUgnjUc1kLRE/0G+1rNrl3WDhKdwyW/d4cHpDa6CQSpEW5OVYKkRWaeHuqsXK049/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sql5nGYM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sql5nGYM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887761F00893;
	Fri, 25 Sep 2026 18:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790361790;
	bh=tebNaOFIklsPnL+9FU2Y53rCCuIJqc9ve4F2ku10fn4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Sql5nGYMbS4VvnwEndYGykc0SKmgea1wNvHgA89isRBwxrwRddNl+Gt1JH9JCKW/5
	 bdxczpp8BIu9rbm5xQ61biSoBilnZneu/gvWEw0hpBi1zG0eyE51DC4CW1ImcCe1Op
	 GgM/Oqh71fWFh9azfmJGezWgQzhAS+zmvQzyNOF7e8Lh+d5BoR35xfxA43k9mVstFQ
	 CVhp6B2aUj1kAaTdVToO8JvZiwnj3NT+TuojLLyxHd307sVrF7zE4XRp1EEj/JKuCJ
	 /w5DBb64rJlTyp3W4udPdkKE+YmZqFNZocx+wKDWi6T9EccqXj/Trqepgo8SeiWp9q
	 E3/V9WTs7CxFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8E036380820D;
	Fri, 25 Sep 2026 18:41:59 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fix for 7.3-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iAT9B4aAFDTZSpDh8Tr9T22QFmavRvr7CP6kCLcJOQbg@mail.gmail.com>
References: <CAJZ5v0iAT9B4aAFDTZSpDh8Tr9T22QFmavRvr7CP6kCLcJOQbg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iAT9B4aAFDTZSpDh8Tr9T22QFmavRvr7CP6kCLcJOQbg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.3-rc5
X-PR-Tracked-Commit-Id: ec0d89150a9381d591344a9f6f5428655c227a7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9dbb658e2101ea37ad6953eb4e2ea234dd9681a
Message-Id: <179036171827.3089752.12167243141375849925.pr-tracker-bot@kernel.org>
Date: Fri, 25 Sep 2026 18:41:58 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Sep 2026 18:01:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9dbb658e2101ea37ad6953eb4e2ea234dd9681a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
