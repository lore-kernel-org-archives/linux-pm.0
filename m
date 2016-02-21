From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] cpufreq: governor: Fixups on top of recent changes
Date: Sun, 21 Feb 2016 03:10:52 +0100
Message-ID: <2410542.x6e5Rli2VY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50011 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752055AbcBUCOO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 20 Feb 2016 21:14:14 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

Hi,

Two fixups on top of recent cpufreq governor changes in the linux-next
branch of linux-pm.git.

[1/2] closes a tiny theoretical race in dbs_update_util_handler()
      that may lead to taking a sample prematurely in some weird
      cases.

[2/2] removes an unnecessary function export.

Thanks,
Rafael

