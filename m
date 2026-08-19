Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DB348EBF6;
	Wed, 19 Aug 2026 17:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160067; cv=none; b=XoqNHZlnfVvAzgCnnw99CeVWCV/2dhyWbc4i99/kUDJ9fnNID5x3PRh51rHryB/a5WRwinbERK5MiUfOCngarpdwmqJvGVAMThdOeSGNw8zxPqNTcalix/Y6QhehOVyzXpOt9xDy2WpYEiw/SdPKpZRfpTEemSRSC7tsHgKWxN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160067; c=relaxed/simple;
	bh=tRUurqDXoNOfocrY+UxNfcHmgSJHV8gmomC5Z8GIXEM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KivFKc0QH9Qkkr0LLtfH66I2Mpe2jAfVqVjSnHZC5F2Y7TuGVkZbapp4W7qmuH4CBVlW9NqSOb5/KIC1e9eFROrvg8r6HK9WKUlc4Ugv0aRzIEcF6bPFWqYt0EcnYVGVMUNYdAzgfXWbeMwV/4bMK+bq9OUA0tL2RygMfK/cs6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlVrEGQ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlVrEGQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994411F338C5;
	Wed, 19 Aug 2026 17:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787160053;
	bh=q09MIeffxh9uHj3whXhkUw4sMsPh+iJvKHP6K+054Uw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=GlVrEGQ78Wa2NVrDHRpA2GypTDfBNjclcnTpeEDJWi9HptyMg9IR7yMCXiigIL+ck
	 LpreaALXgFCEnTV38KmJFjGK9Uc2SrpBYwUset/2y3FjHZpXcr4rxDcl9la408iUmf
	 KWpY4loNRskHYezhLeaJlhgsTGG9bS8tN+REN2ggQeeoU1V0qIp4R25zS9ngZm1pe2
	 C03VYmMD6i7bjBw6SiHGAiIdrQTKKQHsZV5T5lcXw6u6lJs0EFTBVXsEV5OzdmnMqk
	 KQAVy5eJ+k7Cuzr6Nam0QDaGVXn8plEN9//M6giedWQSGgXeqPi063D3ZMgU+ZsZ2i
	 aLwYaDkHqFgwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BD19438119E7;
	Wed, 19 Aug 2026 17:20:05 +0000 (UTC)
Subject: Re: [GIT PULL] power sequencing updates for v7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260813082754.9972-1-bartosz.golaszewski@oss.qualcomm.com>
References: <20260813082754.9972-1-bartosz.golaszewski@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260813082754.9972-1-bartosz.golaszewski@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v7.3-rc1
X-PR-Tracked-Commit-Id: a39ac4651e3b9d2ca78b6d3dc2a81a6bd25fa616
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0d82a84c965915ac13d08b726b4cb440d90b122
Message-Id: <178716000454.3599392.2484292795060051827.pr-tracker-bot@kernel.org>
Date: Wed, 19 Aug 2026 17:20:04 +0000
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Aug 2026 10:27:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v7.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0d82a84c965915ac13d08b726b4cb440d90b122

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
