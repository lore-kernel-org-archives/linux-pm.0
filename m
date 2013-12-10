From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [PATCH][3.11.y]  intel_pstate: fix no_turbo
Date: Tue, 10 Dec 2013 14:37:28 -0500
Message-ID: <52A76D78.4070507@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:44343 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab3LJThi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2013 14:37:38 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Luis Henriques <luis.henriques@canonical.com>, Kamal Mostafa <kamal.mostafa@canonical.com>
Cc: stable@vger.kernel.org, srinivas.pandruvada@linux.intel.com, dirk.j.brandewie@intel.com, rafael.j.wysocki@intel.com, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Kernel Team <kernel-team@lists.ubuntu.com>

Hello,

Please consider including mainline commit
1ccf7a1cdafadd02e33e8f3d74370685a0600ec6 in the next v3.11.y release. 

It was included in the mainline tree as of v3.12-rc4.  It has been
tested and confirmed
to resolve http://bugs.launchpad.net/bugs/1254091 .

commit 1ccf7a1cdafadd02e33e8f3d74370685a0600ec6
Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date:   Tue Oct 1 10:28:41 2013 -0700

    intel_pstate: fix no_turbo

Other stable trees may also want to pick up this commit.

Sincerely,
Joseph Salisbury

