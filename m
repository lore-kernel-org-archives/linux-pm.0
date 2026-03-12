Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2323FE66F
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773339591; cv=none; b=ShTaHTUrsxhAZy9aRmLX8IDQXiVxIkot/W1plJaBW/mjEWWwIXmOmyu6nL4Nd0IuCaF3zBF8f/2+imxx5mMhWjlschjJOOOAc3+k7VbL2f47iww1oDfq0kp9LFBoAtCY5DgIID2kr6jTY2Bf/SVocZwWIbJz9FC5N0tsUCklN+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773339591; c=relaxed/simple;
	bh=jRaD5qfgT2Lnlv3pbpQW/NDrCNfgb/lQiIom05njaao=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=f3CRsOz6vU09Qtay58avd4oPrxfT0stRib2v+TTU4m80EvS81zCu1Dv3+a1R520fXvyD1fvebjfN/zARB1sINjEqKSP7Y3i/mT+bLOBCbHG0kZbSJ8usO4MH4BYdMqh/7UZ/TsA61PaQF21H3ChD4nAofMh8sUT9aJor16tGunc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awi0/hLT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awi0/hLT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E483EC2BC86
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 18:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773339590;
	bh=jRaD5qfgT2Lnlv3pbpQW/NDrCNfgb/lQiIom05njaao=;
	h=From:Date:Subject:To:Cc:From;
	b=awi0/hLTNWSu9KwEPfJcZ0e5qtbH7aZ/Ey9UqUW+SdDhAkaHk1niNnaXqawJ+SelP
	 kKv8t5VNTbMUDGb8ktEy/olWRE3VwnuhnzXWxnpelPbfu7oDJE6SDtkX9Ni1iJFW9P
	 6vNN2tL5uM5pjNSUSwnN/T6qhRKRVgkxhM0J77dFjgKIzK0/aQTLGpVdFvpmLX8Tby
	 w890pSGy8Ib5MMeBvYuQogn9OHX0kfFqZpZh+VrBu9V5HLGeanBl1wGYG7nIIuEJSt
	 3fbTuvddMxnXqif+0koBePOmlcSpz6gzf39jJTjnNM4XcjGBIHQq6xYYGEz56XZjC1
	 CY2A73RSofXoQ==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-679b072ed3aso695920eaf.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 11:19:50 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzyr6RE4s5MqQ0xyY/vBj0ABdkt19edu8WDTYW/6lWHIBB2Ntsc
	yTGUTQWVQbuax1VweB/fLrpTCm8cMi8cT5cipnIv0js7t9biA+fyYa28+pBG1sJUr+lasEOqQs6
	Wh0YeZx1ITT+Xf3TBtqjGBjeQXSioGss=
X-Received: by 2002:a05:6820:f036:b0:67b:b844:ed13 with SMTP id
 006d021491bc7-67bdaa9f50dmr201006eaf.71.1773339590070; Thu, 12 Mar 2026
 11:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Mar 2026 19:19:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iXTPTMm8k84CwTPUBRmiDNVA3CnFsg+xHYWCApP38=EA@mail.gmail.com>
X-Gm-Features: AaiRm53HN12IGKsqWrDBC2wxX6LIRn5IeLYIdlS2SLDrri-QzgoEES4lCUejrH8
Message-ID: <CAJZ5v0iXTPTMm8k84CwTPUBRmiDNVA3CnFsg+xHYWCApP38=EA@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v7.0-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-7.0-rc4

with top-most commit a076cc74744d83fb9f70147a154b99278945a3d2

 Merge branch 'pm-tools'

on top of commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681

 Linux 7.0-rc3

to receive power management updates for 7.0-rc4.

These fix a recently introduced special case issue in the idle loop and
update the cpupower utility:

 - Make the idle loop skip the cpuidle governor .reflect() callback
   after it has skipped the .select() one (Rafael Wysocki)

 - Fix swapped power/energy unit labels in cpupower (Kaushlendra Kumar)

 - Add support for setting EPP via systemd service and intel_pstate
   turbo boost support to cpupower (Jan Kiszka, Zhang Rui)

Thanks!


---------------

Jan Kiszka (1):
      cpupower: Add support for setting EPP via systemd service

Kaushlendra Kumar (1):
      cpupower: fix swapped power/energy unit labels

Rafael J. Wysocki (1):
      sched: idle: Make skipping governor callbacks more consistent

Zhang Rui (1):
      cpupower: Add intel_pstate turbo boost support for Intel platforms

---------------

 drivers/cpuidle/cpuidle.c                    | 10 -------
 kernel/sched/idle.c                          | 11 +++++++-
 tools/power/cpupower/cpupower-service.conf   |  5 ++++
 tools/power/cpupower/cpupower.sh             |  6 ++++
 tools/power/cpupower/utils/cpupower-set.c    |  6 +++-
 tools/power/cpupower/utils/helpers/helpers.h |  5 +++-
 tools/power/cpupower/utils/helpers/misc.c    | 41 ++++++++++++++++++++++++++--
 tools/power/cpupower/utils/powercap-info.c   |  4 +--
 8 files changed, 71 insertions(+), 17 deletions(-)
