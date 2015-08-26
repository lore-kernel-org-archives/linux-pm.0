From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v8 0/9] CPUFreq driver using CPPC methods
Date: Tue, 25 Aug 2015 20:31:32 -0400
Message-ID: <CAJ5Y-eZDgshbO5YVq2bZFA6hoqterwtoi2NEyXDdN3rZCY0nYg@mail.gmail.com>
References: <cover.1438781668.git.ashwin.chaugule@linaro.org>
	<2045829.54HCqxaeyf@vostro.rjw.lan>
	<CAJ5Y-ebJhAY8PPz4AqyGBD=oGPEJOyD9eH66Dc_2S9kFT4pW4w@mail.gmail.com>
	<21207145.jPCoRLotCE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:36770 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932672AbbHZAbe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2015 20:31:34 -0400
Received: by labia3 with SMTP id ia3so44808880lab.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2015 17:31:33 -0700 (PDT)
In-Reply-To: <21207145.jPCoRLotCE@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jaswinder Singh <jaswinder.singh@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "rwells@codeaurora.org" <rwells@codeaurora.org>

On 25 August 2015 at 20:46, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, August 25, 2015 08:03:06 PM Ashwin Chaugule wrote:
>> On 25 August 2015 at 20:24, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > On Wednesday, August 05, 2015 09:40:23 AM Ashwin Chaugule wrote:
>> >> CPPC:
>> >> ====
>> >>
>> >> CPPC (Collaborative Processor Performance Control) is a new way to control CPU
>> >> performance using an abstract continous scale as against a discretized P-state scale
>> >> which is tied to CPU frequency only. It is defined in the ACPI 5.0+ spec. In brief,
>> >> the basic operation involves:
>> >> - OS makes a CPU performance request. (Can provide min and max tolerable bounds)
>> >>
>> >> - Platform (such as BMC) is free to optimize request within requested bounds depending
>> >> on power/thermal budgets etc.
>> >>
>> >> - Platform conveys its decision back to OS
>> >>
>> >> The communication between OS and platform occurs through another medium called (PCC)
>> >> Platform communication Channel. This is a generic mailbox like mechanism which includes
>> >> doorbell semantics to indicate register updates. See drivers/mailbox/pcc.c
>> >>
>> >> This patchset introduces a CPPC based CPUFreq driver that works with existing governors
>> >> such as ondemand. The CPPC table parsing and the CPPC communication semantics are
>> >> abstracted into separate files to allow future CPPC based drivers to implement their
>> >> own governors if required.
>> >>
>> >> Initial patchsets included an adaptation of the PID governor from intel_pstate.c. However
>> >> recent experiments led to extensive modifications of the algorithm to calculate CPU
>> >> busyness. Until it is verified that these changes are worthwhile, the existing governors
>> >> should provide for a good enough starting point for ARM64 servers.
>> >>
>> >> Finer details about the PCC and CPPC spec are available in the latest ACPI 5.1
>> >> specification.[2]
>> >>
>> >> Testing:
>> >> =======
>> >>
>> >> This was tested on an SBSA compatible ARMv8 server with CPPCv2
>> >> firmware running on a remote processor. I verified that each CPUs
>> >> performance limits were detected and that new performance requests
>> >> were made by the on-demand governor proportional to the load on each
>> >> CPU. I also verified that using the acpi_processor driver correctly
>> >> maps the physical CPU ids to logical CPU ids, which helps in picking
>> >> up the proper _CPC details from a processor object, in the case where
>> >> CPU physical ids may not be contiguous.
>> >>
>> >> Changes since V7:
>> >> - Simplied new kconfig options for PSS and idle.
>> >> - Separated patch to enable acpi processor on ARM64.
>> >> - Removed redundant kconfig cross deps on PCC.
>> >> - Decoupled processor_perflib from new PSS kconfig option.
>> >>
>> >> Changes since V6:
>> >> - Separated PSS and CST from ACPI processor driver in two patches.
>> >> - Made new Kconfig symbols auto selectable from Arch Kconfigs.
>> >>
>> >> Changes since V5:
>> >> - Checkpatch cleanups.
>> >> - Change pss_init to pss_perf_init. Rec by Srinivas Pandruvada.
>> >> - Explicit comment explaining why postcore_initcall to pcc mailbox.
>> >> - Fold acpi_processor_syscore_init/exit into CONFIG_ACPI_CST.
>> >> - Added patch with dummy functions used by ACPI_HOTPLUG_CPU.
>> >>
>> >> Changes since V4:
>> >> - Misc cleanups. Addressed feedback from Rafael.
>> >> - Made acpi_processor.c independent of C-states, P-states and others.
>> >> - Per CPU scanning for _CPC is now made from acpi_processor.c
>> >> - Added new Kconfig options for legacy C states and P states to enable future
>> >> support for newer alternatives as defined in the ACPI spec 6.0.
>> >>
>> >> Changes since V3:
>> >> - Split CPPC backend methods into separate files.
>> >> - Add frontend driver which plugs into existing CPUfreq governors.
>> >> - Simplify PCC driver by moving communication space mapping and read/write
>> >>       into client drivers.
>> >>
>> >> Changes since V2:
>> >> - Select driver if !X86, since intel_pstate will use HWP extensions instead.
>> >> - Added more comments.
>> >> - Added Freq domain awareness and PSD parsing.
>> >>
>> >> Changes since V1:
>> >> - Create a new driver based on Dirks suggestion.
>> >> - Fold in CPPC backend hooks into main driver.
>> >>
>> >> Changes since V0: [1]
>> >> - Split intel_pstate.c into a generic PID governor and platform specific backend.
>> >> - Add CPPC accessors as PID backend.
>> >>
>> >> [1] - http://lwn.net/Articles/608715/
>> >> [2] - http://www.uefi.org/sites/default/files/resources/ACPI_5_1release.pdf
>> >> [3] - https://patches.linaro.org/40705/
>> >>
>> >>
>> >> Ashwin Chaugule (9):
>> >>   PCC: Initialize PCC Mailbox earlier at boot
>> >>   ACPI: Split out ACPI PSS from ACPI Processor driver
>> >>   ACPI: Decouple ACPI idle and ACPI processor drivers
>> >>   ACPI: Introduce CPU performance controls using CPPC
>> >>   CPPC: Add a CPUFreq driver for use with CPPC
>> >>   ACPI: Add weak routines for ACPI CPU Hotplug
>> >>   CPPC: Probe for CPPC tables for each ACPI Processor object
>> >>   PCC: Disable compilation by default
>> >>   ACPI: Allow selection of the ACPI processor driver for ARM64
>> >
>> > I've queued up [1-3/9] for 4.3, but I still have a couple of questions/comments
>> > regarding [4/9] and the rest of the series (I'll respond to the patch messages
>> > with those).
>>
>> Thanks! Would you mind taking [8/9] too? It just defaults PCC to disabled.
>
> OK, I'll do that.

Very much appreciated!
