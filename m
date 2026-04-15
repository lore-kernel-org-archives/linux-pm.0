Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C663A33F5AC;
	Wed, 15 Apr 2026 22:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776290475; cv=none; b=tDoZl43MUJ3PWX4E4jSvTXP3xJ8/RQjK+dUa0W/ToAdg6C/XF88MoOcRNAsk3XHusP4ee7dbGafZ6yrEa202TKDZyffShmNlfx/D9bWIz55tWVFWk9gRoUguHlQxLy8LCAf3rBToeXPRDcoujTWrjtExSQkK53tqJgUevd1e2tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776290475; c=relaxed/simple;
	bh=Cvv7WMMiVOX5VAT00vi45hE1b91zrk1QdOSZLpJBYvQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BREkiqx8yzDvNEHpUtU11p4jLjOXnzLn+8Zo2geI4+fY1wL6x1sMwNdPkgeQKKGIaRFQt7h9H00sQA/q/jrHcGTB8uoz/+Vm/UGiwXooDS3nQtrynGOjAShxxKoa9FLe3y99lpZczlQOMTDIgfDlUJub4dKJDnR7yc4HeXcoPcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOMc+B1Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOMc+B1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC416C2BCB3;
	Wed, 15 Apr 2026 22:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776290475;
	bh=Cvv7WMMiVOX5VAT00vi45hE1b91zrk1QdOSZLpJBYvQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hOMc+B1Q896nnOl46V6R2Mi4zZ64HgnTC1WnopyYt7QNb90Gi0Owruf6fQR8mQYwJ
	 9idLR6RHx+x9yyi/1+rpKpI//fyrBMfdhyqtZXfMK6iKxDngKYWWAubiUGFABteqFi
	 7CdMAK7NvgIcdFQ60XxU/Oh2wRgVkLUu7kRTcf/E67SB4dlIrfHKqbFyM7izViSmKq
	 JEt3WpLjqeUaB5mwFjVQg6KXdm2D6F1J5XJonZy0knJUlzz/NlGMwusY2DYSrMRQKN
	 51lqAQf+qjIp5YJhJTMYee03sonXq6CmlOb625x5Xojz6XHEX7Wqp2uoEvXeXrYrK7
	 5k1rsNt55cldg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B526380A964;
	Wed, 15 Apr 2026 22:00:46 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain updates for v7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260414103826.161076-1-ulf.hansson@linaro.org>
References: <20260414103826.161076-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20260414103826.161076-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.1
X-PR-Tracked-Commit-Id: 596ca99cf04f339db2ed18a5bb230ee11a47b699
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e41a25c53f96abe40edc5db1626d37a518852d84
Message-Id: <177629044491.2457809.14724201696656005362.pr-tracker-bot@kernel.org>
Date: Wed, 15 Apr 2026 22:00:44 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 14 Apr 2026 12:38:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e41a25c53f96abe40edc5db1626d37a518852d84

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
