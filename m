From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v4 2/2] CPPC: Add CPUFreq driver based on CPPC methods
Date: Wed, 4 Feb 2015 10:18:41 -0500
Message-ID: <CAJ5Y-eYB1XhZ_uVq8FocD6JMcPe6O1Z5ZH0BaOaPGsakiO0XgQ@mail.gmail.com>
References: <1422392638-31334-1-git-send-email-ashwin.chaugule@linaro.org>
	<1805804.escc39d3ai@vostro.rjw.lan>
	<CAJ5Y-eY66PybCZ5CMtPeg_rKc+NX3O9_7whTubN6iF=F21WgYA@mail.gmail.com>
	<3237680.21UHnh0sSv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:49900 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965873AbbBDPSn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Feb 2015 10:18:43 -0500
Received: by mail-we0-f177.google.com with SMTP id l61so2339068wev.8
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2015 07:18:42 -0800 (PST)
In-Reply-To: <3237680.21UHnh0sSv@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "rwells@codeaurora.org" <rwells@codeaurora.org>, Linda Knippers <linda.knippers@hp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Patch Tracking <patches@linaro.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Jaswinder Singh <jaswinder.singh@linaro.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>

Hello,

On 4 February 2015 at 09:33, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, February 03, 2015 10:23:31 PM Ashwin Chaugule wrote:
>> On 3 February 2015 at 17:33, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > On Tuesday, January 27, 2015 04:03:58 PM Ashwin Chaugule wrote:
>> >
>> > First question: How do we ensure that this won't interact negatively with
>> > the existing ACPI cpufreq driver?  In particular, what is there to allow
>> > users to use the driver they want?
>>
>> The existing ACPI cpufreq driver isnt enabled on ARM. (At a minimum,
>> it needs spec updates in the PSS sections for ARM.) For ARM64 servers,
>> CPPC is the preferred choice. But you're right, if someone adds PSS
>> support on ARM then we need a way to make these two mutually exclusive
>> at runtime.
>
> Analogously, if _CPC is present on a non-ARM platform.

Hm. Currently CPPC is available only under Kconfig.arm under cpufreq.
My understanding is that X86 will use HWP (CPPC equivalent) through
intel_pstate (using MSRs). I'm not aware of any other non-ARM platform
that could use this as of yet, although in theory, any platform with
ACPI support should be able to.

>> On ARM64 servers, we'd want it the other way. i.e. if the acpi-cpufreq
>> driver detects CPC then it skips its init.
>
> I'm not sure if we can do that in general, though.

Curious to know why we couldn't check for _CPC in the acpi-cpufreq
driver and bail if it is found? FWIW, the spec also states that if
_CPC is present it supersedes _PSS and friends  (section 8.4.5.1.10)

>
>> I'm open to any suggestions on how to handle this.
>
> Let me think about that a bit more.

Much appreciated!

Cheers,
Ashwin
