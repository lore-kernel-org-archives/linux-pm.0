From: Sherry Hurwitz <sherry.hurwitz@amd.com>
Subject: [PATCH 0/2] Series short description
Date: Tue, 20 Jun 2017 02:02:36 -0500
Message-ID: <20170620065708.21434.80154.stgit@Diesel2540.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from [165.204.78.1] ([165.204.78.1]:37351 "EHLO diesel2540.amd.com"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750863AbdFTHMR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Jun 2017 03:12:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: trenn@suse.com
Cc: linux-pm@vger.kernel.org

The following series fixes a bug caused by not saving the 
function return value but using the value from a previous function.
It also implements support for the new AMD Family 0x17: including
the current operating frequency calculation particular to AMD 
Family 0x17, detecting core performance boost support and whether
it is currently active.

---

Sherry Hurwitz (2):
      cpupower: Check the return from amd_pci_get_num_boost_states
      cpupower: Add support for new AMD family 0x17


 tools/power/cpupower/utils/helpers/amd.c     |   31 +++++++++++++++++++-------
 tools/power/cpupower/utils/helpers/helpers.h |    2 ++
 tools/power/cpupower/utils/helpers/misc.c    |   23 ++++++++++++++++---
 3 files changed, 44 insertions(+), 12 deletions(-)

--
Signature
