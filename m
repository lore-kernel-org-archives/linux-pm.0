From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2 10/21] ARM: pxa: magician: Add UDA1380 sound support
Date: Thu, 20 Aug 2015 21:51:45 +0200
Message-ID: <87h9nt68mm.fsf@belgarion.home>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D259B7.90703@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <55D259B7.90703@tul.cz> (Petr Cvek's message of "Tue, 18 Aug 2015
	00:01:27 +0200")
Sender: linux-leds-owner@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Petr Cvek <petr.cvek@tul.cz> writes:

> +/*
> + * Magician Audio controller
> + */
> +
> +static struct platform_device magician_audio_device = {
> +	.name = "magician-audio",
Is this already upstream or is it a submission in progress ? Other than that
detail, I'll queue it in a week probably.

Cheers.

--
Robert
