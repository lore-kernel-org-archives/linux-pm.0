From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH 0/3] Use the ladder cpuidle governor when appropriate
Date: Mon, 11 Jan 2016 17:39:15 +0100
Message-ID: <20160111173915.63ec1bcd@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49685 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759747AbcAKQjX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Jan 2016 11:39:23 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>

Hi all,

This is my attempt to fix:
https://bugzilla.kernel.org/show_bug.cgi?id=65531

[PATCH 1/3] nohz: Expose tick_nohz_enabled
[PATCH 2/3] cpuidle: Default to ladder governor on ticking systems
[PATCH 3/3] cpuidle: Don't enable all governors by default
-- 
Jean Delvare
SUSE L3 Support
