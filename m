Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B47489876;
	Wed, 26 Aug 2026 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780471; cv=none; b=ZLwwuNNUJhs4HlnRtqJmZcwOIUgG/i6ScLWX3A9RtE5hjJGDOSx/SeQm2UZ2Pktny+D2f2uz/anMywsYIufr0P775qjEUtT5Gag4499hFOzyGHeTJQSITfkcZjjTvBx5SUNamN2LOIUigNTl5wsFdZtoAkUTNvm5Dl8WKrJts2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780471; c=relaxed/simple;
	bh=+93lg2GzO2DdHnqLP5etNEAEpWnCjmqRB/N77x/LM78=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Z3kYxLuJZcDElUwidP+HNsJsH/E/W7xiywpNxhhNqw+bxoZYBR7KnFEKSsc7ja7x3rWNiP3prH2jlsmb1yukC8NiLRq0js6poBPaeq+jPsCq/5aEEvGdf/5xRkOdOcdzBmI08jyZlOi4pzxbglmkr7QKDtwTK33HAdPGAY27IR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNdbBN8M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNdbBN8M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9651F000E9;
	Wed, 26 Aug 2026 21:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787780470;
	bh=qDzzRm108fZBnwJnyvY+kvAJeADulfnEu7VpCv6/U28=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=kNdbBN8MMGNxJ1RwpCdk7P3WinOns6h5KjvsagpY5z94O6b/7hXfEq/fYJ0YZyvtz
	 ZiA0VoKyF5GxoVUoO6ylxTLFpCMRrhTWATtpUktLt8wTc0F1Vcp411iYQJJd7AKb65
	 414v5273FHQx4cs2mMTKsec5Ahd53t5UveNZTb+mPv5L5fPSHH94WyKk53EpNaVJuq
	 8KCjC2QnHmI1J2+7TPdX7JuxQDv203LeAN51OPvPedrwfaUpvcK62yZZw6YkIuCGJS
	 sJ2dLNRY7vF94gLyfQbypPMMXkaR2Ge7QznLvNKBsqvF1b0/9gj1aoA0LrpwhF8Hj0
	 3Baa8PBwzcmuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C4FEE3809A08;
	Wed, 26 Aug 2026 21:40:17 +0000 (UTC)
Subject: Re: [GIT PULL] More thermal control updates for 7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g_k+WA+7aKKMw46h25uL0t+1gqQT3DAtgCWX91TcvFRQ@mail.gmail.com>
References: <CAJZ5v0g_k+WA+7aKKMw46h25uL0t+1gqQT3DAtgCWX91TcvFRQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g_k+WA+7aKKMw46h25uL0t+1gqQT3DAtgCWX91TcvFRQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.3-rc1-2
X-PR-Tracked-Commit-Id: 79a57e48822a88f082a4dadb366abaf3c0988b5d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b81e34131907d2c243c51117a4aff8dbe22ccc9c
Message-Id: <178778041634.904445.16573206978162914603.pr-tracker-bot@kernel.org>
Date: Wed, 26 Aug 2026 21:40:16 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, Jonathan Cameron <jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 26 Aug 2026 20:41:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.3-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b81e34131907d2c243c51117a4aff8dbe22ccc9c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
