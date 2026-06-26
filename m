Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC5F3A8758
	for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496646; cv=none; b=lKWZjxAJV1izHuc7hGn67032AXWGWkBlPSXYMqiCTu2VP7c/x9Dnc+1pdblceRiFooNDgaVasz/15hNBxJLKrhLmix/lLCqPsAdQTfLXr97j6Eal8IgqobjqPM+cEgatQJ+NKk2IJk0Z1r6NHxLF2+h7obMXp+i5hS+C/KXYXzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496646; c=relaxed/simple;
	bh=DfSiZes3jy9A9LstcqzMaB3GnwBwKQEp9p/RMkd9CDs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ox/cBucdefufgrNVI70Xt4mfTcrJZVAQ9zWMf65O4r/bze96cx9pdJINo5eNvyCy382iFyBTjq3gTj8wfKppWcteIbnr8vW0LZxyWcwEoY/Z6wf9wTkCjsepWGccPywZHt8iStJa8jub/nwxq9WVjjJmPyxOag+8TLzk4hVkx7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eq33FUjZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eq33FUjZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3207D1F00A3A
	for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 17:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496645;
	bh=V6LyiYvvut2BJ2KLf/N5V2QH+GUbBAbwDKI8nNgTVyU=;
	h=From:Date:Subject:To:Cc;
	b=Eq33FUjZq+RgsCCp+1prDs9DOmciaV2oqh4DfUm/9ZYvPN47gJSVVL7RvVBSCjm2e
	 O7KExOEthMK+uITzzp6rUxvyDoICtoa4jrHt0DnCzEWhP1rreIo+jMmd2wo6EOzZuR
	 omhwwuGb/orTSBmR0j4P+1lEoDdUKSPaWScc5GKOBiQTMaI4dAKDyHADmkp7d+KufG
	 Fd+VirDUUFqDBJKtoGhhBFWuFFAQs4sDYQGGvBfvsPdfAGgfWDct73y8nt04t+8fxj
	 3+YEne+lcH6X6Joqv2TQf34oCclcWPJkQbsCioHI/SNs54AudfaI+29Mb9BGuvAnKY
	 rRlwaU817SwVg==
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-59ebde7d704so372769e0c.2
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 10:57:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YzrK/N6eyQhQx8BpDArsHV7K3txPMnNElvFJazoXmVb6/o+lE15
	LBRAjczfZx3ndpcT1c7MEXEUoeY7zP0yAaCkQVxQMFBon/9mJndqeMMQdQp7X+5W9RepHdCW8xw
	lKHSfaNEj0d0KcZUBTy4paLgXqReacAw=
X-Received: by 2002:a05:6122:469e:b0:575:36c4:8900 with SMTP id
 71dfb90a1353d-5bd69e5f0c2mr3559117e0c.14.1782496644476; Fri, 26 Jun 2026
 10:57:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Jun 2026 19:57:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j7=MYemjObicteXH1u401Ru5Sjr1ZNPNzdHpDKsDrQ3Q@mail.gmail.com>
X-Gm-Features: AVVi8Cc0BSDHUbSS_AjcqrTevT6WfcpVIhGZTmSz2iPqk2H-MEMLN9SOxkwXqxk
Message-ID: <CAJZ5v0j7=MYemjObicteXH1u401Ru5Sjr1ZNPNzdHpDKsDrQ3Q@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for 7.2-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-7.2-rc1-2

with top-most commit 795f1b1a91ae13ebc012a364075e42f486a1cafe

 Merge branch 'thermal-testing'

on top of commit f3c4a338b5064effd9ce6d2cfd26c73daa56f1f4

 Merge tag 'thermal-7.2-rc1' of
gitolite.kernel.org:pub/scm/linux/kernel/git/rafael/linux-pm

to receive thermal control fixes for 7.2-rc1.

These fix a failure path in an Intel thermal driver and prevent thermal
testing module code from being executed after it has been freed:

 - Fix dangling resources on thermal_throttle_online() failure in the
   Intel thermal_throttle driver (Ricardo Neri)

 - Eliminate a possibility of running thermal testing module code after
   that module has been removed (Rafael Wysocki)

Thanks!


---------------

Rafael J. Wysocki (1):
      thermal: testing: zone: Flush work items during cleanup

Ricardo Neri (1):
      thermal: intel: Fix dangling resources on
thermal_throttle_online() failure

---------------

 drivers/thermal/intel/therm_throt.c       |  7 +++++-
 drivers/thermal/testing/command.c         | 36 +++++++++++++++++++++++++++----
 drivers/thermal/testing/thermal_testing.h |  8 +++++++
 drivers/thermal/testing/zone.c            |  7 +++---
 4 files changed, 49 insertions(+), 9 deletions(-)
