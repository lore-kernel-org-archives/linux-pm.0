Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793403206;
	b=f+BRTsQdbaxZ1cSFkDNAqMBPz989BX0nX+s0tp9KPmVrJyrJKy1xERqCy68WL9P8wQlz
	 RZmECcc4Zq56FZeyqReNA67UQbFI0rPhR9DrWoyfeDWit6aZrQgz68P/mWEtSRAsPQtiY
	 XWm/KS4QMZ6P0Sd7hgpKhxIawkHFe3kTfIKHNsrnmxUlL9FINPrkrJ2MJkJ8FqxfmsbJi
	 pBoOi4gelffJOUtGC89rBvK3uvWZHsOGR+YoY7gVXNG+5/UyYCBj0iDsEJ8fA6m7Q8jSi
	 gPYpndLum3lDZVtGgO7IGqG71Am5pentrbP0kYY08GFRqRU1kNolNns8rvUsWCKApHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793403206;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=E55Vhn8jWOeVhGrDIzL15nS/0d1shu5nieeTldT6VQU=;
	b=Sq+rbf2BdwSrBLuWUhOLRETwQZD8NMHa4txMquPp+RzsFh6vwG7k9GZiJwfbMAs4LFqM
	 DX4pgWxHa1VOKsxFsa80Dkrjpax38UTdPQpzfSAIkDeHEIW0r3fRqNeX+z/qJONHfN1fh
	 iMNYdRxMr6NkfnRVfXooXkK/u8IPsv4bDUWPD6kmpZTZ4wh+FfrI5+HxJ8PrUxDwWnZa9
	 wZHYdEWYKRiGRmiY+0V4w5Jog/naVX/W2V4FPGuImFDDcKXnCUaJwUWbSPEHfCnxqpDAp
	 Ofu+2Ce59zJcH6/Ahf6pcGuYXFR7KHI234aT9dhheWBhVHijOyNaPl80MEX9YS5cAEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cua8ds3z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E255E606A31C;
	Fri, 30 Oct 2026 23:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cua8ds3z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854D01F000C1;
	Fri, 30 Oct 2026 23:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793403205;
	bh=E55Vhn8jWOeVhGrDIzL15nS/0d1shu5nieeTldT6VQU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Cua8ds3zhYVKhe5soZ4VD8spRUa3/wvEPWa4C+L1BrPwv96+KsdmcVmCQLG50x7T/
	 oGC+dMefNmAwp4ykzNdnnCUjIVZHGanQeqIoDIzDhJDg91uXSeQj74w0lXrJiS30gu
	 eE3/T18vIBqgngwYAGrUZsJwquqRnr2tk7THGc0YYNYW1TCayAkmGkp99iPKIg3xxU
	 bpTftMSSouX5H3Om79A0dF1M+F+glBNUWvwQkvpmWsuyBRQOpA50mjElLsg2cnJRT0
	 AyDHv42Q1aWxDu4aOwM8wyC6xuYibzAaYWNQksNLYdkpElQjSNm9k2JOEH5ozSe7CW
	 twbYQU9M50/hA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D26C3800478;
	Fri, 30 Oct 2026 23:33:25 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for 7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jSxPop-hQ+2+cDRihaUWB3ubNJEcW-p5VC--W+Xfr0YA@mail.gmail.com>
References: <CAJZ5v0jSxPop-hQ+2+cDRihaUWB3ubNJEcW-p5VC--W+Xfr0YA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jSxPop-hQ+2+cDRihaUWB3ubNJEcW-p5VC--W+Xfr0YA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.4-rc1-2
X-PR-Tracked-Commit-Id: 018f42c9ac5fa9701fc09514ed0739ab72708331
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7306ea08c00efaf6406281bd113f7d657be2e6c8
Message-Id: <179340320420.1831258.3972115184942752225.pr-tracker-bot@kernel.org>
Date: Fri, 30 Oct 2026 23:33:24 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 30 Oct 2026 21:25:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.4-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7306ea08c00efaf6406281bd113f7d657be2e6c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
