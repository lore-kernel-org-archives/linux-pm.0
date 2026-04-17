Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A3D28C87C;
	Fri, 17 Apr 2026 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776451820; cv=none; b=dLm0OdVB2yEJ/OakhewHg0J04dJnN9gX87lmfAghBeS1a2gI/jskdJ6SZnGULneUMorVvXHI7Bp16oOP7pgni2XPV/4DctBAfKij5X92Yt0lX4IRItk1P+N2ce+j9c0cZgvHOend/nA1uRFYn5m3Xz0sA3SId9vLzFBy+JN9g8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776451820; c=relaxed/simple;
	bh=uQ5wrcyvvx3Pty2QrLHp7jAgYNRAqkv2JtjtytjvxbM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mb4OEzBY1URvdPbi4gOzWQd9D3B3FSASBKgzyzMHdMKmGvGwzivVChYyMmDPr1HZMDBNLiLVnqDl5wf1sfaFQDnq494xsw/7kqMPesVTCQDZPtOFFOplZBfN4D0hIcBY8KlIkAskEEZB1h1fFRisdvZvh+BVu9ybTEOGRCvKcGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lb86Trtr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lb86Trtr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C417C2BCB3;
	Fri, 17 Apr 2026 18:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776451819;
	bh=uQ5wrcyvvx3Pty2QrLHp7jAgYNRAqkv2JtjtytjvxbM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lb86Trtr8zLkdXuo3A2mpuYkstbI/ikvnWVDYhbi3DEN2wmVDumFYioKtIOXY4bp+
	 5jjKxNO7WAJJHcg0n6JPRdc5s/wHVuOYjcDzJrfF5MB41KcQs0eM3m441Vu2p2UFoB
	 7ZJgnXSsoB4Iwxn2Kk7BIQ8EQrcrW9hRcRaahwwnRW0ug9flmZBdDW96vu0k4Ez//e
	 WimIGyKSPG+TTrz5ABIpv3RwWlRmIi2DIB7PcI4keDI7jF/ZilfL3n70xBVxHg415t
	 2rHapfpQ5TM0Y7aSNsTN271sGYCOQcTw/x4j3uNvKGsQ1s6fKnfofeFz0V0JBU4obS
	 he/UgYEXUlQ0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A89F380CEE7;
	Fri, 17 Apr 2026 18:49:48 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aeJTAaRJ6lh1wBZr@venus>
References: <aeJTAaRJ6lh1wBZr@venus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aeJTAaRJ6lh1wBZr@venus>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v7.1
X-PR-Tracked-Commit-Id: 98d68b74ebb9d5f145960ff7d96ce8e7a39fb965
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 59bd5ae0db22566e2b961742126269c151d587c7
Message-Id: <177645178678.115481.86226222219777797.pr-tracker-bot@kernel.org>
Date: Fri, 17 Apr 2026 18:49:46 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Apr 2026 17:41:25 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v7.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/59bd5ae0db22566e2b961742126269c151d587c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
