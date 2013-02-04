From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 0/4][V2] davinci: cpuidle - some cleanups
Date: Mon,  4 Feb 2013 13:01:40 +0100
Message-ID: <1359979304-8715-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:46083 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755304Ab3BDMBs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Feb 2013 07:01:48 -0500
Received: by mail-wi0-f175.google.com with SMTP id l13so2259108wie.8
        for <linux-pm@vger.kernel.org>; Mon, 04 Feb 2013 04:01:46 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: khilman@deeprootsystems.com, nsekhar@ti.com
Cc: patches@linaro.org, linaro-dev@lists.linaro.org, davinci-linux-open-source@linux.davincidsp.com, lenb@kernel.org, linux-pm@vger.kernel.org

This patchset does some cleanup. It could have been folded in a single
patch but the review would have been less clean than splitting it into
small and trivial patches.

The main purpose of this patch is to remove the usage of the driver_data
field from the state_usage structure. Len Brown is doing this cleanup in
the intel_idle.c file. With this patchset, the processor_idle.c file will
be the last user of this field.

Also, the patchset simplify the code and makes it a bit more clear to read.

Thanks to Sekhar for testing the patchset.

Changelog:
V2:
 * removed global static variable initialization to 'false'
 * added Acked-by: Sekhar Nori <nsekhar@ti.com>
V1: initial post

Daniel Lezcano (4):
  davinci: cpuidle - use global variable for ddr2 flag
  davinci: cpuidle - move code to prevent forward declaration
  davinci: cpuidle - remove the ops
  davinci: cpuidle - remove useless initialization

 arch/arm/mach-davinci/cpuidle.c |   84 ++++++++++++---------------------------
 1 file changed, 25 insertions(+), 59 deletions(-)

-- 
1.7.9.5

