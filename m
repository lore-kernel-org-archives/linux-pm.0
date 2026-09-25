Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B0F4E1C9F;
	Fri, 25 Sep 2026 18:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361790; cv=none; b=ZoCkWXQNZJEUdQZYOuWX04amEOBLV/djqP6WE/AUpXjodOpaEjRlavi6ixO6IgD/UWfuTMVJ+maGjzZx75HZ9YDKaqEaGhHaa/0gYg1FZrD4sH1l81jkikpLJD4q0VfzA7v32zUO76/h9mcTm7N+1ThY6vhBIzyICntMiMi34VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361790; c=relaxed/simple;
	bh=tNGkPnZLlPsGoudnJnJzV30AoDq1a85zUUaVc7o631c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=F5DO95W4wM0UPNjOEuPm7rFLNMfvzTABYJ/btSlyo4QmsRZbMcJE4kZWgp66aNwyvEhUwbyexaUvpEcZMMrE92SeRWwltdTlH/mO1F3a2VBpDwIJrFe6JwXtlFlv7hgw/udUFqgnkLFj6wNJsARyhKOtWQMBDgI/hm/cMnacI+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bK0gPtKi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bK0gPtKi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186A21F000FF;
	Fri, 25 Sep 2026 18:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790361789;
	bh=qr5AtcBSUpPM+rc2ST5WH7dZ3mtIJ3ojOLeedYAoM2c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=bK0gPtKivTD6nfuLXxQwsHS6Yq23qLdGkn/YzNG53y2wJzvYX2C2amjd9x3RfZLA8
	 XAoWaz/KwI+L+X8V5NMiWl2sFF6Z+QYPfTXmFA0fKsSGC/GJckUrLblq1/fbGozJMN
	 b4JsBNhJW/7ggfVVhNJfNvhEZFSMIXIptrfRQujcO4sAvUXTLWl0bVJlzaucdszGha
	 GtMXrj+KhCYQnzyJtkX0j0/YJ3hygibOy+sQj8xvwGL/fPtmae8E26PuFpyLJRnN+S
	 UbJyhYnO7HH3ggECE5xpwEgHmgoTHzAUsAignOzZoT2wgGggb+Vucy3WNr0rkZMgBh
	 rWw8y5VzbURkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C794380820D;
	Fri, 25 Sep 2026 18:41:58 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for 7.3-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jSaS=xp006ufiOjn+FXF96FLEs8_dawUgDqObD9FacLA@mail.gmail.com>
References: <CAJZ5v0jSaS=xp006ufiOjn+FXF96FLEs8_dawUgDqObD9FacLA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jSaS=xp006ufiOjn+FXF96FLEs8_dawUgDqObD9FacLA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.3-rc5
X-PR-Tracked-Commit-Id: 41112a787f9182c7f2d27122817861e3f22ef928
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ba51ef66a7773c2ce4a5356e2f97f5c291463ca
Message-Id: <179036171693.3089752.5263246120026183099.pr-tracker-bot@kernel.org>
Date: Fri, 25 Sep 2026 18:41:56 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Sep 2026 17:59:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ba51ef66a7773c2ce4a5356e2f97f5c291463ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
