From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v3 1/2] CPPC as a PID controller backend
Date: Sat, 20 Dec 2014 19:14:33 -0500
Message-ID: <CAJ5Y-ebUct=nBNBAqKTMef6bn9EZeWPJyQkg8Z8jeFvE4gQrVA@mail.gmail.com>
References: <1416429381-3839-1-git-send-email-ashwin.chaugule@linaro.org>
	<547C8191.4030002@gmail.com>
	<CAJ5Y-eaopvn8PxCzXR8ad38WOGNJq4ms0pWp1gqEUXYqn+N-6w@mail.gmail.com>
	<4328753.Stv6XUNcFM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:42657 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbaLUAOg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 20 Dec 2014 19:14:36 -0500
Received: by mail-wg0-f54.google.com with SMTP id l2so4135723wgh.27
        for <linux-pm@vger.kernel.org>; Sat, 20 Dec 2014 16:14:35 -0800 (PST)
In-Reply-To: <4328753.Stv6XUNcFM@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, "rwells@codeaurora.org" <rwells@codeaurora.org>, Linda Knippers <linda.knippers@hp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Patch Tracking <patches@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

Hi Rafael,

On 15 December 2014 at 10:16, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, December 15, 2014 09:42:08 AM Ashwin Chaugule wrote:
>> On 1 December 2014 at 09:56, Dirk Brandewie <dirk.brandewie@gmail.com> wrote:
>> > On 11/30/2014 10:26 PM, Viresh Kumar wrote:
>> >>
>> >> On 1 December 2014 at 11:53, Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> >> wrote:
>> >>>
>> >>> On 19 November 2014 at 15:36, Ashwin Chaugule
>> >>> <ashwin.chaugule@linaro.org> wrote:
>> >>>>
>> >>>> CPPC (Collaborative Processor Performance Control) is defined
>> >>>> in the ACPI 5.0+ spec. It is a method for controlling CPU
>> >>>> performance on a continuous scale using performance feedback
>> >>>> registers. In contrast to the legacy "pstate" scale which is
>> >>>> discretized, and tied to CPU frequency, CPPC works off of an
>> >>>> abstract continuous scale. This lets the platforms freely interpret
>> >>>> the abstract unit and optimize it for power and performance given
>> >>>> its knowledge of thermal budgets and other constraints.
>> >>>>
>> >>>> The PID governor operates on similar concepts and can use CPPC
>> >>>> semantics to acquire the information it needs. This information
>> >>>> may be provided by various platforms via MSRs, CP15s or memory
>> >>>> mapped registers. CPPC helps to wrap all these variations into a
>> >>>> common framework.
>> >>>>
>> >>>> This patch introduces CPPC using PID as its governor for CPU
>> >>>> performance management.
>> >>>>
>> >>>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> >>>> ---
>> >>>>   drivers/cpufreq/Kconfig    |   12 +
>> >>>>   drivers/cpufreq/Makefile   |    1 +
>> >>>>   drivers/cpufreq/acpi_pid.c | 1156
>> >>>> ++++++++++++++++++++++++++++++++++++++++++++
>> >>>>   3 files changed, 1169 insertions(+)
>> >>>>   create mode 100644 drivers/cpufreq/acpi_pid.c
>> >>>
>> >>>
>> >>>
>> >>> Ping.
>> >>>
>> >>> Any comments on these patches?
>> >>
>> >>
>> >> Redirecting the Ping to Rafael/Dirk :)
>> >>
>> > Ashwin has incorporated my feedback.  I have no issues
>>
>> Thanks Dirk! I'll add your Reviewed-by to the patchset.
>>
>> Rafael, any comments from your side?
>
> I have a couple of quick ones (will post them shortly), but generally I need
> more time to review the whole thing.

Thanks for the quick review. I've added those changes locally. Just
this week we were able to run these drivers (CPPC + PCC) on an ARM64
platform with some CPPC support in the firmware. This helped in
catching a couple of bugs, which didn't show up on the X86 platform
which I'd been using all this while. So, I'll send V4 with the new
changes for your review at the earliest.

Thanks,
Ashwin
