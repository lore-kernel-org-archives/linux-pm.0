From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 0/4] davinci: cpuidle - some cleanups
Date: Fri,  1 Feb 2013 14:48:11 +0100
Message-ID: <1359726495-8024-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:49918 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756058Ab3BANs2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Feb 2013 08:48:28 -0500
Received: by mail-wg0-f54.google.com with SMTP id fm10so2983661wgb.9
        for <linux-pm@vger.kernel.org>; Fri, 01 Feb 2013 05:48:27 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: nsekhar@ti.com, khilman@ti.com
Cc: patches@linaro.org, linaro-dev@lists.linaro.org, davinci-linux-open-source@linux.davincidsp.com, lenb@kernel.org, linux-pm@vger.kernel.org

This patchset does some cleanup. It could have been folded in a single
patch but the review would have been less clean than splitting it into
small and trivial patches.

The main purpose of this patch is to remove the usage of the driver_data
field from the state_usage structure. Len Brown is doing this cleanup in
the intel_idle.c file. With this patchset, the processor_idle.c file will
be the last user of this field.

Also, the patchset simplify the code and makes it a bit more clear to read.

I don't have this hardware, the code is not tested.

Daniel Lezcano (4):
  davinci: cpuidle - use global variable for ddr2 flag
  davinci: cpuidle - move code to prevent forward declaration
  davinci: cpuidle - remove the ops
  davinci: cpuidle - remove useless initialization

 arch/arm/mach-davinci/cpuidle.c |   84 ++++++++++++---------------------------
 1 file changed, 25 insertions(+), 59 deletions(-)

-- 
1.7.9.5

