Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A103CA492;
	Fri, 13 Mar 2026 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773423198; cv=none; b=TMK2J8M1vQ0mqjaWGQAXnqwvE/KW9Kh4yZona1DQtKzL0aKhlvWZ48+5DxThcDnK0JUMDTcOi3ikszhE46aEWvTHlP9ix1YS4L7NvCOI1dvbTWtaRcBXb0O9Lih5JAgiwiJqh7/JumseHhFK/kU4q0xje3CdeFiR/6NBorgXU/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773423198; c=relaxed/simple;
	bh=BfmyISGxlVAOSTxksyjZ1Q6UFf8YFommfJ2UrtwDlKE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HgSY8JZ/vn8m4XVOvzwpB8YZXYETTGW8Y0C5YnM+9//HW/a4si0ohM66m60Bw+WKelhzCpCszEOpNXFwMkK7wcxLjAE1hd5tuykptPkzi/nQQp8gaOCTI6/EDQwUbOc/uuVnlmXRucwjpXODFLF3rikg9RvA/QIYevdlMaZd6MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgvacG07; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgvacG07"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6425C19421;
	Fri, 13 Mar 2026 17:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773423197;
	bh=BfmyISGxlVAOSTxksyjZ1Q6UFf8YFommfJ2UrtwDlKE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rgvacG07qhtl01pcADx7X+yFjk6vkOxyEMex3BhLN81pugLriCR9pGDt80+HUPhW6
	 BCvCqZaIJdUeskY0e/SPdyUOXi8osy3ht9afB4O0aNjz+OYquBZ7Np154utlAYjMoz
	 8r4hwMklUmwA04v5Csx2GslBg4fOT0N6Lp5/HuzKxSfe5GyH2JS9Ur/pzVj5QLd1PC
	 zHMjeJK8R3HbuR9kCeCgDEPe6CTA3/kP2mYLGERIsntNk3zlHvRooTr/dhvEGB7xru
	 TsMMvTqVDEXOhyWvhBA/3LaMginC2Hz3IpUIbQObopYxtpqlRHXmAjC4hESbyHM8cB
	 9TC4s61vpLM7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0AC3808200;
	Fri, 13 Mar 2026 17:33:13 +0000 (UTC)
Subject: Re: [GIT PULL] power sequencing fixes for v7.0-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260313091403.7973-1-bartosz.golaszewski@oss.qualcomm.com>
References: <20260313091403.7973-1-bartosz.golaszewski@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260313091403.7973-1-bartosz.golaszewski@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-fixes-for-v7.0-rc4
X-PR-Tracked-Commit-Id: 5c3daa5301693d2e5364483a3405649a0fdaed98
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92e989acfb83493e0305bc9fdcc666275ddd46c9
Message-Id: <177342319228.1438840.7249911167636099569.pr-tracker-bot@kernel.org>
Date: Fri, 13 Mar 2026 17:33:12 +0000
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Mar 2026 10:14:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-fixes-for-v7.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92e989acfb83493e0305bc9fdcc666275ddd46c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
