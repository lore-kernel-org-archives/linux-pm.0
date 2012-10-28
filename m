From: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: [REGRESSION] 3.7-rc2 kernel BUG at kernel/power/snapshot.c:517!
Date: Sun, 28 Oct 2012 22:12:49 +0100
Message-ID: <201210282212.50282.maciej.rutecki@gmail.com>
References: <201210211712.28571.maciej.rutecki@gmail.com>
Reply-To: maciej.rutecki@gmail.com
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <201210211712.28571.maciej.rutecki@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org, pavel@ucw.cz, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On niedziela, 21 pa=C5=BAdziernika 2012 o 17:12:28 Maciej Rutecki wrote=
:
> Error: kernel BUG at kernel/power/snapshot.c:517!
>=20
> Last known good: 3.6.1
> Bad: 3.7-rc2
>=20
> Steps to reproduce:
> 1. Boot system with 3.7-rc2 kernel
> 2. Try suspend to disk (s2ram works OK)
>=20
> System dies on message:
> http://mrutecki.pl/download/kernel/3.7-rc2/swinka/DSCN0280.jpg
>=20
> lspci:
> http://mrutecki.pl/download/kernel/3.7-rc2/swinka/lspci.txt
>=20
> dmesg:
> http://mrutecki.pl/download/kernel/3.7-rc2/swinka/dmesg-3.7-rc2.txt

Still present in -rc3

Regards

--=20
Maciej Rutecki
http://www.mrutecki.pl
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
