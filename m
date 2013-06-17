From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 0/6] Thermal: step_wise governor fixes
Date: Mon, 17 Jun 2013 21:24:22 +0800
Message-ID: <1371475468-5351-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50832 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756202Ab3FQNYk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Jun 2013 09:24:40 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, durgadoss.r@intel.com, shawn.guo@linaro.org, ruslan.ruslichenko@ti.com, Zhang Rui <rui.zhang@intel.com>

Hi, all,

There are a lot of step_wise governor problems reported recently,
and plus, there are already several patches avaible, but I'd like to do
a cleanup for this piece of code altogether.

This patch set fixes several problem as addressed in the description
of each patch.
Please kindly review.

Note: I just run build test. It would be great that some of you
can test it.

thanks,
rui
