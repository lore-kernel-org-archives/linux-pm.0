From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v3 0/2] CPPC as a PID backend
Date: Wed, 19 Nov 2014 15:36:19 -0500
Message-ID: <1416429381-3839-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:60286 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755821AbaKSUgm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Nov 2014 15:36:42 -0500
Received: by mail-pa0-f52.google.com with SMTP id eu11so976347pac.11
        for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2014 12:36:41 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh.kumar@linaro.org
Cc: rwells@codeaurora.org, linda.knippers@hp.com, linux-pm@vger.kernel.org, Catalin.Marinas@arm.com, dirk.brandewie@gmail.com, patches@linaro.org, linaro-acpi@lists.linaro.org, rjw@rjwysocki.net, Ashwin Chaugule <ashwin.chaugule@linaro.org>

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

This implementation was tested using a Thinkpad X240 Laptop which enumerates CPPC and PCC
tables in its ACPI firmware.

This patchset builds on top of the PCC driver which is being reviewed separately[3].

Changes since V2:
- Select driver if !X86, since intel_pstate will use HWP extensions instead.
- Added more comments.
- Added Freq domain awareness and PSD parsing.

Changes since V1:
- Create a new driver based on Dirks suggestion.
- Fold in CPPC backend hooks into main driver.

Changes since V0: [1]
- Split intel_pstate.c into a generic PID governor and platform specific backend.
- Add CPPC accessors as PID backend.

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
[3] - https://patches.linaro.org/40705/


Ashwin Chaugule (2):
  CPPC as a PID controller backend
  ACPI PID: Add frequency domain awareness.

 drivers/cpufreq/Kconfig    |   12 +
 drivers/cpufreq/Makefile   |    1 +
 drivers/cpufreq/acpi_pid.c | 1230 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1243 insertions(+)
 create mode 100644 drivers/cpufreq/acpi_pid.c

-- 
1.9.1

