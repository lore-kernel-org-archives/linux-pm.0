From: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Subject: Re: [PATCH] power: Add support for LTC1760 Dual Smart Battery
 System Manager
Date: Mon, 06 Jun 2016 21:26:14 +0200
Message-ID: <1465241174.23646.4.camel@amnesix>
References: <1465160129.17905.24.camel@amnesix>
	 <5860b17d-8958-4292-59ab-68dfd1efff4d@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <5860b17d-8958-4292-59ab-68dfd1efff4d@axentia.se>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, Phil Reid <preid@electromag.com.au>
List-Id: linux-pm@vger.kernel.org

Hi,

Am Montag, den 06.06.2016, 12:16 +0200 schrieb Peter Rosin:
> Hi!
> 
> On 2016-06-05 22:55, Karl-Heinz Schneider wrote:
> > This driver adds support for the LTC1760 Dual Smart Battery System
> > Manager.
> > The LTC1760 is an I2C device listening at address 0x0a and is capable of
> > communicating up to two I2C smart battery devices. Both smart battery
> > devices are listening at address 0x0b, so the LTC1760 muliplexes between
> > them. The driver makes use of the I2C-Mux framework to allow smart
> > batteries to be bound via device tree, i.e. the sbs-battery driver.
> > 
> > Via sysfs interface the online state and charge type are presented where
> > the charge type can also be changed between the default value "trickle"
> > and
> > "fast".
> > 
> > Signed-off-by: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
> > ---
> > Path generated against v4.7-rc1
> 
> This patch has two fundamental problems. First, the patch is whitespace-
> damaged (your mailer probably destroyed it). Please fix that. Second, and
> more serious, the patch has not even been compile-tested when applied on
> top of v4.7-rc1.
Sorry mixed things up in the makefile. Was happy the compiler didn't
complain about anything...
> 
> The i2c-muxing code saw an update in 4.6 and this driver needs adjustment.
> As a hint, I suspect that you can make this mux "mux-locked" and avoid
> the dead-lock workaround in ltc1760_write_select_bat_reg().
Difficult to test for me, since I'm forced to use an old 3.14 Kernel for
the target device (SECO imx6 board).
> 
> I didn't look further than this.
> 
> Cheers,
> Peter
Tanks for review and sorry for noise in this case. Will fix the issues.

Greetings

