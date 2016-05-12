From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] cpufreq: Avoid checking governor return values that are always 0
Date: Thu, 12 May 2016 15:12:54 +0200
Message-ID: <4540082.RMPf3KxPDh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47734 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752200AbcELNMH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2016 09:12:07 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi,

As it turns out, all of the existing governors (and the upcoming schedutil one)
always return 0 from ->governor() for the event argument equal to _GOV_STOP
or _POLICY_EXIT.

The following two patches rearrange the core cpufreq code to take that into
account.

Thanks,
Rafael

