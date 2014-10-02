From: Paul Bolle <pebolle@tiscali.nl>
Subject: cpufreq v3.17-rc7 error: "cpufreq: cpufreq_resume: Failed to start
 governor for policy: f6909a00"
Date: Thu, 02 Oct 2014 13:45:50 +0200
Message-ID: <1412250350.3060.9.camel@x41>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:51893 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751219AbaJBLpx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Oct 2014 07:45:53 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Running v3.17-rc7 I see a new (for me) error, apparently during each
resume (from suspend) or thaw (from hibernate):
     cpufreq: cpufreq_resume: Failed to start governor for policy: f6909a00

The logs on this laptop go back over nine months (ie, the oldest kernels
I see in there are rc's for v3.13). It has basically booted every rc in
between and never printed this error before. It is an (outdated!)
ThinkPad X41 (single core i686).

Note that I did not actually notice anything odd before checking the
logs. But this laptop is getting rather painful to use, so I'll probably
only notice _major_ regressions.

Feel free to prod me for further details.


Paul Bolle

