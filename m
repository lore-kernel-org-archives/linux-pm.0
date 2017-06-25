From: Hans de Goede <hdegoede@redhat.com>
Subject: Making the kernel control fanspeed ?
Date: Sun, 25 Jun 2017 16:42:09 +0200
Message-ID: <632d19eb-38e0-0213-d9a3-843b0dbff2cb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi <linux-acpi@vger.kernel.org>
Cc: Christopher Williamson <home@chrisaw.com>
List-Id: linux-pm@vger.kernel.org

Hi All,

I've been contacted by Christopher Williamson who owns
this device:

https://www.indiegogo.com/projects/gpd-pocket-7-0-umpc-laptop-ubuntu-or-win-10-os-laptop--2#/

And is trying to run Linux on it.

As the indiegogo campaign shows is quite a popular device,
so supporting this properly with the mainline kernel is
important IMHO.

It has a (small) fan for cooling which we (Christopher and
me) have managed to figure out is controller by 2 GPIOs,
giving it 4 speeds (including "off" as speed). Writing a
driver for this is easy, it has an ACPI node with a unique
_HID and a _CSR table listing the GPIOs.

At least writing a driver using the lm_sensors to export
this as a fan-speed controller (fake pwm) is easy, but
that requires the user to setup the fancontrol service
to actually control the fan speed, while as I really
want something which will make installing the distributions
coming out April 2018 just work without needing tweaks.

So I was wondering if there was a way to make the driver
directly adjust the fan speeds based on SoC temperature.

I was thinking of maybe registering it as a cooling device,
if I were to do this will it get called when the system
is getting somewhat hot, or only when approaching really
hot ?

Or maybe a combination of lm_sensors interface, defaulting
to medium speed + a cooling device to ramp up to max speed
when necessary?  Down side of that approach is the fan will
spin needlessly when the system is idle ...

Any other suggestions ?

Regards,

Hans
