From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v4 0/2] CPUFreq driver using CPPC methods
Date: Tue, 27 Jan 2015 16:03:56 -0500
Message-ID: <1422392638-31334-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:44858 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755108AbbA0VEO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 16:04:14 -0500
Received: by mail-pa0-f41.google.com with SMTP id kq14so20860339pab.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2015 13:04:14 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: rwells@codeaurora.org, linda.knippers@hp.com, linux-pm@vger.kernel.org, Catalin.Marinas@arm.com, patches@linaro.org, linaro-acpi@lists.linaro.org, ashwin.chaugule@linaro.org, viresh.kumar@linaro.org, jaswinder.singh@linaro.org, broonie@kernel.org, arnd.bergmann@linaro.org

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
doorbell semantics to indicate register updates. See drivers/mailbox/pcc.c

This patchset introduces a CPPC based CPUFreq driver that works with existing governors
such as ondemand. The CPPC table parsing and the CPPC communication semantics are
abstracted into separate files to allow future CPPC based drivers to implement their
own governors if required.

Initial patchsets included an adaptation of the PID governor from intel_pstate.c. However
recent experiments led to extensive modifications of the algorithm to calculate CPU
busyness. Until it is verified that these changes are worthwhile, the existing governors
should provide for a good enough starting point for ARM64 servers.

Finer details about the PCC and CPPC spec are available in the latest ACPI 5.1
specification.[2]

Changes since V3:
- Split CPPC backend methods into separate files.
- Add frontend driver which plugs into existing CPUfreq governors.
- Simplify PCC driver by moving communication space mapping and read/write
	into client drivers.

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

[1] - http://lwn.net/Articles/608715/
[2] - http://www.uefi.org/sites/default/files/resources/ACPI_5_1release.pdf
[3] - https://patches.linaro.org/40705/


Ashwin Chaugule (2):
  Mailbox: Restructure and simplify PCC mailbox code
  CPPC: Add CPUFreq driver based on CPPC methods

 drivers/cpufreq/Kconfig.arm    |  15 +
 drivers/cpufreq/Makefile       |   1 +
 drivers/cpufreq/cppc_acpi.c    | 801 +++++++++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cppc_acpi.h    | 134 +++++++
 drivers/cpufreq/cppc_cpufreq.c | 186 ++++++++++
 drivers/mailbox/pcc.c          | 122 ++-----
 6 files changed, 1174 insertions(+), 85 deletions(-)
 create mode 100644 drivers/cpufreq/cppc_acpi.c
 create mode 100644 drivers/cpufreq/cppc_acpi.h
 create mode 100644 drivers/cpufreq/cppc_cpufreq.c

-- 
1.9.1

