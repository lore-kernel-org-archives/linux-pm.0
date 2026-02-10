Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5CC306D3F;
	Tue, 10 Feb 2026 03:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770694820; cv=none; b=cjJ5WlqCes75yf1bTAkBq9z0YebptIhEBbTbBZpF5uoZkhRFwgBjS/eb51+o5QOT6VLwHJNfhsEV5qpAsWWM1VLLZkIrn+wRJFW6pINAR0wcA2osWD6VMYMA4tsNxmtB4NgsnMdlaVD55lZG8TeHC+fUovH9WNaxXokhUGEz4MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770694820; c=relaxed/simple;
	bh=VftFGMTBeuhAyXIbv2sjBMbIxkiP6/b+jMbSEJ8Froc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YLnl2ApXyMwDGDL3/P+mMbFocOtU0IQt87xEFqUGBXDmiGTtzjVnqP3bU8YISoE7a6XTZbItKf7kpACkte7TAeVU2MjjOAhRnvvY5COw4q5bTnzZJTAQr5buIUN6Piy0I+gsHYLtSQ3oJammemwSCLd2EOYAXjs1t7ow5Kjo5TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOjAe95b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOjAe95b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCF6C116C6;
	Tue, 10 Feb 2026 03:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770694820;
	bh=VftFGMTBeuhAyXIbv2sjBMbIxkiP6/b+jMbSEJ8Froc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=vOjAe95beLyaedVwxBpLKn24j6wKZFCSGi+cLdXF6uOuu43WES3aSPxG4C7yof6ce
	 W6XJgHQWTlMPoOTKRURcFTa7vImaTyIRftoP5623FtzjCxvcTiCcQaMdXtdaHHGjJp
	 Qfvfup6gf4G7uTVAO+/5CYrBHXPnhiiwJ9CNMX0dqNP/Op314AJ2nxQL8RgMOzEGLU
	 mIWCmlCSlgu/0sVXoChlt21h0M7zM0DoHaKJe/qfnDqvqHKrYXbESF4wxIyuvU4BnJ
	 vzDYdGzrUoxGovP54SRSfx8jIGg3vhppVXgvJ6/qVQ/2DkzU4SKhmOVky8tCAU/fPl
	 wkWudmuxh6ZkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C209E380AA4F;
	Tue, 10 Feb 2026 03:40:16 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v6.20-rc1/v7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hOUCPEPeE1bN3BkgRnM3ouDX301f5qnK53BTD+oU5=rw@mail.gmail.com>
References: <CAJZ5v0hOUCPEPeE1bN3BkgRnM3ouDX301f5qnK53BTD+oU5=rw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hOUCPEPeE1bN3BkgRnM3ouDX301f5qnK53BTD+oU5=rw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.20-rc1
X-PR-Tracked-Commit-Id: 8035d70cf85e86f36f5eb1e07b243f300a936b8b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0506158ac7363a70f0deb49f71d26ccb57e55990
Message-Id: <177069481529.3327783.9914234024033718204.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 03:40:15 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 5 Feb 2026 20:42:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0506158ac7363a70f0deb49f71d26ccb57e55990

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
