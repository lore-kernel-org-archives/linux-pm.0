Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B4E17BA6;
	Fri, 19 Jun 2026 00:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781827795; cv=none; b=dHd1w6BDgIUg9aTBRc6enqR2VBLgfkr8Beli4nXP6MQSOntlHkX0P/PAYnZAtdpuiQSBgQpfcJtRZqOgLojralMnOcIjmGn2R5JUo+TWSeTnlGlnWmYvnXbrycemIYRlmfJBRsivUMmfAz39WN4Uc0jQedVtTdVox2ZD5Nizl3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781827795; c=relaxed/simple;
	bh=U5JIPa4o8pOIb1dIZpIbBbfTD9M2QTWAM8bne0P+bAU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=al2Utqrcbjf1Rlg8pzEwTCHrBYC3KPSFS2IFTBNn+x1R8q11o/6L8D+02eRYQgyVQlVdgc1c6y+PF9yI35SOvo8UyuLLr66+dg8TewFi/NfrtSfa2aCdnUVfRc7Uwp3p4+crTi4mMRj7k5MTUXYgXRwZffzZQFhV5wlQIu/SVZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ip+C5K6C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ip+C5K6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8909D1F000E9;
	Fri, 19 Jun 2026 00:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781827794;
	bh=RXDPYV6FaGofHC5e3LeKXG3SaYnogPbrvQqTOsV8EVw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ip+C5K6Ch/g4Mtfp4Eq5IlR9fYhfadgwbM43Ay6buwirtd3X1jKkGyvIPS2vIrs71
	 JlGQNiK92Mw8ne2G5nwVWtdht5xqSdNNOvKvQU4mpj+y1itXZX/gb9DHTzENIEC2Tb
	 4GKOc9Kgk3RHS5RBDnv+3V1Pwk1rdCKh7YPyE40K0vlhxed3MPRav5tgAiU9DGruqK
	 VDSxqwOzG0S32G2HlReMJEsBBiHlIQYWKxQ0IbGuvpDc7Ss+EhNjhJrClQgyw64gTA
	 Brrb3Q94u+XJEwAniy23Bj8PKF3ox4qpTQsI5GwK5agZvBa8XmYfzMDnlpMrcR3bKF
	 Ta7WEQjewP5hg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198693A5676C;
	Fri, 19 Jun 2026 00:09:49 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain updates for v7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260617090546.18688-1-ulf.hansson@oss.qualcomm.com>
References: <20260617090546.18688-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260617090546.18688-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.2
X-PR-Tracked-Commit-Id: 528ad521a433cf873724893bda339df95d8ac1e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7849ce38717e64213bf9cbb166d1cda14e05143f
Message-Id: <178182778768.3120511.5297628949177706525.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jun 2026 00:09:47 +0000
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Jun 2026 11:05:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7849ce38717e64213bf9cbb166d1cda14e05143f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
