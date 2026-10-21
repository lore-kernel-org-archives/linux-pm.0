Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792620797;
	b=hP4PUF3HBrsKGlP1Y/GWAWHyXS3icjqIOCFd2+GVuUzZJ4UhH8tecL1Cw+guLbwyzVDH
	 0N2yqRNaaBrFKZ3RoBIl2PAwubrW11huGlZKSbuR9+0Ilo2EIDpW0T3kokB/fsdZHbknT
	 VjuByLcL9SaQZ21Wu0g35CCb/j6V1AWawU1/BYIHGKLFH9sYoHYHleTV9OwacWSRrOWu4
	 JdS4IfMmCOw5jFumadu0biXmOYGLF9bRn5rdqERjSg2WPt5yrz5pQ/GnCFcQ8dL2Z1mll
	 Gj6wJKgDsTQVVVjy94dP2mjP45GGWeG9ayljPN3OPea4InfLtcjb8DTfrlfno8+jJ+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620797;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=WPzjtOdhZ9CVHVWEYS7wn8WlD7K/zNfSQnHa3pzQl1k=;
	b=XicPAe1QAyiOe2gFZku3TJvRtasbnPDKRh7lWMAHOdFnALgxhCa4VWyvrOup7CJmmf/E
	 2ZyUinwOR24Xf1acHva1wURZdDeKnUD9OdaCVX37FemIo9SURXFGWrVqSIAw09scjBe2O
	 O0vrMzFsp3rJeNzJpmV4IqVkk1l6qpXeIb9okGNWLZa6PzEi1YZ8Bl22wT1V96pv9Qqov
	 f4bli1CI9ccYi9S+l540PPNWPAqhgud3HjY5B+gFicqtvn3EzRii2inDN/mMZheE5ecB/
	 IckOjzFqhQZcf8c8t8sEP85hOqgSBAtlcOT3aMiw0wMmPPkLY7w/QFGegqaiVELw1Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C+gwll3B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D8B606A31D;
	Wed, 21 Oct 2026 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C+gwll3B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453941F000C1;
	Wed, 21 Oct 2026 22:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792620796;
	bh=WPzjtOdhZ9CVHVWEYS7wn8WlD7K/zNfSQnHa3pzQl1k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=C+gwll3BSsD2AlyvS8KJbOlZgc6WwPApO3cA3HGyFnuNpJGQKhNhBPGLFz76KdtJ/
	 Esd5gVLFVm2ZGBX/1ilyvwL1iWaACqHjmTchyCV+EHCEGr3PKTQukQLMYRujK0sagG
	 LZekJ6Awjv/jYQ2R9vbm2C0nMLMiZek0kD7qxFdOywMFlV+ujuKA+mm2GZH4NrX1D6
	 JvH/hB0J44lSuBzmsj4ZVZxAed1JDdA0YLT5prqFANy0K3M+bpS74nxhJYKCOSKA1k
	 c8/RjpCQQXwxP409aHmdPXW83TKi6QrK+e3B2MwEgOj61aSZJYxRKEhbuRwKg967sb
	 EcMLi6uC51u2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3C2380A962;
	Wed, 21 Oct 2026 22:13:16 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support updates for 7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jh159XME50-=dm7s7-HbE_kffbhbze-fDPi7RE+pepLg@mail.gmail.com>
References: <CAJZ5v0jh159XME50-=dm7s7-HbE_kffbhbze-fDPi7RE+pepLg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jh159XME50-=dm7s7-HbE_kffbhbze-fDPi7RE+pepLg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.4-rc1
X-PR-Tracked-Commit-Id: 84c4409e8566549d0f21f25e2bac9327dc279d23
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4df4d2a577db2d3d57b888bcfb1206fc74661d16
Message-Id: <179262079480.1335980.10558636473814564101.pr-tracker-bot@kernel.org>
Date: Wed, 21 Oct 2026 22:13:14 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Mon, 19 Oct 2026 19:14:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4df4d2a577db2d3d57b888bcfb1206fc74661d16

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
