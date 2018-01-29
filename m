From: Len Brown <lenb@kernel.org>
Subject: turbostat 18.01.28 is ready for testing!
Date: Sun, 28 Jan 2018 22:01:00 -0500
Message-ID: <CAJvTdK=3hO=t7TaxP=pym6G-kNGy9mGESb5b+FEeEU_zQnu=FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37171 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbeA2DBB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Jan 2018 22:01:01 -0500
Received: by mail-qt0-f194.google.com with SMTP id d54so10980629qtd.4
        for <linux-pm@vger.kernel.org>; Sun, 28 Jan 2018 19:01:01 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, charles.rose@dell.com, "Rafael J. Wysocki" <rafael@kernel.org>, suravee.suthikulpanit@amd.com

Please give this version a go.
In particular, I'd like confirmation on multi-node AMD boxes that all
the cores are listed, and the Node column is correct.

thanks,
-Len


The following changes since commit d39a01eff9af1045f6e30ff9db40310517c4b45f:

  Merge tag 'platform-drivers-x86-v4.15-3' of
git://git.infradead.org/linux-platform-drivers-x86 (2017-12-12
17:19:58 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

for you to fetch changes up to 5bbffe1af8b104215cb9d48a135d6753cf7be089:

  tools/power turbostat: update version number (2018-01-28 21:54:28 -0500)

----------------------------------------------------------------
Artem Bityutskiy (4):
      tools/power turbostat: fix Skylake Xeon package C-state display
      tools/power turbostat: fix printing on input
      tools/power turbostat: dump BDX, SKX automatic C-state conversion bit
      tools/power turbostat: a small C-states dump readability imporovement

Laura Abbott (1):
      tools/power: Don't make man pages executable

Len Brown (12):
      MAINTAINERS: add turbostat utility
      tools/power turbostat: add --enable Time_Of_Day_Seconds
      tools/power turbostat: on SIGINT: sample, print and exit
      tools/power turbostat: on SIGUSR1: sample, print and continue
      tools/power turbostat: end current interval upon newline input
      tools/power turbostat: fix  MSR_IA32_MISC_ENABLE MWAIT printout
      tools/power turbostat: fix possible sprintf buffer overflow
      tools/power turbostat: do not hard-code 25MHz crystal on SKX
      tools/power turbostat: remove blank lines
      tools/power turbostat: Fix regression caused by previous patch
      Merge branch 'turbostat.node' into turbostat
      tools/power turbostat: update version number

Prarit Bhargava (8):
      tools/power turbostat: Set max_num_cpus equal to the cpumask length
      tools/power turbostat: Fix node and siblings lookup data
      tools/power turbostat: Calculate additional node information for a package
      tools/power turbostat: Track thread ID in cpu_topology
      tools/power turbostat: Rename num_cores_per_pkg to num_cores_per_node
      tools/power turbostat: Remove num_ from cpu_topology struct
      tools/power turbostat: Add node information into turbostat calculations
      tools/power turbostat: Add Node in output

 MAINTAINERS                                     |  10 +
 tools/power/x86/turbostat/Makefile              |   2 +-
 tools/power/x86/turbostat/turbostat.8           |  24 +-
 tools/power/x86/turbostat/turbostat.c           | 750 ++++++++++++++++--------
 tools/power/x86/x86_energy_perf_policy/Makefile |   2 +-
 5 files changed, 533 insertions(+), 255 deletions(-)
