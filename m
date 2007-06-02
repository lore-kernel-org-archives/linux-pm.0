From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [PATCH] i386: Do not restore reserved memory after
	hibernation
Date: Sat, 2 Jun 2007 08:50:26 +0400
Message-ID: <200706020850.28299.arvidjaar@mail.ru>
References: <200706012158.32832.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8599452666714144669=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706012158.32832.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.osdl.org>, Andi Kleen <ak@suse.de>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============8599452666714144669==
Content-Type: multipart/signed; boundary="nextPart1245899.o13xTKfRZL";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1245899.o13xTKfRZL
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 01 June 2007, Rafael J. Wysocki wrote:
> Hi,
>
> This patch is designed to fix
> http://bugzilla.kernel.org/show_bug.cgi?id=3D7995
>
> Unfortunately, the reporter is unresponsive,=20

well, we have our life too ...

I confirm that this patch works. Unfortunately 2.6.22-rc here tends to hang=
 on=20
resume from STD often enough to be annoying so I tend to avoid it for daily=
=20
use. It just sits there with cursor in upper left corner, no output on=20
screen, nothing. I believe to have seen discussion about USB deadlock durin=
g=20
resume but cannot find it anymore. The problem is sporadic enough to render=
=20
bisect useless.

=2Dandrey

> so it hasn't been explicitly=20
> confirmed to fix the issue, but it's based on some previous patches that
> worked and definitely does what it's meant to do. :-)
>
> Greetings,
> Rafael
>
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> On some systems the ACPI NVS area is located in the first 1 MB of RAM and
> it is overwritten by the i386 code during the restore after hibernation.
> This confuses the ACPI platform firmware that doesn't update the AC adapt=
er
> status appropriately as a result
> (http://bugzilla.kernel.org/show_bug.cgi?id=3D7995).
>
> The solution is to register the reserved memory in the first 1 MB as
> 'nosave', so that swsusp doesn't touch it during the restore.  Also, this
> has been done on x86_64 for a long time now, so the patch makes the i386
> restore behaviour equivalent to the one of x86_64.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  arch/i386/kernel/e820.c  |   30 ++++++++++++++++++++++++++++++
>  arch/i386/kernel/setup.c |    1 +
>  include/asm-i386/e820.h  |    1 +
>  3 files changed, 32 insertions(+)
>
> Index: linux-2.6.22-rc3/arch/i386/kernel/e820.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.22-rc3.orig/arch/i386/kernel/e820.c
> +++ linux-2.6.22-rc3/arch/i386/kernel/e820.c
> @@ -10,6 +10,7 @@
>  #include <linux/efi.h>
>  #include <linux/pfn.h>
>  #include <linux/uaccess.h>
> +#include <linux/suspend.h>
>
>  #include <asm/pgtable.h>
>  #include <asm/page.h>
> @@ -320,6 +321,35 @@ static int __init request_standard_resou
>
>  subsys_initcall(request_standard_resources);
>
> +/**
> + * e820_mark_nosave_regions - Find the ranges of physical addresses that
> do not + * correspond to e820 RAM areas and mark the corresponding pages =
as
> nosave for + * hibernation.
> + *
> + * This function requires the e820 map to be sorted and without any
> + * overlapping entries and assumes the first e820 area to be RAM.
> + */
> +void __init e820_mark_nosave_regions(void)
> +{
> +	int i;
> +	unsigned long pfn;
> +
> +	pfn =3D PFN_DOWN(e820.map[0].addr + e820.map[0].size);
> +	for (i =3D 1; i < e820.nr_map; i++) {
> +		struct e820entry *ei =3D &e820.map[i];
> +
> +		if (pfn < PFN_UP(ei->addr))
> +			register_nosave_region(pfn, PFN_UP(ei->addr));
> +
> +		pfn =3D PFN_DOWN(ei->addr + ei->size);
> +		if (ei->type !=3D E820_RAM)
> +			register_nosave_region(PFN_UP(ei->addr), pfn);
> +
> +		if (pfn >=3D max_low_pfn)
> +			break;
> +	}
> +}
> +
>  void __init add_memory_region(unsigned long long start,
>  			      unsigned long long size, int type)
>  {
> Index: linux-2.6.22-rc3/arch/i386/kernel/setup.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.22-rc3.orig/arch/i386/kernel/setup.c
> +++ linux-2.6.22-rc3/arch/i386/kernel/setup.c
> @@ -648,6 +648,7 @@ void __init setup_arch(char **cmdline_p)
>  #endif
>
>  	e820_register_memory();
> +	e820_mark_nosave_regions();
>
>  #ifdef CONFIG_VT
>  #if defined(CONFIG_VGA_CONSOLE)
> Index: linux-2.6.22-rc3/include/asm-i386/e820.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.22-rc3.orig/include/asm-i386/e820.h
> +++ linux-2.6.22-rc3/include/asm-i386/e820.h
> @@ -44,6 +44,7 @@ extern void register_bootmem_low_pages(u
>  extern void e820_register_memory(void);
>  extern void limit_regions(unsigned long long size);
>  extern void print_memory_map(char *who);
> +extern void e820_mark_nosave_regions(void);
>
>  #endif/*!__ASSEMBLY__*/



--nextPart1245899.o13xTKfRZL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGYPcUR6LMutpd94wRApwCAKCHX5IR1UR1drwNyVVgPVa4JG7VKgCfbSsT
Vx4T8kiZ39QgeydNPeFdKlY=
=7tdV
-----END PGP SIGNATURE-----

--nextPart1245899.o13xTKfRZL--

--===============8599452666714144669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8599452666714144669==--
