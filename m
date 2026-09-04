Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17167472F72;
	Fri,  4 Sep 2026 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536474; cv=none; b=gjurd2gY1O9YyyzviC9FW8UuMkEB29reP/m3avEcS0c6y5KYoRjzzAxeIYUdKBrf7c+92VzsXVFEZRfk6KelDgzYDN4JHCwIeWqP1HSF51UfP/tExcTjKS40MnR+oGjcF8mprAuIuUlROTbsX8mS0uQ5xL6iz0L3iZv7EIQGGYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536474; c=relaxed/simple;
	bh=BwK5Cy2JlLQb2TNklrd1qMU5dYIyMVr0SJWRc9E0A3M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=D0Q65Vez7+PEjW809j8Dzf3pYMlVAiXeq/TVYRUlKlSjFa1Cgo4AeETqL83hqEHJTt85ziJHOIENPEqxSF09SdnOsWEOUZ6U6EnA0GlQ70lQp0uKIPCi0wfweaioZ/oSMUJxl9Ee7jdaDNs7eVkSl7u0WSujw96H/93FhdGujnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hb49PqMw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hb49PqMw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAB71F00A3D;
	Fri,  4 Sep 2026 15:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788536472;
	bh=/4bzm00zvEaFAPsu+rlxZVavvC2QugQbZMzQyLJ4fYQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=hb49PqMw8wZMa52iz4c2/+aVqfzbS3MToE/lhIyvCoiR4ekM9+DJDL+z3LPv8Pj6y
	 NoNcLtULYcBUFRCmUYVOUggYHpusaa2aqG+kD7iMrrQOkT5BDeEBiECetHylKoqQjA
	 L5rLusNYDCGGJjWVC8b9UG9zHGaYUxYWu+l1rckC6RqNCHiZw0/gjWKA7D9iMf8VFc
	 yaGjrDxxQhDU/jjeHduY15K0oj+5iV0sXBfKKf5830o47IohD//u5KoMP79Gzsp08W
	 NUWlPrXu8I3jnYFSO6vv4j1ph/oyAsFi2+o4FHTC/fR2QlEEjQoILz2lpIh4y8S4V6
	 Zyu22CIcGQVcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A4A392446F;
	Fri,  4 Sep 2026 15:40:14 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain/cpuidle fixes for v7.3-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260904081215.215528-1-ulf.hansson@oss.qualcomm.com>
References: <20260904081215.215528-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20260904081215.215528-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.3-rc1
X-PR-Tracked-Commit-Id: 2b0ac85512b7f67479127b2713254490662eb13d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65119e86fe463cdc96455539020fa75b02f2cf91
Message-Id: <178853641318.344944.1977702652031876231.pr-tracker-bot@kernel.org>
Date: Fri, 04 Sep 2026 15:40:13 +0000
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  4 Sep 2026 10:12:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65119e86fe463cdc96455539020fa75b02f2cf91

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
