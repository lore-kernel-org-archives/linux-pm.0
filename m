From: Len Brown <lenb@kernel.org>
Subject: [GIT PULL] turbostat updates for Linux-4.6 merge
Date: Sun, 13 Mar 2016 04:27:43 -0400
Message-ID: <CAJvTdKnf096DSbn6w+kiFqrvfYnH16WNLP83W679DvB9vORGCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:35770 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbcCMI1p (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 13 Mar 2016 04:27:45 -0400
Received: by mail-lb0-f176.google.com with SMTP id bc4so203687812lbc.2
        for <linux-pm@vger.kernel.org>; Sun, 13 Mar 2016 00:27:45 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael@kernel.org>

Hi Rafael,

Please pull these turbostat patches.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit afd2ff9b7e1b367172f18ba7f693dfb62bdcb2dc:

  Linux 4.4 (2016-01-10 15:01:32 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

for you to fetch changes up to 685b535b2cdb9cdf354321f8af9ed17dcf19d19f:

  tools/power turbostat: bugfix: TDP MSRs print bits fixing
(2016-03-13 04:22:57 -0400)

----------------------------------------------------------------
Chen Yu (1):
      tools/power turbostat: bugfix: TDP MSRs print bits fixing

Chrzaniuk, Hubert (1):
      tools/power turbostat: Intel Xeon x200: fix erroneous bclk value

Hubert Chrzaniuk (1):
      tools/power turbostat: Intel Xeon x200: fix turbo-ratio decoding

Len Brown (17):
      tools/power turbostat: decode more CPUID fields
      tools/power turbostat: CPUID(0x16) leaf shows base, max, and bus frequency
      x86 msr-index: Simplify syntax for HWP fields
      tools/power turbostat: decode HWP registers
      tools/power turbostat: Decode MSR_MISC_PWR_MGMT
      tools/power turbostat: allow sub-sec intervals
      tools/power turbostat: re-name "%Busy" field to "Busy%"
      tools/power turbostat: add --out option for saving output in a file
      tools/power turbostat: fix compiler warnings
      tools/power turbostat: make fewer systems calls
      tools/power turbostat: show IRQs per CPU
      tools/power turbostat: show GFXMHz
      tools/power turbostat: show GFX%rc6
      tools/power turbostat: detect and work around syscall jitter
      tools/power turbostat: indicate SMX and SGX support
      tools/power turbostat: call __cpuid() instead of __get_cpuid()
      tools/power turbostat: correct output for MSR_NHM_SNB_PKG_CST_CFG_CTL dump

 arch/x86/include/asm/msr-index.h      |   8 +-
 tools/power/x86/turbostat/turbostat.8 |  32 +-
 tools/power/x86/turbostat/turbostat.c | 889 +++++++++++++++++++++++++++-------
 3 files changed, 728 insertions(+), 201 deletions(-)
