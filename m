Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE147274670;
	Fri, 31 Jul 2026 00:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785458727; cv=none; b=hjTd3QlMBKCdvcWeEANAeIGDFk9bU5CLoVG60bPObNwJT/+YATLPK7BAJ9s6dHVTRe1qt75p+odqfkl9D58P/6a5Su0Ax+vFs92ew+L4+ZQuWnGDrcOVY7GnCeZvijk13aYT8xb/IyuY/LKnCyL9cWIowurVzglzJoZZFZVGTl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785458727; c=relaxed/simple;
	bh=6KKc07WgqqIL662FfNCepk5u721cGkp9gK1AF3UeIvQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hIP5pg+CiFwVejPOl5XsJ0RCl3e/W8eULGmI8atNxk4zE0GgK5U122WLlwl7JcueGP/aXJnMEKzB5VxA7trjFdDZqjwuuLZMP8/5iwTNfzTWCImDznCLL2a+Vb5lNxYiUz9M6jkN1SvhnBh6v25Kp1FzqYIH47EhvFHprT/9iv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZm8xUl/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZm8xUl/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0CA1F000E9;
	Fri, 31 Jul 2026 00:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785458725;
	bh=JmcZx0V2rYhe8LS5CCQbgwtoRNosZ/LFLCzSOesZE8Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=MZm8xUl/rmjPt0v6FaAayLZjx6s7EMtvCbJSKAmJSLKjwRomP/ObFYs2riq8pos1L
	 ORxuvMw3vz3r3pM77hHfGXmgyb6Z+py3II7OwRUVTKRj7blVnByoVkSqmcKQMgGeD+
	 arL0j/gJ6Yrn8lc9H5vdhBwSO/KBzED7GClq1tSB+OfEi5tW97fKyx3cLhTUqx1RN1
	 e7RSLC8IAw/cHi5Jta0lTfRGnupmwONkiGc3pFDcdRIfr3N4OCQYU0J7IM4Ext1EJ7
	 i9+MFgx3lsEVHJuFaTsTPoGIYJQrYgmbSAMTKR2TscDw+ce/vq+T/APZ01bpfPhZNf
	 2m5zqgj22J7pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A7E3924472;
	Fri, 31 Jul 2026 00:44:50 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 7.2-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <amvRQlU7ArDfz5yc@venus>
References: <amvRQlU7ArDfz5yc@venus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <amvRQlU7ArDfz5yc@venus>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v7.2-rc
X-PR-Tracked-Commit-Id: 160a783aa65b74782bc17cb874af1a6d3f5fba3c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a11f030c83e6a13f99645e3f4b24befa4bf9efea
Message-Id: <178545868870.61505.4216642601657980273.pr-tracker-bot@kernel.org>
Date: Fri, 31 Jul 2026 00:44:48 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 Jul 2026 00:36:14 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v7.2-rc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a11f030c83e6a13f99645e3f4b24befa4bf9efea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
