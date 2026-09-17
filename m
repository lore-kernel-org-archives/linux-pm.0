Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A2E4F7CCA;
	Thu, 17 Sep 2026 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789665221; cv=none; b=lnCLenOGpqe/+wc2R19u4W8letg5lVgBM3aQmcvcvv+f69G4AjgjVtVoDqy+ZuSgZLPcNqRalEvg1qa5HevmJx8AB2E73QRuDw0ENeJo1RMZOJI53pxf7w/aoWFNXk+yffg7cp4wnH4KIcI9si5N1XrZImWh+7MO9d54D7DX1UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789665221; c=relaxed/simple;
	bh=IhKZeT7nc6AX8Ra6U7tmrqmPEULR1hogtGxYxcCON3s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QO1YbVa5DQwb7PnTK2550v1SiSaCX8dN8JvO9azyMQBav6tMRBdqoI5/bm512iBCfS/iwC/0VEVUPZvECTlXAFX3wwlBhfrnkdI3uhVk3QsmiLNvhcEmg2eaTV6OUjZn2a4wmWT+2lcL+cdi9RyEGoLrn9w9O+qo7TNzyze6LCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0K/Coad; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0K/Coad"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8221F000FF;
	Thu, 17 Sep 2026 17:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789665218;
	bh=htveQh0RcvfgSmJFALoXUqaX+CYZp3rUc3N54AeNyiQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=n0K/CoadakRAxKvwTfe0gI/UZXtLOc1zaFcr2r7CJd9IHy7IYjoe7Dk09Ww/vFay/
	 oKnGsBv79acETo4YfR0VXLyh6HnvRPxeUG7NNbFualKyNEv25PbxUY/UeUYPcrUdAA
	 FD3VP6GC7mukw4ELix4Zu2GTz6ByOmTqkSE7He3n5BMCTyqdm4ZZEcyBqcfHVWv1U9
	 bnGjIb2p3ictV2RqLDPCucm9Bv0nZ+GBgpc03LfXumw49by1GawFP92sC71OFhEhCl
	 Ojliilv5WP3qEnXDg8BymT2ErEpTJyol/ETo08xbcO8ajhtAmxT8NrRW2ZkugQ5w29
	 qA86hQ8cVEvMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B5E381197E;
	Thu, 17 Sep 2026 17:12:32 +0000 (UTC)
Subject: Re: [GIT PULL] power sequencing fixes for v7.3-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260917093904.6692-1-bartosz.golaszewski@oss.qualcomm.com>
References: <20260917093904.6692-1-bartosz.golaszewski@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260917093904.6692-1-bartosz.golaszewski@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-fixes-for-v7.3-rc4
X-PR-Tracked-Commit-Id: 242da4318d97380741516b595af3920207b2f0f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f143ea21cf834b4d57d70b47b99e582461f2dfaf
Message-Id: <178966515149.3773542.5095924675652747761.pr-tracker-bot@kernel.org>
Date: Thu, 17 Sep 2026 17:12:31 +0000
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 17 Sep 2026 11:39:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-fixes-for-v7.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f143ea21cf834b4d57d70b47b99e582461f2dfaf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
