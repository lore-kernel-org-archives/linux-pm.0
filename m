From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH v3 1/2] CPPC as a PID controller backend
Date: Mon, 01 Dec 2014 06:56:17 -0800
Message-ID: <547C8191.4030002@gmail.com>
References: <1416429381-3839-1-git-send-email-ashwin.chaugule@linaro.org>	<1416429381-3839-2-git-send-email-ashwin.chaugule@linaro.org>	<CAJ5Y-ebiHC9Nk-T7mA33jfibdA1T-pkO2k4KLnhS=-o6gHSbLw@mail.gmail.com> <CAKohpomTpDO4mRvivYpm5xLSpOniO_iw0n7Rj4pCksjBim-cRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:57592 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744AbaLAO4P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 09:56:15 -0500
Received: by mail-pa0-f43.google.com with SMTP id kx10so11271020pab.30
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2014 06:56:14 -0800 (PST)
In-Reply-To: <CAKohpomTpDO4mRvivYpm5xLSpOniO_iw0n7Rj4pCksjBim-cRg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: dirk.brandewie@gmail.com, "rwells@codeaurora.org" <rwells@codeaurora.org>, Linda Knippers <linda.knippers@hp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Patch Tracking <patches@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On 11/30/2014 10:26 PM, Viresh Kumar wrote:
> On 1 December 2014 at 11:53, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
>> On 19 November 2014 at 15:36, Ashwin Chaugule
>> <ashwin.chaugule@linaro.org> wrote:
>>> CPPC (Collaborative Processor Performance Control) is defined
>>> in the ACPI 5.0+ spec. It is a method for controlling CPU
>>> performance on a continuous scale using performance feedback
>>> registers. In contrast to the legacy "pstate" scale which is
>>> discretized, and tied to CPU frequency, CPPC works off of an
>>> abstract continuous scale. This lets the platforms freely interpret
>>> the abstract unit and optimize it for power and performance given
>>> its knowledge of thermal budgets and other constraints.
>>>
>>> The PID governor operates on similar concepts and can use CPPC
>>> semantics to acquire the information it needs. This information
>>> may be provided by various platforms via MSRs, CP15s or memory
>>> mapped registers. CPPC helps to wrap all these variations into a
>>> common framework.
>>>
>>> This patch introduces CPPC using PID as its governor for CPU
>>> performance management.
>>>
>>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>>> ---
>>>   drivers/cpufreq/Kconfig    |   12 +
>>>   drivers/cpufreq/Makefile   |    1 +
>>>   drivers/cpufreq/acpi_pid.c | 1156 ++++++++++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 1169 insertions(+)
>>>   create mode 100644 drivers/cpufreq/acpi_pid.c
>>
>>
>> Ping.
>>
>> Any comments on these patches?
>
> Redirecting the Ping to Rafael/Dirk :)
>
Ashwin has incorporated my feedback.  I have no issues

--Dirk
