From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] cpufreq: ondemand: Small cleanups
Date: Tue, 16 Feb 2016 20:59:57 +0100
Message-ID: <76641630.CimCW8476L@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52977 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752584AbcBPUAY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2016 15:00:24 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

Hi,

Two cleanups for the ondemand governor.

[1/2] rearranges some code to avoid duplication.
[2/2] drops a governor-specific callback that's never used.

Both on top of the linux-next branch of the linux-pm.git tree from today.

Thanks,
Rafael

