Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9AD3C3F7C;
	Wed, 26 Aug 2026 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787769649; cv=none; b=MuaSrWAXapYi+yuiMFgI1Y21h6VPz30fQPUzGINYO3DRLVJnu0T3Tde0dNsN0pZ4yNwX2/LIvmH24+PdC+qQ3c4pjG2Ci6oVxmOpJnOWI8YHZ2g3dGDfHLgQbl7JOunrGRNWpzcv4RTcEClINOP3lXYSea1kfFE48tSb5khXqWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787769649; c=relaxed/simple;
	bh=jOd9Q9BK2otFcigHK+lsw/jgVTBqSZgx2P0EYU5JWgo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=j+Q0l33y8tGoG4r6Tk91EOEBUU7OifuBwPBANQ+E2eUSturcP474/RORzLE3jJhTZQGehiYKZ69Lj6kT7KKhsyof6FltwD7zbMpwFmL5G4fwZ7tyKr9S8RejHaqziOQTHknAwuFKG/FEGXVHpR7fvIIeY26baJsuE9EsJUsOUgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0Q5FQ/D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0Q5FQ/D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC321F000E9;
	Wed, 26 Aug 2026 18:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787769636;
	bh=BO7MKX+Q/I9ians4Xv9y89yBoLVPdUBnkwo6BcJh0Cg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=C0Q5FQ/DfGLhoCKMgeC2KW0l8828q9rKvPUZVESAoRKyoibGF7+mX0TiTkg1arjKX
	 SyIc9RczdISOwXW1SDTUq1+c26vyEo8JqHZPcTzmGqAcPKuvhjOtdLH5XVH8mih6pj
	 /fHl4jeXMWzPIbNhUGSSoOBhp1bjS9y43oMmnAzs2g9tUHdRdGQ2Y21vbXtVvPX1zQ
	 lP5MTqWPzjeY5ROvtNfdZd2yDybV0zy16kFkJrtO65sUMj35iJb6Rc0eF2UkOCXdch
	 QFhhqSjMSS/2g11zyI6iMuPKy2H4TJ0gP09pmczB0Ji43VC5XvZ/YB36eqdE+9TKAU
	 V6vfnX0wAS6Xw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198E4380820D;
	Wed, 26 Aug 2026 18:39:44 +0000 (UTC)
Subject: Re: [GIT PULL] power sequencing updates for v7.3-rc1 - part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260826081458.26747-1-bartosz.golaszewski@oss.qualcomm.com>
References: <20260826081458.26747-1-bartosz.golaszewski@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260826081458.26747-1-bartosz.golaszewski@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v7.3-rc1-part2
X-PR-Tracked-Commit-Id: d51fc9d4cd6eb18ac82913d83ecf7bd8c85f71ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5218c6474df97f2e7f3af15dcdfc674bae5c137
Message-Id: <178776958280.801398.7494324198135481696.pr-tracker-bot@kernel.org>
Date: Wed, 26 Aug 2026 18:39:42 +0000
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 26 Aug 2026 10:14:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v7.3-rc1-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5218c6474df97f2e7f3af15dcdfc674bae5c137

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
