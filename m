Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E5935675E
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779455404; cv=none; b=ANm9KSHfqWj1a1pTnLbnwFhd6YYVmxdCGHTWAJqvRffoVOUa01QRsfQvVf51djJczWBG9xkVRVyJzK0QN4gepNsqwaLkkhWrA/MJxGJkdeCpxHUlWjlIPTX1+lApF2vepQ1eouf/lA2iTV4EeKPNiC7r5SQRTO1mnbOTqinigOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779455404; c=relaxed/simple;
	bh=KmZnhuMx6Bsui35NhSzIWrhB7v8b9MqLrZb2DpOmR5Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nMgQfjBQ0MXoDq2OYbbcoASLtyOlnllQzLu86li50N71RJ6QTy2pvtyB0zAEnjPK81Xy2zGrlV/uqi/40nIuowIlc6LN3RUXzJ0jrWuMmxT2w7y/ofka1rrlVo22E3NH0QUNO2WsWQnLWkwDM/9+XZFQq3++t0RpUfDD+KfVmhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5KKd9fu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5KKd9fu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D175E1F00A3E
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 13:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779455402;
	bh=YRXtrfnr2482aHjawo4sPYBL9Qn4MPKM3DN0ksscEH8=;
	h=From:Date:Subject:To:Cc;
	b=R5KKd9fuVx+YLTpQvxjhdKLp/oDBcPhhDfJk7Cz1goODk653GvYl7XA+KBpeZP/5e
	 P3eYmBg0ZEhjpP/x8bJWwUWPIesIgMQkKo+eRfRn/3SHMUAP73zBvInt5gJh/fJZ6Y
	 Wnc+bdIcOarOnitlEKd1klECxEBFIVnlvlEPDgz5nag0ypROF33pGHVUzBbHSofNyd
	 4HOI/keE0Hi4ephkrNYjlgceXpn8S+iS0T3MOIzbJZCltNu5JqFdTa/i/eoFzsU15V
	 vEf7/rZ/GDwsNr1GWeDcgKjYQe/NZ7JUYOvRjBn/ipVY2XARQU2T+GPdw4JeSsIzeD
	 lhkFE/NJ5fzsA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a40cfab24dso2428313e87.2
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 06:10:02 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx0WC+JCy45t1tycS2/xyEDkBKcOajx0c9qVA6W06EiABKVddPr
	pmfOMA0o4uv7ySiGbsFOtqKBPYrTEWBZJqgxg/tzOBEI7wnCSb2YLuPoKTa7YDdG8oidEndMP7C
	OP5YOvo3bSHuMgw5BT57NvMMMHguHNL8=
X-Received: by 2002:ac2:5091:0:b0:5a2:bedb:2119 with SMTP id
 2adb3069b0e04-5aa323ac260mr877446e87.26.1779455401334; Fri, 22 May 2026
 06:10:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 May 2026 15:09:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jV993R+4XzRDLRE170myHSHhqwH4cDDmRiEMGwEdKfUQ@mail.gmail.com>
X-Gm-Features: AVHnY4KF8tXsyItaTgpMux5fpMLKx-4xaqvfGRYI0IcRkffPhL4AmpXCiqaOdD0
Message-ID: <CAJZ5v0jV993R+4XzRDLRE170myHSHhqwH4cDDmRiEMGwEdKfUQ@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v7.1-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-7.1-rc5

with top-most commit a67f3113331d9fb3eb0664602d9b581cb2df7294

 Merge tag 'amd-pstate-v7.1-2026-05-14' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux into
pm-cpufreq-fixes

on top of commit 5d6919055dec134de3c40167a490f33c74c12581

 Linux 7.1-rc3

to receive power management fixes for 7.1-rc5.

These fix maximum frequency computation in the intel_pstate driver
for two processor models, update its documentation and fix issues
related to the dynamic EPP support (added during the current
development cycle) in the amd-pstate driver:

 - Fix maximum frequency computation in the intel_pstate driver for
   Raptor Lake-E and Bartlett Lake that are SMP platforms derived from
   hybrid ones (Rafael Wysocki, Henry Tseng)

 - Fix the description of asymmetric packing with SMT in the
   intel_pstate driver documentation (Ricardo Neri)

 - Fix multiple amd-pstate driver issues related to dynamic EPP support
   added recently, including making it opt-in only (K Prateek Nayak,
   Mario Limonciello)

Thanks!


---------------

Henry Tseng (1):
      cpufreq: intel_pstate: Use HYBRID_SCALING_FACTOR_ADL for Bartlett Lake

K Prateek Nayak (6):
      cpufreq/amd-pstate: Grab "amd_pstate_driver_lock" when toggling
dynamic_epp
      cpufreq/amd-pstate: Return -ENOMEM on failure to allocate profile_name
      cpufreq/amd-pstate: Allow writes to dynamic_epp when state isn't modified
      cpufreq/amd-pstate: Reorder notifier unregistration and floor perf reset
      cpufreq/amd-pstate: Use "epp_default_dc" as default when
dynamic_epp is disabled
      cpufreq/amd-pstate-ut: Drop policy reference before driver switch

Mario Limonciello (1):
      cpufreq/amd-pstate: Drop Kconfig option for dynamic EPP

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Use correct scaling factor on Raptor Lake-E

Ricardo Neri (1):
      Documentation: intel_pstate: Fix description of asymmetric
packing with SMT

---------------

 Documentation/admin-guide/pm/amd-pstate.rst   | 11 ++++----
 Documentation/admin-guide/pm/intel_pstate.rst | 11 ++++----
 drivers/cpufreq/Kconfig.x86                   | 12 ---------
 drivers/cpufreq/amd-pstate-ut.c               | 36 +++++++++++++++++++++------
 drivers/cpufreq/amd-pstate.c                  | 27 +++++++++++++-------
 drivers/cpufreq/intel_pstate.c                |  3 ++-
 6 files changed, 60 insertions(+), 40 deletions(-)
