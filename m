From: Piotr Luc <piotr.luc@intel.com>
Subject: [PATCH 0/2] tools/power turbostat: enable turbostat to support Knights Mill (KNM)
Date: Wed, 12 Oct 2016 20:29:47 +0200
Message-ID: <20161012182949.4015-1-piotr.luc@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:24342 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933921AbcJLScl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Oct 2016 14:32:41 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The intention of this series is to add KNM CPU ID to turbostat.
The first patch improves code style by replacing raw numbers of CPUIDs
with descriptive macros of processor names. 
The second patch enables turbostat to support KNM processor.

The second patch depends oni patch: 
x86/cpu/intel: Add Knights Mill to Intel family
https://lkml.kernel.org/r/20161012180520.30976-1-piotr.luc () intel ! com

Piotr Luc (2):
  tools/power turbostat: Use Intel family processor macros
  tools/power turbostat: enable turbostat to support Knights Mill (KNM)

 tools/power/x86/turbostat/Makefile    |   3 +-
 tools/power/x86/turbostat/turbostat.c | 249 +++++++++++++++++-----------------
 2 files changed, 130 insertions(+), 122 deletions(-)

-- 
2.10.1

