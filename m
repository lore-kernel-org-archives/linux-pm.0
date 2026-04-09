Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D964B279DA6;
	Thu,  9 Apr 2026 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775768254; cv=none; b=SNTlhmDssVeq6Dhy+SRWVKdg3E7M9rSudprvLl0OAOEaTfZVf50CtPXDLMdnC19sjkNQKYWDh0R9WSmmYKFoN/UZbjtIZXInPoSQ0E8T6SdQgSG22hYJRjEHtEbsUflCN7lIzIdKyM3QkbsD4rWQbY5yniyfe6PakMj9zhbZeV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775768254; c=relaxed/simple;
	bh=54kvRZ2rkbOuxoiopOrDDDHNsJgHFcyQMKsLi84Ficc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PxEjkIDLaTxjZO5B5icy/jXGLbjABa84fL8e9aATtTXjkGPPKvRiYVZjE1CxPkMma9Ysnv0DzVs+s/gzO7Arn3JnRz778OWC1NjDhn/wSfPDS0bp49kI+dP0EYgWecbSjigCiLTds+NIbU3W9WFc5/qHlc5bMZR62bOnp/ppkYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a03kBB90; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a03kBB90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F4DC4CEF7;
	Thu,  9 Apr 2026 20:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775768254;
	bh=54kvRZ2rkbOuxoiopOrDDDHNsJgHFcyQMKsLi84Ficc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=a03kBB90ccj37LqtMgwr2DHZjyp7wFXZ9NvaB1hzV7MIK3Z9YarsKgJwyXbw1Fqea
	 X+Mlvtw69B0CA5GJIOh9WmjEJjPoGRgwgyCKxjIEnI5iXKkxHl/HAlOlOo0hK/fuvm
	 zcbde3nOhmb0+7WAViJFO9kb40kS1c3CYaR/WFjboSsQPH0Z6N85oxJeIg+2CzrofC
	 oqLomfGcBGL1xnWUQKmqi6n2UjFZiiVUviGUVMH/fsrLI5h3U+SYYTAsWaIdyjaTvS
	 +nNlRDGaBWWt91goCnUFy+i8JtUbFEuG/H5WySWY3LZkDJdzDJPJLeWRjb/WQ740f1
	 lrtpAPU1nMd6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF9F39308B7;
	Thu,  9 Apr 2026 20:57:11 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v7.0-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260409150950.28527-1-ulf.hansson@linaro.org>
References: <20260409150950.28527-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260409150950.28527-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.0-rc6
X-PR-Tracked-Commit-Id: c2812c0cb909211a1d2e7cec862406e32833b9de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d58305b2dbe3434c9b21ede210329b97c44ee9e8
Message-Id: <177576822986.1737704.17369808610359378593.pr-tracker-bot@kernel.org>
Date: Thu, 09 Apr 2026 20:57:09 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  9 Apr 2026 17:09:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d58305b2dbe3434c9b21ede210329b97c44ee9e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
