Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795127213;
	b=fAWCy58GfG4H77NnSE44KAL0fiEr8pJ29zwRJmaUIxhqYHDlHq4cQmPFiV2Ug2Lr/qe6
	 E7lJS7avi1HlvocxNucdy9qGBjxzFMJzO1HCNpFC4A8t4xTDkYUHZK/rOM6xfLWN1okfC
	 LJJ1MG3AbQ0GGBoI/F3h4NoqfZKlTT2YrjHkTXOn+al/5Doz3sVzneQcO0oh7aMDHYgVh
	 RePDg5La3HISiYyWQERMqgar3xXQcAXk2sAFuSqMCH5JuwLG//Sn/oaS2WSY5Z7CPep9U
	 LfIDdusOYFJgZlpZjHaxovxiev2nihF95WrAbC79L53RYvKe/XjczGgBz8VMaQV2Crg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127213;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=+h+rWdX8kdxhi0nCHOhMfS550/Pkwiekc6wuXKTeUF4=;
	b=2biBJU/bwDWV2l2pOOMbbhw7MCDRDPhR3VdQeKuMzungtFELwYyRPxCoLELHOhheOOWj
	 fUWwiC6yUsUf3OHLlYMQcJJJ3eOaCYo4c+mvBDqO41zIKuEHjdHSuKTg0e2yhiEqEueRq
	 EfhgnYxV2uG4m0s3vDMezZTB/NHOv2EkpiCs12WEZLJkTtkXVB0YCv1g2w1Uq/B/UinLL
	 azoQ8wr1IAoOzmOaIUGZY+LQBCyPLEFGTk39dEFrlbF8RrI56bBbhI6K3mgFTym8eIZer
	 BqD3noEbQ3kFdoOjdKe8u0GEqdI2QYG0wrGJICiRic5q41621BBdwXA5o4Rfga/gj0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vhyvrrw5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658FF606A320;
	Thu, 19 Nov 2026 22:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vhyvrrw5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078891F000C4;
	Thu, 19 Nov 2026 22:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127213;
	bh=+h+rWdX8kdxhi0nCHOhMfS550/Pkwiekc6wuXKTeUF4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Vhyvrrw5SQ8XUZb4+W0iFyCwJQzqvNXGkL9lT7mciLM4hSNXFupQ9FjSA1KaIQlaL
	 ZVVjOGMIPhvFVN9S8LZCwRKgsKMbohwtvz9x4sWvnluFGN1ptd93m1+bS4z8U8wQ/H
	 yjxLG8KtFwE4bcsolZH6ZAaNxEHS1z3ZlrA4n2Ssd/XoJPWIfZzcbEZuGlZ3zlEr1q
	 7ul6NwrhJl+Wq/xyxDaLcVmlzU98AUq89UdYhpw8jxwVL6VLwiAsmbnJFFBDzqwy3S
	 OqxwseerGtcwplGJXg3FBNEyQZCzxVFTGuB6dN119cuWtejIjaJUmes0ui4ZtxAzTp
	 fLa847jhRp1ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15EA3808209;
	Thu, 19 Nov 2026 22:26:52 +0000 (UTC)
Subject: Re: [GIT PULL] Power management and ACPI support fixes for 7.4-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0izRYXCE-EMaA+Q80q2EitZbQ7BGN383mnXR19cx77CWg@mail.gmail.com>
References: <CAJZ5v0izRYXCE-EMaA+Q80q2EitZbQ7BGN383mnXR19cx77CWg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0izRYXCE-EMaA+Q80q2EitZbQ7BGN383mnXR19cx77CWg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.4-rc4
X-PR-Tracked-Commit-Id: d40cb8a12ed25789f39404c5f7968a65e98d89c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75099ce6829ff89464cb7dd32471024c6c17c1de
Message-Id: <179512721160.3897686.13753804108556699714.pr-tracker-bot@kernel.org>
Date: Thu, 19 Nov 2026 22:26:51 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Christian Loehle <christian.loehle@arm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Thu, 19 Nov 2026 20:51:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75099ce6829ff89464cb7dd32471024c6c17c1de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
