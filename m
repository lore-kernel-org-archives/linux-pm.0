From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v4 2/2] CPPC: Add CPUFreq driver based on CPPC methods
Date: Wed, 1 Apr 2015 11:38:10 -0400
Message-ID: <CAJ5Y-ea-5cV=+=+XC7QfGPyAerpfajFa4T3Y-9A4imuB1wyXYQ@mail.gmail.com>
References: <1422392638-31334-1-git-send-email-ashwin.chaugule@linaro.org>
	<1805804.escc39d3ai@vostro.rjw.lan>
	<CAJ5Y-eY66PybCZ5CMtPeg_rKc+NX3O9_7whTubN6iF=F21WgYA@mail.gmail.com>
	<3237680.21UHnh0sSv@vostro.rjw.lan>
	<CAJ5Y-eYB1XhZ_uVq8FocD6JMcPe6O1Z5ZH0BaOaPGsakiO0XgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34298 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbbDAPiK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2015 11:38:10 -0400
Received: by iedfl3 with SMTP id fl3so51937589ied.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2015 08:38:10 -0700 (PDT)
In-Reply-To: <CAJ5Y-eYB1XhZ_uVq8FocD6JMcPe6O1Z5ZH0BaOaPGsakiO0XgQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "rwells@codeaurora.org" <rwells@codeaurora.org>, Linda Knippers <linda.knippers@hp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Patch Tracking <patches@linaro.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Jaswinder Singh <jaswinder.singh@linaro.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>

Hi Rafael,

On 4 February 2015 at 10:18, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> Hello,
>
> On 4 February 2015 at 09:33, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Tuesday, February 03, 2015 10:23:31 PM Ashwin Chaugule wrote:
>>> On 3 February 2015 at 17:33, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> > On Tuesday, January 27, 2015 04:03:58 PM Ashwin Chaugule wrote:
>>> >
>>> > First question: How do we ensure that this won't interact negatively with
>>> > the existing ACPI cpufreq driver?  In particular, what is there to allow
>>> > users to use the driver they want?
>>>
>>> The existing ACPI cpufreq driver isnt enabled on ARM. (At a minimum,
>>> it needs spec updates in the PSS sections for ARM.) For ARM64 servers,
>>> CPPC is the preferred choice. But you're right, if someone adds PSS
>>> support on ARM then we need a way to make these two mutually exclusive
>>> at runtime.
>>
>> Analogously, if _CPC is present on a non-ARM platform.
>
> Hm. Currently CPPC is available only under Kconfig.arm under cpufreq.
> My understanding is that X86 will use HWP (CPPC equivalent) through
> intel_pstate (using MSRs). I'm not aware of any other non-ARM platform
> that could use this as of yet, although in theory, any platform with
> ACPI support should be able to.
>
>>> On ARM64 servers, we'd want it the other way. i.e. if the acpi-cpufreq
>>> driver detects CPC then it skips its init.
>>
>> I'm not sure if we can do that in general, though.
>
> Curious to know why we couldn't check for _CPC in the acpi-cpufreq
> driver and bail if it is found? FWIW, the spec also states that if
> _CPC is present it supersedes _PSS and friends  (section 8.4.5.1.10)
>
>>
>>> I'm open to any suggestions on how to handle this.
>>
>> Let me think about that a bit more.
>
> Much appreciated!

Gentle reminder to review the CPPC patch.

Thanks,
Ashwin.
