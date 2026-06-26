Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9B637F727;
	Fri, 26 Jun 2026 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782505921; cv=none; b=YpcNOvGjgSBtRnz8nHxK63sulNMWM7uI5gq04g2sEoJJ7y7sBRkfkazEEEd1dTdBhHfYm1QgWwkFbjxqeYuM1n/E0+iVDI4G01h9Ijb6Hdv9Phl9V4JBnWvwRbNy3I7JK53ra2IzTGz65lSsCONQ//b7aSeNJ16uyB/zmt8hIHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782505921; c=relaxed/simple;
	bh=pHVT9TJIlVW8GXYsv3lqLcnzUJUF7EpNGY5avI4+VYg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hg+XPfBJm5J04c0CJBm3IzvcuTIonNrLWZjxxMmljmVlVRewocmtNbZD5+S/Us5XL7s2razEVDWawC0zEpulTvegoNdKiZjKJER61isMSudsZNSREajw9aCl+DqvNtMUyvW0qZ7xu9ehIueePe05GbE4o+9F5LNfTunAEq8Ffd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbSKdDnm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbSKdDnm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975451F000E9;
	Fri, 26 Jun 2026 20:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782505920;
	bh=5ZG2eS+Xss+lhkxQqDlOW16P9hLp/pwvPP5WbIHFnC4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=UbSKdDnmbrdQ/7doY01gwBMFE9/RrarF+0PBJNahvMqvxePxbzzwC5UDZafstArnC
	 UdRHn6zzScuQ8t3NPfWe/5MvuFkPpISXeWgOQAyJJAH5EP1WOlb6rxXfAHfI71eWHr
	 C9T83VrAb+VZNZbob42xMSRqiAjvx+PNOmh9sHtkKPq5OcXSl8UomF2AhGZwj+ONuf
	 pYFHVi5nAUZSV7x0/QkUDJA6+klOeLUwXsMpAMoHwXpGiGtVwCtKvHOm52AWa66rLa
	 e40wJ4z63Hbu7jq2cPBiXWcoHotdYaw8bMOYOArXvrO1SSvHzS5W8qdFpCLR8U1Qia
	 QHdDuhD4ielDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713D33938C5D;
	Fri, 26 Jun 2026 20:31:48 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support fixes and cleanups for 7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0juZ6YJVALVEi1s_O0qgcr_o880TJbRHXWsd-Drb-sUXQ@mail.gmail.com>
References: <CAJZ5v0juZ6YJVALVEi1s_O0qgcr_o880TJbRHXWsd-Drb-sUXQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0juZ6YJVALVEi1s_O0qgcr_o880TJbRHXWsd-Drb-sUXQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.2-rc1-2
X-PR-Tracked-Commit-Id: cf1e70d021343d33728e54a6227607925c8d5419
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 737b9ff0c816f7d2eac91897e44e89984939662c
Message-Id: <178250590728.1084729.3241316531157162169.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jun 2026 20:31:47 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jun 2026 19:54:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.2-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/737b9ff0c816f7d2eac91897e44e89984939662c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
