From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v3 0/2] CPPC as a PID backend
Date: Wed, 19 Nov 2014 15:39:55 -0500
Message-ID: <CAJ5Y-eYqA-TqG1YVV+00RSq3cYSAARKefqCg6BiKk7VS-1+6cQ@mail.gmail.com>
References: <1416429381-3839-1-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:48819 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756482AbaKSUj5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Nov 2014 15:39:57 -0500
Received: by mail-wg0-f53.google.com with SMTP id l18so1805341wgh.26
        for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2014 12:39:56 -0800 (PST)
In-Reply-To: <1416429381-3839-1-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "rwells@codeaurora.org" <rwells@codeaurora.org>, Linda Knippers <linda.knippers@hp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Dirk Brandewie <dirk.brandewie@gmail.com>, Patch Tracking <patches@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ashwin Chaugule <ashwin.chaugule@linaro.org>

On 19 November 2014 15:36, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> This patchset introduces CPPC(Collaborative Processor Performance Control) as a backend
> to the PID governor. The PID governor from intel_pstate.c maps cleanly onto some CPPC
> interfaces.
> e.g. The CPU performance requests are made on a continuous scale as against discrete pstate
> levels. The CPU performance feedback over an interval is gauged using platform specific
> counters which are also described by CPPC.
>
> Although CPPC describes several other registers to provide more hints to the platform,
> Linux as of today does not have the infrastructure to make use of those registers.
> Some of the CPPC specific information could be made available from the scheduler as
> part of the CPUfreq and Scheduler intergration work. Until then PID can be used as the
> front end for CPPC.
>
> This implementation was tested using a Thinkpad X240 Laptop which enumerates CPPC and PCC
> tables in its ACPI firmware.
>
> This patchset builds on top of the PCC driver which is being reviewed separately[3].
>
> Changes since V2:
> - Select driver if !X86, since intel_pstate will use HWP extensions instead.
> - Added more comments.
> - Added Freq domain awareness and PSD parsing.
>

Apologies for resending. I had a typo in the linaro-acpi email addr.

Thanks,
Ashwin
