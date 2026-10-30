Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793403112;
	b=NQlxeN5lfs2TZ9FYZpiqgVWccFOyXBUZs4IbVZCFe9WCMyGm/jvIvpQ3UIuhCt3uRIMu
	 VQMiwmQSuiZVhzz+9yMpsbXPim9tY/dp6sSYfPMR/FskNauwCXr8FwU0lCehZmhO/0o9M
	 3MtrJ3bNS0y0nyAfPhM99lmK+Yujx89Vy+R9Ag6aXwgD3nu7yTVF1jc/PcJJsShT5nO1q
	 a9lbpaR1Icnwt7++1Aq2EZ6fKgeThLdIEaqRJEMCWbcTFk+Dmt6ff0gBMnOX4pCrZ/jlO
	 bg8TdhvWszfGuptzSBe798b5tZcnkxItlCGWf/hooLhFVvWN90ZfZmzniqhqmMWUrwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793403112;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=UZfx/Hh7lwBXVLcVEYet8mPN/a76aT7QljhiQsVsjDg=;
	b=N18GYsnHkCnmctY1rQTi5PeXfZjTxa9UScrCdI0svlDAc4bzlZ1/clSv/AAYB4xunOk/
	 gJFzdvbmL7x81Usm7UROCBO2v7DJNY+tyAqKBgrHuqLBmqUfs7ZAaCpaEaPVCRxlHEFgA
	 02RQpelG0fGWk4p7ZH2bwEliKIkbGmQ7T5ZcsVKAfX5O3/OEqwqSzsesJ2NYOn2Eif3zB
	 RPprhilg4brEMlJVIJWOyiYWZGQog8zj6n7PudRyZB31CcTp2cZAbm/35mGkDIfK2tHOa
	 jnJ5nE9Z+HbEi1C7e+H/IajqlQvQ0k2p5V9wdcxkoGLK3d2SnEWhWLyf+eAKpv+nz+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aGOk/asG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7284D606A31A;
	Fri, 30 Oct 2026 23:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aGOk/asG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAFB1F000C1;
	Fri, 30 Oct 2026 23:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793403112;
	bh=UZfx/Hh7lwBXVLcVEYet8mPN/a76aT7QljhiQsVsjDg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=aGOk/asGsWQiZXc66eYZIZVOtUMF6mDYn0qzXKqUajHcF6pBUoSp/VNzDzqvZrqB8
	 3gQw1JNz74lSC/gKwMgEHs3KGdCYE9rI9h7N/PgferFz7rGENwWV80Ghu5JNcIRd+J
	 LzvcOqQHDclFzOqx8YY2sBTeJEhnh+Eg+ln4/FU7lV+ZtgYX3Wrj6tXlCuGu7rcMJ0
	 EsLRMB3dSFJkV8+T8HxqNdx1BvBmK0AtlwbQbrseqhSC9nKo+qeGuYGBi7Lxu3wQPN
	 kzTjCJ+mFXuMmSvhhP6/6zUwtTNWKjUPl4cyXRDlPzStNX5YuQeK0OXWkdKdeUuomN
	 /+oWmPP1kqugw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0356A3800478;
	Fri, 30 Oct 2026 23:31:52 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support fixes for 7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jsHWBL0901EUHMAV4ZzfAP54_W2ag8qEo_f896pG6dUg@mail.gmail.com>
References: <CAJZ5v0jsHWBL0901EUHMAV4ZzfAP54_W2ag8qEo_f896pG6dUg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jsHWBL0901EUHMAV4ZzfAP54_W2ag8qEo_f896pG6dUg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.4-rc1-2
X-PR-Tracked-Commit-Id: 3f971ee94fb57377f0a9d5a8d190d1d465ac6b80
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3e15872e77f3feecd831eccfb753b9af916f387
Message-Id: <179340311063.1831258.12731930536422741927.pr-tracker-bot@kernel.org>
Date: Fri, 30 Oct 2026 23:31:50 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 30 Oct 2026 21:21:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.4-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3e15872e77f3feecd831eccfb753b9af916f387

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
