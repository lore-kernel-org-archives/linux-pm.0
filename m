From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v7 8/8] PCC: Enable PCC only when needed
Date: Tue, 04 Aug 2015 15:53:38 +0100
Message-ID: <55C0D1F2.9050505@arm.com>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>	<CAJZ5v0j-_QB1U-A0F2YSoDa_71nyEGR=yn8Kb5qe-FSqDPevOA@mail.gmail.com>	<55AE652B.7030409@arm.com>	<1583446.GxfV2z2IW5@vostro.rjw.lan> <CAJ5Y-eb5HOtStDztU+AYj264dRGbqa5OrVo-VHRBcnfHK-2a3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58402 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934437AbbHDOxn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 4 Aug 2015 10:53:43 -0400
In-Reply-To: <CAJ5Y-eb5HOtStDztU+AYj264dRGbqa5OrVo-VHRBcnfHK-2a3w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>



On 03/08/15 18:35, Ashwin Chaugule wrote:
> On 21 July 2015 at 21:28, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Tuesday, July 21, 2015 04:28:43 PM Sudeep Holla wrote:
>>> Hi Rafael,
>>>

[...]

>>>
>>> Agreed and I am absolutely fine with that. But if you look at this
>>> patch, it does
>>>
>>> config PCC
>>>        bool "Platform Communication Channel Driver"
>>>        depends on ACPI && ACPI_CPPC_LIB
>>
>> My bad, I've evidently overlooked that.
>>
>> If PPC is selected from ACPI_CPPC_LIB, the "depends on" above is
>> obviously not needed.
>
> Thanks Sudeep.
> So I'll take this dependency out and default PCC to 'n'. Think that
> should work for all cases. Agree?
>

Yes

Regards,
Sudeep
