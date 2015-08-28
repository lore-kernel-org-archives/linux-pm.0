From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2 10/21] ARM: pxa: magician: Add UDA1380 sound support
Date: Fri, 28 Aug 2015 10:48:48 +0200
Message-ID: <87a8tb3ij3.fsf@belgarion.home>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D259B7.90703@tul.cz>
	<87h9nt68mm.fsf@belgarion.home> <55D65C32.6080503@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:47647 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbbH1IxW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2015 04:53:22 -0400
In-Reply-To: <55D65C32.6080503@tul.cz> (Petr Cvek's message of "Fri, 21 Aug
	2015 01:01:06 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Dne 20.8.2015 v 21:51 Robert Jarzmik napsal(a):
>> Petr Cvek <petr.cvek@tul.cz> writes:
>> 
>>> +/*
>>> + * Magician Audio controller
>>> + */
>>> +
>>> +static struct platform_device magician_audio_device = {
>>> +	.name = "magician-audio",
>> Is this already upstream or is it a submission in progress ? Other than that
>> detail, I'll queue it in a week probably.
>
> This one is problematic. Vanilla version did not work from at least 3.4 (where I
> started, but probably even more in past). Somewhere between 3.13 and ~4.1 there
> is a change which causes it to fail after driver reload (bad pointers I
> think). UDA codec routes are not constructed completely and in ~4.1 they are
> refused, there are some swapped control registers and bad DMA definitions. Oh
> and recording stopped to work too (maybe it is caused by that routes).
>
> I tried to send initial separate patches (for DMA and registers), but it got
> stuck somewhere (at least it is not in 4.2rcX and I sent them around start of
> this year).
>
> I can add some of these patches to this patchset (but I didn't started yet on
> failing reload, record and fixing the routes).

Ok, but not for this patchset. This would be an apart submission to sound/soc
and Mark Brown more likely.
So I presume my answer is "no, it is not upstream yet, it is a submission under
review". In that case, I'll take it in my "held" tree until you tell me your
patches have been queued up by Mark, and then I'll move them to the for-next
tree.

Cheers.

-- 
Robert

PS: For DMA registers, there will also be an impact by the dmaengine
conversion. I'd like to be joined to the sound/soc submission, to foresee the
conflicts.
