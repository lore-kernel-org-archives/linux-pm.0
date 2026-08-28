Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99A63B42C4;
	Fri, 28 Aug 2026 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939429; cv=none; b=WZCRr8t/4PehQEAx9z4Sh28UXQF4gDw/S+tApdibV7Jipa177MI7k9kpwun1E/HRWmRPIo2AfrLP3M+GnPdqMyIpRv3cNmIYIk1PWk6uA+n02rMkCU8njQKQ9ydyuUZf/lt5N9jq2qbJbk9pj10CW/ThIlSBU/V9p/UfLd5M9oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939429; c=relaxed/simple;
	bh=OBSOHEA9enDimSlCYLaa/VvzdQu3fnthFdBAspB46lw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BzZqb7jd7yPjCQl4geQ064q7mR8YjVRFZujVYZa/7zJ23KtGNwHP7uz4vy53u/L/Ypr3yHeBc7BCOJbTZqfJxoEJ9FXI5Wp3eX5os7V5UNXaJ8ZEOyag+oWioJUsImRG4VyGpJzFv/HLAHUD2XTr9sNtljctSqhSPT/nSiIPufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCYqRkfE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCYqRkfE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458BF1F000E9;
	Fri, 28 Aug 2026 17:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787939428;
	bh=XntAcv8iQPyS1VXnsHoweRYIAdxgFQhXuceRGWYG8q0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=eCYqRkfEXup5hFNaBshPoW5soNWfEotQm8yBQtBuSu5e99oAZQ3K2w3sNH/cz9gyp
	 vSSolUECzayVlSSPe6317IPleHzBNDifBxneYJlb/CFbGMqIzN8pjyzesdeQDEuWY1
	 GoW5oRBn4d5lZDhpD8M9Z8v7HkCquR2D964jY0hVdFcNiFtLFPjkl8HmioGSm7Qrxw
	 kP6T503TgqWrRWr+wKxl+pl+Rv6/eUCy3odaSOzHr5vjP+yvcyl5BmJenEpnuVRXBa
	 7Lsk4dUHCEBcGheSYCa2oyqRFt608dS4VW34ll2IL6Q8hbLZJGPQ6uUTfoQZhT9x9/
	 Zw1NaTetDdopQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B90380AA67;
	Fri, 28 Aug 2026 17:49:34 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support fix for 7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i9xVAS9XWOOfB58w9oA5WTUQnx=QfLo=7Nnsup3KS-OA@mail.gmail.com>
References: <CAJZ5v0i9xVAS9XWOOfB58w9oA5WTUQnx=QfLo=7Nnsup3KS-OA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i9xVAS9XWOOfB58w9oA5WTUQnx=QfLo=7Nnsup3KS-OA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.3-rc1-3
X-PR-Tracked-Commit-Id: 3b446d169a93e6abae9a93535369fa18bbcbefd9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 344be13211d0fceb791a7da70ef810ad13340fe0
Message-Id: <178793937295.2708560.3128394683288620075.pr-tracker-bot@kernel.org>
Date: Fri, 28 Aug 2026 17:49:32 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Aug 2026 17:47:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.3-rc1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/344be13211d0fceb791a7da70ef810ad13340fe0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
