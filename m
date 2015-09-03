From: "Doug Smythies" <dsmythies@telus.net>
Subject: System will not suspend with highest numbered CPU offline [REGRESSION][BISECTED]
Date: Thu, 3 Sep 2015 14:40:43 -0700
Message-ID: <001401d0e691$302127b0$90637710$@net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta3.telus.net ([209.171.16.76]:44930 "EHLO cmta3.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756883AbbICVkr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 3 Sep 2015 17:40:47 -0400
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Viresh Kumar' <viresh.kumar@linaro.org>, "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Saravana Kannan' <skannan@codeaurora.org>
Cc: Doug Smythies <dsmythies@telus.net>, linux-pm@vger.kernel.org

As of, or about, Kernel 4.2RC1 if I take my highest numbered
CPU offline (7 in my case), the system will not suspend.
The issue persists through Kernel 4.2.
This is on my test computer with an i7-2600K.
I do not normally use suspend on this computer,
but was doing so while working on a bug report.

The kernel was bisected, and the result was:

$ git bisect bad
87549141d516aee71d511138e27117c41e8aef68 is the first bad commit
commit 87549141d516aee71d511138e27117c41e8aef68
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Wed Jun 10 02:13:21 2015 +0200

cpufreq: Stop migrating sysfs files on hotplug

See also several e-mails with the above subject line
between June 8th and 10th.

With any other combination of taking CPUs offline,
not including CPU 7, suspend seems to work properly.

Since I sometimes mess up using git bisect, and end
up at some random result, the conclusion was double
checked manually:

87549141d516aee71d511138e27117c41e8aef68 has the issue.
11e584cfb8a9d2226151fd39bfa74d09e575f72d (the previous commit) does not have the issue.


