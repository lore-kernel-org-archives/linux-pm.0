From: Jean Delvare <jdelvare@suse.de>
Subject: cpuidle governors
Date: Thu, 07 Nov 2013 14:44:30 +0100
Message-ID: <1383831870.4370.382.camel@chaos.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52905 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591Ab3KGNog (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 7 Nov 2013 08:44:36 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Hi all,

I had to work on cpuidle recently and there are two things which caused
me trouble and I'd like to discuss.

1* Is there no documentation about how the available governors (menu and
ladder) work? I found good documentation of the general architecture and
API in Documentation/cpuidle, but I am missing a description of the
internal logic of each available governor (just like
Documentation/cpu-freq/governors.txt for cpufreq.) Also, the
documentation says that "the kernel picks the best governor based on
governor ratings" but that's pretty vague. An explanation of how the
governors are rated would be good to have. Could this be added?

2* Is there no way to specify/force the cpuidle governor at boot time? I
found the cpuidle_sysfs_switch parameter and then I can change the
governor in sysfs, but this seems overly complicated (and apparently
discouraged) in a production environment. Wouldn't it be easier to
implement a cpuidle.governor=xxx boot parameter? That way we don't have
to deal with run-time changes, but the user can still force a specific
governor.

Thanks,
-- 
Jean Delvare
Suse L3 Support

