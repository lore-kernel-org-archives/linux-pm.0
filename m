From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: linux-pm build failure
Date: Thu, 08 May 2014 21:44:13 +0200
Message-ID: <2930403.UViFFypGRj@vostro.rjw.lan>
References: <536BBAF8.6040601@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62847 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755244AbaEHT1d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 May 2014 15:27:33 -0400
In-Reply-To: <536BBAF8.6040601@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>, Lv Zheng <lv.zheng@intel.com>, Lan Tianyu <tianyu.lan@intel.com>
Cc: Bob Moore <robert.moore@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thursday, May 08, 2014 08:12:24 PM Stratos Karafotis wrote:
> Hi all,

Hi,

Thanks for the report!

This is caused by commit

0e23847d5ee4 ACPICA: Export acpi_buffer_to_resource symbol

merged on top of the recent ACPICA material.

Lv, Tianyu, care to take care of this?

> There is a build failure in latest linux-pm bleeding-edge:
>=20
> In file included from include/linux/linkage.h:6:0,
>                  from include/linux/kernel.h:6,
>                  from include/acpi/platform/aclinux.h:64,
>                  from include/acpi/platform/acenv.h:150,
>                  from include/acpi/acpi.h:56,
>                  from drivers/acpi/acpica/rscreate.c:44:
> include/linux/export.h:59:20: error: redefinition of =E2=80=98__kstrt=
ab_acpi_buffer_to_resource=E2=80=99
>   static const char __kstrtab_##sym[]   \
>                     ^
> include/linux/export.h:69:2: note: in expansion of macro =E2=80=98__E=
XPORT_SYMBOL=E2=80=99
>   __EXPORT_SYMBOL(sym, "")
>   ^
> include/acpi/platform/aclinux.h:110:37: note: in expansion of macro =E2=
=80=98EXPORT_SYMBOL=E2=80=99
>  #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
>                                      ^
> drivers/acpi/acpica/rscreate.c:119:1: note: in expansion of macro =E2=
=80=98ACPI_EXPORT_SYMBOL=E2=80=99
>  ACPI_EXPORT_SYMBOL(acpi_buffer_to_resource)
>  ^
> include/linux/export.h:59:20: note: previous definition of =E2=80=98_=
_kstrtab_acpi_buffer_to_resource=E2=80=99 was here
>   static const char __kstrtab_##sym[]   \
>                     ^
> include/linux/export.h:69:2: note: in expansion of macro =E2=80=98__E=
XPORT_SYMBOL=E2=80=99
>   __EXPORT_SYMBOL(sym, "")
>   ^
> include/acpi/platform/aclinux.h:110:37: note: in expansion of macro =E2=
=80=98EXPORT_SYMBOL=E2=80=99
>  #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
>                                      ^
> drivers/acpi/acpica/rscreate.c:117:1: note: in expansion of macro =E2=
=80=98ACPI_EXPORT_SYMBOL=E2=80=99
>  ACPI_EXPORT_SYMBOL(acpi_buffer_to_resource);
>  ^
> include/linux/export.h:63:39: error: redefinition of =E2=80=98__ksymt=
ab_acpi_buffer_to_resource=E2=80=99
>   __visible const struct kernel_symbol __ksymtab_##sym \
>                                        ^
> include/linux/export.h:69:2: note: in expansion of macro =E2=80=98__E=
XPORT_SYMBOL=E2=80=99
>   __EXPORT_SYMBOL(sym, "")
>   ^
> include/acpi/platform/aclinux.h:110:37: note: in expansion of macro =E2=
=80=98EXPORT_SYMBOL=E2=80=99
>  #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
>                                      ^
> drivers/acpi/acpica/rscreate.c:119:1: note: in expansion of macro =E2=
=80=98ACPI_EXPORT_SYMBOL=E2=80=99
>  ACPI_EXPORT_SYMBOL(acpi_buffer_to_resource)
>  ^
> include/linux/export.h:63:39: note: previous definition of =E2=80=98_=
_ksymtab_acpi_buffer_to_resource=E2=80=99 was here
>   __visible const struct kernel_symbol __ksymtab_##sym \
>                                        ^
> include/linux/export.h:69:2: note: in expansion of macro =E2=80=98__E=
XPORT_SYMBOL=E2=80=99
>   __EXPORT_SYMBOL(sym, "")
>   ^
> include/acpi/platform/aclinux.h:110:37: note: in expansion of macro =E2=
=80=98EXPORT_SYMBOL=E2=80=99
>  #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
>                                      ^
> drivers/acpi/acpica/rscreate.c:117:1: note: in expansion of macro =E2=
=80=98ACPI_EXPORT_SYMBOL=E2=80=99
>  ACPI_EXPORT_SYMBOL(acpi_buffer_to_resource);
>  ^
> make[3]: *** [drivers/acpi/acpica/rscreate.o] Error 1
> make[2]: *** [drivers/acpi/acpica] Error 2
> make[1]: *** [drivers/acpi] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [drivers] Error 2
>=20
>=20
> Reverting commit 51e35823eb57 ("ACPICA: Update acpi_buffer_to_resourc=
e interface"), build completes fine.
>=20
>=20
> Thanks,
> Stratos Karafotis
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
