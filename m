Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EAB425893
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784209752; cv=none; b=kEAMFLBlu7/730gU4LXuYlcBDiTRTF5LG22g8IOv0rIelblD6rcNWQIOEJ8x93GtbKhO2Mj9rCcIwjpX0dLbg3gY8GcOxxQ3ggRH7w8z/98UWnjgj8eElVLa7643+sFGJaNK393CM4Mxlycw6dRJBU2QJEcgKpcffF9+UM+lAoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784209752; c=relaxed/simple;
	bh=4I+MVhRIU7iQIJVTyf8YSJmrKNVOmk7NzTfIM2UMz0I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UYjyEeK0R7ivsATRoICkrZHZxpt8PViGz39a1QlI8GkCERWgq4LRjOxORUEF2tm3+9BLZgLArZacUkeQPl2wl2Bou3APtrQvwnLkZIVnoMq/NcgRuuPxrOXlK9arBCPwWqvhCQAKgoZdRRdQz4yht/fvdPrvq4B8xQm/SX3Qfv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eT21gHpD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eT21gHpD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432E11F00ACF
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 13:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784209744;
	bh=F0UKs47fMN7XsjPxqfqpp7DxGH6fNF2X342DBXM8ZyA=;
	h=From:Date:Subject:To:Cc;
	b=eT21gHpDVjBPcaEW5AraX1+fRnN7lWuquYKLkSuaZOAVksCCUbMLMTSjCu26mOol2
	 35+/6ZQyoRzCgmgZERbUhBTRjE/6dSo5vcQ/eOK/TC4TUiHDzWpWZnbdpnaZ8JJRkU
	 nnMHCa0LcFOUusyWwxC7t1xRQz4cuRoiP6OPN+C2KzEzZbiXSHRlg6Arhw9nizV5eH
	 HLkxpYtCXkSkcts1ArG+uVKL/djHt1hZshHA8OLIm9CmpxQDtEBB2esLRfZ9Y6+JDo
	 tETn71EarS+eq+JHUlkC5w1UMtFtpTSSLHgkn9bFSXtXd/FkbB3kp2hyTawoh4luzE
	 Ms0bB3A1yKqDA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b14d1f9315so5064060e87.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 06:49:04 -0700 (PDT)
X-Gm-Message-State: AOJu0YzmVUYSc2vGFQKPgCDFB1CiaXUJ4ZpcDnArVER5N0+bK/O8PNJS
	DjWhLqTAjz9z51IdipP20OE3+OMpFsD5CX9RZRQX1GXwh0twC4CbLe1QW22yKB5Yk4pxWNV61ST
	yU4kE2Zfay54RN/PSjAy8FIAGvjySfQE=
X-Received: by 2002:ac2:531c:0:b0:5ae:a995:c16c with SMTP id
 2adb3069b0e04-5b15827ef3cmr1974863e87.27.1784209742624; Thu, 16 Jul 2026
 06:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 16 Jul 2026 15:48:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hDM05rLL869aAZ+JSd_7VJW1zC88CgrrRb=X28UqeNhQ@mail.gmail.com>
X-Gm-Features: AUfX_mx0Vn05EiX5FGYAMKsa7ck3QOwnL4aPPSjx69pVsa-zoci4RqqobEUFCC8
Message-ID: <CAJZ5v0hDM05rLL869aAZ+JSd_7VJW1zC88CgrrRb=X28UqeNhQ@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for 7.2-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-7.2-rc4

with top-most commit d2d5c129d07ea8eb91cd8a8633b5774116c4d171

 cpufreq: Make cpufreq_update_pressure() fall back to cpuinfo.max_freq

on top of commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda

 Linux 7.2-rc2

to receive power management fixes for 7.2-rc4.

These fix two cpufreq issues, one in the intel_pstate driver and one in
the core:

 - Make cpufreq_update_pressure() use cpuinfo.max_freq as the default
   reference frequency when arch_scale_freq_ref() returns 0 to allow
   the scheduler to still take CPU frequency caps into account in those
   cases (Rafael Wysocki)

 - Use the HWP guaranteed performance level as the full capacity
   performance in intel_pstate on hybrid systems when turbo frequencies
   are not allowed to be used to make scale-invariance work as expected
   in those cases (Rafael Wysocki)

Thanks!


---------------

Rafael J. Wysocki (2):
      cpufreq: intel_pstate: Set non-turbo capacity to HWP_GUARANTEED_PERF()
      cpufreq: Make cpufreq_update_pressure() fall back to cpuinfo.max_freq

---------------

 drivers/cpufreq/cpufreq.c      | 3 +++
 drivers/cpufreq/intel_pstate.c | 6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)
