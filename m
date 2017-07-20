From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/3] PM / sleep: Mark suspend/hibernation start and finish
Date: Thu, 20 Jul 2017 23:05:34 +0200
Message-ID: <CAJZ5v0hw5Zk6WEDN2=m5-e_JMRv_AbyBExcxOOKAv1OQAnU7=g@mail.gmail.com>
References: <2539550.y54cRb749c@aspire.rjw.lan> <1528829.lXeqX43PVF@aspire.rjw.lan>
 <21457958.U8q3irAeUz@aspire.rjw.lan> <364d0454-a446-51c4-f9c5-15bc6670928a@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36437 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932346AbdGTVFf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jul 2017 17:05:35 -0400
In-Reply-To: <364d0454-a446-51c4-f9c5-15bc6670928a@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Salyzyn <salyzyn@android.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, Jul 20, 2017 at 7:49 PM, Mark Salyzyn <salyzyn@android.com> wrote:
> On 07/19/2017 06:38 PM, Rafael J. Wysocki wrote:
>>
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Regardless of whether or not debug messages from the core system
>> suspend/hibernation code are enabled, it is useful to know when
>> system-wide transitions start and finish (or fail), so print "info"
>> messages at these points.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>
>> -> v2: Smiplified the messages as suggested by Mark.
>>
>> ---
>>   kernel/power/hibernate.c |    5 +++++
>>   kernel/power/suspend.c   |    2 ++
>>   2 files changed, 7 insertions(+)
>>
>> Index: linux-pm/kernel/power/hibernate.c
>> ===================================================================
>> --- linux-pm.orig/kernel/power/hibernate.c
>> +++ linux-pm/kernel/power/hibernate.c
>> @@ -692,6 +692,7 @@ int hibernate(void)
>>                 goto Unlock;
>>         }
>>   +     pr_info("hibernation entry\n");
>
> nit (minor): Many of the logs report a PM: prefix. Flipping coin that the 3
> characters provides any real gain is in your hands. My WAG is it would be
> nice to be able to do dmesg | grep PM:

Yeah, that's why pr_fmt() is defined in hibernate.c.  It is missing in
suspend.c ATM, though, hence the difference (but will be added there
too).

Thanks,
Rafael
