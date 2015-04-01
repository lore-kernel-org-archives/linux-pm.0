From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 00/20] clockevents_notify() removal
Date: Thu, 02 Apr 2015 00:02:03 +0200
Message-ID: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64552 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753184AbbDAWDj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2015 18:03:39 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi,

This is the next batch of patches from Thomas that remove clockevents_notify().

I've reordered the set (to put more stratightforward things to the front) and
rebased it on top of the timers material currently queued up for 4.1.

This series in based on the bleeding-edge branch of the linux-pm tree (which
for all practical purposes is my linux-next branch with timers/core from tip
merged into it).

Please let me know how to proceed with these.

Thanks,
Rafael
