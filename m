Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFD3275AE4;
	Tue, 14 Apr 2026 03:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776137731; cv=none; b=Ltw6qO7833y8M5JlgnU1lu1OTQM/8YW2HCqknfgLdHSM8HjY4ExZjm+esy37CEQ4ntGFn5RErW/wXclINzWthHnK8d4BSvv0e/n/sKphyi5ElEG3JooWJyy0a5N4Sd5qN/fI7v4mdQuTNGMi2G9VMlLG8CoB0Cah+H9Dog6a5rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776137731; c=relaxed/simple;
	bh=+5x3RgaxqlH2lytE51Z1TZXv6DOWyyCB6Z3fVvfW938=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U2vOT14P5qYOdK/bh1Y6rBkRMU//izsFnn+mUiNKYFOyWPUBmpfmGZ3HaOkEhQdT5lHS0DjqyZr+ilnh5SHwLPIaibAz9QJJwHocYoBEEiSVmdKcH4zvA7D/a1b3CQilMLEwtHwXTHqZCICi60VbFa+So1bs0f/KpAM/AeUVLfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxCc7x73; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxCc7x73"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00146C2BCAF;
	Tue, 14 Apr 2026 03:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776137731;
	bh=+5x3RgaxqlH2lytE51Z1TZXv6DOWyyCB6Z3fVvfW938=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hxCc7x73CFOUylQDJm7oq1LfWAW6odXdZy2YXjQqVYVJAwVkrEbNaxwWHcgjhBMHW
	 T0UkPHyjJFdC8RnVHk3VHZmQUDyp2DIXme3g5FDJmggeMeDpUv1mq3szVnq8T8wgs7
	 zwfYic4zOTteGhw2cte7IHlp6m8igbGGDq7EhWgytwV1gjV99y0tPK6Glt2wNNP/CM
	 WdrrZFwnCh/VjoVz1RxDyf8PUeMF6jqEE6ntiademDhPyMose53S4fkEscpUGmt0pe
	 ApzHE2ea7rqVJN+danq+cGanjjvg+rntLCaiE7h5H/FP2LJ4kyy0oNDZ2hF2DKApbq
	 Lj4Vwrdp772rQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4010B3809A0B;
	Tue, 14 Apr 2026 03:35:03 +0000 (UTC)
Subject: Re: [GIT PULL] power sequencing updates for v7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260410084643.14631-1-bartosz.golaszewski@oss.qualcomm.com>
References: <20260410084643.14631-1-bartosz.golaszewski@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260410084643.14631-1-bartosz.golaszewski@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v7.1-rc1
X-PR-Tracked-Commit-Id: b4464d8f313f903ba72db06042f3958a9a1e464a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d60bc140158342716e13ff0f8aa65642f43ba053
Message-Id: <177613770182.678926.3794023254462078709.pr-tracker-bot@kernel.org>
Date: Tue, 14 Apr 2026 03:35:01 +0000
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Apr 2026 10:46:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v7.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d60bc140158342716e13ff0f8aa65642f43ba053

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
