From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: linux-pm build failure
Date: Fri, 09 May 2014 09:45:27 +0800
Message-ID: <536C3337.40402@intel.com>
References: <536BBAF8.6040601@semaphore.gr> <2930403.UViFFypGRj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10746 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753367AbaEIBpM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 8 May 2014 21:45:12 -0400
In-Reply-To: <2930403.UViFFypGRj@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Stratos Karafotis <stratosk@semaphore.gr>, Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On 2014=E5=B9=B405=E6=9C=8809=E6=97=A5 03:44, Rafael J. Wysocki wrote:
> On Thursday, May 08, 2014 08:12:24 PM Stratos Karafotis wrote:
>> Hi all,
>=20
> Hi,
>=20
> Thanks for the report!
>=20
> This is caused by commit
>=20
> 0e23847d5ee4 ACPICA: Export acpi_buffer_to_resource symbol
>=20
> merged on top of the recent ACPICA material.
>=20
> Lv, Tianyu, care to take care of this?

Hi Rafael:
	Just check commit 51e35823eb57 and find it also exports
acpi_buffer_to_resource symbol which commit 0e23847d5ee4 has already
done. I think you can drop commit 0e23847d5ee4 which only exports symbo=
l
without any other changes.

>=20
>> There is a build failure in latest linux-pm bleeding-edge:
>>
>> In file included from include/linux/linkage.h:6:0,
>>                  from include/linux/kernel.h:6,
>>                  from include/acpi/platform/aclinux.h:64,
>>                  from include/acpi/platform/acenv.h:150,
>>                  from include/acpi/acpi.h:56,
>>                  from drivers/acpi/acpica/rscreate.c:44:
>> include/linux/export.h:59:20: error: redefinition of =E2=80=98__kstr=
tab_acpi_buffer_to_resource=E2=80=99
>>   static const char __kstrtab_##sym[]   \
>>                     ^
>> include/linux/export.h:69:2: note: in expansion of macro =E2=80=98__=
EXPORT_SYMBOL=E2=80=99
>>   __EXPORT_SYMBOL(sym, "")
>>   ^
>> include/acpi/platform/aclinux.h:110:37: note: in expansion of macro =
=E2=80=98EXPORT_SYMBOL=E2=80=99
>>  #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
>>                                      ^
>> drivers/acpi/acpica/rscreate.c:119:1: note: in expansion of macro =E2=
=80=98ACPI_EXPORT_SYMBOL=E2=80=99
>>  ACPI_EXPORT_SYMBOL(acpi_buffer_to_resource)
>>  ^
>> include/linux/export.h:59:20: note: previous definition of =E2=80=98=
__kstrtab_acpi_buffer_to_resource=E2=80=99 was here
>>   static const char __kstrtab_##sym[]   \
>>                     ^
>> include/linux/export.h:69:2: note: in expansion of macro =E2=80=98__=
EXPORT_SYMBOL=E2=80=99
>>   __EXPORT_SYMBOL(sym, "")
>>   ^
>> include/acpi/platform/aclinux.h:110:37: note: in expansion of macro =
=E2=80=98EXPORT_SYMBOL=E2=80=99
>>  #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
>>                                      ^
>> drivers/acpi/acpica/rscreate.c:117:1: note: in expansion of macro =E2=
=80=98ACPI_EXPORT_SYMBOL=E2=80=99
>>  ACPI_EXPORT_SYMBOL(acpi_buffer_to_resource);
>>  ^
>> include/linux/export.h:63:39: error: redefinition of =E2=80=98__ksym=
tab_acpi_buffer_to_resource=E2=80=99
>>   __visible const struct kernel_symbol __ksymtab_##sym \
>>                                        ^
>> include/linux/export.h:69:2: note: in expansion of macro =E2=80=98__=
EXPORT_SYMBOL=E2=80=99
>>   __EXPORT_SYMBOL(sym, "")
>>   ^
>> include/acpi/platform/aclinux.h:110:37: note: in expansion of macro =
=E2=80=98EXPORT_SYMBOL=E2=80=99
>>  #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
>>                                      ^
>> drivers/acpi/acpica/rscreate.c:119:1: note: in expansion of macro =E2=
=80=98ACPI_EXPORT_SYMBOL=E2=80=99
>>  ACPI_EXPORT_SYMBOL(acpi_buffer_to_resource)
>>  ^
>> include/linux/export.h:63:39: note: previous definition of =E2=80=98=
__ksymtab_acpi_buffer_to_resource=E2=80=99 was here
>>   __visible const struct kernel_symbol __ksymtab_##sym \
>>                                        ^
>> include/linux/export.h:69:2: note: in expansion of macro =E2=80=98__=
EXPORT_SYMBOL=E2=80=99
>>   __EXPORT_SYMBOL(sym, "")
>>   ^
>> include/acpi/platform/aclinux.h:110:37: note: in expansion of macro =
=E2=80=98EXPORT_SYMBOL=E2=80=99
>>  #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
>>                                      ^
>> drivers/acpi/acpica/rscreate.c:117:1: note: in expansion of macro =E2=
=80=98ACPI_EXPORT_SYMBOL=E2=80=99
>>  ACPI_EXPORT_SYMBOL(acpi_buffer_to_resource);
>>  ^
>> make[3]: *** [drivers/acpi/acpica/rscreate.o] Error 1
>> make[2]: *** [drivers/acpi/acpica] Error 2
>> make[1]: *** [drivers/acpi] Error 2
>> make[1]: *** Waiting for unfinished jobs....
>> make: *** [drivers] Error 2
>>
>>
>> Reverting commit 51e35823eb57 ("ACPICA: Update acpi_buffer_to_resour=
ce interface"), build completes fine.
>>
>>
>> Thanks,
>> Stratos Karafotis
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--=20
Best regards
Tianyu Lan
