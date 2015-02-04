From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 2/2] CPPC: Add CPUFreq driver based on CPPC methods
Date: Wed, 04 Feb 2015 15:33:39 +0100
Message-ID: <3237680.21UHnh0sSv@vostro.rjw.lan>
References: <1422392638-31334-1-git-send-email-ashwin.chaugule@linaro.org> <1805804.escc39d3ai@vostro.rjw.lan> <CAJ5Y-eY66PybCZ5CMtPeg_rKc+NX3O9_7whTubN6iF=F21WgYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56214 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932630AbbBDOKp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Feb 2015 09:10:45 -0500
In-Reply-To: <CAJ5Y-eY66PybCZ5CMtPeg_rKc+NX3O9_7whTubN6iF=F21WgYA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: "rwells@codeaurora.org" <rwells@codeaurora.org>, Linda Knippers <linda.knippers@hp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Patch Tracking <patches@linaro.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Jaswinder Singh <jaswinder.singh@linaro.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>

On Tuesday, February 03, 2015 10:23:31 PM Ashwin Chaugule wrote:
> Hi Rafael,
> 
> On 3 February 2015 at 17:33, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, January 27, 2015 04:03:58 PM Ashwin Chaugule wrote:
> >> CPPC stands for Collaborative Processor Performance Controls
> >> and is defined in the ACPI v5.0+ spec. It describes CPU
> >> performance controls on an abstract and continuous scale
> >> allowing the platform (e.g. remote power processor) to flexibly
> >> optimize CPU performance with its knowledge of power budgets
> >> and other architecture specific knowledge.
> >>
> >> This patch introduces a CPUFreq driver which works with
> >> existing CPUFreq governors. The backend CPPC methods for
> >> parsing the CPPC table and reading/writing using CPPC semantics
> >> are abstracted away such that they can be used by any other CPPC
> >> based CPUFreq driver in the future.
> >
> > First question: How do we ensure that this won't interact negatively with
> > the existing ACPI cpufreq driver?  In particular, what is there to allow
> > users to use the driver they want?
> 
> The existing ACPI cpufreq driver isnt enabled on ARM. (At a minimum,
> it needs spec updates in the PSS sections for ARM.) For ARM64 servers,
> CPPC is the preferred choice. But you're right, if someone adds PSS
> support on ARM then we need a way to make these two mutually exclusive
> at runtime.

Analogously, if _CPC is present on a non-ARM platform.

> IIUC on X86, intel_pstate is skipped if it finds PSS/PPC?

Nope.  There are quirks for systems where this happens, but generally
intel_pstate is a preferred driver.

> On ARM64 servers, we'd want it the other way. i.e. if the acpi-cpufreq
> driver detects CPC then it skips its init.

I'm not sure if we can do that in general, though.

> I'm open to any suggestions on how to handle this.

Let me think about that a bit more.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
