From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] power: Add support for LTC1760 Dual Smart Battery System
 Manager
Date: Mon, 6 Jun 2016 12:16:32 +0200
Message-ID: <5860b17d-8958-4292-59ab-68dfd1efff4d@axentia.se>
References: <1465160129.17905.24.camel@amnesix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1465160129.17905.24.camel@amnesix>
Sender: linux-i2c-owner@vger.kernel.org
To: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: Phil Reid <preid@electromag.com.au>
List-Id: linux-pm@vger.kernel.org

Hi!

On 2016-06-05 22:55, Karl-Heinz Schneider wrote:
> This driver adds support for the LTC1760 Dual Smart Battery System
> Manager.
> The LTC1760 is an I2C device listening at address 0x0a and is capable of
> communicating up to two I2C smart battery devices. Both smart battery
> devices are listening at address 0x0b, so the LTC1760 muliplexes between
> them. The driver makes use of the I2C-Mux framework to allow smart
> batteries to be bound via device tree, i.e. the sbs-battery driver.
> 
> Via sysfs interface the online state and charge type are presented where
> the charge type can also be changed between the default value "trickle"
> and
> "fast".
> 
> Signed-off-by: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
> ---
> Path generated against v4.7-rc1

This patch has two fundamental problems. First, the patch is whitespace-
damaged (your mailer probably destroyed it). Please fix that. Second, and
more serious, the patch has not even been compile-tested when applied on
top of v4.7-rc1.

The i2c-muxing code saw an update in 4.6 and this driver needs adjustment.
As a hint, I suspect that you can make this mux "mux-locked" and avoid
the dead-lock workaround in ltc1760_write_select_bat_reg().

I didn't look further than this.

Cheers,
Peter
