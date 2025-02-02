Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000F83595A;
	Sun,  2 Feb 2025 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738529744; cv=none; b=tJkyJrQa+FJPJIH9Sk+uDCrpDgdUOxKFVSlgv7NxVIyF6whvtwqyQezYu3h1x1/9rJ/HVhQKjG5h6f8nbuj0oRHwpUfGvryBrAAhyu/JHmxRMMshKzbCOgGv8O4YsqKHr0VPm5siI2v/pNTTihUbmFDWudgax5TpVQ2icHONf7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738529744; c=relaxed/simple;
	bh=iR0I3EdR0iBssTSZp7kBFnWRXLSQCQlMDJ4XwMl5rfE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QPyOyRSuEVgt1RnwcvVhDNUAfJDkS+kBHVnoIHrLI/zt1eITAU4mMRJthQgXSOSHwzaxi/ieX+ddFTooz20Q/wlP42KkvcKtGOighTMbqJiZD8fZl3ocDePk0+/DNp2td50Ol7mRgFRP66oj1g5/byKhvgKs3w37yAeUrKOXtEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxjA21DH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxjA21DH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E67C4CED1;
	Sun,  2 Feb 2025 20:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738529743;
	bh=iR0I3EdR0iBssTSZp7kBFnWRXLSQCQlMDJ4XwMl5rfE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jxjA21DHBsO3EEkoI6U0QfRu+PfUI0QbsoGwx2NjYPe5JmjOjTHBLALQbDi2NNmTf
	 arLPkVqcMSfPnVF34NbdiCEcj5Drc52D186XuIn753AnBjiwVTOzO9J1EWWdYUfxhB
	 FLRT6PNF7nwalVVvfyFGOf2hji4st8+dv9ircNXNomwl4Kd7/ETK1tGk8C6R3ISr/e
	 M+SStXqls8rtgXbB2W+1htKNhHERJC6Hs6nMoKnb/NGtty9DVYbg1fWbL20zZ+NwHU
	 hSQx6qfFFZk8RrrgZV+fTWhZ41bhPlDl6lSlx24K1hoVQG/M64U32Y8X6MZD7j3akv
	 ANain4Ni3tqQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0C0380AA70;
	Sun,  2 Feb 2025 20:56:11 +0000 (UTC)
Subject: Re: [GIT PULL] turbostat-2025.02.02 for Linux-6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJvTdKmaGD8YJj4HKuNhE8Kkr_s5VH=DhXcc75xxHtxqcdYp0Q@mail.gmail.com>
References: <CAJvTdKmaGD8YJj4HKuNhE8Kkr_s5VH=DhXcc75xxHtxqcdYp0Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJvTdKmaGD8YJj4HKuNhE8Kkr_s5VH=DhXcc75xxHtxqcdYp0Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-2025.02.02
X-PR-Tracked-Commit-Id: 2c4627c8ced77855b106c7104ecab70837d53799
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d79bc8f79baacdd2549ec4af6d963ce3e69d7330
Message-Id: <173852977057.2208626.622267848896307504.pr-tracker-bot@kernel.org>
Date: Sun, 02 Feb 2025 20:56:10 +0000
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 2 Feb 2025 11:16:39 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-2025.02.02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d79bc8f79baacdd2549ec4af6d963ce3e69d7330

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
