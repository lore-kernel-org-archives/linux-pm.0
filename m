Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792629674;
	b=sxr/N1n9oLEQ7dgyfNtxHe5M7yZuhWn7f/pXKq/HBeJkOuTj+IQ77uOLvJO13aFMfUEj
	 qzA2wUZQ35tzsmM8xMbTFK6n2Mcf0C7q0BLkmKvt1DIfK2zZLgTM/WkLjoNfNhLMVYkTu
	 /nQmtgsKIaRTGkoUB4Ruw+G4ZxgoKFXU/xEMn/yerS849PKZ/sF9m7DhJorEkPVNgOat2
	 exgKWF6CrOT9NO4SoJZa5fbVpzZL6YszPX0s8tsWquJRjkZHrwNCTafM8x7KHENZC8zp8
	 V66maHP1cRbxfCDLj1kS18+vNjFcQWZCosSI5NyngWLWdFsjB1wYyW5Q04oCYgXGgVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792629674;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=jkSLV5hnId9MX4IRs6XHMh3z48IgTlOHlE1daB8n3lw=;
	b=nVcF46H86uWjTA7AKx09cQCrWCobrPJb6ejXa4Q2gsI+5fvKwYa5GYejTQIzjWMUzBXI
	 EOjLxrUsouejaok44LL8IK7fGC6/uudZ5XvDf6fTo3SEK2qshY1bHbO0K8VlIaKuhFf4c
	 7iT/e6TgYeMWSzn6nUVP3dWvXZk4pFzY4415Xe4CkQv3BpTHNcJI5Pi+yBytoPV27R2mw
	 2SOVGlHyBkE5RlhCrIDtAywzN4oAy6LcOyVBERAFVhA+YmatEYnntXLpJfEff7MOHfyl5
	 pw4zW9g8Cl0v5B24C4h9PAMrJSwwvMWYQkcSa9TA16yLlfiHEm1AgdhJeyJ7Y7mctRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RS4o8OPr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6289606A31D;
	Thu, 22 Oct 2026 00:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RS4o8OPr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2E91F000C2;
	Thu, 22 Oct 2026 00:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792629673;
	bh=jkSLV5hnId9MX4IRs6XHMh3z48IgTlOHlE1daB8n3lw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=RS4o8OPrJ558Aaw3WaofENp4tbANIeLXraXij3u1JaBkoMzxtvXjYKDMBM1bXjIbK
	 1s6dPzjcz6CjprRPqPSbx+KOeb6DdZxPCsoeIR6GcEXt88WrrEZfwP8WzwF44Lkxo4
	 78ua6jT/AmMvDD6W15v2iyNmepg6AM/DnBXOPjb25vsDm3JlYHjqVG14oxR5HIsOdh
	 T6Qs2BQjY9qkmnS3mLLzYDBOhKn3dLcO8nlPwZH2h8pdDmGxFweXXfjMPCf5vu8FE8
	 IU4gvNtR12i2Y0ebS1a9ktlmT4ZfEZY/TDWAuNEZCFF2PjFZe0I23J/WJAodQnWVix
	 Q/nlsbmGfy5jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4557380A963;
	Thu, 22 Oct 2026 00:41:13 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for 7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0igpXbgU7i0x87GZwhAOmMXeT4A4fnKC7y0MPB_CSv6eg@mail.gmail.com>
References: <CAJZ5v0igpXbgU7i0x87GZwhAOmMXeT4A4fnKC7y0MPB_CSv6eg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0igpXbgU7i0x87GZwhAOmMXeT4A4fnKC7y0MPB_CSv6eg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.4-rc1
X-PR-Tracked-Commit-Id: 6c326a54b0738ec3b2cc89e1da953a3586c6a8c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df37e3924292fb41d325721008520ba93deced42
Message-Id: <179262967255.1381797.5728625255497277598.pr-tracker-bot@kernel.org>
Date: Thu, 22 Oct 2026 00:41:12 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Mario Limonciello <superm1@kernel.org>, Christian Loehle <christian.loehle@arm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Mon, 19 Oct 2026 19:16:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df37e3924292fb41d325721008520ba93deced42

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
