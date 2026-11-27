Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795813768;
	b=jnNnOmYwLlb1/z+VtBqo4qSHc4cSdGfTNsbq4K9SWaWKZvp7rJYhkXICIf18nPExhrT2
	 dTumc3ZCpYHxmE4W/PtBwG8dzb8pg2tXU2gXv3oaXLeSKODT+3FkAwR3xsSH0p1nry0fG
	 oS/hzNfZ7UXBmieCVNbzwJ2RfBLPVzxbOPliLN/uf7t9gK7DiQRep6bNAqosEKsP+MUTw
	 l276sBkBdV90TP57GmkMnwqIWn7uz2UGZaG6wID8Ci2DQFl2U14i0CnTwIffHSwtXZGRb
	 XSLACZ5CLHpetbmv/PFCQu0+bC8dACDvJnGgS7C2XMHBC7ZY6d2qa+WDnCFXFRPxdPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795813768;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=DtmulB6yiMkv0GbK2PIRZjRQgIETqaYOFdcaYpD+HnQ=;
	b=asgcp5TgIHGKC20ZA++SS1ScjXcEgqPemP82Q5X76YFiqhsWv8iEoBOu81IVCbUMgr7X
	 vBK7j0UJttRJIsTVkkD6KKx0G/D+4QlYmS7KXIWWbAaIMajk0HNNPPBncvoJj5Fw5tsao
	 jNIe33yzajaqsUuZNS6lCSC8I2kEgFHYXraQ3QLWl0MXUOfuNT8QVn5fU4QDcUVeXFicH
	 658AoxDDV+1dwXMAFDnGSs33e6+XQVQ07H0adp0QT7sueZHqa/WMEc5qcIppOgpDwhAcy
	 AEeWGd6fhhxSdKYl/WikHoFKqC6q5KXsvvLAob68bOsPqZQ/xQIaw8sbQBU55Txr1kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNDMVQWo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D98E606A326;
	Fri, 27 Nov 2026 21:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNDMVQWo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C751F00899;
	Fri, 27 Nov 2026 21:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795813768;
	bh=DtmulB6yiMkv0GbK2PIRZjRQgIETqaYOFdcaYpD+HnQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ZNDMVQWo5LfgAYisOmu8OCAzcukG+vBngJdXbik/Y4k8Rfpf7TdMulQqEzx52r9Cv
	 myUEyaE85lwJSUKHdgWFR5k95EaNzU+rIeej9cwPQfm91EYXQUpNiA5Gl5C01dGsgY
	 wSn2tGJL6IVseY15iLK23jp5ffrNkZ9DeCnUkaqs3JvIp/lZlcp26m6YLFU7ui3MXh
	 SNvkMKX5WEqU0HUJ04NoVA7t9/22kZFwz5TK5sWyQafBDJIE+3dTnbwQflrRqTPhs/
	 U4wzZ0UtxxVLQMHZfmyFNIO2vKGoWNyf0hUc4C4ep1AH1c4QZ45NT5NZFUycHH3eu2
	 X+eIF+pFGmiKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7170F3927065;
	Fri, 27 Nov 2026 21:09:28 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fix for 7.4-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0goDeyB0c_g5YvKGGZZNKaSLqWKkei_9pb50BHseizSmw@mail.gmail.com>
References: <CAJZ5v0goDeyB0c_g5YvKGGZZNKaSLqWKkei_9pb50BHseizSmw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0goDeyB0c_g5YvKGGZZNKaSLqWKkei_9pb50BHseizSmw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.4-rc5
X-PR-Tracked-Commit-Id: 52424a7805a05286743a5e9cb2dfe6548480b4af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4585067150b85e33f60876149a6e742928da75e
Message-Id: <179581376715.1686500.7665831420524155816.pr-tracker-bot@kernel.org>
Date: Fri, 27 Nov 2026 21:09:27 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, Daniel Lezcano <daniel.lezcano@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 27 Nov 2026 17:57:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4585067150b85e33f60876149a6e742928da75e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
