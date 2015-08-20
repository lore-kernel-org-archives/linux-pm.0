From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2 09/21] ARM: pxa: magician: Add OV9640 camera support
Date: Thu, 20 Aug 2015 21:48:20 +0200
Message-ID: <87lhd568sb.fsf@belgarion.home>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D259A1.6090102@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <55D259A1.6090102@tul.cz> (Petr Cvek's message of "Tue, 18 Aug
	2015 00:01:05 +0200")
Sender: linux-leds-owner@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Petr Cvek <petr.cvek@tul.cz> writes:

> +	mdelay(3);
Okay, there are several mdelay(3) in this file.

Could you please test if removing these mdelays prevents the camera from working
? If not, I'd like to have them removed.

Cheers.

--
Robert
