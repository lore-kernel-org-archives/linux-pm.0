From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [REGRESSION] 3.7-rc2 kernel BUG at kernel/power/snapshot.c:517!
Date: Sun, 28 Oct 2012 22:55:11 +0100
Message-ID: <6638433.SFcaNLWS2z@vostro.rjw.lan>
References: <201210211712.28571.maciej.rutecki@gmail.com> <201210282212.50282.maciej.rutecki@gmail.com> <1552872.pfLgNj3qcY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:41778 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349Ab2J1VvL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 28 Oct 2012 17:51:11 -0400
In-Reply-To: <1552872.pfLgNj3qcY@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: maciej.rutecki@gmail.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, pavel@ucw.cz, linux-pm@vger.kernel.org

On Sunday, October 28, 2012 10:45:26 PM Rafael J. Wysocki wrote:
> On Sunday, October 28, 2012 10:12:49 PM Maciej Rutecki wrote:
> > On niedziela, 21 pa=C5=BAdziernika 2012 o 17:12:28 Maciej Rutecki w=
rote:
> > > Error: kernel BUG at kernel/power/snapshot.c:517!
> > >=20
> > > Last known good: 3.6.1
> > > Bad: 3.7-rc2
> > >=20
> > > Steps to reproduce:
> > > 1. Boot system with 3.7-rc2 kernel
> > > 2. Try suspend to disk (s2ram works OK)
> > >=20
> > > System dies on message:
> > > http://mrutecki.pl/download/kernel/3.7-rc2/swinka/DSCN0280.jpg
> > >=20
> > > lspci:
> > > http://mrutecki.pl/download/kernel/3.7-rc2/swinka/lspci.txt
> > >=20
> > > dmesg:
> > > http://mrutecki.pl/download/kernel/3.7-rc2/swinka/dmesg-3.7-rc2.t=
xt
> >=20
> > Still present in -rc3
>=20
> This appears to be a memory allocation error and I have no idea what

I mean memory management, sorry.

> the reason of it is.
>=20
> Any chance to bisect?
>=20
> Does "echo disk > /sys/power/state" work?

Thanks,
Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
