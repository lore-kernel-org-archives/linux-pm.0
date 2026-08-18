Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CF548987E;
	Tue, 18 Aug 2026 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787080547; cv=none; b=NMCKNCXUzNxg3ljtzw8gG0OP3IItiZEkB8fQd9n+Ys5izdH3KAQCCI3e3gn+spOL6V/9MMBrdWntUOBYactEyzlyV+F/ADwF/tT3LesImzWH4+MYxifGkU9efnboutDvrWQs4UNbP2sSn1r85xXKNqo/mKaPow2657/hn9S8w+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787080547; c=relaxed/simple;
	bh=Bhkg2VFr2e7d0EVDE7PMDzXEBf3b1s2CQHN3QKRMBuE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=p/Zp6pB7KePSfd7XqbabPbCOOiZJKPv5HM7sACflzEsp/Cq9X7sXrl4ZxkbHG8NNky/qihSJAWCXtMZiz+TBq1vGdvU3OjmOu+6+56oaxWIb24WRFUfqJgwn2r2eMUcVed695LLFRuue5EYOGSE+wg+Pn03kTi3L9C4vc8o2784=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfbmOz/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfbmOz/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5607C1F01558;
	Tue, 18 Aug 2026 19:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787080518;
	bh=M5htUiu2/uaw43DPS42F+8AN9dTjaV7mr87Va9qNGM4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=SfbmOz/bLyAxcdcDOl8Y3YlisOvPk7NGN8ZCta2RWH1glVKOkBWAb7pHx9rZYoH6+
	 E0An0ysYHKUQxfv+mGO61aEYhlWuQYuQIRjGB9/03HMENS8KWINwiF8QjVYHk+kXdH
	 z28Gt9qmox+ZPJj0a8lxSb1OqIQxYRkZtHa1/D8eo+8rEdnpsadFDFebaLY8x9bXRT
	 r0XHo71ICKTGh3f3MLC/ER3sxp0EP9KjWN+Ecfd1XPolyFPgCcbfzCfA+FXeMPPaPq
	 VM8Z/59KyiSkYP9ENQ0eHPGyT0Ni5PTo2yIQWGtIIZxbg3xmFH7NkaxjSkmqq0ZhjM
	 sUa9+mvOxzprA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A083927051;
	Tue, 18 Aug 2026 19:14:31 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support updates for 7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h7+MKn52LePu1qqJucAqGpJB3cHZu7Adccsy1TQEJ4rw@mail.gmail.com>
References: <CAJZ5v0h7+MKn52LePu1qqJucAqGpJB3cHZu7Adccsy1TQEJ4rw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h7+MKn52LePu1qqJucAqGpJB3cHZu7Adccsy1TQEJ4rw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.3-rc1
X-PR-Tracked-Commit-Id: 79ba234b396b0fdcb3a82dd8aa872348f4069aae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d508f1745b57272d4d4a3d50dc35aa2a3682238
Message-Id: <178708046962.2235733.16368250721941782187.pr-tracker-bot@kernel.org>
Date: Tue, 18 Aug 2026 19:14:29 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Aug 2026 20:52:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d508f1745b57272d4d4a3d50dc35aa2a3682238

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
