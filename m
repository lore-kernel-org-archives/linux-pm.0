From: Petr Cvek <petr.cvek@tul.cz>
Subject: Re: [PATCH v2 10/21] ARM: pxa: magician: Add UDA1380 sound support
Date: Fri, 21 Aug 2015 01:01:06 +0200
Message-ID: <55D65C32.6080503@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D259B7.90703@tul.cz>
 <87h9nt68mm.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <87h9nt68mm.fsf@belgarion.home>
Sender: linux-leds-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Dne 20.8.2015 v 21:51 Robert Jarzmik napsal(a):
> Petr Cvek <petr.cvek@tul.cz> writes:
> 
>> +/*
>> + * Magician Audio controller
>> + */
>> +
>> +static struct platform_device magician_audio_device = {
>> +	.name = "magician-audio",
> Is this already upstream or is it a submission in progress ? Other than that
> detail, I'll queue it in a week probably.

This one is problematic. Vanilla version did not work from at least 3.4 (where I started, but probably even more in past). Somewhere between 3.13 and ~4.1 there is a change which causes it to fail after driver reload (bad pointers I think). UDA codec routes are not constructed completely and in ~4.1 they are refused, there are some swapped control registers and bad DMA definitions. Oh and recording stopped to work too (maybe it is caused by that routes).

I tried to send initial separate patches (for DMA and registers), but it got stuck somewhere (at least it is not in 4.2rcX and I sent them around start of this year).

I can add some of these patches to this patchset (but I didn't started yet on failing reload, record and fixing the routes).

> 
> Cheers.
> 
> --
> Robert
> 
