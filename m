Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9498D489873;
	Wed, 19 Aug 2026 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160062; cv=none; b=JwJp/fjqozba/XPftZ488647PiwyVovsvaBMyr+j2OVVlIr82d51+1PZeCMimW22X3HaRyn2ch9YKT4mJrpy//Fu1I1y1vJIOHk9rwytcRVyg2XlXXpmSdYFrWgYL/2wv0sNwbtgdTpzAl/ikEafusxInJvw0mbUlSKwqT9rEfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160062; c=relaxed/simple;
	bh=xpIseNJ8SHEVT5uSQmvEEGA0JV/wcPHKkw2L+yJXCeI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BxwvBfHvYguh+4ejVLjIbGCInwuNSt5eTZnLDlJ22GJ/lIiOyYZng/VQxhBQmgqxumoF7wt4lXKtOggADnknd4kXWYf7AkeS3mmvEPtjnaHsxYU4iSZqv9kBG1U93lAJCt6A0WpCzhlw9lfMn3xUH09CUCTfQKu1wp9YI04jfjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OA4XH17k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OA4XH17k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561E11F338CF;
	Wed, 19 Aug 2026 17:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787160055;
	bh=imEHt27mUhxQ58R44WgkTdQcFGZixGru/Rw969OaqtY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=OA4XH17kgEwXC9nbTZ5FV84tBgY60IrNVGMRr+33XsSy6z08k3yMcwojQJlcVc3Mb
	 UQZHi3/v/3v/GpeHwkkggEmyIf8bSzc398SG10kJDhvIY+3/+c/NyjkdMSjbDxaVHJ
	 ILOCvbNH5dtnxOnLu5xEjtd1N57FHBx15RoHN12OJexbZ9TtkrQQk/a41LdqqoliK9
	 HcJ2vwRvBJFJW9w44PVWN1gMUkwJ7L8cRgvp3R1LfJ/MDIaULhCbP580h8d+PjWwH0
	 6JVsj3Q0WZuFjgJ3WoRVedR6Tkv1uFKoNuXGCI2VFKM80E4zDM04gQMrWWg+7BCfzp
	 Am95YehXVlf5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8395838119E7;
	Wed, 19 Aug 2026 17:20:07 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain updates for v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260817113836.134458-1-ulf.hansson@oss.qualcomm.com>
References: <20260817113836.134458-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260817113836.134458-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.3
X-PR-Tracked-Commit-Id: 3ca7b513aec1db32b75b909395be1111c1198afb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ee1b6365f07a14e987dd0f994fc7d46966037ea9
Message-Id: <178716000620.3599392.1518378382337655084.pr-tracker-bot@kernel.org>
Date: Wed, 19 Aug 2026 17:20:06 +0000
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Aug 2026 13:38:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ee1b6365f07a14e987dd0f994fc7d46966037ea9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
