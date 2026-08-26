Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A187F41A8F;
	Wed, 26 Aug 2026 21:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780467; cv=none; b=MGvXpt4NVN9zIQcPVRF6dEDJxNBhf7nKqePDjhjLCI2eJq350F0x1XvXph/pkSh/IDhAuojNZZKz1gDioCbhqxBWCT1BUM4nYQy7KJJPXdaartnrEFREOTNHmNijSzij2sKe1TD2gSfOBrerfMfPoZh+Dd281uXm4Ldt/6m6qsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780467; c=relaxed/simple;
	bh=E42GyNYkVGzg1H9sN4aUey+/uKsmDF+JLnjo2kKL0N4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KhxXJARXA1+/ZfqKNDLqPmgKMhDMVlC2vY6VqV5L90N8MHLx8Wc4PkJabUW7T3pEVziLC6I1blntLE2OwiYo1d1YQrXI+LRMYnMXXtE93Pt3v0ZVlbbX0PK9DaGlN9MAu5wyz3T3R5+eD2vYF13n3EaaKSfnLxELB4Kg2gRHnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkUFuZXn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkUFuZXn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887131F000E9;
	Wed, 26 Aug 2026 21:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787780466;
	bh=zefBpv0c8aDWVTC0gasPG4uIiGjvH3sqCRbllk6SZxo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=lkUFuZXntxJ8Qw4MHVI9qeaAb1PJdBGVLD10gnKppOIJKzdHrCrVG301dCa6L7ZqX
	 EIFXpGY/TNjQjzGkQaXkd/hg6FHM4/UTF1xjOMmVlpnnhWIJYtGkUWKfO4EX5DKD29
	 a2+ogsA0ZWpul/ogTtb6EFzWR0UqM1C1aH2GoykJnPwgEA267Y+8R9PitcJPh8h40y
	 XNTHST+dv087cpKThlVgLRRR2loDoESnJEdJ5flvGU/lxgdioWrcq+g+Cwqn60LTk5
	 YAthznFECw4IqQ+W6ifdgN9Z26Kylou0jAeoFR2p2O5yRzp2t2D/+LFdw2vtDWjOlJ
	 iJH/52hgH5MuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CD33809A08;
	Wed, 26 Aug 2026 21:40:13 +0000 (UTC)
Subject: Re: [GIT PULL] More ACPI support updates for 7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jdSjMH_kYu6GQ1-AQ2TXHji2Vd1+v5YP8_CxXM3PUa6A@mail.gmail.com>
References: <CAJZ5v0jdSjMH_kYu6GQ1-AQ2TXHji2Vd1+v5YP8_CxXM3PUa6A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jdSjMH_kYu6GQ1-AQ2TXHji2Vd1+v5YP8_CxXM3PUa6A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.3-rc1-2
X-PR-Tracked-Commit-Id: ea10c0b334e0dca944de2b5ecf57cf7e366674f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3382bfbca58c7d5ee3f31a7b37fbeb208e98e656
Message-Id: <178778041263.904445.2781680551193452372.pr-tracker-bot@kernel.org>
Date: Wed, 26 Aug 2026 21:40:12 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 26 Aug 2026 20:37:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.3-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3382bfbca58c7d5ee3f31a7b37fbeb208e98e656

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
