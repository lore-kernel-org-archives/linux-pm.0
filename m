From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v4] kernel: Add support for power-off handler call chain
Date: Tue, 28 Oct 2014 21:58:53 +0100
Message-ID: <5361222.IVraj5jbi5@diego>
References: <1414516266-4965-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:39575 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857AbaJ1Uzn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Oct 2014 16:55:43 -0400
In-Reply-To: <1414516266-4965-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Alexander Graf <agraf@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lee Jones <lee.jones@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Philippe =?ISO-8859-1?Q?R=E9tornaz?= <philippe.retornaz@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Romain Perier <romain.perier@gmail.com>

Am Dienstag, 28. Oktober 2014, 10:11:06 schrieb Guenter Roeck:
> Various drivers implement architecture and/or device specific means t=
o
> power off the system.  For the most part, those drivers set the globa=
l
> variable pm_power_off to point to a function within the driver.
>=20
> This mechanism has a number of drawbacks.  Typically only one scheme
> to remove power is supported (at least if pm_power_off is used).
> At least in theory there can be multiple means remove power, some of
> which may be less desirable. For example, some mechanisms may only
> power off the CPU or the CPU card, while another may power off the
> entire system.  Others may really just execute a restart sequence
> or drop into the ROM monitor. Using pm_power_off can also be racy
> if the function pointer is set from a driver built as module, as the
> driver may be in the process of being unloaded when pm_power_off is
> called. If there are multiple power-off handlers in the system, remov=
ing
> a module with such a handler may inadvertently reset the pointer to
> pm_power_off to NULL, leaving the system with no means to remove powe=
r.
>=20
> Introduce a system power-off handler call chain to solve the describe=
d
> problems.  This call chain is expected to be executed from the archit=
ecture
> specific machine_power_off() function.  Drivers and architeceture cod=
e
> providing system power-off functionality are expected to register wit=
h
> this call chain.  When registering a power-off handler, callers can
> provide a priority to control power-off handler execution sequence
> and thus ensure that the power-off handler with the optimal capabilit=
ies
> to remove power for a given system is called first.
>=20
> Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Philippe R=E9tornaz <philippe.retornaz@gmail.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Romain Perier <romain.perier@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

Similarly to the restart handlers, I really like the concept.

Acked-by: Heiko Stuebner <heiko@sntech.de>

