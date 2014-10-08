From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [RFC PATCH v2 0/3] CPPC as PID backend
Date: Wed,  8 Oct 2014 16:11:01 -0400
Message-ID: <1412799064-2339-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:59206 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627AbaJHULg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Oct 2014 16:11:36 -0400
Received: by mail-vc0-f171.google.com with SMTP id hy10so7457446vcb.16
        for <linux-pm@vger.kernel.org>; Wed, 08 Oct 2014 13:11:36 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh.kumar@linaro.org
Cc: dirk.brandewie@gmail.com, rwells@codeaurora.org, rjw@rjwysocki.net, linaro-acpi@lists.linaro.org, linux-pm@vger.kernel.org, Catalin.Marinas@arm.com, linda.knippers@hp.com, Ashwin Chaugule <ashwin.chaugule@linaro.org>

This patchset introduces CPPC(Collaborative Processor Performance Control) as a backend
to the PID governor. The PID governor from intel_pstate.c maps cleanly onto some CPPC
interfaces.
e.g. The CPU performance requests are made on a continuous scale as against discrete pstate
levels. The CPU performance feedback over an interval is gauged using platform specific
counters which are also described by CPPC.

Although CPPC describes several other registers to provide more hints to the platform,
Linux as of today does not have the infrastructure to make use of those registers.
Some of the CPPC specific information could be made available from the scheduler as
part of the CPUfreq and Scheduler intergration work. Until then PID can be used as the
front end for CPPC.

This implementation was tested using a Thinkpad X240 Laptop which seemed to have
CPPC and PCC tables in its ACPI firmware. However, it seems as though some addresses
pointed to by the tables do not exist. This patchset also shows the hacks that
were made in order to work around those limitations and test the control flow.

This patchset builds on top of the PCC driver which is being reviewed separately[3].

Changes since V1:
-	Create a new driver based on Dirks suggestion.
-	Fold in CPPC backend hooks into main driver.

Changes since V0: [1]
-	Split intel_pstate.c into a generic PID governor and platform specific backend.
-	Add CPPC accessors as PID backend.


CPPC:
====

CPPC (Collaborative Processor Performance Control) is a new way to control CPU
performance using an abstract continous scale as against a discretized P-state scale
which is tied to CPU frequency only. It is defined in the ACPI 5.0+ spec. In brief,
the basic operation involves:
- OS makes a CPU performance request. (Can provide min and max tolerable bounds)

- Platform (such as BMC) is free to optimize request within requested bounds depending
on power/thermal budgets etc.

- Platform conveys its decision back to OS

The communication between OS and platform occurs through another medium called (PCC)
Platform communication Channel. This is a generic mailbox like mechanism which includes
doorbell semantics to indicate register updates. The PCC driver is being discussed in a
separate patchset [3] and is not included here, since CPPC is only one client of PCC.

Finer details about the PCC and CPPC spec are available in the latest ACPI 5.1
specification.[2]

[1] - http://lwn.net/Articles/608715/
[2] - http://www.uefi.org/sites/default/files/resources/ACPI_5_1release.pdf
[3] - http://comments.gmane.org/gmane.linux.acpi.devel/71171


Ashwin Chaugule (3):
  PCC HACKS: Update PCC comm region with MSR data
  CPPC as a PID controller backend
  CPPC HACKS

 drivers/cpufreq/Kconfig    |   12 +
 drivers/cpufreq/Makefile   |    1 +
 drivers/cpufreq/acpi_pid.c | 1085 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/mailbox/pcc.c      |  125 ++++-
 4 files changed, 1207 insertions(+), 16 deletions(-)
 create mode 100644 drivers/cpufreq/acpi_pid.c

-- 
1.9.1

