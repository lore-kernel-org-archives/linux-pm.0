Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF333385BE;
	Wed, 18 Feb 2026 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771455345; cv=none; b=Ph9kD3rqImSq8jDr+MRsvR+b7nPQKT8mW+SBwYzKRKeHbdHG3dky9cNFNDiso/NogQp2IFa+QrCkzB1iYEgtEmbZCFqEdcuA4+ucmUMx+kUkl4a2GaiIWxy+TqcRAxhPT38q7/ytuixZHEeAm9DdwAUbJkbUUwYy1Hq8R2glpBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771455345; c=relaxed/simple;
	bh=3+NWHrHV+tUjRLXZA3F2rzHhPMfnyGR77eRAncLRPw0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=j1KKf3RhX5g3RoVUO10SsT0kQ6V0GqpHlFBuRmqmjiyhyBbPRFOr0uDIUPZLj+RPs+agd8aq0FtnxSu54MKSGBz7rNFqvJyf8pOyUzt49dEdya0DjbhaHz9uEo6todEJ8uCCuc4O6HxmLKGzoUemp6lQ7RNXHOKWQx2yxccTbLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4wrYGAm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4wrYGAm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84904C116D0;
	Wed, 18 Feb 2026 22:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771455345;
	bh=3+NWHrHV+tUjRLXZA3F2rzHhPMfnyGR77eRAncLRPw0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=i4wrYGAmKNtFQrCfLsIOnsrYpg7kuPZSQfJlkAGJqZdPOwibhyh8njJ0Xsg5NeRor
	 LgGLJ5p05JzKQam2BcQgcpxiHFFGK84JlSweOXLllsNUOWAEZdP41k4aXiEZPm5olH
	 Nn6DpTzmXK0sv/HR4Ae16ETCZdNnZa5eV3CRLVBfMSz0HF9dTLvtn6llWUW2tmRFnj
	 OMeFl3tI9cbGqVHCeGtUTSz11MxEOwuoR/NspurD79GOIdcezyxHx1AL4K/L6P6QMP
	 OEegJk9fkXbmHeXePWanZEKAu7MuwdGjUpfYje1nqgoZCTd7vYTFr08beMRhsXmkkH
	 G56hP4XY/dXvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1459E380CEE0;
	Wed, 18 Feb 2026 22:55:38 +0000 (UTC)
Subject: Re: [GIT PULL] More power management updates for v7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gh1N0codB+aY67U-e_mAkYQghKj6QE1jMB5jA_bJjLSw@mail.gmail.com>
References: <CAJZ5v0gh1N0codB+aY67U-e_mAkYQghKj6QE1jMB5jA_bJjLSw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gh1N0codB+aY67U-e_mAkYQghKj6QE1jMB5jA_bJjLSw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.0-rc1-2
X-PR-Tracked-Commit-Id: becbdde56a5c0e40c9bbbb6b8d5ffbb8de635d63
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3c1e9853363d247270f9d500cbaa1df8f14d4f9
Message-Id: <177145533677.1584616.9847736815862598179.pr-tracker-bot@kernel.org>
Date: Wed, 18 Feb 2026 22:55:36 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 18 Feb 2026 20:52:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.0-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3c1e9853363d247270f9d500cbaa1df8f14d4f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
