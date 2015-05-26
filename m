From: Al Stone <al.stone@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v5 0/6] CPUFreq driver using CPPC methods
Date: Tue, 26 May 2015 11:23:22 -0600
Message-ID: <5564AC0A.2050501@linaro.org>
References: <1432590581-8925-1-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34886 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbbEZRXZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2015 13:23:25 -0400
Received: by igbyr2 with SMTP id yr2so64147612igb.0
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2015 10:23:25 -0700 (PDT)
In-Reply-To: <1432590581-8925-1-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>, rjw@rjwysocki.net
Cc: linaro-acpi@lists.linaro.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, patches@linaro.org, jaswinder.singh@linaro.org, sudeep.holla@arm.com

On 05/25/2015 03:49 PM, Ashwin Chaugule wrote:
> CPPC:
> ====
> 
> CPPC (Collaborative Processor Performance Control) is a new way to control CPU
> performance using an abstract continous scale as against a discretized P-state scale
> which is tied to CPU frequency only. It is defined in the ACPI 5.0+ spec. In brief,
> the basic operation involves:
> - OS makes a CPU performance request. (Can provide min and max tolerable bounds)
> 
> - Platform (such as BMC) is free to optimize request within requested bounds depending
> on power/thermal budgets etc.
> 
> - Platform conveys its decision back to OS
> 
> The communication between OS and platform occurs through another medium called (PCC)
> Platform communication Channel. This is a generic mailbox like mechanism which includes
> doorbell semantics to indicate register updates. See drivers/mailbox/pcc.c
> 
> This patchset introduces a CPPC based CPUFreq driver that works with existing governors
> such as ondemand. The CPPC table parsing and the CPPC communication semantics are
> abstracted into separate files to allow future CPPC based drivers to implement their
> own governors if required.
> 
> Initial patchsets included an adaptation of the PID governor from intel_pstate.c. However
> recent experiments led to extensive modifications of the algorithm to calculate CPU
> busyness. Until it is verified that these changes are worthwhile, the existing governors
> should provide for a good enough starting point for ARM64 servers.
> 
> Finer details about the PCC and CPPC spec are available in the latest ACPI 5.1
> specification.[2]
> 
> Changes since V4:
> - Misc cleanups. Addressed feedback from Rafael.
> - Made acpi_processor.c independent of C-states, P-states and others.
> - Per CPU scanning for _CPC is now made from acpi_processor.c
> - Added new Kconfig options for legacy C states and P states to enable future
> support for newer alternatives as defined in the ACPI spec 6.0.
> 
> Changes since V3:
> - Split CPPC backend methods into separate files.
> - Add frontend driver which plugs into existing CPUfreq governors.
> - Simplify PCC driver by moving communication space mapping and read/write
> 	into client drivers.
> 
> Changes since V2:
> - Select driver if !X86, since intel_pstate will use HWP extensions instead.
> - Added more comments.
> - Added Freq domain awareness and PSD parsing.
> 
> Changes since V1:
> - Create a new driver based on Dirks suggestion.
> - Fold in CPPC backend hooks into main driver.
> 
> Changes since V0: [1]
> - Split intel_pstate.c into a generic PID governor and platform specific backend.
> - Add CPPC accessors as PID backend.
> 
> [1] - http://lwn.net/Articles/608715/
> [2] - http://www.uefi.org/sites/default/files/resources/ACPI_5_1release.pdf
> [3] - https://patches.linaro.org/40705/
> 
> 
> Ashwin Chaugule (6):
>   PCC: Initialize PCC Mailbox earlier at boot
>   ACPI: Make ACPI processor driver more extensible
>   ACPI: Introduce CPU performance controls using CPPC
>   CPPC: Add a CPUFreq driver for use with CPPC
>   CPPC: Probe for CPPC tables for each ACPI Processor object
>   PCC: Enable PCC only when needed
> 
>  drivers/acpi/Kconfig            |  58 ++-
>  drivers/acpi/Makefile           |   8 +-
>  drivers/acpi/cppc_acpi.c        | 808 ++++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/processor_driver.c |  89 +++--
>  drivers/cpufreq/Kconfig         |   2 +-
>  drivers/cpufreq/Kconfig.arm     |  16 +
>  drivers/cpufreq/Kconfig.x86     |   2 +
>  drivers/cpufreq/Makefile        |   2 +
>  drivers/cpufreq/cppc_cpufreq.c  | 197 ++++++++++
>  drivers/mailbox/Kconfig         |   2 +-
>  drivers/mailbox/pcc.c           |   2 +-
>  include/acpi/cppc_acpi.h        | 137 +++++++
>  include/acpi/processor.h        | 118 +++++-
>  13 files changed, 1380 insertions(+), 61 deletions(-)
>  create mode 100644 drivers/acpi/cppc_acpi.c
>  create mode 100644 drivers/cpufreq/cppc_cpufreq.c
>  create mode 100644 include/acpi/cppc_acpi.h
> 

Apart from how the patches showed up in email :), nice work, Ashwin.

Can you add a description of how you tested this, too?

Other than that,

Reviewed-by: Al Stone <al.stone@linaro.org>

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
