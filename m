From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 09/21] ARM: pxa: magician: Add OV9640 camera support
Date: Thu, 20 Aug 2015 22:26:39 +0200
Message-ID: <2889798.x6xcIzdYMU@wuerfel>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D259A1.6090102@tul.cz> <87lhd568sb.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <87lhd568sb.fsf@belgarion.home>
Sender: linux-leds-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, Petr Cvek <petr.cvek@tul.cz>, linux@arm.linux.org.uk, sameo@linux.intel.com, linux-pm@vger.kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, cooloney@gmail.com, sre@kernel.org, haojian.zhuang@gmail.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org, philipp.zabel@gmail.com, lee.jones@linaro.org, j.anaszewski@samsung.com, daniel@zonque.org
List-Id: linux-pm@vger.kernel.org

On Thursday 20 August 2015 21:48:20 Robert Jarzmik wrote:
> Petr Cvek <petr.cvek@tul.cz> writes:
> 
> > +     mdelay(3);
> Okay, there are several mdelay(3) in this file.
> 
> Could you please test if removing these mdelays prevents the camera from working
> ? If not, I'd like to have them removed.
> 
> 

FWIW, it might be possible to replace some of them with msleep() calls,
potentially after replacing spinlocks with mutexes where necessary.

	Arnd
