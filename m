From: Petr Cvek <petr.cvek@tul.cz>
Subject: Re: [PATCH v2 11/21] ARM: pxa: magician: Add MAX1586 Vcore regulator
 support
Date: Fri, 21 Aug 2015 00:33:41 +0200
Message-ID: <55D655C5.40506@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D259CC.6040307@tul.cz>
 <87pp2h69iy.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:53444 "EHLO bubo.tul.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752611AbbHTWah (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 20 Aug 2015 18:30:37 -0400
In-Reply-To: <87pp2h69iy.fsf@belgarion.home>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Dne 20.8.2015 v 21:32 Robert Jarzmik napsal(a):
> Petr Cvek <petr.cvek@tul.cz> writes:
> 
>> Add support for MAX1586 Vcore regulator.
>>
>> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> I'll leave that for a week and if no objections queue it.
> 
> I would have expected a better commit message : for example, from your patch I
> deduce magician has a 1587 regulator, not a 1586 one : that deserves a small
> mention in the commit message. Moreover, the Maxim has 2 outputs : one is
> connected to VCC_Core of the SoC, what about the other output ?  Is it unknown,
> or do you know but don't use it ?
> 
You mean V6 - Usim? MAX1587 does not have this pin implemented. I will note it in commit message.


> Cheers.
> 
> --
> Robert
> 

