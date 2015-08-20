From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2 11/21] ARM: pxa: magician: Add MAX1586 Vcore regulator support
Date: Thu, 20 Aug 2015 21:32:21 +0200
Message-ID: <87pp2h69iy.fsf@belgarion.home>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D259CC.6040307@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <55D259CC.6040307@tul.cz> (Petr Cvek's message of "Tue, 18 Aug
	2015 00:01:48 +0200")
Sender: linux-leds-owner@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Add support for MAX1586 Vcore regulator.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
I'll leave that for a week and if no objections queue it.

I would have expected a better commit message : for example, from your patch I
deduce magician has a 1587 regulator, not a 1586 one : that deserves a small
mention in the commit message. Moreover, the Maxim has 2 outputs : one is
connected to VCC_Core of the SoC, what about the other output ?  Is it unknown,
or do you know but don't use it ?

Cheers.

--
Robert
