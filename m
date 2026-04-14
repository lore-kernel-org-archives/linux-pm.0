Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA8330FF31;
	Tue, 14 Apr 2026 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776136236; cv=none; b=OFmx5/17osqdLRQwQj3oxMVvVj89G81IT25rKQtVPXGGG12xEnt9eqzepuAPPwbzvu3JCoS4Ynona9DtAoOgHK0zxZhzZCgPYJb3ArReMfanOxo0JV2fXzdcCbhsQ3BgvnKZchP1kP+fInj1CSNNo8YUL3yfeddmqT7/l/WLrIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776136236; c=relaxed/simple;
	bh=VCQkwhdanJUic2pQNUWJ7iygVPxOEhgrne45E/eUUww=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qhHRP6xzVoxZu3WXA3H5IVh/fskK6g8seRvklkc8A3VRWX+M2vAVut/OavEqdndZ8el4tq3+eFt7QHBvkWdcy43NXmjwLsJFBR3w6Mx1jDzm4GvR4yuCJZN05P8n6Klqbxqz/t+Dc0YrlkCf+bX1IcbW5VR6k3wZCHW/Kt+XtA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvG3WdAk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvG3WdAk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27E5C2BCAF;
	Tue, 14 Apr 2026 03:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776136236;
	bh=VCQkwhdanJUic2pQNUWJ7iygVPxOEhgrne45E/eUUww=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mvG3WdAkNqjuRzMCAsV95n3/gJKK6cH3UXGt83YPv20PmUo06rL+kOM8CpROEuzRk
	 EJ3ieQ/gvLtBpOfnFvsqlkdXQpQFiM2Bb69Sh3R7LpT/PGeOGgPckzJRXQJjZrBqXk
	 19FDVwLQ/2LfqFwxgDd+f+biiB5oUoxJYHbM35myolji7BI3H2i7o41bfukORN9fAh
	 OiyokIihkA+6rW1WJofn3RCuqNv1BFEZBX8Oikbwf0CxPtStuPEp2Z+npjnujcvyTk
	 bsVigfC+UJbeXz/Obe5mR70KxyCOW0ANYtsjIKgJzbN+bMcoQZxwENsL9sjyCT3A/O
	 4ddD+rd/ExabQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02B2C3809A0B;
	Tue, 14 Apr 2026 03:10:09 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gi8LtGAC=E16TRqx=gQxTSz2chzt=OmrQf8etnoE_QKA@mail.gmail.com>
References: <CAJZ5v0gi8LtGAC=E16TRqx=gQxTSz2chzt=OmrQf8etnoE_QKA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gi8LtGAC=E16TRqx=gQxTSz2chzt=OmrQf8etnoE_QKA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.1-rc1
X-PR-Tracked-Commit-Id: cd1a3b2ff0553e987de71ff0aa675e418de22898
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fbfb6bd927c9ac6ea155471cc7ced8e16b37c2cb
Message-Id: <177613620757.668097.4795987504612727319.pr-tracker-bot@kernel.org>
Date: Tue, 14 Apr 2026 03:10:07 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Apr 2026 16:29:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fbfb6bd927c9ac6ea155471cc7ced8e16b37c2cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
