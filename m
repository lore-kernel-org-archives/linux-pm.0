From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4] kernel: Add support for power-off handler call chain
Date: Tue, 28 Oct 2014 14:10:34 -0700
Message-ID: <20141028211034.GA15820@roeck-us.net>
References: <1414516266-4965-1-git-send-email-linux@roeck-us.net>
 <5361222.IVraj5jbi5@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39972 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbaJ1VLT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Oct 2014 17:11:19 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XjE2w-000gqH-SY
	for linux-pm@vger.kernel.org; Tue, 28 Oct 2014 21:11:19 +0000
Content-Disposition: inline
In-Reply-To: <5361222.IVraj5jbi5@diego>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Alexander Graf <agraf@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lee Jones <lee.jones@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Romain Perier <romain.perier@gmail.com>

On Tue, Oct 28, 2014 at 09:58:53PM +0100, Heiko St=FCbner wrote:
> Am Dienstag, 28. Oktober 2014, 10:11:06 schrieb Guenter Roeck:
> > Various drivers implement architecture and/or device specific means=
 to
> > power off the system.  For the most part, those drivers set the glo=
bal
> > variable pm_power_off to point to a function within the driver.
> >=20
> > This mechanism has a number of drawbacks.  Typically only one schem=
e
> > to remove power is supported (at least if pm_power_off is used).
> > At least in theory there can be multiple means remove power, some o=
f
> > which may be less desirable. For example, some mechanisms may only
> > power off the CPU or the CPU card, while another may power off the
> > entire system.  Others may really just execute a restart sequence
> > or drop into the ROM monitor. Using pm_power_off can also be racy
> > if the function pointer is set from a driver built as module, as th=
e
> > driver may be in the process of being unloaded when pm_power_off is
> > called. If there are multiple power-off handlers in the system, rem=
oving
> > a module with such a handler may inadvertently reset the pointer to
> > pm_power_off to NULL, leaving the system with no means to remove po=
wer.
> >=20
> > Introduce a system power-off handler call chain to solve the descri=
bed
> > problems.  This call chain is expected to be executed from the arch=
itecture
> > specific machine_power_off() function.  Drivers and architeceture c=
ode
> > providing system power-off functionality are expected to register w=
ith
> > this call chain.  When registering a power-off handler, callers can
> > provide a priority to control power-off handler execution sequence
> > and thus ensure that the power-off handler with the optimal capabil=
ities
> > to remove power for a given system is called first.
> >=20
> > Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> > Cc: Alexander Graf <agraf@suse.de>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Philippe R=E9tornaz <philippe.retornaz@gmail.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Romain Perier <romain.perier@gmail.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
>=20
> Similarly to the restart handlers, I really like the concept.
>=20
> Acked-by: Heiko Stuebner <heiko@sntech.de>
>=20

Thanks!

Guenter
