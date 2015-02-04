From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v4 2/2] CPPC: Add CPUFreq driver based on CPPC methods
Date: Tue, 3 Feb 2015 22:23:31 -0500
Message-ID: <CAJ5Y-eY66PybCZ5CMtPeg_rKc+NX3O9_7whTubN6iF=F21WgYA@mail.gmail.com>
References: <1422392638-31334-1-git-send-email-ashwin.chaugule@linaro.org>
	<1422392638-31334-3-git-send-email-ashwin.chaugule@linaro.org>
	<1805804.escc39d3ai@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:33289 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbbBDDXd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 22:23:33 -0500
Received: by mail-we0-f175.google.com with SMTP id p10so48554600wes.6
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2015 19:23:31 -0800 (PST)
In-Reply-To: <1805804.escc39d3ai@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "rwells@codeaurora.org" <rwells@codeaurora.org>, Linda Knippers <linda.knippers@hp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Patch Tracking <patches@linaro.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Jaswinder Singh <jaswinder.singh@linaro.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>

Hi Rafael,

On 3 February 2015 at 17:33, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, January 27, 2015 04:03:58 PM Ashwin Chaugule wrote:
>> CPPC stands for Collaborative Processor Performance Controls
>> and is defined in the ACPI v5.0+ spec. It describes CPU
>> performance controls on an abstract and continuous scale
>> allowing the platform (e.g. remote power processor) to flexibly
>> optimize CPU performance with its knowledge of power budgets
>> and other architecture specific knowledge.
>>
>> This patch introduces a CPUFreq driver which works with
>> existing CPUFreq governors. The backend CPPC methods for
>> parsing the CPPC table and reading/writing using CPPC semantics
>> are abstracted away such that they can be used by any other CPPC
>> based CPUFreq driver in the future.
>
> First question: How do we ensure that this won't interact negatively with
> the existing ACPI cpufreq driver?  In particular, what is there to allow
> users to use the driver they want?

The existing ACPI cpufreq driver isnt enabled on ARM. (At a minimum,
it needs spec updates in the PSS sections for ARM.) For ARM64 servers,
CPPC is the preferred choice. But you're right, if someone adds PSS
support on ARM then we need a way to make these two mutually exclusive
at runtime. IIUC on X86, intel_pstate is skipped if it finds PSS/PPC?
On ARM64 servers, we'd want it the other way. i.e. if the acpi-cpufreq
driver detects CPC then it skips its init. I'm open to any suggestions
on how to handle this.

Thanks,
Ashwin
