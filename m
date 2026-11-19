Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795127215;
	b=hZ8+uFQ8LWXVl+ljIDpO/uj+mR3Qyl/cP1Der2/28+t8CozSwbmAP/tbBIWwoidAJeyw
	 tvAq19McElhNWtAXLimAlKUPpcc8/G/LhI3z5haITp0OcohztHDhOgP6cn1YwAEfWvjRB
	 EM1zmcGVXmy3n38jxk7kWNliB5UKIqy4UbkiqFRo+76J5gugcNzRpJ1flfgSGj6gPw0tq
	 /xKcj3wKL82lJzeIF9dfsW3dyxYT/aSwLoCzcS0ORA/+CPN6xgPlCN4/s4Cx8MPvfcsLL
	 OP64PUPaq+yUvPIBfz95ct5OqgFpCYqDtnmSkV9Du2kKd773Nt3Sgy++V9jsWoOSQ7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127215;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=a1z9qEU81LL2p42Z8/sX2sjizU8FoJhNrWW0/5knn3I=;
	b=QbOlCGaoxrCVSf6ByMVlLiqy90iAEUTwYHACiGeWklUb7BzUN1W4uYZFBFp/rsJB9OIp
	 CGbGpMXd9XUv1veOkunHFkZhAZlW4VqXMxhGAHTKDhzsS3UO2NvisPfUAvego9HgY3Scl
	 Kfx+oNF6rOwl/hWC/UHPF0T1cqfG/WV5lAuyBGzW0Mk2JH8I7t6JizcD43hDU2iLg7wmE
	 9RuIW/f4PxQ6ewHSjbd7dvV5gdFnbFNp4Nu4bfY4lZbx7phWax6ntHRhPhEX+RLNOEMAj
	 9wAk0/eVCGGSvHWMA7MVPdNxWr2LcTj76CDxyFIixM38mUOtX+yoQJCRgFwu7xR4IQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzZwee9A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B648B606A32A;
	Thu, 19 Nov 2026 22:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzZwee9A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436211F000CF;
	Thu, 19 Nov 2026 22:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127215;
	bh=a1z9qEU81LL2p42Z8/sX2sjizU8FoJhNrWW0/5knn3I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=EzZwee9AG01uphW9sN29wCRiDc2Od66uKyyx9vqo1YsS+WKoSLV45Zyt6EjybHA/S
	 noVH43MyEdU7WE7bj1hbe+ZuCvmFkNINzL7bRsBVI2lw6l8Ai7TLaTk+Zbnd25fwhC
	 0H9iZIlPOkdl9yr3M7/kunc3+4R9l1evMIGVVDmYHIzhNS1SHbjeFewhpFj+tr3f4z
	 k/MXjoretSqBVepPCDOi32BCQpNOFjk6g/bOAZ5BwUP2cw2YF76yofqIGGXM3tYs6m
	 dXReAXnvba8eWkwjXismFC7+CaEfQC4Vzdg/dCwLHSEsBUTyUi7onIO5QCcfVLdGOS
	 OiARAkAxhAEAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3633808209;
	Thu, 19 Nov 2026 22:26:55 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fix for 7.4-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iug8To5GYw_S_1=t+LAO6+tqYG0To7f1RtuONLiv9ehQ@mail.gmail.com>
References: <CAJZ5v0iug8To5GYw_S_1=t+LAO6+tqYG0To7f1RtuONLiv9ehQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iug8To5GYw_S_1=t+LAO6+tqYG0To7f1RtuONLiv9ehQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.4-rc4
X-PR-Tracked-Commit-Id: 22139b5a46353184f43d120b569b01447843d363
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3e1fcc93027bec7c470bc4dfae4716e621f5cde
Message-Id: <179512721366.3897686.3426832996533123195.pr-tracker-bot@kernel.org>
Date: Thu, 19 Nov 2026 22:26:53 +0000
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

The pull request you sent on Thu, 19 Nov 2026 20:53:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3e1fcc93027bec7c470bc4dfae4716e621f5cde

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
