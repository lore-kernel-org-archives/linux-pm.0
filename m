Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508333;
	b=m2Ljq1Bdm7CR4gwxyKHe/vTj3KAgp/whnf0gNuAj4PNpoRwyD+03VBNq3lBIgZA2cwwX
	 gsyVpSh5/P7R8a28Pu00CsoL8uTVqmlpb6kc/YWyGTdiuci7Ae3hoEB0XZUO2TO9kJ5st
	 mto01/eL359GJj90MXPRi6uRcPjue7RjoARgyk3EK9fBsOwbHVT76j4iL9TXAOMEjIbHb
	 KCLBsbe3DzeGP5Jiy7nxev1NrpJUYrwI5WvT0XpgUerZxRyTHj9QUV7lS+rq0PzePnC5B
	 wH5ShemsUTImdniZF26eVHWpzKwyKyh+NKlpExq3o+uN/Mv7NOw5BDdRunBUbMyfqRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508333;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=OFffBC/0A3d/er3CdMg4bNbeiYQPAM+yiSRfBJ7UoBI=;
	b=m+wfvtT/CruOOkuMGgtNxyyaWVcrwp7wE1c4FWmVoVe1Dtpv4CBjJ/CE068OT9Uo6zdc
	 EuHUBVEJ+Q8Bdwn3wWyBraZRw0MuK4x+2W69TyGszl/DmaF8yBej6ZM2Di5LViFxAeZOc
	 L8HiYdIzdORO+asPCpUug5VCyqVQAeM6CKbhw8Pi5VHo/z2cYDKjmT9dE3ZpZc9FPZZ+m
	 8JVPiBQvyVyw2vkKcr1Lgd4uRh0QW2+q3uMgTTI8V8T/Vd6x0O0Ujd7jlkuo8t+QcPgs2
	 POknYC/zMfSS8yevRt3sY2ZbCEuDNnPwfzSr1Lxbr0o2t9IbmY0usP6HbJd+0aNuhww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZvUYUxVp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC6E606A32D;
	Thu, 12 Nov 2026 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZvUYUxVp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0989F1F000C4;
	Thu, 12 Nov 2026 18:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794508333;
	bh=OFffBC/0A3d/er3CdMg4bNbeiYQPAM+yiSRfBJ7UoBI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ZvUYUxVpunT534DCUtoCQU5mPaEB+Pw9ZoL923/npMjc7bKCVRijIOhKI8SdmhBg7
	 Xe+0fk3DGTzt5rRkidL+q1RJqL/pPFR/jZydwN4hiyGuOrAQolaW4duMhl9uTP1C1m
	 b/64Ad/SpLoVYe/UDrGCSj/Pev4WTCtmuGjOtwRbBG0cmBWpjZecanwdu1+vfs7vZJ
	 Oo6iteFDhN65n5+vzXGkQ7LgzSWxmJ+y0ExCiZG50yMx/l3wx8gk+h40GqgitGCE+L
	 TrBqzg83ogS6wotmIHRjdsl/S7HLBbzQ0uYuDtprpBTqQ2ehVcENUDrzoa52MKspAi
	 CcBLkNmsHbszQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15B3380AAFF;
	Thu, 12 Nov 2026 18:32:12 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support fixes for 7.4-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gEHWcCX=1cDRUstU5m=9_PQqfD-PgJfrF4jo=0hk4NWA@mail.gmail.com>
References: <CAJZ5v0gEHWcCX=1cDRUstU5m=9_PQqfD-PgJfrF4jo=0hk4NWA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gEHWcCX=1cDRUstU5m=9_PQqfD-PgJfrF4jo=0hk4NWA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.4-rc3
X-PR-Tracked-Commit-Id: 756a3f9e02913ca1616ee8ed4598b1208ab8e9fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: baa6744dc939a927e2c94e5f20aff01ac538aef1
Message-Id: <179450833162.582195.4050505416215162819.pr-tracker-bot@kernel.org>
Date: Thu, 12 Nov 2026 18:32:11 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Thu, 12 Nov 2026 13:46:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/baa6744dc939a927e2c94e5f20aff01ac538aef1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
