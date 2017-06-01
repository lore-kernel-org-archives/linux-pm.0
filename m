From: Jon Mason <jon.mason@broadcom.com>
Subject: Re: [PATCH] thermal: broadcom: ns-thermal: depends/default only for NS/NSP
Date: Thu, 1 Jun 2017 11:51:43 -0400
Message-ID: <CAC3K-4q1tvLqxx3a3F8WXLO_gcJYcqsej8ku25Y=wk97Q8g36g@mail.gmail.com>
References: <1496260544-4200-1-git-send-email-jon.mason@broadcom.com> <20170601030906.GA4502@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:36732 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbdFAPvu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jun 2017 11:51:50 -0400
Received: by mail-it0-f44.google.com with SMTP id m47so42272627iti.1
        for <linux-pm@vger.kernel.org>; Thu, 01 Jun 2017 08:51:45 -0700 (PDT)
In-Reply-To: <20170601030906.GA4502@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Florian Fainelli <f.fainelli@gmail.com>, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>

On Wed, May 31, 2017 at 11:09 PM, Eduardo Valentin <edubezval@gmail.com> wrote:
> On Wed, May 31, 2017 at 03:55:44PM -0400, Jon Mason wrote:
>> ARCH_BCM_IPROC includes support for many SoCs, not all of which have the
>> same thermal hardware interface as the Northstar/Northstar Plus SoCs.
>> This is not a major issue, as this driver will only be probed if the
>> relevant device tree entry is present.  However, it will result in a
>> slightly larger than necessary kernel.  By limiting the driver to only
>> work on the NS/NSP SoCs, we can avoid the issue.
>>
>> Suggested-by: Scott Branden <scott.branden@broadcom.com>
>> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
>
> Should this commit message include a Fixes: tag?
>
> Maybe
> Fixes: a94cb7e ("thermal: broadcom: add Northstar thermal driver")

Technically, it would be 2 patches

Fixes: a94cb7eeecc4 ("thermal: broadcom: add Northstar thermal driver")
Fixes: a54c51863ed1 ("thermal: broadcom: ns-thermal: default on iProc SoCs")

We could probably get away with only doing the latter one, as it is
the one that makes it enabled by default


>> ---
>>  drivers/thermal/broadcom/Kconfig | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/broadcom/Kconfig b/drivers/thermal/broadcom/Kconfig
>> index 42c098e86f84..c729dad2348c 100644
>> --- a/drivers/thermal/broadcom/Kconfig
>> +++ b/drivers/thermal/broadcom/Kconfig
>> @@ -8,8 +8,8 @@ config BCM2835_THERMAL
>>
>>  config BCM_NS_THERMAL
>>       tristate "Northstar thermal driver"
>> -     depends on ARCH_BCM_IPROC || COMPILE_TEST
>> -     default y if ARCH_BCM_IPROC
>> +     depends on ARCH_BCM_NSP || ARCH_BCM_5301X || COMPILE_TEST
>> +     default y if ARCH_BCM_NSP || ARCH_BCM_5301X
>>       help
>>         Support for the Northstar and Northstar Plus family of SoCs (e.g.
>>         BCM4708, BCM4709, BCM5301x, BCM95852X, etc). It contains DMU (Device
>> --
>> 2.7.4
>>
