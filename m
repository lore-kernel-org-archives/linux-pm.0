Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795813766;
	b=pfI9tdQj80OyCC8Vx214G9a20Ho/K081b6j1Px6SV9qsDbLuon/K4uDWZSN/eoOVbj14
	 1djvjzA6IdaUR2F/oSF0IvN52Co8Q50FOeo1lBijz06Upfmk4lAVnIoKuHGsIGwEEBNuf
	 6fFgEhu1raOvivHovq2p0RhaTU7qHlfrRWsxy5bVqCItPbhbf0DIbVX/a0NFcsvoXCT86
	 VwJTgVpxDfNk94sEmXBT1ClnuWjFh6WMCJYjWW71M+AFl3kNqvEg6U9LtMoFlSIpql0ku
	 jRu5uL+PCoP5LAxd+5//d72uDIY6SZGeOjRsNJOZp8Afq4yKOBlTUH0UvJuxP4zLNUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795813766;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=dNt28iSI/GVfA9KguiAIHfQKkzMQX5T2iXm4raGJONY=;
	b=Sn7Dy77xLwjMAIeOhDMfyml8swrNYFYmXaJfzZlX0MZcBXI1HAXgHknX11orL2XPHHXs
	 B42CU7T1PVIvMAenNvPqp4pLgHCN/yjCy61uoZKuia+PHeRYHChJoT3jVfvqtgR3gqiBu
	 250/sOJagafF6wtNOgpno59AODDN/aOPyFGj1GZSmDWgw4YjwdfiAOOG0KpUPw7ebwS9Y
	 b3OBX2DuZudyhseZ/LSspVMs2b9EfjN3l/dUSbc+TpiIbQZWE3FXwG2DKPas495Etwazx
	 lwDERZVJHwVtrgY9nVBOA9O/bpJLIkxxBY6btBey1z69HjTrJKQfuR+zHkesCz5DY5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CwynmRFJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EBB606A31C;
	Fri, 27 Nov 2026 21:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CwynmRFJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794691F000C1;
	Fri, 27 Nov 2026 21:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795813766;
	bh=dNt28iSI/GVfA9KguiAIHfQKkzMQX5T2iXm4raGJONY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=CwynmRFJ3hevyEy9UAKv7UVDf41Y3ZsOpATyCrD7QJcGq0bcmXX99w/6Q9mGcYj7p
	 Dp1+QYunaGsNl21Z6jqruWvbVCBS0YwhyZvQWpyDSrg9+ksEhboI1oSW6+8iY6HESE
	 W9Qv49sHX83kMAnAYzc9X2UV1O+XNW0HtnWBFogkndRY5Kmq8K5D0MCl446XcycpYv
	 gpm6cA5XHLepxTgAUHp24sw2XmocBw8OyKkGIiyDtmza/GYH5zJJMqVGxm2H6ktkoG
	 UhKNnpgwVFkuopJcqviqS87+6O1pwIsFduwak0pm7/Jbj5XR+PlHVXb3wnwBrtzZk1
	 TqGzbrd6ZxH6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 717C43927065;
	Fri, 27 Nov 2026 21:09:26 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for 7.4-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jwg0cGJgPnP2SaXdcHWpW_5FPq25McuQmh9794L5QWpQ@mail.gmail.com>
References: <CAJZ5v0jwg0cGJgPnP2SaXdcHWpW_5FPq25McuQmh9794L5QWpQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jwg0cGJgPnP2SaXdcHWpW_5FPq25McuQmh9794L5QWpQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.4-rc5
X-PR-Tracked-Commit-Id: 569e1eb36b033f42a9c363ffe4bfbf50bdadae51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2cf42c49089d09e6b2a1dc35186f15721fe18c9c
Message-Id: <179581376496.1686500.6598464488298353438.pr-tracker-bot@kernel.org>
Date: Fri, 27 Nov 2026 21:09:24 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 27 Nov 2026 17:56:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2cf42c49089d09e6b2a1dc35186f15721fe18c9c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
