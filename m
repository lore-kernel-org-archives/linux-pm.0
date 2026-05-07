Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37224472774;
	Thu,  7 May 2026 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170024; cv=none; b=q4lD4CtgXqKEo9CqBw20nKGFP0ZdKXDLlapCo5S8LpvhabxJSN8sUPuNEfbmmdOPuf8Pj9ISuKLEQFgzKg/6JW1MSDi+8/MBrvLrQl+nup8MxGLuZuTuc+addl9ZG94bTQXsI3Odjfw7ykb2gROtDieCSOqCamdlTNYfKjqmgdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170024; c=relaxed/simple;
	bh=5z1MGFO+USucjV/1tjsmkRhMpG8nWbc9mYG4cOnHawY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZPSPBb0N3LtPR/FSI3JJGso/BsrxK9eSH4OyEUSKt3MZe1Luca+Kzdy7+2G2M3ah5W3uYuHNrht2eDclsc30BBJbaT2iXpkKaLK96KETzIr6rKTEFdb/5k8X9RvkTPoGMs/4rGGRej1aqtCgmNL1+jxPqiG3qfERGKuw8R1r8eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wj5vVx05; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wj5vVx05"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE27C2BCB2;
	Thu,  7 May 2026 16:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778170023;
	bh=5z1MGFO+USucjV/1tjsmkRhMpG8nWbc9mYG4cOnHawY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Wj5vVx05fyg+WhDGWxOHgQr2h8zk28EVv2ZwT/ipJZWYCfYyBlaDiCa1Deg5CrAmy
	 9YVKfiI+1eY1NCHkueVfC5/SSrop83ftQy+VgGUBV3j3SC9SiVr4dIyXsqBsOlYyWm
	 y4VFhNdN+twGT/lCxSg/Fq48kIhY2lLajU/vAY4UYmfSKQ8WphSz+fPAlQE+feXbV8
	 k7tw02pIkkFXrxnnhjU7sym5tveNzZtUPG8kusx3g/FW8k6H/C41F6POlyHQtLG1WG
	 O076S3yXOpQkJAEV2JkEuKN8zPbu8BK/RNfFPNO4PZ+tNrE7fQuj/Acp/WDvBTFQnx
	 tFsQ2JgNeFu7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE303930909;
	Thu,  7 May 2026 16:06:14 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v7.1-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260507100304.8170-1-ulf.hansson@linaro.org>
References: <20260507100304.8170-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260507100304.8170-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.1-rc1
X-PR-Tracked-Commit-Id: ec1fcddb3117d9452210e838fd37389ee61e10e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3737eac0a0f70b2a6b6a872213f0f235624e487
Message-Id: <177816997280.4057089.14466103668847479623.pr-tracker-bot@kernel.org>
Date: Thu, 07 May 2026 16:06:12 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  7 May 2026 12:03:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3737eac0a0f70b2a6b6a872213f0f235624e487

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
