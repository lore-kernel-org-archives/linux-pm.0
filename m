Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226FE72602;
	Thu, 10 Sep 2026 21:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789077229; cv=none; b=ujCK0hRgVOad0m+/skFWvA4caE7oblYoeslYb/2aLVfoZK8BmyW6uF2oJkuDrKESNHdK8QmFkpoo6B2yp/uIEUeG5KTuQh/46+FUnNLmAeWvYAb3yTkTuhB48ml/K31MVLWMauV7Afzjq0Nep1bW5TKHvZ+7LnIQV2lVKTatbpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789077229; c=relaxed/simple;
	bh=6T4OotmLJb1+GkMnCOi1nNaILTb/nstifvFF8FAHn4A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=O/RBLC1ps403Jq+eOltD+mAa97rJKUfpHxurk8W4C7IfdqLsLiXjdlYDkNmS1DsA0B16UfFJsNRbIpoS+fZXfltbf3xYaOeG9hl7CUuIhqdGgMNC/V9dq5jTIcMh91Ry0shgsp/ASgDoM9NbtLykcJOZoHjcz6h1cvVrSTgq2J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IchxZO7U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IchxZO7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5E21F00899;
	Thu, 10 Sep 2026 21:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789077226;
	bh=TPuseiK9l47TqzSAgSs3YE8yukRWz6Ih0866Sf4mwDM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=IchxZO7UOyaFc7sclwx8PwfrlZzd9RvGpOGVY7fwanhaRthGzOauP1LNh3NDmhBYC
	 G9aAL55jG35TKNITv8c7KAdpsJjKcJUsKNflQPsj+zFhLQQKY0CWONqs9N7ZcZfeeC
	 tbYSDwA8wZNdzfBDk79qxrzzoQ0Mk/5nYvr90/PXTOzq+bjgjTkuVGEqIjUqLby/FQ
	 fA/44tk9GUXGEDzKFbYXTw/znw7xzxEtznfllr+em1CdLurAZpgUjsk/KEo3x5zs0j
	 xNLZ+YJtKZhGQZ9Pyfsua0uBeI5ehH3O3FeakyDmRntQCef77ZIbZeSgq1hqiO2CyR
	 EsiJsvdgAODdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567FE380DBDD;
	Thu, 10 Sep 2026 21:52:45 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fix for 7.3-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hu=AqKVTSoLbid21uYiwBJpWQv3_3e4eZwge-DHdwLVA@mail.gmail.com>
References: <CAJZ5v0hu=AqKVTSoLbid21uYiwBJpWQv3_3e4eZwge-DHdwLVA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hu=AqKVTSoLbid21uYiwBJpWQv3_3e4eZwge-DHdwLVA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.3-rc3
X-PR-Tracked-Commit-Id: 5ad0af4f4367202b1bc71813052fe39b5116cdb9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 08df884136f1c1197bab2a27814404fd329d9aac
Message-Id: <178907716395.2100681.11014942821489271020.pr-tracker-bot@kernel.org>
Date: Thu, 10 Sep 2026 21:52:43 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 10 Sep 2026 20:42:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/08df884136f1c1197bab2a27814404fd329d9aac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
