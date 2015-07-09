From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v6 2/7] ACPI: Make ACPI processor driver more extensible
Date: Thu, 09 Jul 2015 10:06:34 +0100
Message-ID: <559E399A.7000003@arm.com>
References: <cover.1434398373.git.ashwin.chaugule@linaro.org>	<9e352cbe2feac01158a21511bac5c544dc2f29e2.1434398373.git.ashwin.chaugule@linaro.org>	<2138469.Io9yItSdst@vostro.rjw.lan>	<CAJ5Y-eZBYb551T=kBdbjM4YQ1f_hwYBgkVk4wJsDHSib00XfrA@mail.gmail.com>	<CAJZ5v0gKW7bR66trxvuhd_Gb=ZMBbec++u+V+T4mroCZMtO+vg@mail.gmail.com>	<CAJ5Y-ebW3aCSSs4UQFLpLFSfo7d9zPVfigoROjN80uXzG1sZLw@mail.gmail.com>	<CAJZ5v0h24-YAeqW79Se8kRr+_+RknwNfLwS_74-sN+W0_wBaZg@mail.gmail.com>	<CAJ5Y-eYwnaDzyL78CyJDmo35CFTNoQrYfEcO3VYnpaZkSVPdcw@mail.gmail.com> <CAJ5Y-eaGmF6pRKuapzQo8ruMt0FX4kVrdyu-os6maVaS7WO-Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44966 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298AbbGIJGh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 9 Jul 2015 05:06:37 -0400
In-Reply-To: <CAJ5Y-eaGmF6pRKuapzQo8ruMt0FX4kVrdyu-os6maVaS7WO-Pw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jaswinder Singh <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

Hi,

On 08/07/15 21:28, Ashwin Chaugule wrote:
> On 8 July 2015 at 16:05, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
>> On 8 July 2015 at 15:55, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> Hi Ashwin,

[...]

>>>
>>> Can you please just send the new version of the $subject patch alone for now?
>>
>> Attached below. (hope that worked.)
>>
>>>
>>> Also I'm still unsure what the connection between _CST and CPPC is.
>>>
>>
>> There isnt. But I'm missing where I've implied the dependency?
>
> Perhaps the confusion is coming from the introduction of ACPI_CST in
> this file. I could leave it as it is and just separate out the
> ACPI_PSS bits. But I figured, while I'm at it, I'd introduce ACPI_CST,
> since we know the LPI stuff is coming up soon as a CST alternative
> anyway. So if you prefer, I can drop the CST bits and maybe Sudeep can
> address that as part of his LPI patchset?
>

Correct, I will handle it as a prerequisite for introducing _LPI
support. I had posted an RFC long back, will revive those patches and
repost them soon.

It's better to enable ACPI_PROCESSOR on ARM64 only after we have all
these dependencies resolved. Until then we need to carry some patches
locally for testing.

Regards,
Sudeep

