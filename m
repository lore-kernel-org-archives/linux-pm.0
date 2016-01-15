From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] cpuidle optimizations (on top of linux-next)
Date: Sat, 16 Jan 2016 00:53:41 +0100
Message-ID: <1621492.NI2xz9vt7M@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60553 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753837AbcAOX4f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jan 2016 18:56:35 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>

Hi,

When I was looking at the cpuidle code after the Sudeeps's problem report,
it occured to me that we had some pointless overhead there, so two
changes to reduce it follow.

[1/2] Make the fallback to to default_idle_call() in call_cpuidle()
      unnecessary and drop it.
[2/2] Make menu_select() avoid checking states that don't need to
      (or even shouldn't) be checked when making the selection.

Thanks,
Rafael

