Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52224AA573
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790352215; cv=none; b=dQkTlML35SqFJckNGaetW7OFdwncpS40aE290+pTT4CpDHBkDQT5FI39D9nnbSAP/6pIsHtqgktr4X3tL0WWtFu3EYEDdTE/kuSYiJ2uZJ3mYqpAkTL7VnRf6pGCsQ4t0iOsAlLg9a63h5HGMdSBTnF2thdx8RoGCl9UQ6k0/EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790352215; c=relaxed/simple;
	bh=VXIJjJq1235b115N4ZLL0jYwuBwamPLrevHQc5k6io4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GFTw1H47Z0ksBmbdNCKJt7vku4618KnJLIV0ZyWdIe9Es76FtZP836IJZZPWUFA1gU0TLqGUYIe22i6NSAoVzSt9LzO1A6rAM3gCGRxxHWY1dpf0OMsmmdmCHtb328gAgWx6FYYyXVNPBYaFjj9LYQ/cyKz+wCiTtiwbhZdjH/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xl9JIEVC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xl9JIEVC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670291F00899
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 16:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790352213;
	bh=d/8eelIQrinm3h5Kx/HBlkqpP7rCjU8s3pksPYRm73Q=;
	h=From:Date:Subject:To:Cc;
	b=Xl9JIEVCMEV16YAfzuh2lzEszeuMvFKL+WEEryug5wO6jRDWHuS61bG2UnKPx3Nkz
	 j6sb0Wsm8dxXe+zzDe2zlQsycAwodHOiJXXhyEVL5VDin4qlP70USN/A4SciR2EMJC
	 vN9W1y1GhjAe9mghWtS5qoXl8VT/MkwnXrwDypzU3aaPjvoBsRjXGUgiqWO34Clhtl
	 nZzOAyqQDoy9luODfgvEt5WfvgVOEWhW1nShlref5qu7CpGAl0eaOu6iM61ajx77Eg
	 S4DVmHEFb8iT3ekBIpnM531MaPzWHtTjfxPLYUk2S3hzvCr+L6mIgpComso5LNPVhW
	 epyJ5TNSztG/w==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a59bc470d6so9512351fa.0
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 09:03:33 -0700 (PDT)
X-Gm-Message-State: AFuF++lUXVN3yowgzcJnabi80kWi85FfniRXD0T5n9rEqzpVmAWYOYd7
	LwBWPsfCXHmwovL7btTN2ADgnKqGr9I9SWJUIPwGPfvvP153hMKT1AHMJ3Ni1xDRSaAU8Act0Xa
	X1QQgg/x3jr+8mK3wXJkVAZ2cVwdNQ3k=
X-Received: by 2002:a05:651c:43da:10b0:3a6:4c3d:978c with SMTP id
 38308e7fff4ca-3a64c3d99c1mr4806881fa.16.1790352211817; Fri, 25 Sep 2026
 09:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 18:01:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iAT9B4aAFDTZSpDh8Tr9T22QFmavRvr7CP6kCLcJOQbg@mail.gmail.com>
X-Gm-Features: AclHuK-PgmXc6LqEt8-2ePakDAO-9iaB_UlEfiBOFTT4cUyJPG5TsFWgBKTKKZw
Message-ID: <CAJZ5v0iAT9B4aAFDTZSpDh8Tr9T22QFmavRvr7CP6kCLcJOQbg@mail.gmail.com>
Subject: [GIT PULL] Thermal control fix for 7.3-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-7.3-rc5

with top-most commit ec0d89150a9381d591344a9f6f5428655c227a7f

 thermal: gov_step_wise: Fix stale mitigation vote with non-zero lower bounds

on top of commit 93f51579e7df248780214094418f205253383cc5

 Linux 7.3-rc4

to receive a thermal control fix for 7.3-rc5.

This fixes a step-wise thermal governor issue that causes thermal
mitigation to continue forever after the temperature has dropped below
the trip point threshold in some cases (Manaf Meethalavalappu Pallikunhi).

Thanks!


---------------

Manaf Meethalavalappu Pallikunhi (1):
      thermal: gov_step_wise: Fix stale mitigation vote with non-zero
lower bounds

---------------

 drivers/thermal/gov_step_wise.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)
