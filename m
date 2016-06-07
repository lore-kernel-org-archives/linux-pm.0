From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] power: Add support for LTC1760 Dual Smart Battery System
 Manager
Date: Tue, 7 Jun 2016 11:17:02 +0200
Message-ID: <cbee71f0-464f-f1ca-5f99-36cf6c69d3f9@axentia.se>
References: <1465160129.17905.24.camel@amnesix>
 <5860b17d-8958-4292-59ab-68dfd1efff4d@axentia.se>
 <1465241174.23646.4.camel@amnesix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1465241174.23646.4.camel@amnesix>
Sender: linux-acpi-owner@vger.kernel.org
To: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Cc: linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, Phil Reid <preid@electromag.com.au>
List-Id: linux-pm@vger.kernel.org

On 2016-06-06 21:26, Karl-Heinz Schneider wrote:
> Am Montag, den 06.06.2016, 12:16 +0200 schrieb Peter Rosin:
>> This patch has two fundamental problems. First, the patch is whitespace-
>> damaged (your mailer probably destroyed it). Please fix that. Second, and
>> more serious, the patch has not even been compile-tested when applied on
>> top of v4.7-rc1.
> Sorry mixed things up in the makefile. Was happy the compiler didn't
> complain about anything...

Ok, some kind of silly mistake...

>> The i2c-muxing code saw an update in 4.6 and this driver needs adjustment.
>> As a hint, I suspect that you can make this mux "mux-locked" and avoid
>> the dead-lock workaround in ltc1760_write_select_bat_reg().
> Difficult to test for me, since I'm forced to use an old 3.14 Kernel for
> the target device (SECO imx6 board).

I feel your pain. I always feel trapped when working on vendor kernels.

The conversion is not difficult. Have a look at the commits leading
up to 23fe440c59b9 "i2c: mux: drop old unused i2c-mux-api" to see
examples of how to make it work for v4.7 (I think cddcc40b1b15
"[media] rtl2832: convert to use an explicit i2c mux core" looks like
it could be similar to your case). If you then think the mux should
be mux-locked (see Documentation/i2c/i2c-topology) it should be a
simple matter of specifying the flag I2C_MUX_LOCKED when calling
i2c_mux_alloc() and getting rid of the dead-lock workaround.

Cheers,
Peter
