From: Calvin Walton <calvin.walton@kepstin.ca>
Subject: [PATCH v3 0/2] tools/power turbostat: Add support for AMD Fam 17h (Zen) RAPL
Date: Fri, 17 Aug 2018 12:34:40 -0400
Message-ID: <20180817163442.10065-1-calvin.walton@kepstin.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Calvin Walton <calvin.walton@kepstin.ca>
List-Id: linux-pm@vger.kernel.org

This is an updated version of my RAPL patchset for Zen CPUs, rebased on
top of the current state of kernel/git/lenb/linux.get turbostat branch.
(In particular, this fixes conflicts with the AMD APIC-id patch)

I've split it into two patches now. The first patch only adds Cores
power reporting, since I'm fairly confident that this'll work on all of
the Zen chips. I think this part is ready to apply now.

The second part is still a work in progress until I'm able to (or I'm
able to find someone else to) test the package power reporting on a
multi-die Zen chip.

Calvin Walton (2):
  tools/power turbostat: Add support for AMD Fam 17h (Zen) RAPL
  [WIP] tools/power turbostat: Also read package power on AMD F17h (Zen)

 tools/power/x86/turbostat/turbostat.c | 167 +++++++++++++++++++++-----
 1 file changed, 138 insertions(+), 29 deletions(-)

-- 
2.18.0
