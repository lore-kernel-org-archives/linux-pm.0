Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2296F2EBBB2;
	Fri, 20 Mar 2026 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026842; cv=none; b=oSjiRWbDeFiSBgtBQhZNF65QJb7cY3OPMB3lOv5rS3j1Asas6oylHvIAnsZIXYFgtLTTogkZBjIre4daSIod/HWTKzewgNYOkmF1+EKb+RuqZXq/AhlW4Xmgyor1TaH22zrtH3wsL5djcOPE49gK2OqpSNdbxkgf/R8WqITKNI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026842; c=relaxed/simple;
	bh=vobI6MvpdyQUFfdSmmnl5x1t9nnyeRXqQWzfvsmv698=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LuQ0Uc3Zcu5mTaIFgC0H1FWh2F+EzehXlpQzEFHm8DmeqHjshVZkBbNScm3KEFZgRFuczmW2KPjY6fdyy9ZkEIcNdofI4QpWMTZZuxkbXmqQ8JlgNZmcnaHkgvKSBh83DJ1wLu3udLo2h4VOcxGdLsVvewQTuL+VlmQ/KJeSpeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9YHWCZQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9YHWCZQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF59FC2BCAF;
	Fri, 20 Mar 2026 17:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774026842;
	bh=vobI6MvpdyQUFfdSmmnl5x1t9nnyeRXqQWzfvsmv698=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K9YHWCZQjk599sV0bY51N6T6IyblkC82DZ52iT9aEU10iz29ikBnSv9+me6Lrqs7N
	 ITT4h1aEqpzdNmFVNNIGe0CMcr2alHJX4HDPCdJHYbYX6UNa/aqSfkN10ZCEY8h3lV
	 1AhuvWaUUhOFbrvv8qnoydYxlAsuFvZtXlIuOuB6ht+4smktAYC64Wq1EFJW3DdDdK
	 cuDgJPN2rQheIBM8KWU2nddNJLGPNba+zCcVSiW3wFX1Mztjw2zR4cB4lgJyIzPQTu
	 nDbJpvDWjN6YO3WmFsB/E94x9qjgf5VneM9/isNBzIh+hR7Xm+uX1V18BQxDYMzr7T
	 JIX621mP4dlsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE85380820D;
	Fri, 20 Mar 2026 17:13:53 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v7.0-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260320110521.2044803-1-ulf.hansson@linaro.org>
References: <20260320110521.2044803-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260320110521.2044803-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.0-rc1-2
X-PR-Tracked-Commit-Id: b826d2c0b0ecb844c84431ba6b502e744f5d919a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c715f13bb30f9f4d1bd8888667ef32e43b6fedc1
Message-Id: <177402683210.2580860.4459123395605968664.pr-tracker-bot@kernel.org>
Date: Fri, 20 Mar 2026 17:13:52 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Mar 2026 12:05:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.0-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c715f13bb30f9f4d1bd8888667ef32e43b6fedc1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
