From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 0/8 v2]: turbostat: Fix AMD output by making turbostat aware of nodes
Date: Fri, 18 Aug 2017 09:08:21 -0400
Message-ID: <1503061709-4319-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750709AbdHRNIf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Aug 2017 09:08:35 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: lenb@kernel.org, Prarit Bhargava <prarit@redhat.com>, Len Brown <len.brown@intel.com>

AMD family processors do not show all cores in the output of turbostat.  This
occurs because AMD has multiple nodes per socket and enumerates cores
within each node from 0.  For example, socket 0 may have two nodes (0 and 1)
and those nodes both have cores enumerated from 0 through 7.  turbostat cannot
handle this configuration, and as a result only shows 1/2 the cores in its
output.

This patchset makes turbostate aware of nodes.  It has been tested on
various AMD and Intel systems and no issues have been found.

v2: Fix overwriting of thread_id in 3/8.  Add Node output to turbostat (patch
    8/8).  Various checkpatch.pl cleanups.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Len Brown <len.brown@intel.com>

Prarit Bhargava (8):
  turbostat: set max_num_cpus equal to the cpumask length
  turbostat: Fix node and siblings lookup data
  turbostat: Calculate additional node information for a package
  turbostat: track thread ID in cpu_topology
  turbostat: rename num_cores_per_pkg to num_cores_per_node
  turbostat: remove num_ from cpu_topology struct
  turbostat: add node information into turbostat calculations
  turbostat: Add Node in output

 tools/power/x86/turbostat/turbostat.c | 450 ++++++++++++++++++++++------------
 1 file changed, 290 insertions(+), 160 deletions(-)

-- 
1.8.5.5
