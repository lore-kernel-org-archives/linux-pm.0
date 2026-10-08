Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EF84718DC;
	Thu,  8 Oct 2026 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459434; cv=none; b=U49mcs+8fZQSGjOf2xKb+QiqZGYBB8BSF6P7DSwxJMmWKI6x2XJIFC1ZynS7141/MEuyAbTVtohFbZ+Wbtiu0NZuPoIN/JQJEXulu+5jGZtZHUPkD8NKNOAokCwugkBFK/eI2TkufoXzKT2tEYElH8NpzcXdSFTk//PI34srD/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459434; c=relaxed/simple;
	bh=UQX2s8TtuDsm2WLcScJlEGnzQmavsJpdE+9AxHdGjZg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oZQcJ9OT/ZzPgbf2NoTVjy+ZFijT4vXTd56/w78WZ1SJgRrUuah2IgagiPavgVgQnleMDKYP7rVH6bLURfe7gHrH046NjsQSyyAZBtPqiwynsjMJ72sgGSIPYGlis6yzqyz4enYmA1SjgGGwiXBks/GuwllnOLyxGYozt0p6erQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhCpOn+0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhCpOn+0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B151F00893;
	Thu,  8 Oct 2026 11:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791459433;
	bh=XxaFv7Nb1rwkukEecsqJESrxDFle9ga78pM+fQ1L/A8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=DhCpOn+0MXTzKe/VibLMq0+n5aUDakGfrhNlyTKURCKSuqqTTKcw0U1zBvudGUXYd
	 v4YIEjhDPEzZzhfi33GeW1GErkCpW0uBBTyNyOzqxwNhfX0jhe3py5me3g+t4yaTF/
	 b9Zi0Fb68NAPl5oLQg6bhxW26mXch9T0RFbj9MGJigd5NYMS++62CHxg34mmWa/n3C
	 HdO9RK7PTKB37cXYzNdvG9/KFFxbCmKP/JT9WBGdscvbfOu90S8e1pLMdEEBwZq+qy
	 9cN/eN+JI6zs5x+QHqWxTfC5Ev7hyLq4wdMjCg14n496mVgxe54ABIoCX7Q8cy+KK/
	 XF3qOmDPr0RwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A39F380AA4F;
	Thu,  8 Oct 2026 11:37:13 +0000 (UTC)
Subject: Re: [GIT PULL] power sequencing fixes for v7.3-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261008090002.5062-1-bartosz.golaszewski@oss.qualcomm.com>
References: <20261008090002.5062-1-bartosz.golaszewski@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261008090002.5062-1-bartosz.golaszewski@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git pwrseq-fixes-for-v7.3-rc7
X-PR-Tracked-Commit-Id: 0d6c5794fd633427f0d4ad8b51d94061295649da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47324d3a5b3abd781295044d01d92d09f184e872
Message-Id: <179145943193.227328.15995551806118344485.pr-tracker-bot@kernel.org>
Date: Thu, 08 Oct 2026 11:37:11 +0000
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  8 Oct 2026 11:00:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git pwrseq-fixes-for-v7.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47324d3a5b3abd781295044d01d92d09f184e872

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
