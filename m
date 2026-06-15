Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0273BFAE2;
	Mon, 15 Jun 2026 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509937; cv=none; b=VkD+i7rMCWPe+lstl1bnyuUdTC1tjR7BrYEv0DDqgRDyUl4lzpCPr0PzimipPWDYtnCwdgtw9CxULj2FogIFtcb/p6Iq7+qktkFnLlldWi7jDSFjMnn32rCgcAhbUNDu+7797+H8OScNe0SnVb/KFDsRO1RoFAYRT956bfugVas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509937; c=relaxed/simple;
	bh=ZD885NC3gJKWKI4YJICq2/pWyI23EgU/JIyHdcs171k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NXmbJ12A7DVbXgL/v+xbfSoUJ0o8g7WKnaDdix4A3awltpekTAC/osGQ+LfneexAFLMz0MGmFoPGsJ5ud21pfVICFlaSN3XhOah1EYSQZnm4/64rTkU/Iy8qSIqW4DHA0VkZgEcjYsdeFF7ksEY0BUVsylXHo/a7+xVNP+i1l54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdKL643i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdKL643i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05631F000E9;
	Mon, 15 Jun 2026 07:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781509936;
	bh=yF8q+SGCWhWBLNS6JlMSRXjV0w5U+uos5NSryue1+U0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ZdKL643i80fgf4d/vlSdyNJ+l0qfRHRL/+MPxvVzxgnn0ZkJW8CDgi8gy4C8huxpZ
	 Tgep7ibCuehLFmC0cCtuvvc4Qviqoh6raKEpo2xNjcRRw7gU3mXo8On4MIssOWhGY8
	 vZmd1a352c7p5XNvjSuvQd4qzGzaQct6y9401UJR4rYtBNnQrLojfQZ8+RuL6u04R1
	 RZq5TdZvkGh2GVy8rLmL2lyF7jNPAbHpJxyRqkMvlBYasdqc7W4jcETaisE5cG02fb
	 ZgswNsHsdNqWW41hsqfyKOpOjnfYkqw4XAeODCKtkn8qlx2eop7xhnSeY2MPI2/pYk
	 tqQml9ZL34A2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568313A56756;
	Mon, 15 Jun 2026 07:52:13 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for 7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gO6vETP0+054J4pSdPH8ehn_1zY2rRqX2Znc9jeD-4RQ@mail.gmail.com>
References: <CAJZ5v0gO6vETP0+054J4pSdPH8ehn_1zY2rRqX2Znc9jeD-4RQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gO6vETP0+054J4pSdPH8ehn_1zY2rRqX2Znc9jeD-4RQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.2-rc1
X-PR-Tracked-Commit-Id: bc1c872ce0ab3984f5fcefeb952541a802b891e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f3c4a338b5064effd9ce6d2cfd26c73daa56f1f4
Message-Id: <178150993199.2920647.10319607854522905343.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 07:52:11 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jun 2026 19:42:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f3c4a338b5064effd9ce6d2cfd26c73daa56f1f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
