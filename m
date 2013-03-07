From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: ARM big LITTLE: Add generic cpufreq driver and
 its DT glue
Date: Thu, 7 Mar 2013 10:03:28 +0800
Message-ID: <CAKohpok7aD-J-undUisxaOotbXWimPo46jqOH4ok04kg_hMWHA@mail.gmail.com>
References: <f20e3c5e822c4bd28a3b71264d73143cc1f850b0.1362458878.git.viresh.kumar@linaro.org>
	<20130305105251.GL17833@n2100.arm.linux.org.uk>
	<CAKohpo=cBkHZnSa8ZsM=k7RRN+RZDXFUWDM82EXXBSQcM-8Vhw@mail.gmail.com>
	<20130307005119.GY17833@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:43450 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755533Ab3CGCD3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Mar 2013 21:03:29 -0500
Received: by mail-ob0-f170.google.com with SMTP id wc20so4105130obb.15
        for <linux-pm@vger.kernel.org>; Wed, 06 Mar 2013 18:03:29 -0800 (PST)
In-Reply-To: <20130307005119.GY17833@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: rjw@sisk.pl, Steve.Bannister@arm.com, linux-pm@vger.kernel.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Liviu.Dudau@arm.com, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, robin.randhawa@arm.com, linux-arm-kernel@lists.infradead.org, mark.hambleton@broadcom.com, linaro-kernel@lists.linaro.org, charles.garcia-tobin@arm.com

On 7 March 2013 08:51, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Thu, Mar 07, 2013 at 08:32:37AM +0800, Viresh Kumar wrote:
>> On 5 March 2013 18:52, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>> > On Tue, Mar 05, 2013 at 12:52:41PM +0800, Viresh Kumar wrote:
>> >> +     clk[cluster] = clk_get(NULL, name);
>> >> +     if (!IS_ERR_OR_NULL(clk[cluster])) {
>> >
>> > NAK.  Two reasons.
>> >
>> > 1. IS_ERR_OR_NULL.  You know about this, it's been on the list several
>> >    times.
>>
>> Hey, i had a second thought about this one and i have some other opinion
>> here. This is a cpufreq driver and we need clock support for sure here, we
>> can't work without it. And so here is the latest fixup:
>
> NAK.  You just don't understand.

Poor me!!

I still remember the huge discussions we had during "clk: Add non
CONFIG_HAVE_CLK routines" patchset.

For others: https://lkml.org/lkml/2012/4/24/389

Back to the discussion, I understand that clk_get() just returns a cookie and
NULL is not an error and so it shouldn't be treated specially. And that's what
we do with most of our drivers as all other clk routines (clk_get[set]_rate())
have safe guards against the NULL clk, and they wouldn't complain.

The special case we have in a cpufreq driver is, we can't work with
zero returned
from clk_get_rate()... That will make cpufreq driver work badly.

And that's why i got two additions
- depends on HAVE_CLK
- and using IS_ERR_OR_NULL

as NULL returned from clk_get is not a error but is not acceptable to
the cpufreq
driver.

Because i now have the HAVE_CLK dependency i am not sure if we can get NULL
returned from clk_get() at all. Can you get around something here?

--
viresh
