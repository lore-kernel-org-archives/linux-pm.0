From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v9 0/5] CPUFreq driver using CPPC methods
Date: Tue, 13 Oct 2015 05:19:30 -0400
Message-ID: <CAJ5Y-eb7pVe=xjSDT5O8RhNCZD_k173ft6Sv6pdkTezHU+7AjQ@mail.gmail.com>
References: <cover.1441830300.git.ashwin.chaugule@linaro.org> <2971790.bITBxTiVtS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:36100 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbbJMJTv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2015 05:19:51 -0400
Received: by lbcao8 with SMTP id ao8so12348793lbc.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2015 02:19:50 -0700 (PDT)
In-Reply-To: <2971790.bITBxTiVtS@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "rwells@codeaurora.org" <rwells@codeaurora.org>

On 12 October 2015 at 17:37, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, September 09, 2015 04:27:03 PM Ashwin Chaugule wrote:
>> CPPC:
>> ====
>>
>> CPPC (Collaborative Processor Performance Control) is a new way to control CPU
>> performance using an abstract continous scale as against a discretized P-state scale
>> which is tied to CPU frequency only. It is defined in the ACPI 5.0+ spec. In brief,
>> the basic operation involves:
>> - OS makes a CPU performance request. (Can provide min and max tolerable bounds)
>>
>> - Platform (such as BMC) is free to optimize request within requested bounds depending
>> on power/thermal budgets etc.
>>
>> - Platform conveys its decision back to OS
>>
>> The communication between OS and platform occurs through another medium called (PCC)
>> Platform communication Channel. This is a generic mailbox like mechanism which includes
>> doorbell semantics to indicate register updates. See drivers/mailbox/pcc.c
>>
>> This patchset introduces a CPPC based CPUFreq driver that works with existing governors
>> such as ondemand. The CPPC table parsing and the CPPC communication semantics are
>> abstracted into separate files to allow future CPPC based drivers to implement their
>> own governors if required.
>>
>> Initial patchsets included an adaptation of the PID governor from intel_pstate.c. However
>> recent experiments led to extensive modifications of the algorithm to calculate CPU
>> busyness. Until it is verified that these changes are worthwhile, the existing governors
>> should provide for a good enough starting point for ARM64 servers.
>>
>> Finer details about the PCC and CPPC spec are available in the latest ACPI 5.1
>> specification.[2]
>>
>> Testing:
>> =======
>>
>> This was tested on an SBSA compatible ARMv8 server with CPPCv2
>> firmware running on a remote processor. I verified that each CPUs
>> performance limits were detected and that new performance requests
>> were made by the on-demand governor proportional to the load on each
>> CPU. I also verified that using the acpi_processor driver correctly
>> maps the physical CPU ids to logical CPU ids, which helps in picking
>> up the proper _CPC details from a processor object, in the case where
>> CPU physical ids may not be contiguous.
>>
>> Changes since V8:
>> - Fixed up several debug prints, return types and comments.
>> - Simplified read/write ops using existing ACPI core API.
>> - Removed ->get() from cpufreq driver for now.
>> - Fixed bug introduced by copy-paste err in set_perf.
>>
>> Changes since V7:
>> - Simplied new kconfig options for PSS and idle.
>> - Separated patch to enable acpi processor on ARM64.
>> - Removed redundant kconfig cross deps on PCC.
>> - Decoupled processor_perflib from new PSS kconfig option.
>>
>> Changes since V6:
>> - Separated PSS and CST from ACPI processor driver in two patches.
>> - Made new Kconfig symbols auto selectable from Arch Kconfigs.
>>
>> Changes since V5:
>> - Checkpatch cleanups.
>> - Change pss_init to pss_perf_init. Rec by Srinivas Pandruvada.
>> - Explicit comment explaining why postcore_initcall to pcc mailbox.
>> - Fold acpi_processor_syscore_init/exit into CONFIG_ACPI_CST.
>> - Added patch with dummy functions used by ACPI_HOTPLUG_CPU.
>>
>> Changes since V4:
>> - Misc cleanups. Addressed feedback from Rafael.
>> - Made acpi_processor.c independent of C-states, P-states and others.
>> - Per CPU scanning for _CPC is now made from acpi_processor.c
>> - Added new Kconfig options for legacy C states and P states to enable future
>> support for newer alternatives as defined in the ACPI spec 6.0.
>>
>> Changes since V3:
>> - Split CPPC backend methods into separate files.
>> - Add frontend driver which plugs into existing CPUfreq governors.
>> - Simplify PCC driver by moving communication space mapping and read/write
>>       into client drivers.
>>
>> Changes since V2:
>> - Select driver if !X86, since intel_pstate will use HWP extensions instead.
>> - Added more comments.
>> - Added Freq domain awareness and PSD parsing.
>>
>> Changes since V1:
>> - Create a new driver based on Dirks suggestion.
>> - Fold in CPPC backend hooks into main driver.
>>
>> Changes since V0: [1]
>> - Split intel_pstate.c into a generic PID governor and platform specific backend.
>> - Add CPPC accessors as PID backend.
>>
>> [1] - http://lwn.net/Articles/608715/
>> [2] - http://www.uefi.org/sites/default/files/resources/ACPI_5_1release.pdf
>> [3] - https://patches.linaro.org/40705/
>>
>> Ashwin Chaugule (5):
>>   ACPI: Introduce CPU performance controls using CPPC
>>   CPPC: Add a CPUFreq driver for use with CPPC
>>   ACPI: Add weak routines for ACPI CPU Hotplug
>>   CPPC: Probe for CPPC tables for each ACPI Processor object
>>   ACPI: Allow selection of the ACPI processor driver for ARM64
>>
>>  drivers/acpi/Kconfig            |  20 +-
>>  drivers/acpi/Makefile           |   1 +
>>  drivers/acpi/acpi_processor.c   |  18 +
>>  drivers/acpi/cppc_acpi.c        | 755 ++++++++++++++++++++++++++++++++++++++++
>>  drivers/acpi/processor_driver.c |   6 +
>>  drivers/cpufreq/Kconfig.arm     |  17 +
>>  drivers/cpufreq/Makefile        |   2 +
>>  drivers/cpufreq/cppc_cpufreq.c  | 169 +++++++++
>>  include/acpi/cppc_acpi.h        | 138 ++++++++
>>  include/acpi/processor.h        |  14 +
>>  10 files changed, 1137 insertions(+), 3 deletions(-)
>>  create mode 100644 drivers/acpi/cppc_acpi.c
>>  create mode 100644 drivers/cpufreq/cppc_cpufreq.c
>>  create mode 100644 include/acpi/cppc_acpi.h
>
> Series queued up for v4.4 (with the updates).

Great! Thanks Rafael!
