Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508338;
	b=MMf+94oBCYVcjtkGdDEUhSX0VmrsGY8MEKESb5JcPdsH77H49FrembPWAtfYYfyN3qdA
	 plwO4Jv/meJGG4s0xv4RePddaJ9P9KcrEiOM44NcxKU9kRf4+47fntGRz0snYw7lnT9Cv
	 Zao2c+udo2C56G3OcXFZBHFcLKUl2MSYL27fug6gztijXdqR6eAL4EQ0i74PI0o2q5FWl
	 652XyKkKc0oIRYtX4cUChk9JjXBueo72O0WeGkttqv5KzgGYMX06YDn2VrQgPge+eja7l
	 5Xhw+TKQDAqJCnivxkNcNK5BXiL7nLouWBhMZUeKWD0lf9tjA31DKqTc0fcfE3uF09g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508338;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=UtrInM4WXP3OiVCxbLZnTOrG46n0QSbtbo6kVjx+2FM=;
	b=ktUFQSxo4b1b3c0HTsTd5SwJ4gJkyOB+ZeXejDp9k2s96WNiR6Bl/qk3CQuCOUULa4rN
	 8lqHBWisFeOWDcns40P13FQjCUR7MpozxehDl++I4JReOjPqzHPYoJgAfIaE8YCzo0qAf
	 JG5pMzBb8a5jpolnHq6JYTt0Wqo0RTmQsyDLQWUtWO09bnWvhe+v98ti0NYhSdn9Etubp
	 JEWW7+5MmyTTKISN8BbgUETRX4DJK63Ox4K+MOzKX5DWi618N2agn5ka1NVsUaDNS6iUH
	 4o83KvenfaRBCCfl3ykhdDQ4wf8xNTBNYA5HqLLIHb0kzzPhosHlZnO9J+ku8qd6IBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="If6/QzkZ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6947A606A8BF;
	Thu, 12 Nov 2026 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=If6/QzkZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456F61F000CE;
	Thu, 12 Nov 2026 18:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794508338;
	bh=UtrInM4WXP3OiVCxbLZnTOrG46n0QSbtbo6kVjx+2FM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=If6/QzkZgApgbEpup77k7k3JHXnq5OIzFwo5lmYAGVxv64xgH1kBIL0ByufgM5IY9
	 vWVr2Lj6pIW472bQKQSy/ylYFcQHEHs+3xk8VWoHr3zw9kwyFOmG8dBYi/uu0NKDGw
	 3AT+6c7sHUBoEFwl+hD672pSAfTKMAGBWKEGf5QTzxUwfJ3KlucWMey/CquXf9KJ/s
	 qJ+CcwIZoYPbSiHtnb2Vcxus5VyptbFcxsdf8f0q5xl960eODBTLE6BtlSHvU/va8G
	 noqwnEy0dWrBIRGzk1b6gXfB6IZA1CD1jcvldGRhXv7FvRwWrbzl0k/eEpCyz75g3t
	 S4i9rpqvYdhPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A520380AAFF;
	Thu, 12 Nov 2026 18:32:18 +0000 (UTC)
Subject: Re: [GIT PULL] power sequencing fixes for v7.4-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261112160359.52742-1-bartosz.golaszewski@oss.qualcomm.com>
References: <20261112160359.52742-1-bartosz.golaszewski@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261112160359.52742-1-bartosz.golaszewski@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-fixes-for-v7.4-rc3
X-PR-Tracked-Commit-Id: b149b12f6a52997eded725ae5deae24620dbbbff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ee83899302a0457a3ba47464a13e8682bd7ba27d
Message-Id: <179450833666.582195.6902228095481378714.pr-tracker-bot@kernel.org>
Date: Thu, 12 Nov 2026 18:32:16 +0000
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Thu, 12 Nov 2026 17:03:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-fixes-for-v7.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ee83899302a0457a3ba47464a13e8682bd7ba27d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
