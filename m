From: Robert =?ISO-8859-1?Q?Sch=F6ne?= <robert.schoene@tu-dresden.de>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Tue, 09 Sep 2014 09:29:35 +0200
Message-ID: <1410247775.25768.13.camel@x200t>
References: <efa1d8ae3e7b227b73a951d6072fa211d3cfe593.1410235439.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.zih.tu-dresden.de ([141.30.67.72]:33588 "EHLO
	mailout1.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754035AbaIIH3q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Sep 2014 03:29:46 -0400
In-Reply-To: <efa1d8ae3e7b227b73a951d6072fa211d3cfe593.1410235439.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org

Even though the test fixed my initital problem, my test system (which
runs the kernel with this patch applied) just crashed when changing
frequencies. This might be connected to the patch.

I'll have another look into it and let you know.


Am Dienstag, den 09.09.2014, 09:46 +-0530 schrieb Viresh Kumar:
+AD4 This commit was earlier commited in kernel as:
+AD4 19c7630 cpufreq: serialize calls to +AF8AXw-cpufreq+AF8-governor()
+AD4 
+AD4 and was later reverted by Srivatsa:
+AD4 56d07db cpufreq: Remove temporary fix for race between CPU hotplug and sysfs-writes
+AD4 
+AD4 When this commit was first introduced it was written for races during hotplug
+AD4 and because we got some other solution to take care of the races with hotplug we
+AD4 reverted it.
+AD4 
+AD4 But (as I also said in the revert patch: https://lkml.org/lkml/2013/9/10/61)
+AD4 there are more cases where this is required.


