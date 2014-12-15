From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v3 1/2] CPPC as a PID controller backend
Date: Mon, 15 Dec 2014 09:42:08 -0500
Message-ID: <CAJ5Y-eaopvn8PxCzXR8ad38WOGNJq4ms0pWp1gqEUXYqn+N-6w@mail.gmail.com>
References: <1416429381-3839-1-git-send-email-ashwin.chaugule@linaro.org>
	<1416429381-3839-2-git-send-email-ashwin.chaugule@linaro.org>
	<CAJ5Y-ebiHC9Nk-T7mA33jfibdA1T-pkO2k4KLnhS=-o6gHSbLw@mail.gmail.com>
	<CAKohpomTpDO4mRvivYpm5xLSpOniO_iw0n7Rj4pCksjBim-cRg@mail.gmail.com>
	<547C8191.4030002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:54387 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212AbaLOOmK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Dec 2014 09:42:10 -0500
Received: by mail-wi0-f173.google.com with SMTP id r20so9091655wiv.12
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2014 06:42:08 -0800 (PST)
In-Reply-To: <547C8191.4030002@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "rwells@codeaurora.org" <rwells@codeaurora.org>, Linda Knippers <linda.knippers@hp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Patch Tracking <patches@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On 1 December 2014 at 09:56, Dirk Brandewie <dirk.brandewie@gmail.com> wrote:
> On 11/30/2014 10:26 PM, Viresh Kumar wrote:
>>
>> On 1 December 2014 at 11:53, Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> wrote:
>>>
>>> On 19 November 2014 at 15:36, Ashwin Chaugule
>>> <ashwin.chaugule@linaro.org> wrote:
>>>>
>>>> CPPC (Collaborative Processor Performance Control) is defined
>>>> in the ACPI 5.0+ spec. It is a method for controlling CPU
>>>> performance on a continuous scale using performance feedback
>>>> registers. In contrast to the legacy "pstate" scale which is
>>>> discretized, and tied to CPU frequency, CPPC works off of an
>>>> abstract continuous scale. This lets the platforms freely interpret
>>>> the abstract unit and optimize it for power and performance given
>>>> its knowledge of thermal budgets and other constraints.
>>>>
>>>> The PID governor operates on similar concepts and can use CPPC
>>>> semantics to acquire the information it needs. This information
>>>> may be provided by various platforms via MSRs, CP15s or memory
>>>> mapped registers. CPPC helps to wrap all these variations into a
>>>> common framework.
>>>>
>>>> This patch introduces CPPC using PID as its governor for CPU
>>>> performance management.
>>>>
>>>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>>>> ---
>>>>   drivers/cpufreq/Kconfig    |   12 +
>>>>   drivers/cpufreq/Makefile   |    1 +
>>>>   drivers/cpufreq/acpi_pid.c | 1156
>>>> ++++++++++++++++++++++++++++++++++++++++++++
>>>>   3 files changed, 1169 insertions(+)
>>>>   create mode 100644 drivers/cpufreq/acpi_pid.c
>>>
>>>
>>>
>>> Ping.
>>>
>>> Any comments on these patches?
>>
>>
>> Redirecting the Ping to Rafael/Dirk :)
>>
> Ashwin has incorporated my feedback.  I have no issues

Thanks Dirk! I'll add your Reviewed-by to the patchset.

Rafael, any comments from your side?

Thanks,
Ashwin
