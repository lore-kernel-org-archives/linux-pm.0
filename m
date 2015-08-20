From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2 16/21] ARM: pxa: magician: Add support for alternative LCD backlight
Date: Thu, 20 Aug 2015 22:01:50 +0200
Message-ID: <878u95685t.fsf@belgarion.home>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D25A60.7000900@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <55D25A60.7000900@tul.cz> (Petr Cvek's message of "Tue, 18 Aug
	2015 00:04:16 +0200")
Sender: linux-leds-owner@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>, philipp.zabel@gmail.com
Cc: daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Add support for alternative LCD backlight with GPIO (no brightness).
Here, I don't understand, the commit message is too short.

Are there 2 brightness controls on magician, or are these 2 different magicians
(hardware wise), each having a different backlight control ? Or is it there is a
GPIO to light up the screen and a PWM backlight ?

I have to understand first.

Cheers.

--
Robert
