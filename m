Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8608427B32C;
	Thu, 25 Jun 2026 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406133; cv=none; b=j3j4FwGGhHpB2Euy+u5/4Ni9xQFWivzYescMDOekdPZxvLpis57K8qmtjDXbkanSZR6OcE2Ajf2FU0yHSo2hZ39nbNr+nN7auLMinI/iPVWfvSs/3GvMzY7Fsbc98EL4NQge3QAumE+Tbt2LK3kMWaWQ1YeQoZmQtxEGbxrRdKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406133; c=relaxed/simple;
	bh=H34NZuqsrouAWsc4u7jxDd7Cgs20iob7fuiOpt7d7vQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HW1HWV/n6YAD1vx5yR6lVs4Sf6P/qEKSjx3nCKyQi8MRx+/5EpLDKmFwysUIPv3cO2SQ32deu6O4DjaccIFn52JliP4z/7k7nBtZ8SK6FwcM+Or4wuNt5AxydarvI6m+CugoHWZJ9+txs5WYlqR10WdrscXb1MkKXirtTddymzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8sxymU8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8sxymU8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374F81F000E9;
	Thu, 25 Jun 2026 16:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782406132;
	bh=9gTk0QF4pC07358fYyP/1j0QKyOWTcNsVAJWgGMBR8s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=R8sxymU8JadPnxfGf+Oy5O5kVdpuyv3wj7V28rZjU+R0SWFCW2Dj/rkUgFXSy0vGk
	 dsHYjtasWO1GJfyKhwcMFCivMYdr+N70MZXNNtMvCB9z79LV2otP//QKMyE1ZbWp7P
	 dhsbnBvtRraFFgO6+HB/xYC3xGlWxe9TOcoRY8zZr2+Qqq7Ekx4ppzYn1QBvDACWYv
	 yfFnP67kjrSz9qr2BUh9MQ4D8Fds5RHXc5d1lh0iobwdSSOJUGFtR8ZsYfDFieB76p
	 riS1GdtsVRRdc6nED/JvPgXTqw0kiNFk8JjY52lFRID4krwMsynWGEEUYCPhDG5TKc
	 NYEjqfZl3Hgcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199563938789;
	Thu, 25 Jun 2026 16:48:41 +0000 (UTC)
Subject: Re: [GIT PULL] power sequencing fixes for v7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260625085158.11090-1-bartosz.golaszewski@oss.qualcomm.com>
References: <20260625085158.11090-1-bartosz.golaszewski@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260625085158.11090-1-bartosz.golaszewski@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-fixes-for-v7.2-rc1
X-PR-Tracked-Commit-Id: 2d5a7d406ecece5837af1e278ffbbf6c0315560a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec85be724c5c0c2cc392f5681b45da0403ea60ec
Message-Id: <178240611970.3815539.5245691242935876195.pr-tracker-bot@kernel.org>
Date: Thu, 25 Jun 2026 16:48:39 +0000
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Jun 2026 10:51:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-fixes-for-v7.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec85be724c5c0c2cc392f5681b45da0403ea60ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
