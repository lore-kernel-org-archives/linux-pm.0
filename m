Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792629689;
	b=P6PBuqyJZXwwEh+Rr1O2st5JseOefAOa3mz20Vg5InNaVrblUTAoN/MqFb0LsbSw2x2m
	 2RW3qEaUhJF+/mEUtgN7BYE/8GWlKhEWn4P3/j0Pfct0zSBIToGnmeTauVqSkRGJEEF0q
	 S4ubpnyJsUaMGNsQe67jXOcD4BvPCzXrn9O+8CZCpyNWeqGOe8RSXWiOLPYs+8br78w7+
	 UrhNQzbQfsOnGRM0K93LsxtAnvQ/p9XAFJEfLE68AU7cpUkls8LvtMiENODgYdW76GTYw
	 8wIKcMYVUZDDNFB0kN14X0LMXJXVZ7EUYkxm9NyeYeNjr6/FwENhKcKzk3ERzLsD3+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792629689;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=0JMQnG3ZZBP+/9NyLhM85piBlp23tY0DuxQYJlIP3HA=;
	b=1FTasfAkSIDjoplDbsOhwUwrdCcMyk6MCMzL1OEGvEWo9JWKU9NIExJEXXulX7mjDnQI
	 CHq9GtUKadL/no7pT4+H7C04iG5rLXUiCg6iyCSgqkJRDnmERLw02ygCMwumKlnVw3JzU
	 7of46eqhPSM/mckt5PwTchoZPKJs+nrrjb0dh4ucHL4L1aGj/c2ISe0dH4wd4beJgdheP
	 PCDkOzKZ8zEl30dnEF8DDQ8+HoEmmeilV8QFmTjdOI/PODEPVQelmLMLqz51hAYPIkK6U
	 qosgvG7lgi2cTQQSBqxT3Vq5wTYAQHIx4ac2bKY3zrrhhQjSi0iSr/a3xcNR1fak7Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iW2olH66;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CD1606A319;
	Thu, 22 Oct 2026 00:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iW2olH66
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EE81F000C1;
	Thu, 22 Oct 2026 00:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792629689;
	bh=0JMQnG3ZZBP+/9NyLhM85piBlp23tY0DuxQYJlIP3HA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=iW2olH66vXKkzhUtRev4oedZf5TwX/4RiwT2Sgkw+ciRAS9Y7B/zMnzSogHu9ZBzk
	 /EUxNjo/oogxa/EYvG48f9F1W2zK87v6kJN+nvIm1OUxBkojPPbafsRLUt8oDr2HW7
	 9zHpS/xj+M6/NgYaWHto7kNhmDB/7rvRMC8/bAk5C55amxssiq2kXZXGImcfiTnq9T
	 IlWpmIWdp/uwrDMI4kAPxGONetdWLNdJnWmpBf8NYgpWjMkCKquXrFhUNucS1EtkGy
	 NdtpSYGqRzZXg5XokAwldiJCbBXinnSiY9ivDu3USmrWQiLasKKy5uBgyFmGdaSc6T
	 +eAYVSglpgimg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1320380A963;
	Thu, 22 Oct 2026 00:41:28 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for 7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hEkwqD4znFgQBtXskpiXXo52gNp=KbzbeqOW9g=ZGpuw@mail.gmail.com>
References: <CAJZ5v0hEkwqD4znFgQBtXskpiXXo52gNp=KbzbeqOW9g=ZGpuw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hEkwqD4znFgQBtXskpiXXo52gNp=KbzbeqOW9g=ZGpuw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.4-rc1
X-PR-Tracked-Commit-Id: 503bb6e70bbf6304b8113373d09dfffcc4aa9183
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4403278e4ea2f654f8130a5c03eb8b4516a0f201
Message-Id: <179262968757.1381797.7368750239198889873.pr-tracker-bot@kernel.org>
Date: Thu, 22 Oct 2026 00:41:27 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Mon, 19 Oct 2026 19:22:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4403278e4ea2f654f8130a5c03eb8b4516a0f201

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
