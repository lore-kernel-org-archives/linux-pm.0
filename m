From: Len Brown <lenb@kernel.org>
Subject: intel_idle and turbostat patches for Linux 3.15 merge
Date: Mon, 7 Apr 2014 23:48:40 -0400
Message-ID: <CAJvTdKmg+oS2ikeGZ3eGVSn7=XPey465ZMz_RSC32iBt0Qzyzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:55533 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbaDHDsl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Apr 2014 23:48:41 -0400
Received: by mail-yk0-f178.google.com with SMTP id 79so337865ykr.9
        for <linux-pm@vger.kernel.org>; Mon, 07 Apr 2014 20:48:40 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>

Hi Rafael,

Please pull these ACPI & Power Management patches for 3.15.
They have been in in linux-next for some time via my next branch.

get-send-email seems to have failed me in getting these onto the list.
I'll try to figure out why and get the re-posted tomorrow.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit 455c6fdbd219161bd09b1165f11699d6d73de11c:

  Linux 3.14 (2014-03-30 20:40:15 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git release

for you to fetch changes up to 23a299cd93781a190cdca0d7d16034837b7dfd86:

  Merge branches 'turbostat' and 'intel_idle' into release (2014-04-04
13:05:22 -0400)

----------------------------------------------------------------

Jan Kiszka (1):
      intel_idle: Add CPU model 54 (Atom N2000 series)

Len Brown (7):
      ACPI idle: permit sparse C-state sub-state numbers
      intel_idle: allow sparse sub-state numbering, for Bay Trail
      intel_idle: support Bay Trail
      tools/power turbostat: simplify output, add Avg_MHz
      tools/power turbostat: Run on Broadwell
      intel_idle: fine-tune IVT residency targets
      Merge branches 'turbostat' and 'intel_idle' into release

 arch/x86/kernel/acpi/cstate.c         |   4 +-
 drivers/idle/intel_idle.c             | 204 ++++++++++++++++++++++++++++-
 tools/power/x86/turbostat/turbostat.8 | 127 +++++++-----------
 tools/power/x86/turbostat/turbostat.c | 240 ++++++++++++++++------------------
 4 files changed, 362 insertions(+), 213 deletions(-)
