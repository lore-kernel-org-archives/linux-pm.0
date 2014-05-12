From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: linux-pm bleeding-edge build failure
Date: Mon, 12 May 2014 14:05:30 +0200
Message-ID: <1955143.anCSeFYUq9@vostro.rjw.lan>
References: <53703388.3010501@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57313 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753761AbaELLsq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 May 2014 07:48:46 -0400
In-Reply-To: <53703388.3010501@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Monday, May 12, 2014 05:35:52 AM Stratos Karafotis wrote:
> Hi Rafael,
>=20
> Building the latest bleeding edge (4881a46e969889ba1c20fed733e742bf19=
d0591e),
> I get this error:
>=20
> drivers/acpi/acpica/tbfadt.c: In function =E2=80=98acpi_tb_convert_fa=
dt=E2=80=99:
> drivers/acpi/acpica/tbfadt.c:493:12: error: too few arguments to func=
tion =E2=80=98acpi_tb_init_generic_address=E2=80=99
>             fadt_info_table[i].name);
>             ^
> drivers/acpi/acpica/tbfadt.c:190:1: note: declared here
>  acpi_tb_init_generic_address(struct acpi_generic_address *generic_ad=
dress,
>  ^
> drivers/acpi/acpica/tbfadt.c:394:5: warning: unused variable =E2=80=98=
flags=E2=80=99 [-Wunused-variable]
>   u8 flags;
>      ^
> drivers/acpi/acpica/tbfadt.c:393:5: warning: unused variable =E2=80=98=
length=E2=80=99 [-Wunused-variable]
>   u8 length;
>      ^
> drivers/acpi/acpica/tbfadt.c: In function =E2=80=98acpi_tb_validate_f=
adt=E2=80=99:
> drivers/acpi/acpica/tbfadt.c:572:3: error: =E2=80=98flags=E2=80=99 un=
declared (first use in this function)
>    flags =3D fadt_info_table[i].flags;
>    ^
> drivers/acpi/acpica/tbfadt.c:572:3: note: each undeclared identifier =
is reported only once for each function it appears in
> drivers/acpi/acpica/tbfadt.c:599:7: error: =E2=80=98address32=E2=80=99=
 undeclared (first use in this function)
>    if (address32) {
>        ^
> make[3]: *** [drivers/acpi/acpica/tbfadt.o] Error 1
> make[2]: *** [drivers/acpi/acpica] Error 2
> make[1]: *** [drivers/acpi] Error 2
> make: *** [drivers] Error 2
> make: *** Waiting for unfinished jobs....

That's because of my merge conflict resolution that went wrong.

I guess I'll need to drop one commit from acpica-next.

Thanks!

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
