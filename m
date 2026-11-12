Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508336;
	b=uNJ0HeuuUlXVKV8dcCkTcCkDl2bu2n50S0edPs9D5IsxLZfDoqnjRUYNDhkz2G0qew86
	 ouQiw79No8pplt1945Bt0MpVvhT8I0wWKoKsvFu4hoUngVTMKNyhKpo9wGUG2gNSIyilz
	 jKWIZtp15YEJFQZn6uGFndWwOmfNuf37VvXsjWBvCYbi3VR4uMwbuIy4mO4IREMTZEIWj
	 fXJUq3Xpnb9oCjz8WKXEgOluHqitBpoe1lo4gzdjrbZb+oQOsEg6qAM+rk0fJbymUcKZf
	 fdZWK+jF/6dK71oMQnv3dLLTaI87PKB8GuwC8D7+fxok9QrHSMzX7s7LyH2u1HSSFJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508336;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=fKgV3ffQA6k4sWn84cbSdD94+Xba4GL2JuI3lZ12ZtU=;
	b=zueouD27Y/wP7cV7+UlW3zeQcSlCg6boRaKdL+2i9sUqUINtnMAHIPnq9yBGl0nQYgsS
	 AWG8Gw07Ua0cgvGR3r7vkI2FMyBN0XeW1jr7I9vgL6NOvdjDogig51As4C/eSYa5CVejG
	 r8MTTSWzxVv21jgnWa2Coxp53EZCnKlNacwTEum0u1jOVEeoIEZykomX6Q8amgOA0Jypi
	 FAn4q855tvebRFCIUuKVpX7rCQ4R1uwfx/MiM+Td5UN1nc9DqngwoMVuDU/peWcVLedGL
	 UWsCIWEqgHDOSB/x0xUryQYuPrtN1ZEJ6GOjLQqYFFHCdVwouAJOt7hSRoj7y4rfLRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VekwJinm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA33606A8B0;
	Thu, 12 Nov 2026 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VekwJinm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0999B1F000C5;
	Thu, 12 Nov 2026 18:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794508336;
	bh=fKgV3ffQA6k4sWn84cbSdD94+Xba4GL2JuI3lZ12ZtU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=VekwJinmv5fL89Tt2+lnWleVPAtz5gNzmXkIqGEvUqbL6DOkQEJHif2seZtHZ8VKL
	 ZDeG2mS5iITc9wLa5Epl8NCh8NCKYIMoYLVvGNXbM970spEnB+laGpJPVDF6sGivHS
	 gevJWYMqUdP+2dc+Fb8DNUU0c3bGN+LZctJMGaR9TqpXwAigIHjZrJnVvtI9cCeDQj
	 AHgLPleZrV3/w3ruRlqcj2RMuM2pj061bNuJILAIF5KlvrMJ1YzRAZUZ/PWVwUXdou
	 w4Avg3ZNGTObqXRDFU7klDlUVPlUKnv3x2fjTsoaGXvYj0JZT5Oaw0e9RU1CEnnmrX
	 CUzszaRSAC80Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F14F3380AAFF;
	Thu, 12 Nov 2026 18:32:15 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for 7.4-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jbeLEdsBPW94yYQqxfJOyBBdGpq9x_OLcSyKzDHYoH4A@mail.gmail.com>
References: <CAJZ5v0jbeLEdsBPW94yYQqxfJOyBBdGpq9x_OLcSyKzDHYoH4A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jbeLEdsBPW94yYQqxfJOyBBdGpq9x_OLcSyKzDHYoH4A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.4-rc3
X-PR-Tracked-Commit-Id: df42809bd599109660bd3f95e2e22330c80993df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aed8bd53bcf522fd81bc883dd5ade2dfc42097dc
Message-Id: <179450833462.582195.6368771045076469516.pr-tracker-bot@kernel.org>
Date: Thu, 12 Nov 2026 18:32:14 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Thu, 12 Nov 2026 13:44:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aed8bd53bcf522fd81bc883dd5ade2dfc42097dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
