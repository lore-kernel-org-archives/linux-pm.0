Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793484479;
	b=cb9O9hQj8EEixmoExhs6yhMWznf9nfGd6hnp05A0RWDoke/R2U6anVAqr9sHVT9blS/G
	 y6wEQuqb8GC+JCFb+AG4lr+Q+i18vG9b2RXKsk3GM3OJtpXJfKlbMybrYMnlSBVQLJrIK
	 W16jjt53unqYaaLRwcOi7L6+DGGVm+2ZdzlRk7w3atRnNOcdt2y91Buttg0Y+QvrqthAz
	 SJG+2clM07bQSIHKC0mw2LhUxcp9qjXSebmI2GaAJ1xcr28HwpJSAC5wKXeLt/rtsrQkV
	 B4NaLa5b3QUgk02II3jHb7AqdJKcWhPbCWcnv7dZ+Graw8UmybQ+XDYpE71zEmC6d4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793484479;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=pVM/F6r1u+9sqB6YyW3LUP34epjkmoZg2hZgxW72uU8=;
	b=3ZAxyEObIpU9ZzpQ/j8aIbwYjYTJs+F+EOzM3asTORddDKiSmfHRaHDoCPfBx6V8PEi0
	 mUJsTj8ukujEcB9Nd966/Si9+jRRTKmJcRnH7eLVj90H9Gqsm/oEn5gmFnHk+EtBse1ot
	 ru0fRZ0wQ4sbA47rRAaXMopSdZ5HC0Fe4o7ZtpHn5YwGdP34P/ZTKAgT+kY3j4RlOsy58
	 fMUCZzJtLtaR48f/nSJQuZOjsFDO4OhbSpTwyxc+toa2frG/Qcuof18nlJc2wc/h9fe3U
	 O1klWYYguBDQGPetMdZs2QjvLQDNaMTdWfeZGCUW50xRW9+Cumd9CW+9GgCm+X2IMsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ITeYwi5s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86D8606A31A;
	Sat, 31 Oct 2026 22:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ITeYwi5s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C592C1F000C1;
	Sat, 31 Oct 2026 22:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793484478;
	bh=pVM/F6r1u+9sqB6YyW3LUP34epjkmoZg2hZgxW72uU8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ITeYwi5snuV6YIE459YYCNHwp85m2TM66B3Z3DgLuP1x8G9SXvmXjSAYisSmKLEr8
	 yfUJXDJh02rWgogk+RheM5xLZI7GIWsvB9MB3zOMc+80NaVKJV/uwvTqEO/98Zwwtz
	 yUI8LFHqkNEHFgbkCW6wI3tAD8Y/QYDSUfOuEBYj+BZbO+eFa6EqqWEfCUtm4N1s5c
	 XfCMr+KcQ5Sk3ASztdcteqk7CIhgNK4RhPym9ImPZMg7gxsIs0Wq/jK0oaLtisYxHP
	 rT/4rzyibrdi6CtHmq5iRgWxej3VOo3UO8peN1wkfdCuSdKr6mgzi2hXdUY/jFb6nl
	 iVawoX1G/NEvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA48238003E7;
	Sat, 31 Oct 2026 22:07:58 +0000 (UTC)
Subject: Re: [GIT PULL] power utilities update for Linux-7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJvTdKk8oCKTDyzyyaruaTRQoNLeKnZJofiN6va3=fm9VRmGNQ@mail.gmail.com>
References: <CAJvTdKk8oCKTDyzyyaruaTRQoNLeKnZJofiN6va3=fm9VRmGNQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJvTdKk8oCKTDyzyyaruaTRQoNLeKnZJofiN6va3=fm9VRmGNQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/power-utilities-2026.10.31
X-PR-Tracked-Commit-Id: 8969e647d0322939512041b9685cc5f27753dd8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cbbddb6b08cc9900a87cccaa9b22bbe06aa4f50a
Message-Id: <179348447724.2250476.3945151745660290514.pr-tracker-bot@kernel.org>
Date: Sat, 31 Oct 2026 22:07:57 +0000
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Sat, 31 Oct 2026 14:48:50 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/power-utilities-2026.10.31

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cbbddb6b08cc9900a87cccaa9b22bbe06aa4f50a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
