Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C8B485CE1;
	Tue, 18 Aug 2026 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787080544; cv=none; b=ROozmO445NE/o4xiihc87epME3Hph0gd19QpA8d0A74e5sia5GpHa4tQIzHW3VlNBGY+emzfjgu/ZoGFqUBuQPVwqbndOCPN3c+DbWe/nYFShWgKmzE0uBxEztKgRUSVjGrV7X/GqcOp7TvWnIyiaoFb1Etol3677Tv6e9lwcVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787080544; c=relaxed/simple;
	bh=eEwiWvlSTtadt4TBEzyy5P5GP3XF3Iw7gezeP2k5vYc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BIcFD9QuSfM2Ffy0YfWPGajvBWiLNh0QPxEzc0yolV3m1y7xa5T5cgdoR97pVROC4zQT7a+sFXk5wllGD5CMYXH4hxZLvq11u908GQp4xxsc3daUjHkCcCLJ8d3ZZ/E0T8na8MOAeTcq9iUGjuZEfLY1LxlDcISrSCnrkH5y4o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHte+4FN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHte+4FN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A9D1F01559;
	Tue, 18 Aug 2026 19:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787080521;
	bh=Atz0jCcPG0pjFEN3XKZmnRGgm68bpKxgPbGPPIEDOgY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=NHte+4FNNgQoaFvGy6lp3ntJdV4BPDR8ShmgTGdK5dbJdgTs+EKsMJK2r6RZSgV8n
	 Tx3yVlpYzQuSdxfyptOcbVJR24qCcULya8d4ngVuhGJFH4qOiqR1Gz9ZIFmo5LPFRn
	 JK5zNb3axKMPjeqE7G2UGTW8VucF8Unb5id+Im/7x/Vo8tnWSFzDv3Obb8LmGL9s5K
	 9ey3B+jrKBnLi3TpfxHUA2bTc4f5ZRr+ofAfeswBXfhVVTGRpZQBwOkwQbQeVak2Te
	 QTnsjCN4KmjHgmiYVzX8UrgSgcw2RSPGFMNoGPqmyvow0R2VyntY7BlqhMliyXElib
	 Fhl6TECOJHLHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198313927051;
	Tue, 18 Aug 2026 19:14:34 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for 7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gnOPTz8m-eu4+SUG-O4gj2+QM6TzYs=w_WhCVec7Omew@mail.gmail.com>
References: <CAJZ5v0gnOPTz8m-eu4+SUG-O4gj2+QM6TzYs=w_WhCVec7Omew@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gnOPTz8m-eu4+SUG-O4gj2+QM6TzYs=w_WhCVec7Omew@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.3-rc1
X-PR-Tracked-Commit-Id: 2d5667b6c3d7adf0f8551bbac7c707fb87155611
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5c7a47af8d93059f45b6f656a5115e020dec477
Message-Id: <178708047274.2235733.15621160531054746220.pr-tracker-bot@kernel.org>
Date: Tue, 18 Aug 2026 19:14:32 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Aug 2026 20:57:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5c7a47af8d93059f45b6f656a5115e020dec477

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
