Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAEA23EA8B;
	Fri,  1 May 2026 00:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777596367; cv=none; b=n3a12ahYIMWPyn4jLrnbGMV9WN6t0gzvymJ1sBjXK6FOgcGvUmIdT+U0/OoWGWKeXE1Q69jUQYQ6MNmHs2hMwHz5J6MhMv1uNGImooF3E6cpdDusBVX7xnWt7XYL8pYgz+y4VsigwY9wlt6AY5chmd/bsIFruWuO2Uzkb8l4/1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777596367; c=relaxed/simple;
	bh=E2Su34UdUkQXiU9vJQOoDZrEyBq5CK96/uL6owFRBb0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ur8nJLSsPPh6nW4pV7/+HfL3TG3fAG5815OmYBykT2RIcfo84QwyOBJFdKHclc6CgoFO9dv54TUuNMvqaHXdhBJq3Yx9FfUpYJivycMopN8mf27Piq2REXMbb81sqHoZgNu/VAACiAcLyBsZgFT86FII5uXGrWKAfZC8jM8dHzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vgs1tGDy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vgs1tGDy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E70BC2BCB3;
	Fri,  1 May 2026 00:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777596367;
	bh=E2Su34UdUkQXiU9vJQOoDZrEyBq5CK96/uL6owFRBb0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Vgs1tGDyOsGPyv7AhzKiuJ3cEV/YvMOZBtXbHwIXU5KQnVsuhmkli3Hbx9zXjkc4T
	 VbawAnmPc+z52JQSPj8YhKmPwnIxzwgpM93z8l9U3QkMJ59HFTkmle90n7rZl7tNbh
	 O+TSaxbAD60ZjmjjtCBx0lHE3/rzUpLyQGMcDiRDBcN5KaMhhxzX5Tus9+ygiRTs3W
	 b7ouKJQ7UE+B4mchxBTWjluulfA1FR/yKNYt+wypYgVOoDoJpYQzobQ2Ii71/Kh3pR
	 +q198O5QLjxIoSpUdTMQ8wbu6R+DXJ9+n5G9EMKGD4IT6jfxn6l5YT79mXJX338Ccu
	 HuQDxm6acJwwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA01C380CEC4;
	Fri,  1 May 2026 00:45:22 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support fixes for v7.1-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ibhdW57s-68e_kHCZ6b=YXi5o74ykS=pd5vRTiXnbsAQ@mail.gmail.com>
References: <CAJZ5v0ibhdW57s-68e_kHCZ6b=YXi5o74ykS=pd5vRTiXnbsAQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ibhdW57s-68e_kHCZ6b=YXi5o74ykS=pd5vRTiXnbsAQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.1-rc2
X-PR-Tracked-Commit-Id: 36a96eda15bf66a18ca472aef9242e57551016ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cae4ef6f9a3ac71094da2b1083f6e2db699a2c1e
Message-Id: <177759632137.3267405.4931494141895798877.pr-tracker-bot@kernel.org>
Date: Fri, 01 May 2026 00:45:21 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Apr 2026 21:29:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cae4ef6f9a3ac71094da2b1083f6e2db699a2c1e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
