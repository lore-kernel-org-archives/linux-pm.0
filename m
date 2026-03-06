Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9904336EAA5;
	Fri,  6 Mar 2026 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772822289; cv=none; b=izRl6p1kkQqakBv7YinfhoYNxX4sfNVXe3e1s2WAkgPoA+CdUkSLDJCWziAPmEfIKRLLStqq2QpL3imjY87lMyAuFBp2YBRfnVOQ7lvn9xuXxCvr+fPK1yLlbaJ4LPExXRcKU2SM2Ls2Xim4wNutLDzpRTZHbxF+ys5CUoe0wPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772822289; c=relaxed/simple;
	bh=ZmoqSWZUjUvRcBPuXLNW9lpM1fsrJZIyolwlWt6ye1I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FZJFCMHSj2WwRzD8n/l0WRL+hx26yR//3YmsMu3Lf0JGg+mZ/yj2akzsWBurrpDuxxcrFyDXIoACYlT5y0oqGa76EyoKKqXX0LqdolRDD9HnbvQ0XUwX8q6/0qKCTB2y1pNWV8WhnkpxM2x0wW3RBGa0Gxp/9I+PfNrG86phUeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EW+EGpSM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EW+EGpSM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7245DC4CEF7;
	Fri,  6 Mar 2026 18:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772822289;
	bh=ZmoqSWZUjUvRcBPuXLNW9lpM1fsrJZIyolwlWt6ye1I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EW+EGpSM2RhTcLyymSlb6qV2H3KkbXxoOXvF0d/35wwSHckxbGFztnneHfEQScJcQ
	 z5lcrA0RqfxRSclaBpLv7BfHlS/9Av2xYZz1Jeuf9B2hif7LJ6ykbm3bkQoL6i6qk0
	 KgAGRQkJIBWKUSNvmBdBAS6ja12TaNLtPvduXK7YrlCeda5OI18yEcki5fF5Z6OCAF
	 9lRvYp3J9HIen/fJdVMHJ2fNwDTYQpHKuBVXrYLgeVhpaBYBijEMUVmvpJnGR72qAm
	 pM42K3KjVUWJ1QBhFMqCxdeu9X4GxPd27XAaoEEXhrIL8gI2k1EHhsAB6kOvsPk/Vs
	 MIaqNJHJcJTSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F3B3808200;
	Fri,  6 Mar 2026 18:38:10 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v7.0-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260306104356.60885-1-ulf.hansson@linaro.org>
References: <20260306104356.60885-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20260306104356.60885-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.0-rc1
X-PR-Tracked-Commit-Id: 0fb59eaca18f1254ecdce34354eec3cb1b3b5e10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 345dfaaf9f8b8dd0fc563e6f48586922b38ed11c
Message-Id: <177282228863.7628.6753035738379589462.pr-tracker-bot@kernel.org>
Date: Fri, 06 Mar 2026 18:38:08 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  6 Mar 2026 11:43:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/345dfaaf9f8b8dd0fc563e6f48586922b38ed11c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
