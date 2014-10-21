From: Peter Hurley <peter@hurleysoftware.com>
Subject: pnp bus disables serial console despite no_console_suspend
Date: Tue, 21 Oct 2014 15:05:50 -0400
Message-ID: <5446AE8E.8010904@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg KH <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux kernel <linux-kernel@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

Hi,

I'm looking into a cpu lockup while resuming from S3.

I can't paste the warning here because the serial console comes back
scrambled. There are two issues:
1. The 16550A serial port is a pnp device that the pnp bus disables
on suspend, despite having no_console_suspend set, and
2. ACPI suspend powers off the device anyway.

I've managed to workaround these 2 issues by brute force hack,
but I think that it's worthwhile to consider making no_console_suspend
work properly in mainline.

Not disabling the pnp device of the serial console is trivial:
option 1 is to special case some return value from pnp_dev->suspend()
which prevent further action by the pnp bus but does not error out
of suspending, or
option 2 is for the device to override pnp_dev->capabilities and
turn off PNP_DISABLE. This option also requires a new capability to
prevent the pnpacpi protocol from powering off the device.
Option 2 is the workaround I'm using right now and it's pretty messy.

The second issue is less straightforward.

Since ACPI powers off the device anyway, on return from
acpi_suspend_lowlevel(), the device needs some minimal re-programming.
The workaround right now is to re-check a device register on every
console write, and perform the re-programming if it's been cleared.
This is not very robust or desirable; the power-on register value is
a valid (but unlikely) state for the device.

What's needed is a way to distinguish between a console write immediately
before and immediately after resume, before resume starts using printk :)
Ideally, consoles would get a notification before being used; optionally,
a system-wide value which identifies power transition states could work.

Thoughts?

Regards,
Peter Hurley

PS - This situation is not limited to pnpacpi on x86. Several ARM designs
power off the serial port, and require explicit re-programming for resume
using no_console_suspend.
