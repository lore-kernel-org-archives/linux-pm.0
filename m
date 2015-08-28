From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2 11/21] ARM: pxa: magician: Add MAX1586 Vcore regulator support
Date: Fri, 28 Aug 2015 10:49:36 +0200
Message-ID: <87613z3ihr.fsf@belgarion.home>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D259CC.6040307@tul.cz>
	<87pp2h69iy.fsf@belgarion.home> <55D655C5.40506@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:48106 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbbH1IyK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2015 04:54:10 -0400
In-Reply-To: <55D655C5.40506@tul.cz> (Petr Cvek's message of "Fri, 21 Aug 2015
	00:33:41 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Dne 20.8.2015 v 21:32 Robert Jarzmik napsal(a):
>> Petr Cvek <petr.cvek@tul.cz> writes:
>> 
>>> Add support for MAX1586 Vcore regulator.
>>>
>>> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
>> I'll leave that for a week and if no objections queue it.
>> 
>> I would have expected a better commit message : for example, from your patch I
>> deduce magician has a 1587 regulator, not a 1586 one : that deserves a small
>> mention in the commit message. Moreover, the Maxim has 2 outputs : one is
>> connected to VCC_Core of the SoC, what about the other output ?  Is it unknown,
>> or do you know but don't use it ?
>> 
> You mean V6 - Usim? MAX1587 does not have this pin implemented. I will note it
> in commit message.
Excellent, thanks.

Cheers.

-- 
Robert
