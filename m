From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: Re: support for software direct frequency throttling?
Date: Thu, 17 Oct 2013 12:39:22 -0500
Message-ID: <526020CA.1080605@calxeda.com>
References: <5202A24F.6040506@calxeda.com> <2466745.skqnolQonv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp157.dfw.emailsrvr.com ([67.192.241.157]:46791 "EHLO
	smtp157.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757365Ab3JQRkR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2013 13:40:17 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp25.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 91561340319
	for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2013 13:40:16 -0400 (EDT)
Received: from smtp93.ord1c.emailsrvr.com (smtp93.ord1c.emailsrvr.com [108.166.43.93])
	by smtp25.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTPS id 341A8340270
	for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2013 13:40:16 -0400 (EDT)
In-Reply-To: <2466745.skqnolQonv@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 08/07/2013 06:37 PM, Rafael J. Wysocki wrote:
> On Wednesday, August 07, 2013 02:38:55 PM Mark Langsdorf wrote:
>> Is there an easy way to dynamically limit the maximum or minimum
>> frequencies available to a governor? I'm trying to support frequency
>> throttling in response to a thermal event (or theoretically to allow a
>> BMC to set a minimum frequency regardless of current load).
>>
>> I looked into doing this last year and it required some QoS patches that
>> I don't think ever made it into the kernel.
>>
>> Is there a straightforward way to do this right now?
> 
> Have you looked at drivers/thermal/cpu_cooling.c ?

Yes, and I'm not sure how to use it get what I want.

I have a mailbox interrupt on my system that will trigger with a message
when the BMC monitoring the thermal sensor notices that the temperature
passes a trip point; the message will include the new maximum frequency.
I want to pass that new maximum frequency to the cpufreq governor so it
can reassess the current frequency against the maximum and lower it if
need be.

I don't know in advance what the trip points or maximum frequencies are;
the BMC managing the thermal sensor has that information but doesn't
provide it to Linux.

The most appealing solution would be to just copy
cpufreq_apply_cooling() and cpufreq_thermal_modifier() from
drivers/thermal/cpu_cooling.c in the highbank_cpufreq.c driver, as
they're the core logic of what I need. I don't know if that would be
acceptable, though. I've looked at setting up a full thermal_zone
solution, and its more than I need without actually giving me a good way
to set the frequencies when I need to.

--Mark Langsdorf
Calxeda, Inc.
