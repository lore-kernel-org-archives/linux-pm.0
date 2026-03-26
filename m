Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4C6379EFE;
	Thu, 26 Mar 2026 19:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774554525; cv=none; b=mmvz22lbV8tTCAYmY4V/GNAbQYrf1Df24Ox5cZ055tjtbDKeiRriLrrwHBJP4+4hsAQ83kqbqLPLOt8a2qGft4247lq5r0KoSOu5CKe3J1iWWoLqlN9jIB2peU8GoeSVbVHcWQKm8MKQycfSiYQY69dR8uHR09ARs6lSHvRGCqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774554525; c=relaxed/simple;
	bh=f7Z252nwU1tUA55ImTI1yJgcp83zFnnlGJgbYAxYmVo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XpYEiRrPxj8xHQrCEBorfwKN58nrwy0dWyzdKUu+PGy/aLVvCv+MADXUs8aB1ezUKD/+BSaTMiVDQ5Ahm3TcRsqPy7jyBG9iIdWRrjo58S8Uzyts0mflw2rmxYCo/xC35QOXWLz8aplmqeQwtSxZkM/xWUOUwWdsprnW2n5BaS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvEJqk/0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvEJqk/0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9251BC19423;
	Thu, 26 Mar 2026 19:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774554525;
	bh=f7Z252nwU1tUA55ImTI1yJgcp83zFnnlGJgbYAxYmVo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QvEJqk/0DEq6LX+rbhkpAc6mUnUEaXSbot78rWpBHOL2TMf/juEYb9B7eySVXsCrU
	 9yr1CrWIFM8rp+laeRBvxnoefFozYc7bhWNsDEbPl+vAj5CCijNG9uHx+r8d9mGv2+
	 F4uhn2sHRUn5DQzhlxQxagedOC9blUFlZViSxqEvRFa2u4dXYHFinrUqcWWlU0HOgw
	 JVjjyp5qoJsMWRDbGpBqRT/tEJqs3DOB+MS25nFAqIDJgoKKqFS+DE5KQciweNdEeF
	 BOW8hh6dspd0AKxuwQWGWKn5sNwoo1N+36CP4ypmyGlA/TLfwnzy+KImCWUo1ze0/r
	 x0HT3U7X9N55A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD4E39F2038;
	Thu, 26 Mar 2026 19:48:33 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v7.0-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jqdP-n4H+RXvVPyHhtGLCWs2gma_FCrDOrtb0QqcKJHQ@mail.gmail.com>
References: <CAJZ5v0jqdP-n4H+RXvVPyHhtGLCWs2gma_FCrDOrtb0QqcKJHQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jqdP-n4H+RXvVPyHhtGLCWs2gma_FCrDOrtb0QqcKJHQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.0-rc6
X-PR-Tracked-Commit-Id: 042f99c493c2cef3b15de2df19c06df514d39ac7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d813f421930c5b01b9f61043932de02602dd6ae3
Message-Id: <177455451186.3152977.3629336594655459216.pr-tracker-bot@kernel.org>
Date: Thu, 26 Mar 2026 19:48:31 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 26 Mar 2026 19:12:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d813f421930c5b01b9f61043932de02602dd6ae3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
