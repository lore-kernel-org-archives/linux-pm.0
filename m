From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH] ARM: machine_power_off should not return
Date: Wed, 26 Mar 2014 07:12:27 -0300
Message-ID: <20140326101227.GC941@arch.cereza>
References: <1395684784-12601-1-git-send-email-sebastian.capella@linaro.org>
 <20140325224554.GC12185@arch.cereza>
 <20140326005115.GW7528@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:52015 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753545AbaCZKMu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Mar 2014 06:12:50 -0400
Content-Disposition: inline
In-Reply-To: <20140326005115.GW7528@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sebastian Capella <sebastian.capella@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org

Russell,

Thanks for the reply!

On Mar 26, Russell King - ARM Linux wrote:
> On Tue, Mar 25, 2014 at 07:45:55PM -0300, Ezequiel Garcia wrote:
> >=20
> > Without this patch we got the heartbeat's reboot_notifier called tw=
ice while
> > testing the recent hibernation patches, which was unexpected and pr=
oduced a
> > kernel panic: https://lkml.org/lkml/2014/3/19/363
>=20
> I don't see why we should make this change.  kernel/reboot.c handles
> this function returning, so other places should do too.
>=20
> Even on x86, this function can return:
>=20
[..]
>=20
> Therefore, I'd say... it's a bug in the hibernation code - or we prob=
ably
> have many buggy architectures.  I'd suggest fixing the hibernation co=
de
> rather than stuffing some workaround like an endless loop into every
> architecture.
>=20

Which is exactly what Sebastian did first:

https://lkml.org/lkml/2014/3/20/605

But Pavel asked to fix ARM's machine_power_off instead.

Also, looking at the other architectures, it seems this API is not well
defined: some of them have an infinite loop, some don't. So it's hard t=
o
say the function is supposed to return or not.
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
