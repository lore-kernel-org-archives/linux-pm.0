Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FC5224B05
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774548741; cv=none; b=sLBK352Pj+twXFXIt1RuzgESRciCbac5i1PgnAWM2rtaeg5Jsm5XfT/wYTF13LO4qRStf3fgwfiy0YX0BviRKJ8Aj/lgr1pfDqlrnrtdenN+lwsVQWmU7qP+uI3+qPLPeTE8dW8lGknonIqKJAjKHnwHs+s+lFsS7WE+R6tewzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774548741; c=relaxed/simple;
	bh=XTP+/Kf6Zl5lAXcpm51YWfDBcRpPnJiQNtjjPz1qPss=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=A7nEa4D3yf0jti6HCFFltaJwJPqFCasFzPlX1AnadeqV/gsxjSeczt53/lP+DeNQnjSBDVbyKzMBbe01wpxt6wrZ08BYyfZ7ir66Re7a67jsbNNhB5ZQtQpoocZM34Ssv6APLgd3lHZRX51+BE5jy3sXhPkwk4pG7ARmN3Qgx4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dskddAnb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dskddAnb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771C3C4AF0C
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 18:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774548741;
	bh=XTP+/Kf6Zl5lAXcpm51YWfDBcRpPnJiQNtjjPz1qPss=;
	h=From:Date:Subject:To:Cc:From;
	b=dskddAnb0u0N8gNdESSluG+BC6Gw/olizmaEzbfFhVjLVo5GSwDLF/JcFpH+22Aop
	 Z7woP5FNgV0hKyCXGSE3P8IjNLa87RtJtEl4JDvhtlaYiqOMxK43CH4epX9AawJfTA
	 vifqM0UVW9JC9GqgnyhdvZPpIRf3MTF5FcyWWljv3Z2coebhfCYs8fdtV17jk5hXbZ
	 RsaW4pLkmNeXkbyxbzDBWutGuXVN2wQqNnoqlWOO+Du+hshhiOwzl6qFTKgMr8+6je
	 rk7Oe6obXUf63sDRU/LGaVgiN0/XatjQkH3I3yxB/Ant2am+1Tsts4YE6GKw7D6Jks
	 NiZ3F6LRNM6ig==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-467161c4ba7so735760b6e.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 11:12:21 -0700 (PDT)
X-Gm-Message-State: AOJu0YzdjlKuRMe4CRBb7DWE7dqxj/oyluhenY5sACuHElBXirJvS1W6
	3iwLnTDOuXnd6xL8F6zpZUzLGKfAuZxQvrk0kdPB3YDNPRSZIGAIFMaFi2Kf/lAeaAXI+rLHdxk
	CQ4Ih12mNjtMcuLWHFG9B0spFDGmbXTU=
X-Received: by 2002:a05:6808:6f91:b0:467:ed6b:4f28 with SMTP id
 5614622812f47-46a7a9bac9fmr1085500b6e.20.1774548740565; Thu, 26 Mar 2026
 11:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Mar 2026 19:12:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jqdP-n4H+RXvVPyHhtGLCWs2gma_FCrDOrtb0QqcKJHQ@mail.gmail.com>
X-Gm-Features: AQROBzDLSOE3mDYww3FTZAqfgW_bLQDwwq1WMGjAlrHUpiKOSnIn1To5jky47r8
Message-ID: <CAJZ5v0jqdP-n4H+RXvVPyHhtGLCWs2gma_FCrDOrtb0QqcKJHQ@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v7.0-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-7.0-rc6

with top-most commit 042f99c493c2cef3b15de2df19c06df514d39ac7

 Merge branch 'pm-sleep'

on top of commit c369299895a591d96745d6492d4888259b004a9e

 Linux 7.0-rc5

to receive power management fixes for 7.0-rc6.

These fix two cpufreq issues, one in the core and one in the
conservative governor, and two issues related to system sleep:

 - Restore the cpufreq core behavior changed inadvertently during the
   6.19 development cycle to call cpufreq_frequency_table_cpuinfo()
   for cpufreq policies getting re-initialized which ensures that
   policy->max and policy->cpuinfo_max_freq will be valid going
   forward (Viresh Kumar)

 - Adjust the cached requested frequency in the conservative cpufreq
   governor on policy limits changes to prevent it from becoming stale
   in some cases (Viresh Kumar)

 - Prevent pm_restore_gfp_mask() from triggering a WARN_ON() in some
   code paths in which it is legitimately called without invoking
   pm_restrict_gfp_mask() previously (Youngjun Park)

 - Update snapshot_write_finalize() to take trailing zero pages into
   account properly which prevents user space restore from failing
   subsequently in some cases (Alberto Garcia)

Thanks!


---------------

Alberto Garcia (1):
      PM: hibernate: Drain trailing zero pages on userspace restore

Viresh Kumar (2):
      cpufreq: Don't skip cpufreq_frequency_table_cpuinfo()
      cpufreq: conservative: Reset requested_freq on limits change

Youngjun Park (1):
      PM: sleep: Drop spurious WARN_ON() from pm_restore_gfp_mask()

---------------

 drivers/cpufreq/cpufreq.c              |  9 +++------
 drivers/cpufreq/cpufreq_conservative.c | 12 ++++++++++++
 drivers/cpufreq/cpufreq_governor.c     |  3 +++
 drivers/cpufreq/cpufreq_governor.h     |  1 +
 drivers/cpufreq/freq_table.c           |  4 ++++
 kernel/power/main.c                    |  2 +-
 kernel/power/snapshot.c                | 11 +++++++++++
 7 files changed, 35 insertions(+), 7 deletions(-)
