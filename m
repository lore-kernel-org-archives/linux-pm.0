From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [RFC PATCH v2 2/3] CPPC as a PID controller backend
Date: Thu, 9 Oct 2014 13:16:34 -0400
Message-ID: <CAJ5Y-eZjBSP3eTs9QVBaaLskoL8HPgCCG0ArkgcpMLcubJAg5A@mail.gmail.com>
References: <1412799064-2339-1-git-send-email-ashwin.chaugule@linaro.org>
	<1412799064-2339-3-git-send-email-ashwin.chaugule@linaro.org>
	<5436B655.6090403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38171 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbaJIRQf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Oct 2014 13:16:35 -0400
Received: by mail-wi0-f178.google.com with SMTP id cc10so2483793wib.5
        for <linux-pm@vger.kernel.org>; Thu, 09 Oct 2014 10:16:34 -0700 (PDT)
In-Reply-To: <5436B655.6090403@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "rwells@codeaurora.org" <rwells@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Linda Knippers <linda.knippers@hp.com>

Hi Dirk,

On 9 October 2014 12:22, Dirk Brandewie <dirk.brandewie@gmail.com> wrote:
> On 10/08/2014 01:11 PM, Ashwin Chaugule wrote:
>
>> +static int __init acpi_pid_init(void)
>> +{
>> +       int cpu, rc = 0;
>> +
>
>
> You should add a check here to not bind to Intel CPU. The CPPC interface
> was created to provided an ACPI interface to to hardware controlled P states
> (HWP) described in Volume 3 section 14.4 of the Intel SDM.
> intel_pstate will be enabling HWP by controlling the MSRs directly and
> not using CPPC.
>
> Adding this check will keep us from having to fight load order since
> this driver and intel_pstate are at the same init level.

Do you have a recommendation for how to check for such CPUs? Would it
make sense to deselect this driver if intel_pstate is chosen at
compile time instead?

Thanks,
Ashwin
