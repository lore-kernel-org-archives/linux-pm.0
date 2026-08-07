Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384C1175A84;
	Fri,  7 Aug 2026 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786112884; cv=none; b=liTqa2eDNRQkXHdPq447N7IhmlkzbMoEzBD9V8/rgkARdHp2at0yS+KMUI7ZaI0OVH/8nctf9eSn6nucjOoJrkjV4IYIMN9J4h7SBbKOW/HIoqzdusDBM6+lslb+dho8gajPLbxYb95zBnj1R3tHUV1zIOxBwHJkAawvbGnjcbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786112884; c=relaxed/simple;
	bh=eTwNuBsTrZiv1FJcpSHvo/FgI+9qYJDy9Oh5TeLcOLY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DV7/Kt1A2j9jPOgNrCVNIXGhe/0IpxPyvsq+s09Qo5zfhRXkMaB/gNmEiEjiEIEv7LNcXdaEbykZpVhb5HwdtqtKD2aXgCoyQZJWJlxNWAbDvNQlOVleUaau388/cbRXUOm79NLhbWJhRUkay3Uwvl5PZWE9ooLywoin3B0HvwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Urlo3nQI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Urlo3nQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6781F000E9;
	Fri,  7 Aug 2026 14:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786112883;
	bh=WXOBCpK5C0Kz6GLpR2E0EWdSyN9+ta5qJz5/lYNs2nk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Urlo3nQIRQsF1y/gLXPJYxKN25YOenzZ9u0zV+Pt0ju+nJxgUQqVKD+07nQvuEjgM
	 4GCkYqibdDjXMa9aC0/QEuTWzGrwApFtfyp86dKEeAwinCpZ0iX2LMEJt3YovzYXEo
	 +f55TZ3VExNAYPm0Z7AmysXr6DqPLulqglK8YF0Z+NEUkxDgoXtmqcz34R+/lxYbkN
	 DjMzBh/9eGtijJpv4bm9z89YyrLp8oLP6RcOtLvqhetUOfNFCGbOdTjOie9WWoUPnZ
	 Ky5KgNGtAM5zMOrnmNMhVEu7E2ltjyTmowS7kVTBEHDP2LuK8AplAktb/aamRHIbAJ
	 +eYyZJlUspIiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0D4B6380CECE;
	Fri,  7 Aug 2026 14:27:23 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for 7.2-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jEYTmtFHHiR5+NELM-xbErnhtP1JzqOseYWGqA6nnZjw@mail.gmail.com>
References: <CAJZ5v0jEYTmtFHHiR5+NELM-xbErnhtP1JzqOseYWGqA6nnZjw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jEYTmtFHHiR5+NELM-xbErnhtP1JzqOseYWGqA6nnZjw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.2-rc7
X-PR-Tracked-Commit-Id: ff8da20b6f47c48d46e47f93f7a59e2d56ee9107
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cbe91a4be8536a3f17fb00828fc3f024f0a1e61
Message-Id: <178611284159.1826887.13340841624235901668.pr-tracker-bot@kernel.org>
Date: Fri, 07 Aug 2026 14:27:21 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 7 Aug 2026 14:17:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.2-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cbe91a4be8536a3f17fb00828fc3f024f0a1e61

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
