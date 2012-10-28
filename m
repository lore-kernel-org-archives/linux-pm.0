From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [REGRESSION] 3.7-rc2 kernel BUG at kernel/power/snapshot.c:517!
Date: Sun, 28 Oct 2012 22:45:26 +0100
Message-ID: <1552872.pfLgNj3qcY@vostro.rjw.lan>
References: <201210211712.28571.maciej.rutecki@gmail.com> <201210282212.50282.maciej.rutecki@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <201210282212.50282.maciej.rutecki@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: maciej.rutecki@gmail.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, pavel@ucw.cz, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, October 28, 2012 10:12:49 PM Maciej Rutecki wrote:
> On niedziela, 21 pa=C5=BAdziernika 2012 o 17:12:28 Maciej Rutecki wro=
te:
> > Error: kernel BUG at kernel/power/snapshot.c:517!
> >=20
> > Last known good: 3.6.1
> > Bad: 3.7-rc2
> >=20
> > Steps to reproduce:
> > 1. Boot system with 3.7-rc2 kernel
> > 2. Try suspend to disk (s2ram works OK)
> >=20
> > System dies on message:
> > http://mrutecki.pl/download/kernel/3.7-rc2/swinka/DSCN0280.jpg
> >=20
> > lspci:
> > http://mrutecki.pl/download/kernel/3.7-rc2/swinka/lspci.txt
> >=20
> > dmesg:
> > http://mrutecki.pl/download/kernel/3.7-rc2/swinka/dmesg-3.7-rc2.txt
>=20
> Still present in -rc3

This appears to be a memory allocation error and I have no idea what
the reason of it is.

Any chance to bisect?

Does "echo disk > /sys/power/state" work?

Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
