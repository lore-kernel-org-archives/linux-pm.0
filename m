Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381603FE37A;
	Fri, 21 Aug 2026 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787339514; cv=none; b=AXM4JdmsWqvUqtWAIiDDFesHcWyPznIdwkOVuwu+CccshNs0AfcjMc+yiMK6n+c0zGzduKGsVTTp4cmGkZcdcWSNPb0uhnjEA21paL/LawPDnaK+slhj10TJAniWJbCl9DovXrawL98crP5Ta3Pw6ScPey4qEh8Bb8xTaSqe2vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787339514; c=relaxed/simple;
	bh=liIIB40cePlQcTd0tKjayiFmh3SJ0JOu7OqTzw2NkCA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=I4ZBTyy45ZwFBRGPYXdGLxc7udFpuLhrNmR94adHAg8aNuRSteUBFwXt2wOu28sCAL+g37cVV5XtnNOYTUtYdXwEu0YpCBZxl851NfsW6ek0aRe/9uJjzJA3f5EFytC3qLUMXEKPBiSTsSQSnJqWZ6lO0tt91CIS4uA/OgLAU5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIbN8+LY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIbN8+LY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143841F000E9;
	Fri, 21 Aug 2026 19:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787339499;
	bh=oqpaqjjeipbOx6aqJScI7tpAg0WQMoc6Ns+/lcOlImo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=nIbN8+LYl6gnG8ERO80RrYO5Mnn9vLo1GWkdw+BNDI7SO92wmquRwlGb/EL38ZnFJ
	 qtvrhkivGA0d+eIgupGYp7Gb40bb/NnVRkXU5MbApdG1O00bkn05q1gmy9mAr07Gql
	 28Z8h6/rMv9nuIJrsku+p+fd8IrVTIJVu6Pula+jT5Mrtk9l/Hk9V49usnwkc6QeEP
	 ueySy07C4zcUVcN3VaTuO9g8N7cqzVtuxSH+KxqaPNkhzvIkEVC8y2CuAZDwdnEWu0
	 gTfwZmyYLsMYV1ztGHZA5rUsAk5T+4F+1IIQFT0Fl6IE6RjjAeRLRIky/OH3mV47Cb
	 BZ00GWGilQn+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0851380CEC2;
	Fri, 21 Aug 2026 19:10:49 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aohPKghrdr9zgDa2@venus>
References: <aohPKghrdr9zgDa2@venus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aohPKghrdr9zgDa2@venus>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v7.3
X-PR-Tracked-Commit-Id: 2da28b059e0ddcd2e1956eeae383246207965573
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2be02a7c996aa733bb36e29e07715621b0de9736
Message-Id: <178733944863.1438271.17527552579842317668.pr-tracker-bot@kernel.org>
Date: Fri, 21 Aug 2026 19:10:48 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Aug 2026 15:15:29 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v7.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2be02a7c996aa733bb36e29e07715621b0de9736

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
