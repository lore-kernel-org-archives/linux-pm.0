From: Jisheng Zhang <jszhang@marvell.com>
Subject: [RFC] cpufreq-cpu0: allow OPP table supplied by platform
Date: Thu, 13 Mar 2014 18:48:59 +0800
Message-ID: <20140313184859.7d6f6512@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:29742 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754383AbaCMKvO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Mar 2014 06:51:14 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, viresh.kumar@linaro.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org>

Hi all,

cpufreq-cpu0 is suitable for Marvell Berlin SoC. But there's one issue to address.
The opp is different between chips even on the same step SoC, BG2Q for example.
we can calculate the OPP table from the value of one OTP register. We have two
solutions:

1. bootloader reads OTP register and calculate the OPP table then change dtb
danamically

2. supply one driver in mach-berlin to initialize the OPP table; and modify
cpufreq-cpu0 to allow platform supply OPP table, fall back to of_init_opp_table()
if there's no OPP table.

Which solution is better?

Thanks in advance,
Jisheng
