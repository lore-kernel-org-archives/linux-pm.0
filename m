Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FC246AEEA;
	Fri, 22 May 2026 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459933; cv=none; b=cAynMiBWeZKASbAr72Mk1hIwtujVFs43zgcMjJbVcqk6qgCL8e46l9WGcg+ptyESlpYMtF9XqSVZl2QtJHBbECuh2X2L26Eh5ULzFWzZzjQ0YgKTi2c8bnZQwq1in8TW79hoQfzKWQZiZyvmR1EP5JlCikTLy1nJt8rCh3NPso8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459933; c=relaxed/simple;
	bh=RTiVAiVJw6+7yX5EM9D81mUop3wtWqx/aSzDmKYRhkc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dxtkhQs2LkPmiuS4S62N+9M0CPOgdhqo+ZF8OAbA7ocYo3IDdReKQ3zub4URrCvmJWQ+mhvZc1TALqXFwq+nt/qkY0TY7lJ8bTwzPcIXXJVT0Eipaa5RhMm3+Y/anmw8rufKx9pWVaxstf2WZnoIyZHPy3Uf3omt/lQWZTsAwcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2U97mFR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2U97mFR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDEF1F000E9;
	Fri, 22 May 2026 14:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779459932;
	bh=zMzKO5hKPg8Pr4qCVF6+4edukAIZ1TFtad3cyTaX4G8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=o2U97mFR5VW7+ivVVPRdNLpvIiRSJuG0lltHVo4UbvNdVhvg1Pog6i/N8604ki8KA
	 O4wPmeiDFC/dJzbPwwDSOIZ1FehTNeSJdrX0I/lwTSVv0geUOvl1YprLivaZc3JRSh
	 fmWqF1VYRHfh1WVVbS1HQreg3G44AbwbzXHfvjAQU0el+/JKd8yIcpx8qhDWsmeEWZ
	 bE6TdocUulIMV+IuPI5at5tTAWNQif9bUGe8zQmfYRHJXTX2vERp951B8iMzkAgGG7
	 QLiEUSMuZaqH7bvMWvTdYX/sNcg+hH05NhJBI99N2XvW/4FvmWnpxzKfDppmAlxJwA
	 MO123Lj0nRVEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B92392E9B4;
	Fri, 22 May 2026 14:25:42 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support fix for v7.1-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hcQ4bOP_5krEuPCVasPYfJxCjq1s4+ot6bCyhAtpFmkg@mail.gmail.com>
References: <CAJZ5v0hcQ4bOP_5krEuPCVasPYfJxCjq1s4+ot6bCyhAtpFmkg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hcQ4bOP_5krEuPCVasPYfJxCjq1s4+ot6bCyhAtpFmkg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.1-rc5
X-PR-Tracked-Commit-Id: c35cb4fc7231702d1e9952aec1a442f3e27df6f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28222dcdad2181e3b153b2300ac4cb9cb3304fd7
Message-Id: <177945994127.1238704.5422154051070299393.pr-tracker-bot@kernel.org>
Date: Fri, 22 May 2026 14:25:41 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 May 2026 15:01:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.1-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28222dcdad2181e3b153b2300ac4cb9cb3304fd7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
