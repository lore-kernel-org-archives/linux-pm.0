Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DED3D75A1;
	Fri,  9 Oct 2026 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791586821; cv=none; b=KxcI+ytWp4WRYMT8QC2Wt3Li9nBKzakBqJwGj5WNR4S9xi0Z/DfmSghxcZ7Nkw5Zc6SaHs16HJmRu64zWBdq3tZMKBqyp0p92oCBVjCXtf3YwDmGlvx7OAnd0YJfxUhxpgKCwhbiftuFUF4t84LEa8LY0hJPHKr/AUKLRkuprTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791586821; c=relaxed/simple;
	bh=+LR9XNZ01kWawHkSf/MJE+v9vLtntuendfxfSViI4oc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EuRvvFJfL4+FnUFrlDRFRffpfl4ZUaV8oN/TV+bph4gqlc81rK20dz+/da5BmnYQ0usQrW4QvfMu8gFF951kjzfs0WW9h5TSI0Ua4Dpi5GJtG1dD2ePXKFC07+TgTlGHoREDlFwq8xANKST5hF/5HJBJ1laoynPQg25oyQ7QLv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B67TDyDi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B67TDyDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422AA1F000FF;
	Fri,  9 Oct 2026 23:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791586820;
	bh=pEWX4e8zd/mLrXWK/FDCgDIzsdNChaE8hK9xJmgQOXM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=B67TDyDi7QNy4CDRi3NpIlRrnEVQDVkabd9hi2nQAsbiW0GlU/Vw1gFxCV4AeUWR0
	 ZZ+5h+bWi09cF+Ccw2R3rWSodaNgQjNjdRa4bq0WQUy73eKUtEgAec1c50U0h6vduG
	 YsUqVtZn62P3iA1iJCeuLYC/uXaZykoMRMFbulbB1z2OgdaYaPOU344wMUqe/l85zn
	 6I4ubJ8HF5M6jCMEZbe2L+5sd7Ui7izd9hzWlCXzsy/0ymFtPa0CSa6n4TYwqFj6FU
	 NWDp8tYx1qPfez1zHPs8EN6PDjnQHB376QUKK8Frm0oBW5Z4g5IttzxyzG+Kp++MPP
	 fT1hQJwebGMnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A62E39263A7;
	Fri,  9 Oct 2026 23:00:20 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v7.3-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261009115317.14472-1-ulf.hansson@oss.qualcomm.com>
References: <20261009115317.14472-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20261009115317.14472-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.3-rc2
X-PR-Tracked-Commit-Id: 4c66c423593e26273ea0d644906ed007630c6f6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a06d4b7c5feedea819a00af0db1629e43f3def4
Message-Id: <179158681880.1037300.16066360754983974305.pr-tracker-bot@kernel.org>
Date: Fri, 09 Oct 2026 23:00:18 +0000
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  9 Oct 2026 13:53:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a06d4b7c5feedea819a00af0db1629e43f3def4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
