Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E14D3F0A9B;
	Thu,  1 Oct 2026 21:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790890684; cv=none; b=GDAWyyoYEaKUUInTjwrNdlWiIYfONcscfviw5tvY6E9qBnH1GNJMqGyl4/OaVNMO++kZ3DB0hK+DWStWZeH+2A3jqZC/9dhmPdZA46/W/WgeL55QxdaDMr3MmAnyesls3vAXZTGgRGLsRAzZ6J822EBzUAE253yIf4+DREf8l5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790890684; c=relaxed/simple;
	bh=OUl2WXwN/zarlGpVS2A0cD+l2FoPR3JAw3jfLTH/PAU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OFBKIrkA0fXZt4y9hv+8rcHGkRYYk3EpiWArAgHvi+fwQ4Jh/IVaFHlTUN0cdkR54KYKBL7da4RJMRKIov4UGtvwVMvExlR6jUvKzDy5X2Cjh/IhfYLm298JvatdJ4eSGZXyGDiQWOicKFKD/59inUYLru+HK7xO+CG3mex6yrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtURV3t+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtURV3t+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089631F000FF;
	Thu,  1 Oct 2026 21:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790890681;
	bh=9/LTYwSOnQGFomWo+QwTpJ0xrlhqp1PGPero5RfkhS4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=TtURV3t+LN+z872iDnur32aTGzoAU4gQs5jZbs7Pq3aGnCMy8tjTJVw1f05bmSnHJ
	 zZT8IQ5PnH+dFiC/lWRjbRbAZd7mQsjVdszmkKukknnqAnyWnH4oESYFtc/cImxhon
	 r9XCqcOzC5+1DnS6AvWvfIZvVF1T+WT55+mdbfN2LILyfyPNNF+H+DjIuLvKjyvRcZ
	 Agx3Thnp7T0jcnq3awGZPQt6XqkFXotUc8lvmglEEQDA/LzgOVgQgkcxnN2xtOSb9k
	 qPzW8E/ZsDVkEKC4l5UjYmrnTPGXPkydK/X5GmlhS9lHb4Q+dfHux58EnNUzQw9GCm
	 A5YZFIr7yqzFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F154D3811976;
	Thu,  1 Oct 2026 21:38:00 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for 7.3-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gQ8_-9V1DhqO+vYdqVRZSYQj3pVFgH1JgXGmHN-oPd4Q@mail.gmail.com>
References: <CAJZ5v0gQ8_-9V1DhqO+vYdqVRZSYQj3pVFgH1JgXGmHN-oPd4Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gQ8_-9V1DhqO+vYdqVRZSYQj3pVFgH1JgXGmHN-oPd4Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.3-rc6
X-PR-Tracked-Commit-Id: f341dc4d934a69ffbe6c21e3609ee725790188f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 100638f0f016cb0e6c75e95ff2b0495bca0b3054
Message-Id: <179089067944.3100647.10794790809112219206.pr-tracker-bot@kernel.org>
Date: Thu, 01 Oct 2026 21:37:59 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 1 Oct 2026 20:27:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.3-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/100638f0f016cb0e6c75e95ff2b0495bca0b3054

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
