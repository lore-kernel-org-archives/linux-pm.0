From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v5 1/6] PCC: Initialize PCC Mailbox earlier at boot
Date: Wed, 27 May 2015 09:52:28 -0400
Message-ID: <CAJ5Y-eb0UyzYjg0j1unKPTo4=0Y+Tw23F_gXvT7H09=ZrKZ17g@mail.gmail.com>
References: <1432590610-8968-1-git-send-email-ashwin.chaugule@linaro.org>
	<1597157.KLDqcPxL8N@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35720 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbbE0Nw3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2015 09:52:29 -0400
Received: by oihd6 with SMTP id d6so7738204oih.2
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2015 06:52:29 -0700 (PDT)
In-Reply-To: <1597157.KLDqcPxL8N@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jaswinder Singh <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>

On 26 May 2015 at 20:50, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, May 25, 2015 05:50:10 PM Ashwin Chaugule wrote:
>> This change initializes the PCC Mailbox earlier than
>> the ACPI processor driver. This enables drivers introduced
>> in follow up patches (e.g. CPPC) to be probed via the ACPI
>> processor driver interface. The CPPC probe requires the PCC
>> channel to be initialized for it to query each CPUs performance
>> capabilites.
>>
>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> ---
>>  drivers/mailbox/pcc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>> index 7e91d68..8809587 100644
>> --- a/drivers/mailbox/pcc.c
>> +++ b/drivers/mailbox/pcc.c
>> @@ -352,4 +352,4 @@ static int __init pcc_init(void)
>>
>>       return 0;
>>  }
>> -device_initcall(pcc_init);
>> +postcore_initcall(pcc_init);
>
> If there is an ordering requirement between two components, it's better to
> make it explicit rather than to change the initcall priorities like that.
>
> At least please add a comment why that needs to be postcore_ so people don't
> have to wonder why it is so.

Will do.

Thanks,
Ashwin.
