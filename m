From: Jisheng Zhang <jszhang@marvell.com>
Subject: regression caused by 08f511fd41c3 ("cpufreq: Reduce
 cpufreq_update_util() overhead a bit")
Date: Fri, 17 Jun 2016 16:30:23 +0800
Message-ID: <20160617163023.5bb374f8@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:23591 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753171AbcFQIe0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2016 04:34:26 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Dear all,

I found one regression: In an idle system, wakeups/s (reported by powertop)
is increased a lot, e.g on a intel snb 4 core platform, the wakeup event
number is increased from 8 wakeups/s to 24 wakeup/s. bisect points to
this commit. I could send detailed bisect log if it's wanted.


Thanks,
Jisheng
