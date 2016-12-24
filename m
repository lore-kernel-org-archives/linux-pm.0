From: Len Brown <lenb@kernel.org>
Subject: [GIT PULL] turbostat patches for 4.10 merge
Date: Sat, 24 Dec 2016 16:01:55 -0500
Message-ID: <CAJvTdKn1Y-+Y6qB7GnO1ubjrZKNCHJQ9q1Yvi0JT1g0m+e6sZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36056 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbcLXVB5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Dec 2016 16:01:57 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull these turbostat patches.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit 43c4f67c966deb1478dc9acbf66ab547287d530f:
Merge branch 'akpm' (patches from Andrew) (2016-11-30 16:33:41 -0800)
are available in the git repository at:

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

for you to fetch changes up to 6886fee4d7a3afaf905a8e0bec62dc8fdc39878d:
tools/power turbostat: remove obsolete -M, -m, -C, -c options
(2016-12-24 15:38:09 -0500)

----------------------------------------------------------------

Colin Ian King (1):
tools/power turbostat: fix error case overflow read of slm_freq_table[]

Jacob Pan (3):
tools/power/turbostat: split core MSR support into status + limit
tools/power/turbostat: Add Denverton support
tools/power/turbostat: Add Denverton RAPL support


Len Brown (10):
tools/power turbostat: tidy up output on Joule counter overflow
tools/power turbostat: Gracefully handle ACPI S3
tools/power turbostat: switch to tab delimited output
tools/power turbostat: use intel-family.h model strings
tools/power turbostat: Support Knights Mill (KNM)
tools/power turbostat: fix SKX PKG_CSTATE_LIMIT decoding
tools/power turbostat: line up headers when -M is used
tools/power turbostat: Denverton uses a 25 MHz crystal, not 19.2 MHz
tools/power turbostat: Make extensible via the --add parameter
tools/power turbostat: remove obsolete -M, -m, -C, -c options

Mika Westerberg (1):
tools/power turbostat: Allocate correct amount of fd and irq entries

Srinivas Pandruvada (1):
tools/power turbostat: Display HWP OOB status

Xiaolong Wang (1):
tools/power turbostat: fix Denverton BCLK


tools/power/x86/turbostat/Makefile | 1 +
tools/power/x86/turbostat/turbostat.8 | 26 +-
tools/power/x86/turbostat/turbostat.c | 1017 +++++++++++++++++++++------------

3 files changed, 673 insertions(+), 371 deletions(-)
