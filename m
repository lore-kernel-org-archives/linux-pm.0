From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] cpuidle: Avoid returning a disabled C-state from menu governor
Date: Sun, 27 Apr 2014 14:53:09 +0200
Message-ID: <2471963.urOyfY8mOG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58739 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751379AbaD0MjP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 27 Apr 2014 08:39:15 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>

Hi,

The cpuidle menu governor has a problem that it returns 0 when it can't find
a suitable C-state, but on some systems in some situations 0 may be the
CPUIDLE_DRIVER_STATE_START index and it shouldn't be returned if the corresponding
C-state has been disabled, for example.

The following two patches avoid this issue by modifying the menu governor to
return an error code rather than 0 in those situations.

[1/2] Combine cpuidle_enabled() with cpuidle_select(), because [2/2] makes
      the latter return negative error codes sometimes, so keeping them separate
      is not useful any more.

[2/2] Modify the menu governor to return an error code if the extra "poll" state
      is not available.

Thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
