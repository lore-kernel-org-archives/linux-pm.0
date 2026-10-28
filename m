Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793211030;
	b=AHjO1B524yzlUIUh5rAR8S+tfTGuiPZR5SObyc95Y3xGuDZweuCqWB9TNsLx0qFL8XZZ
	 y5xRjxuYiqwozlx18uKp9a6XX8WXlK2l46Rffap9eTf/xpdJwE3I4b02hagkArxksWmv7
	 0QIUCKp0i8Ns8RdLMkArb4/couZ0VF86I/1vNe4ltoCyd9SVlOXrALFSM3X4QxqEv2feL
	 ZETK1Vi7Qib7536H1DPH8uKZj0uYK3XDDgBJa6kjvSu1rznUxK/PN2meXqnuiNbbWZT76
	 3Zq9Y02VTyJsjNyGtgDTwdG8a+ZB72S3p5e2vboaxzAWCn6jxd7VVwAlO0sAkLIlEKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211030;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=2yPSHe+Gu/WlQZaNaKd4WqCDg1xKSDejGLI5WPcYHJg=;
	b=BPerxDKWxCk71Q5vpQbEQhkoczdmv9k2iWbhgqPkIPiasV105U0Vl9nfTmKGO7CIsBGl
	 qWk9yYctjma/rMnknbKd+yQNu5untScJei4VFCbik1BEcWLCt7xWxrSQ6SnD3a/5gQg1i
	 fJ7F3niX7ld6cCEqD47clJD/Su9kk10IHkdlRkSlzP2eu7JUAVKZT9tA23ZYT3mdJdPQg
	 PQqzn7YAvpB9bx2UiBgOr6JwJ39chKsme8dcxI1l3PtiRfBUg77Jz1i7zaq0CPHTKI9Tq
	 SSp9ngJ0i5w/h2o2/LD41fAB8sa5BE+pHC5bnuKHzg6IxI5I4FFHDHb6R0Ww3kPfxcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o1FH1Xk+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2BD606A33A;
	Wed, 28 Oct 2026 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o1FH1Xk+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376191F031E4;
	Wed, 28 Oct 2026 18:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793211030;
	bh=2yPSHe+Gu/WlQZaNaKd4WqCDg1xKSDejGLI5WPcYHJg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=o1FH1Xk+SCSDxt5BvRg2uI7dZsN2oxTNbhdlu6h98at7o8upSrbtyRPa0kypRvqet
	 iqLm5Blqi+Oa8Pnq6xdApAKCFt5BYbr1tsKSuwI+eqsSUPINPjwR9Hv9tIMjas7fwM
	 LOh1UfbhjH/SdhIEV3MQNrPSBKJT+g13RI20Tf0QO0hw6CuSn92ix6zbUcohkNwam9
	 JOckOdDKB1eAXaPR+L9Scvxs1V6l7AkQK/YDM2tenH4OlIGQNPedNSNjhvb6JSYh61
	 ksb0BpBXPG6cR3isOZ+l35lVmBgWKn8mmQXXJaCtDfN0UHqXyY7+fxPjHEPkyQAxmK
	 o59EihkuejZqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 29A3C3AAA76F;
	Wed, 28 Oct 2026 18:10:30 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <at-FRLALI5DhW7Lh@venus>
References: <at-FRLALI5DhW7Lh@venus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <at-FRLALI5DhW7Lh@venus>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v7.4
X-PR-Tracked-Commit-Id: f0f400459bf6a037e70768de623fff3f8920b8bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ddbc782c0bb86c902eda146677087a6bfc398ee
Message-Id: <179321102884.1342141.12528462269560950088.pr-tracker-bot@kernel.org>
Date: Wed, 28 Oct 2026 18:10:28 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Mon, 26 Oct 2026 17:52:53 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v7.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ddbc782c0bb86c902eda146677087a6bfc398ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
