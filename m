Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98282E11B9;
	Fri, 26 Jun 2026 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782505960; cv=none; b=cs6NEdySL+UI6nNJjjNjEQT2ZVp7ZW0Ra6UgJ/EcvzcElSu/S4rVrBt4d3kb/pl9+dlURyUIjGGyzzgmpQMX/+aLxvoRiJobjEP7ZO7oQ1nDWKfk9KFIfWUqDOKBDK+LWQoGEbCHXcyBMR2nGva0G6VgIgpLWVjsDHl0Aa+8MAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782505960; c=relaxed/simple;
	bh=ECV9Bdcfm04B3ByeL7P7c2gyehvaBXnMn4fUEAryQ/Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=py6KxmyWF32HvfgWU7UxCR6KhWRb0sazdF6nk3C8lhG/hUdnJ4VXtwnImMlnjFBgz7f3Lo73zEcrOTXJo8x6KFRoX61GZ39HFzPHiviYaScUyE/PlW05DWhMNPNSIiD10pOp1jo01TGpODLfn9v3GZjows5R5a36U9WINSb2Njc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1q8g7Wq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1q8g7Wq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C131F000E9;
	Fri, 26 Jun 2026 20:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782505959;
	bh=PZvdvDPkNb8LQ9su6m3zHxWF5BTdmuX/Lzl8EPCE8rQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=V1q8g7WqpKGX651Vq32Yme8FbCCwIDQfpUFfQqayxLibYXm/Xp0Cw6SATob8Jsj/N
	 Ha6YsJ1PnKG+ahnoGhCdunACJNxTV5YV004XKR4G5k1PJfC4IKlY21O34BoS5t5PBW
	 jnSQ/PeklR4zVYJ2e4kDk1PB1JnGn8RRwHkscSk5jRvuZKUJxAWAugCNDVqWm8Y+RS
	 ccsuvcsFyTYOcoAaZFWqrUe4beSpLAEptxIf5ifGBc57gCG7Wu0wpHAzwBpJw5Wdgq
	 yGqKpG48n6WYiZlMTo6A4a5jEyQRfEcdaT818eCc873gHktL5ciSl9fukGsS6zSR/h
	 xX8aZ/Wh6r6xw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569C33938C5D;
	Fri, 26 Jun 2026 20:32:27 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for 7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ht40XZr9tnHJc5v_LPNNNnW7WrX7E9A7G+4irJAfZvcQ@mail.gmail.com>
References: <CAJZ5v0ht40XZr9tnHJc5v_LPNNNnW7WrX7E9A7G+4irJAfZvcQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ht40XZr9tnHJc5v_LPNNNnW7WrX7E9A7G+4irJAfZvcQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.2-rc1-2
X-PR-Tracked-Commit-Id: 3a2976df778a9af95e91f7ff88008b4517ddc658
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e27d4bbe0d7380d9d26910de70541af6e77c29ea
Message-Id: <178250594597.1084729.1525163697134180972.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jun 2026 20:32:25 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jun 2026 19:55:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.2-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e27d4bbe0d7380d9d26910de70541af6e77c29ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
