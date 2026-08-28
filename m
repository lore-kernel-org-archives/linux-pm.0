Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536A0374A0F
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787932082; cv=none; b=szmsNZxbDVKLGP2rgduGD6asGaPk4+x60F4J0mnM2HOEdJjqNyq4moya/EJ0Ri2cAvfSIX/HxnmWl4sOou5w5NqAMHWfG4X6BxPX6OUhisK9mvEMocYAiqP0CnKU6Ioj+MMiqA9GAL6WDq121+wEzpYuEQ3jNXPvhS0hPHEd72w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787932082; c=relaxed/simple;
	bh=WbxtKhIbMOejm7liR9/rPZ2UBXbDbt5sTcDBrPI2dz8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JRbvkK6BVq+NoW97NjxZrktbi/KHvwBPIPqDfMYkmYu78xCTPXdaKTxk20FEDbcwqOoc8uWjp23c4UJdPx1bunOGdR8YdtxfNa0mdPz0gmnmUq79SXy0Ean9xnX03z7UExi47/lJ/ppPqhCftinmE9JAFxIEFiAO6wFhk7tvKP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvS5K8E4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvS5K8E4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71E71F00A3F
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 15:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787932076;
	bh=qmXa71VaIDs5omcsqKx45QoxRAq7MtBZj++ZHm+Bdv8=;
	h=From:Date:Subject:To:Cc;
	b=jvS5K8E4KkB/E1j418TdtZwXAFvRI0RuP/kESm+6126lT/RjM1s9Q993blbABqXFR
	 ztR25Ykvy4XE47cfWfjwXKRv57sgUixxJPHUhIG0csd2W0fZX1CPL91id9PhW86K1e
	 Fo76vMUVHSPiJCSJ9FhuPo/44u/GLFhrb1QmWEZ9vWmxMEgqekb9vWTPyTeWdTRT8m
	 Y2rVW6b7+J1ldNphCaDLw7g6yNn6F7CcDMLmw2awlJUweyAQ6pah64u3gjzfc0l+Dq
	 3lBqx/uLnwnQsqtUKM9JX4BC68uIMCkXK/JF6ApjWwwEs0X+aMZTftxOOQIklb/Ocy
	 Q3GTyDWtyIi7Q==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3a1f75277f3so8816711fa.0
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 08:47:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoWT7O6tlkpSbYaXga3F0jXKQkf0eObL3K8Di2dxEWsUFfAcywp5B6HcjC3sFsg/S32AeE9P52gDw==@vger.kernel.org
X-Gm-Message-State: AFuF++lSb8xpQmz7VbUPsJ7u32bmZcTDewFbyhRYbg0R+MB522EcVUfB
	VVpejtswTlPJ/hQ/nSCNrxF3wLHLUHjKLIR6zXGQzJocmZ6FbL7UysjcJIuh7BxRxnGwd1BRoVD
	FCxQ9fPjLeODAq4sq5XLXUsztZ/3M4hw=
X-Received: by 2002:a05:651c:3056:b0:3a1:476:74b3 with SMTP id
 38308e7fff4ca-3a301b63a84mr14800961fa.9.1787932075015; Fri, 28 Aug 2026
 08:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 28 Aug 2026 17:47:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i9xVAS9XWOOfB58w9oA5WTUQnx=QfLo=7Nnsup3KS-OA@mail.gmail.com>
X-Gm-Features: AcwNN1XihMrn46N5cOvdT5tW7nCNPj8V133tEWIw2xxTC4zbFKe8B_SebPzgxLU
Message-ID: <CAJZ5v0i9xVAS9XWOOfB58w9oA5WTUQnx=QfLo=7Nnsup3KS-OA@mail.gmail.com>
Subject: [GIT PULL] ACPI support fix for 7.3-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.3-rc1-3

with top-most commit 3b446d169a93e6abae9a93535369fa18bbcbefd9

 Revert "ACPI: scan: Defer device power initialization"

on top of commit 3382bfbca58c7d5ee3f31a7b37fbeb208e98e656

 Merge tag 'acpi-7.3-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive an urgent ACPI support fix for 7.3-rc1.

This reverts an incomplete recent commit that may cause ACPI device
power management to stop working.

Unfortunately, I only realized that the problem was there after the
commit in question had gone in and AI did not catch it either.

Thanks!


---------------

Rafael J. Wysocki (1):
      Revert "ACPI: scan: Defer device power initialization"

---------------

 drivers/acpi/power.c | 1 -
 drivers/acpi/scan.c  | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)
