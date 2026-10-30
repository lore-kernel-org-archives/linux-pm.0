Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793403208;
	b=vRLTpSLur/N1HC/jCLdN5cvWMR5t4DdWNpZdM/S2sRglQr96l2pU9SX5BA5h5r2mFpxx
	 GXj27TZne3cGG+XbQeOSK+G/eLknhLgUQG2f8kuHDm1g22oDsMZqAqUIP8hTDMCH+RSfX
	 5McyFSrSlVwpYgYtu/h0+S210yRJnnp4mEBw8+4Po6ue3TkGND7cGXJVesDZqvkz83Eqb
	 S4JWoboW4ixSu3smbuG5ahxtbYQrW3XeRb/U/KtIpWhChoRVuwnFGFWo1aN11CL5SXZLf
	 VNdHYgXvgRNsfp5i+1xfNRCKFT5BP7U/p5mn6Y0R6QJngh34YSdeqAiin2AQ5lK57lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793403208;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=rIM07U8EAAaNoo3eaOYwtWzXSWsnLrfbZ1zlbdtziow=;
	b=hdnsuZIElrpt65LSrpVzUPj/qTLmUQwIEWugbziXSOHyVZEHFhaR0bKEGSqQcssrs0Pg
	 Yek2mneQqEvZDmnbVwlo9ZNq3LGd5g8XSRwFmCunIpvzcx63zdTDdW23qRae7HgbTtcxt
	 VShHQzvLnOWoFHagBCoh01Xj7yBy+11hRH46Q5w0/6A0Ja4XgPNHWtPTEhAf5uNGrVeIF
	 Qf6TlKj0nx4mcz+XrRwa585FFNdnJKUyWjsaaiKCK1g5WpynDrZ34lY75DAyJseuf+k9m
	 M7QlbbI7JE0oXu7aEvty8mtUEw9NFLk8gpNl1F7T3rN1YjKvEjIns/M25iobg8AsfKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LJPSrhSp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB530606A31A;
	Fri, 30 Oct 2026 23:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LJPSrhSp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DBF1F000C1;
	Fri, 30 Oct 2026 23:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793403207;
	bh=rIM07U8EAAaNoo3eaOYwtWzXSWsnLrfbZ1zlbdtziow=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=LJPSrhSpGeflTyKGWdwmYydbo74+yAQvlHGbR2L9FqtxW3wgRkPwbpDBZM2Fg5Wu1
	 mECruXYg/f5x0n61cAggNAol7gBsK58iipo29fG/wYTLiQWgiXuSF+5LcXYmQHKFmw
	 WupuP4PEzeR92eNJIjtH7kSz/5wTQ9kdfsBsfg8ruJyNdRsKXf6i/gWTDbIB/hQmWV
	 uqn2wCGb47yZwIHlrOeZjicz/YDCyg3SnqJviOgzE3REpnTtYAWWiygLGnoHr/4Im3
	 3YxYWwNjluhFtUzES2ZmkrXZ3mbJSaQN+ew17jLMVz31K7OcRDcAAfek6mZY+SeiqN
	 ID1Z7+hA3wtFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA14C3800478;
	Fri, 30 Oct 2026 23:33:27 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for 7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iNLS=-XW+LeJTa5ttDJGs6AcQdMOxaFTCxhXu78jnsjQ@mail.gmail.com>
References: <CAJZ5v0iNLS=-XW+LeJTa5ttDJGs6AcQdMOxaFTCxhXu78jnsjQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iNLS=-XW+LeJTa5ttDJGs6AcQdMOxaFTCxhXu78jnsjQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.4-rc1-2
X-PR-Tracked-Commit-Id: 4358090906b01806ee483229e8d7163b806bd116
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a9547379cb381e2a036e3261a6becc17973ac470
Message-Id: <179340320624.1831258.3449648061474347587.pr-tracker-bot@kernel.org>
Date: Fri, 30 Oct 2026 23:33:26 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, Daniel Lezcano <daniel.lezcano@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 30 Oct 2026 21:27:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.4-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a9547379cb381e2a036e3261a6becc17973ac470

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
