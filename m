Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C48332909
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781113218; cv=none; b=aaKAciQuES0rw3SaHfaBgxRDLkk3Pk4WqZQpcetJUzNEcTGhnV23QhxB5rtF76BDGMMSWVKWutoxVtUy8UIuaj0rAmKvtYLYEHhe2BvFonTQzmpkxyeKhMBrhPXG1zinlw9lB/7Y4j/BbaeY8ondcD4s8UudC25e7Vva8W8+zXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781113218; c=relaxed/simple;
	bh=iiV4jaKhEQihoed1PI5aj6NUixaofnS1Xz8KldVRC3g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RIYrZoK2ak7+qFiFN7kUQewIv4lu6GahaY6WERARUWNHV7UzcMHt4S3kSii1Z8XXUf0W4lFsxcLtAsfjCEqnyyRiJfzWD7gE1aNWjuQzR0AjyyiW5bWJCRYBLXD7+M7K5vzYDwqo23zgk2mEixNcR/DVQLyGb7yHNRIbu+9zJDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyksPnKD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyksPnKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A4D1F0089A
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 17:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781113217;
	bh=0AzttZyJrnnJXhfX2JsnWXprYH6UK7E486JcHPjHg5M=;
	h=From:Date:Subject:To:Cc;
	b=jyksPnKDskUoQrfUfOtwjkgToySWqCs0IkGJQ/eZBYpvTlmD/y/Evii61fAjma2ic
	 q8gy1OYmIR6so6O8wefciG48K4rOcEGoW9mkOWpl+VUczSjaX5yvNGX73evig0KoDB
	 hxPQ0mKFx7x+CAGzOFNYSTzAHYIU9Oc2pw/6NIZGn3QboQ5WPWJOVfcFxWPJIzm1pt
	 FFibtFFOb4pZOtSHACEk/HxQop+FAquiYP2Yugt1MW9XOQ4h00Lfi3rVFJ49cNJKyT
	 CJqyljFpZ2KFpe81408cDGGnAPJ+QgYoo7geZKea+nTGBjXzNNqcnTBwPzLESsQY6Q
	 eDsmd3hVEAbxQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa619653e4so96801e87.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 10:40:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YwwIOP7woZugNEkAHM04VpFPQnAZeurQE1pHbDZ0AZ1SxHcpmEA
	j7WuQo6CatMJoxInUwcgu87rl3bEyZ5fAv+c0VENUzRNlLL/5S/FDyqVxqljmSF6wZEE3wt2lRk
	SfOv/WQ38R2WNguNSzTUdMtqwZ0xtPTw=
X-Received: by 2002:a05:6512:ad5:b0:5aa:4a98:bdb0 with SMTP id
 2adb3069b0e04-5aa8865b583mr7783956e87.4.1781113215511; Wed, 10 Jun 2026
 10:40:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Jun 2026 19:40:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iYVY_Xjt5v7GFuOp4CoMC4_TMdvYKr9+TspVUw4h-gyA@mail.gmail.com>
X-Gm-Features: AVVi8CcUZSjR_4_gu1VzlYovcHNKxVNEuZOfYfonVkg6lVtZkl78Vg5i6vIs1HY
Message-ID: <CAJZ5v0iYVY_Xjt5v7GFuOp4CoMC4_TMdvYKr9+TspVUw4h-gyA@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for final 7.1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-7.1-rc8

with top-most commit 6100a82e34cb75571feba920a9c18f60698d598a

 Merge tag 'amd-pstate-v7.1-2026-06-02' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux

on top of commit df488cac6140aa04ae52af9b4507d8f99a3762be

 cpufreq/amd-pstate-ut: Disable dynamic_epp after the mode switch

to receive power management fixes for final 7.1.

These address some remaining fallout after introducing dynamic EPP
support in the amd-pstate driver during the current development cycle:

 - Restore allowing writing EPP of 0 when in performance mode in the
   amd-pstate driver which was unnecessarily disallowed by one of the
   recent updates (Mario Limonciello)

 - Remove stale documentation of the epp_cached field in struct
   amd_cpudata that has been dropped recently (Zhan Xusheng)

Thanks!


---------------

Mario Limonciello (AMD) (1):
      cpufreq/amd-pstate: Fix setting EPP in performance mode

Zhan Xusheng (1):
      cpufreq/amd-pstate: drop stale @epp_cached kdoc

---------------

 drivers/cpufreq/amd-pstate.c | 2 +-
 drivers/cpufreq/amd-pstate.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)
