From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC patch 2/2] ARM: at91: cpuidle: move the driver to drivers/cpuidle
 directory
Date: Mon, 15 Apr 2013 16:37:57 +0200
Message-ID: <516C10C5.4050107@linaro.org>
References: <1366032598-23053-1-git-send-email-daniel.lezcano@linaro.org> <1366032598-23053-3-git-send-email-daniel.lezcano@linaro.org> <20130415142047.GE15139@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:58395 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016Ab3DOOiA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Apr 2013 10:38:00 -0400
Received: by mail-we0-f172.google.com with SMTP id r3so3801837wey.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2013 07:37:59 -0700 (PDT)
In-Reply-To: <20130415142047.GE15139@game.jcrosoft.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux@maxim.org.za, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, rjw@sisk.pl, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org

On 04/15/2013 04:20 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 15:29 Mon 15 Apr     , Daniel Lezcano wrote:
>> We don't have any dependency with the SoC specific code.
>>
>> Move the driver to the drivers/cpuidle directory.
>>
>> Add Nicolas Ferre as author of the driver, so it will be in copy of =
the emails.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> please use -M when generating the patch

Oh, right. Thanks for reminding me the option.

[ ... ]

>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/cpuidle.h>
>> +#include <asm/cpuidle.h>
>> +
>> +#define AT91_MAX_STATES	2
>> +
>> +extern void (*at91_standby_ops)(void);
> really don't like can we pass it via the pm?

I agree, it is hackish. Can you elaborate when you say "pass it via the
pm" ?



--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

