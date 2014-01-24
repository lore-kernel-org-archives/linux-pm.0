From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: [PATCH V2 0/2] time/cpuidle: Support in tick broadcast framework in
 absence of external clock device
Date: Fri, 24 Jan 2014 12:27:08 +0530
Message-ID: <20140124065501.17564.39363.stgit@preeti.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:33561 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbaAXHBE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jan 2014 02:01:04 -0500
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Fri, 24 Jan 2014 00:01:03 -0700
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org, peterz@infradead.org, fweisbec@gmail.com, galak@kernel.crashing.org, paul.gortmaker@windriver.com, paulus@samba.org, mingo@kernel.org, mikey@neuling.org, shangw@linux.vnet.ibm.com, rafael.j.wysocki@intel.com, agraf@suse.de, benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, arnd@arndb.de, linux-pm@vger.kernel.org, rostedt@goodmis.org, michael@ellerman.id.au, john.stultz@linaro.org, anton@samba.org, tglx@linutronix.de, chenhui.zhao@freescale.com, deepthi@linux.vnet.ibm.com, r58472@freescale.com, geoff@infradead.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, schwidefsky@de.ibm.com, svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org

This earlier version of this patchset can be found here:
https://lkml.org/lkml/2013/12/12/687. This version has been based on the
discussion in http://www.kernelhub.org/?p=2&msg=399516.

This patchset provides the hooks that the architectures without an external
clock device and deep idle states where the local timers stop can make use of.

Presently we are in need of this support on certain implementations of
PowerPC. This patchset has been used on PowerPC for testing with

---

Preeti U Murthy (1):
      time: Change the return type of clockevents_notify() to integer

Thomas Gleixner (1):
      tick/cpuidle: Initialize hrtimer mode of broadcast


 include/linux/clockchips.h           |   15 ++++-
 kernel/time/Makefile                 |    2 -
 kernel/time/clockevents.c            |    8 ++-
 kernel/time/tick-broadcast-hrtimer.c |  102 ++++++++++++++++++++++++++++++++++
 kernel/time/tick-broadcast.c         |   51 ++++++++++++++++-
 kernel/time/tick-internal.h          |    6 +-
 6 files changed, 171 insertions(+), 13 deletions(-)
 create mode 100644 kernel/time/tick-broadcast-hrtimer.c

-- 

