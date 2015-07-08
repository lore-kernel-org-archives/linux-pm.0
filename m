From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v6 2/7] ACPI: Make ACPI processor driver more extensible
Date: Wed, 8 Jul 2015 17:57:11 -0400
Message-ID: <CAJ5Y-eb00m6DE_4mHXnGha4j6PwTNeV8x0eroMe_JZy7NVowow@mail.gmail.com>
References: <cover.1434398373.git.ashwin.chaugule@linaro.org>
	<CAJZ5v0iGGgvzdcvAfS9ZiQTWMhqF9GWfZ7Fx6_rF1BGZmACpXw@mail.gmail.com>
	<CAJ5Y-eZCWF8fsfwtJFAS9wyz8ttpGVTZKhoboCudLhUHw80qkg@mail.gmail.com>
	<36832814.6sPr1fbHHF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:35188 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbbGHV5L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 17:57:11 -0400
Received: by obbop1 with SMTP id op1so159985097obb.2
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2015 14:57:11 -0700 (PDT)
In-Reply-To: <36832814.6sPr1fbHHF@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jaswinder Singh <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>

On 8 July 2015 at 18:21, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, July 08, 2015 05:46:45 PM Ashwin Chaugule wrote:
>> On 8 July 2015 at 16:46, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> >>
>> >> Perhaps the confusion is coming from the introduction of ACPI_CST in
>> >> this file. I could leave it as it is and just separate out the
>> >> ACPI_PSS bits. But I figured, while I'm at it, I'd introduce ACPI_CST,
>> >> since we know the LPI stuff is coming up soon as a CST alternative
>> >> anyway. So if you prefer, I can drop the CST bits and maybe Sudeep can
>> >> address that as part of his LPI patchset?
>> >
>> > Yes, please.  That would be much less confusing.
>>
>> Deja Vu. :)
>>
>> When I let processor_driver and processor_idle compile on ARM64, I get
>> a bunch of errors because processor_idle.c contains a lot of X86
>> specific defines. That is why I'd created the ACPI_CST option which
>> we'd enable only on X86.
>>
>> I'm not entirely sure what these enums and functions should default
>> to, or what they should be on ARM specifically. Given that on ARM64
>> we're likely to use LPI as against CST, it seems the original approach
>> is better. Thoughts?
>
> Before we go anywhere deeper, have you checked what happens on ia64?

I dont have access, but I'm really not changing anything functionally.

Thanks,
Ashwin.
