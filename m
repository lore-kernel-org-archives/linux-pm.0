From: "Hu, Fenghua" <fenghua.hu@intel.com>
Subject: Kernel panic after resuming from S4 on Napa dual-core.
Date: Wed, 12 Jul 2006 09:29:40 +0800
Message-ID: <076F541A621E59428B837DCEA0AEDB587A227B@bjsmsx401>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.osdl.org, lhcs-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

Hi all,

I am struggling with a S4 issue. On a Napa dual-core laptop, sometimes
when resuming from S4, kernel panic occurs, then system reboots. After
some investigation, I found it's due to CPU1(AP) can't be woken up in
time, and
this can be alleviated, even eliminated by introducing more delay in
function wakeup_secondary_cpu().In official kernel tree, there were
three lines in this function for delaying: mdelay(10), udelay(300) and
udelay(200), now I changed them all to mdelay(500). Seems incorrect
timing has led to the issue. Could you help me to root cause it? Thanks.

Best regards
Hu, Fenghua
