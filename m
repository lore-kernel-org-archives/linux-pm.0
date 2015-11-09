From: Jacob Tanenbaum <jtanenba@redhat.com>
Subject: [PATCH 0/2] Some changes to "cpupower frequency-info" command
Date: Mon,  9 Nov 2015 14:26:57 -0500
Message-ID: <1447097219-31370-1-git-send-email-jtanenba@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53509 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbbKIT1D (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Nov 2015 14:27:03 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: trenn@suse.com, prarit@redhat.com, Jacob Tanenbaum <jtanenba@redhat.com>

patch 1:
  - makes every command return a printed message 
  - refactors so that debug_output_one uses the functions already in place 
    to get the various values to print

patch 2:
  - fixed bug in how cpuinfo_transition_latency value is interpreted

Jacob Tanenbaum (2):
  rework the "cpupower frequency-info" command
  fix how "cpupower frequency-info" interprets latency

 tools/power/cpupower/utils/cpufreq-info.c | 235 +++++++++++-------------------
 1 file changed, 88 insertions(+), 147 deletions(-)

-- 
2.4.3

