Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6741F313272
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775828476; cv=none; b=uKWOB3qQ1Jbc8fzFmFK4ISKfO2ddAshpegsDLMvIChA0sxxY1iCqmDf2zBMR/G+BmeoPlnv6MAXMY97I7lfbEH819wpvsYC5RTLvoIThMB0Ak1NV8V88+ANDkrD9wULyFwsFeRpbGV6Gnc2Mu447Q4w32cEFbIUraLtmNW6pBko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775828476; c=relaxed/simple;
	bh=g7lQAe13SJwY9dl2qnAmlRx+sOcT7Auycqc9cD2ahY4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rFyFEusiU8Vb591O3nweIX1ux3wyj2k+j61uPWlPXt+lFyn6vthmRM7V80F6eBmU2IacrDjGS8XebSJ4/h+TI1A4Ojv0VOHYSRNEFh2XP/vGs1+9aGrAzSoM/kjhj8jMTZoQFQIc3BU01tDGvsNInPEMQ6Sgki4ITDFHyYGICCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLVXAu+i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLVXAu+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15112C19421
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 13:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775828476;
	bh=g7lQAe13SJwY9dl2qnAmlRx+sOcT7Auycqc9cD2ahY4=;
	h=From:Date:Subject:To:Cc:From;
	b=YLVXAu+i8bTeLi40WuyX+6LZdVgK3m6JUSyOuF/fGutJWGZvsiWugPujbs9K99hIv
	 VUEYA+MxkAS92DIWrHMX6vWhpE5+04fsRkVv6dM5rOswY8/W6Sf+QAurByqHlFJY06
	 4G+rzKrL47FgNF7Ha5ogKuYRnd0I0xnZ4FHNGbx26AT0SIGsSYpQmVFIXRc4ePP1V9
	 8Q2ZhCTkvAZCJg0cnFJuWGqwYPkdHvsIbEusALAd2nBhCkJjM4+iskwQPFHA2BcCBO
	 assNdo9k/IBf6cOx2q7pnOOt9vje8OP7vEFTRJVA3DiK86gzeDuRtKXYmIUEuZ/dlf
	 6ZnFd696SBiAA==
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506251815a3so16865261cf.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 06:41:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YyMPjGdNCcYs1SGmQiiqJqDL+psqjUsskiQ0UVDxchKevA7PY7R
	JCfF6UO4U1kKKdSwKEAQPvd24lpsYsO3aS1EL4jiHxW4oumOfV62RDyYCj8xuoWb8Rtqfpn8M6t
	eMGuF3ORgC6CApjdOBK8kg9UUJaXSat0=
X-Received: by 2002:ac8:7d11:0:b0:509:35d1:ca37 with SMTP id
 d75a77b69052e-50dd5aeef70mr49230901cf.16.1775828474740; Fri, 10 Apr 2026
 06:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Len Brown <lenb@kernel.org>
Date: Fri, 10 Apr 2026 09:40:59 -0400
X-Gmail-Original-Message-ID: <CAJvTdKnLmCFKQevH7-Am-TQZcvtgRhhMbyfrb5zG6EbEsQheqg@mail.gmail.com>
X-Gm-Features: AQROBzCYZVoX8qwSsdV-ZKno2Ul7Y4gXMIcmcMoWiFh7tjaMfpBcTi-EeDQncYc
Message-ID: <CAJvTdKnLmCFKQevH7-Am-TQZcvtgRhhMbyfrb5zG6EbEsQheqg@mail.gmail.com>
Subject: [GIT PULL] turbostat fixes for 7.0
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull these turbostat-fixes-for-7.0 patches.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681:

  Linux 7.0-rc3 (2026-03-08 16:56:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
tags/turbostat-fixes-for-7.0

for you to fetch changes up to ba893caead54745595e29953f0531cf3651610aa:

  tools/power turbostat: Allow execution to continue after
perf_l2_init() failure (2026-04-10 09:04:32 -0400)

----------------------------------------------------------------
Turbostat Fixes

Fix a memory allocation issue that could corrupt output values or SEGV

Fix a perf initilization issue that could exit on some HW + kernels.

Minor fixes.

----------------------------------------------------------------
Artem Bityutskiy (4):
      tools/power turbostat: Consistently use print_float_value()
      tools/power turbostat: Fix incorrect format variable
      tools/power turbostat: Fix --show/--hide for individual cpuidle counters
      tools/power turbostat: Fix delimiter bug in print functions

David Arcari (1):
      tools/power turbostat: Allow execution to continue after
perf_l2_init() failure

Len Brown (1):
      tools/power turbostat: Fix swidle header vs data display

Serhii Pievniev (1):
      tools/power/turbostat: Fix microcode patch level output for AMD/Hygon

Zhang Rui (2):
      tools/power turbostat: Fix illegal memory access when SMT is
present and disabled
      tools/power turbostat: Eliminate unnecessary data structure allocation

 tools/power/x86/turbostat/turbostat.c | 100 ++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 46 deletions(-)
