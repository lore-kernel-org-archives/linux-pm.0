Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEC0318BB5;
	Tue, 14 Apr 2026 03:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776136225; cv=none; b=qNDBM0X9ZQvZnfFe0c7M4AAT80J6y3eGBxqcnC8+coU29y4zFVYFQhBCE0ncngf9Lq66ElkIiG/4Wn/Tian90X0nDUfSoAsV7OxfpLE4eqXQ9P6iEGw4PhYwpP2l8zxuGNpK9ba+9j8qXoNr587m0t020TJs9h/dXFPPOY58R0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776136225; c=relaxed/simple;
	bh=4akmO5nsx/09/6HrCgLZrLjPfKW6pxk+We6Ac4Mwn+8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=I7H0C0dQY2Hiyd+g5Q/KhM3Z8kfs3TcwWLbwN64o1iofHwSf+3l9AnUKQ6mR1T5ZQlxix1om927DDFpaZoYLL5aiqFju/5MICqxX2AoIFSiMK7SoKCcxUHIGV15MfA9oK+6/wr98o+QM94DIxIHYM6b/LIZjTTIK7DS8XAHQolI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJ8W52/S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJ8W52/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFC4C2BCB5;
	Tue, 14 Apr 2026 03:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776136225;
	bh=4akmO5nsx/09/6HrCgLZrLjPfKW6pxk+We6Ac4Mwn+8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IJ8W52/ShQOuSKQdBkt417cyu7ineO2GDLRxDZn/y1NfxkSkVBOlzb1UIZvEsoh2P
	 um4Lp7/pFt+tRjs0xk9kryY2M1NeTmWDLziffSPiItn1aCxVsshdXW0TzeauLr9FK9
	 XdFA86XTmNMTW+DnzSkjvEFBSST2XMNm0g3Euei/CX1A8Me2QWleCTsGCLWQo61bfG
	 lgxJrqYT8CPhxhaKupt13jjU1MQhXu6q1Hk+pUM527gbnyC9NpsetdVwRIj3kf2TXW
	 LBHc92NUuh/AIhDlf6B7CO3Ueo2AMkhKowj0hORs2bUf4YE1G3PGD6xrM7H7/9A21x
	 MZ0uu8a6r0/Yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02BCE3809A0B;
	Tue, 14 Apr 2026 03:09:58 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support updates for v7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i9EjajGD55kAXtQz=NjvqT8ffcmEYS_dHoFvu901TjwA@mail.gmail.com>
References: <CAJZ5v0i9EjajGD55kAXtQz=NjvqT8ffcmEYS_dHoFvu901TjwA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i9EjajGD55kAXtQz=NjvqT8ffcmEYS_dHoFvu901TjwA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.1-rc1
X-PR-Tracked-Commit-Id: 8e937866b425248fa375b2138c19c117a87c6be0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e31b16101834bdc0b720967845d6a0a309cf27b
Message-Id: <177613619671.668097.13681144508493889926.pr-tracker-bot@kernel.org>
Date: Tue, 14 Apr 2026 03:09:56 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Apr 2026 16:27:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e31b16101834bdc0b720967845d6a0a309cf27b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
