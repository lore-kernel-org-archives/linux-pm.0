From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [GIT PULL] Post-v3.13-rc3 power management fixup
Date: Sun, 08 Dec 2013 02:03:31 +0100
Message-ID: <8261350.avSs2HnPeX@vostro.rjw.lan>
References: <2062235.VIUAclBWFD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57234 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752811Ab3LHAu2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 7 Dec 2013 19:50:28 -0500
In-Reply-To: <2062235.VIUAclBWFD@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, Viresh Kumar <viresh.kumar@linaro.org>, Paul Bolle <pebolle@tiscali.nl>, Martin Ziegler <ziegler@uni-freiburg.de>

Hi Linus,

Please pull from the git repository at

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-3.13-rc3-fixup

to receive reverts of two recent cpufreq fixes that broke more
than they fixed for v3.13-rc4 with top-most commit d4faadd5d5b3

  Revert "cpufreq: fix garbage kobjects on errors during suspend/resume"

on top of commit 374b105797c3d4f29c685f3be535c35f5689b30e

  Linux 3.13-rc3

This reverts commits that fixed issues for some people, but broke
things for others, so revert them and we'll need to fix the original
problems differently.

Thanks!


---------------

Rafael J. Wysocki (2):
      Revert "cpufreq: suspend governors on system suspend/hibernate"
      Revert "cpufreq: fix garbage kobjects on errors during suspend/resume"

---------------

 drivers/base/power/main.c |    3 ---
 drivers/cpufreq/cpufreq.c |   46 +++------------------------------------------
 include/linux/cpufreq.h   |    8 --------
 3 files changed, 3 insertions(+), 54 deletions(-)

