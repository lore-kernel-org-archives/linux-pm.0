From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 RFC] This patch repairs HTC Magician machine (PXA27x) support
Date: Thu, 13 Aug 2015 20:01:08 +0200
Message-ID: <87y4hfhxuj.fsf@belgarion.home>
References: <55CBCDED.8010409@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <55CBCDED.8010409@tul.cz> (Petr Cvek's message of "Thu, 13 Aug
	2015 00:51:25 +0200")
Sender: linux-leds-owner@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>, Philipp Zabel <philipp.zabel@gmail.com>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Fixing original code: Problems to successful boot due to the bad LCD
> power sequence (wrongly configured GPIO).
>
> Add/fix platform data and helper function for various hardware
> (touchscreen, audio, USB device, ...).
>
> Add new discovered GPIOs and fix names by GPIO context.
>
> Add new LEDs driver.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
Hi Petr,

Just as Lee, I want the serie to be split per-subsystem.

For the mach-pxa part, I need you to split the patch into several chunks to
review.
At least please split :
 - a first patch for cleanup (identation and whitespaces)
 - a second patch for cleanup (comments changes, debug messages)
 - a serie of fix patches
   - one for the power sequence
   - one for GPIO fixes
 - a serie of evolution patches
   - new gpio_keys
   - new backlight stuff
   - one per new device declared
   - new flash stuff
   - etc ...

Please keep in mind that in order to pick the patches, I need to split them in 3
groups :
 - cleanups
 - fixes
 - evolutions / new stuff
Moreover I want to be able to revert one functionality (for example new power
sequence) without reverting the whole serie.

You probably know that the pxa patches need the subject prefix to be "ARM: pxa:
magician: " in your case. Other subsystem maintainers have similar requirements
I believe.

When that's done, I'll begin the review, and Philipp will probably too as he is
the maintainer.

Cheers.

--
Robert
