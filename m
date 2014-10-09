From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [RFC PATCH v2 2/3] CPPC as a PID controller backend
Date: Thu, 09 Oct 2014 10:40:01 -0700
Message-ID: <5436C871.5020404@gmail.com>
References: <1412799064-2339-1-git-send-email-ashwin.chaugule@linaro.org>	<1412799064-2339-3-git-send-email-ashwin.chaugule@linaro.org>	<5436B655.6090403@gmail.com> <CAJ5Y-eZjBSP3eTs9QVBaaLskoL8HPgCCG0ArkgcpMLcubJAg5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:63734 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbaJIRkE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Oct 2014 13:40:04 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so161890pad.33
        for <linux-pm@vger.kernel.org>; Thu, 09 Oct 2014 10:40:03 -0700 (PDT)
In-Reply-To: <CAJ5Y-eZjBSP3eTs9QVBaaLskoL8HPgCCG0ArkgcpMLcubJAg5A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: dirk.brandewie@gmail.com, Viresh Kumar <viresh.kumar@linaro.org>, "rwells@codeaurora.org" <rwells@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Linda Knippers <linda.knippers@hp.com>

On 10/09/2014 10:16 AM, Ashwin Chaugule wrote:
> Hi Dirk,
>
> On 9 October 2014 12:22, Dirk Brandewie <dirk.brandewie@gmail.com> wrote:
>> On 10/08/2014 01:11 PM, Ashwin Chaugule wrote:
>>
>>> +static int __init acpi_pid_init(void)
>>> +{
>>> +       int cpu, rc = 0;
>>> +
>>
>>
>> You should add a check here to not bind to Intel CPU. The CPPC interface
>> was created to provided an ACPI interface to to hardware controlled P states
>> (HWP) described in Volume 3 section 14.4 of the Intel SDM.
>> intel_pstate will be enabling HWP by controlling the MSRs directly and
>> not using CPPC.
>>
>> Adding this check will keep us from having to fight load order since
>> this driver and intel_pstate are at the same init level.
>
> Do you have a recommendation for how to check for such CPUs? Would it
> make sense to deselect this driver if intel_pstate is chosen at
> compile time instead?

Probably the simplest is to change the depends line in Kconfig to:
	depends on PCC && !X86
This will keep your driver from being selected on X86 and the potentail
issue goes away.


>
> Thanks,
> Ashwin
>

