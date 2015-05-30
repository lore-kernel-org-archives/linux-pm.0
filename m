From: Len Brown <lenb@kernel.org>
Subject: [GIT PULL] turbostat fixes for Linux 4.1-rc5
Date: Sat, 30 May 2015 14:17:18 -0400
Message-ID: <CAJvTdKny+sccSc4-N4+hRN83PyqYcrUFm7D47JVqzBOygzmiXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:36676 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755756AbbE3SRU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 30 May 2015 14:17:20 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull these fixes to the turbostat utility.

Just one minor kernel dependency in this batch -- added a #define to msr-index.h

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit ba155e2d21f6bf05de86a78dbe5bfd8757604a65:

  Linux 4.1-rc5 (2015-05-24 18:22:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

for you to fetch changes up to a68c7c3ff0469d79993ee85e8e0a3a9a568ce350:

  tools/power turbostat: update version number to 4.7 (2015-05-27
18:04:01 -0400)

----------------------------------------------------------------
Dasaratharaman Chandramouli (2):
      tools/power turbostat: correctly display more than 2 threads/core
      tools/power turbostat: enable turbostat to support Knights Landing (KNL)

Len Brown (2):
      tools/power turbostat: correctly decode of ENERGY_PERFORMANCE_BIAS
      tools/power turbostat: update version number to 4.7

Prarit Bhargava (1):
      tools/power turbostat: allow running without cpu0

 arch/x86/include/uapi/asm/msr-index.h |   1 +
 tools/power/x86/turbostat/turbostat.c | 224 ++++++++++++++++++++++++++++------
 2 files changed, 185 insertions(+), 40 deletions(-)
