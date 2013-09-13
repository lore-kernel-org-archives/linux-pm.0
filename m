From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] drivers: cpuidle: rename ARM big.LITTLE driver config and makefile entries
Date: Fri, 13 Sep 2013 08:23:44 -0700
Message-ID: <87ppscg2yn.fsf@linaro.org>
References: <1379071966-26757-1-git-send-email-lorenzo.pieralisi@arm.com>
	<5232FCD4.2070802@free-electrons.com>
	<20130913140125.GA2062@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:48633 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754932Ab3IMPXr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 11:23:47 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp13so2653202pab.21
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2013 08:23:47 -0700 (PDT)
In-Reply-To: <20130913140125.GA2062@e102568-lin.cambridge.arm.com> (Lorenzo
	Pieralisi's message of "Fri, 13 Sep 2013 15:01:25 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Daniel Lezcano <daniel.lezcano@linaro.org>

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:

> On Fri, Sep 13, 2013 at 12:53:56PM +0100, Gregory CLEMENT wrote:
>> Hi Lorenzo,
>> 
>> On 13/09/2013 13:32, Lorenzo Pieralisi wrote:
>> > Following the reorganization of CPU idle drivers configurations into an ARM
>> > specific Kconfig, the existing idle drivers Kconfig entries were renamed and
>> > moved to the Kconfig.arm file. Makefile entries were updated accordingly.
>> > 
>> > This patch renames the entries in Kconfig.arm and makefile to make the newly
>> > added big.LITTLE CPUidle driver compliant with the new naming convention.
>> 
>> Do you also consider to reorder the entries in alphabetic order?
>> It should help to reduce the merge conflict.
>
> Sure, here it is, thanks for pointing that out.

FYI, updated patches deep inside threads are very likely to be missed.
I saw this because I was looking for it, but would've easily been
missed.

Could you resend a v2 with my ack so Daniel can pick up and get it
merged for v3.12-rc?  Thanks

Acked-by: Kevin Hilman <khilman@linaro.org>

Kevin
