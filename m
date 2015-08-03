From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v7 8/8] PCC: Enable PCC only when needed
Date: Mon, 3 Aug 2015 13:35:49 -0400
Message-ID: <CAJ5Y-eb5HOtStDztU+AYj264dRGbqa5OrVo-VHRBcnfHK-2a3w@mail.gmail.com>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>
	<CAJZ5v0j-_QB1U-A0F2YSoDa_71nyEGR=yn8Kb5qe-FSqDPevOA@mail.gmail.com>
	<55AE652B.7030409@arm.com>
	<1583446.GxfV2z2IW5@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34330 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231AbbHCRfv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2015 13:35:51 -0400
Received: by lbqc9 with SMTP id c9so56406317lbq.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2015 10:35:49 -0700 (PDT)
In-Reply-To: <1583446.GxfV2z2IW5@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>

On 21 July 2015 at 21:28, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, July 21, 2015 04:28:43 PM Sudeep Holla wrote:
>> Hi Rafael,
>>
>> On 21/07/15 15:34, Rafael J. Wysocki wrote:
>> > Hi Sudeep,
>> >
>> > On Tue, Jul 21, 2015 at 11:23 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> >>
>> >>
>> >> On 20/07/15 23:04, Rafael J. Wysocki wrote:
>> >>>
>> >>> On Monday, July 20, 2015 03:22:37 PM Sudeep Holla wrote:
>> >>>>
>> >>>>
>> >>>> On 09/07/15 19:04, Ashwin Chaugule wrote:
>> >>>>>
>> >>>>> CPPC is the first client to make use of the PCC Mailbox channel. So
>> >>>>> enable it only when CPPC is also enabled.
>> >>>>>
>> >>>> This sounds like a reverse dependency to me. So if there's some client
>> >>>> unrelated to CPPC using PCC, CPPC_LIB needs to be selected to enable PCC
>> >>>> ?
>> >>>
>> >>>
>> >>> No.  The other client will need to select PCC too.
>> >>
>> >>
>> >> Yes the PCC users/clients selecting PCC is fine and that's already
>> >> done(i.e. ACPI_CPPC_LIB selects PCC). I still don't understand the need
>> >> for this change, also how will other clients possibly select PCC which
>> >> now depends on CPPC_LIB ? e.g. if we have
>> >>
>> >> config ACPI_XYZ_LIB
>> >>          select PCC
>> >>
>> >> config ACPI_XYZ
>> >>          select ACPI_XYZ_LIB
>> >>
>> >> Won't this shout warning: (ACPI_XYZ_LIB && ACPI_CPPC_LIB) selects PCC
>> >> which has unmet direct dependencies (MAILBOX && ACPI && ACPI_CPPC_LIB)
>> >> if ACPI_CPPC_LIB is not selected ?
>> >
>> > That depends on the "depends on" clauses used.  Selecting itself
>> > doesn't cause any dependencies to appear.
>> >
>>
>> Agreed and I am absolutely fine with that. But if you look at this
>> patch, it does
>>
>> config PCC
>>       bool "Platform Communication Channel Driver"
>>       depends on ACPI && ACPI_CPPC_LIB
>
> My bad, I've evidently overlooked that.
>
> If PPC is selected from ACPI_CPPC_LIB, the "depends on" above is
> obviously not needed.

Thanks Sudeep.
So I'll take this dependency out and default PCC to 'n'. Think that
should work for all cases. Agree?

Thanks,
Ashwin.
