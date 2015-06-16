From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [pm:linux-next 151/172] include/linux/ctype.h:15:12: error: expected ';', ',' or ')' before numeric constant
Date: Tue, 16 Jun 2015 23:33:38 +0200
Message-ID: <3128117.jH9XgSdYxQ@vostro.rjw.lan>
References: <201506160806.2CCbvoNT%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59126 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755037AbbFPVHl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2015 17:07:41 -0400
In-Reply-To: <201506160806.2CCbvoNT%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc: kbuild-all@01.org, Mark Salter <msalter@redhat.com>, linux-pm@vger.kernel.org

On Tuesday, June 16, 2015 08:39:11 AM kbuild test robot wrote:
>=20
> --vkogqOf2sHV7VnPd
> Content-Type: text/plain; charset=3Diso-8859-1
> Content-Disposition: inline
> Content-Transfer-Encoding: 8bit
>=20
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
=2Egit linux-next
> head:   5b58fe3a9afa62089c4d6a99b5a6a77cede5be9b
> commit: b6197b93fa4bcba9313cc415934e3fe27e2db9b0 [151/172] arm64 : In=
troduce support for ACPI _CCA object
> config: arm64-allyesconfig (attached as .config)
> reproduce:
>   wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git=
/plain/sbin/make.cross -O ~/bin/make.cross
>   chmod +x ~/bin/make.cross
>   git checkout b6197b93fa4bcba9313cc415934e3fe27e2db9b0
>   # save the attached .config to linux build tree
>   make.cross ARCH=3Darm64=20
>=20
> All error/warnings (new ones prefixed by >>):
>=20
>    In file included from include/acpi/platform/aclinux.h:74:0,
>                     from include/acpi/platform/acenv.h:173,
>                     from include/acpi/acpi.h:56,
>                     from include/linux/acpi.h:37,
>                     from arch/arm64/include/asm/dma-mapping.h:21,
>                     from include/linux/dma-mapping.h:86,
>                     from include/linux/skbuff.h:34,
>                     from include/crypto/algapi.h:18,
>                     from crypto/asymmetric_keys/rsa.c:16:
> >> include/linux/ctype.h:15:12: error: expected ';', ',' or ')' befor=
e numeric constant
>     #define _X 0x40 /* hex digit */
>                ^
>    crypto/asymmetric_keys/rsa.c:123:47: note: in expansion of macro '=
_X'
>     static int RSA_I2OSP(MPI x, size_t xLen, u8 **_X)
>                                                   ^
>    crypto/asymmetric_keys/rsa.c: In function 'RSA_verify_signature':
> >> crypto/asymmetric_keys/rsa.c:256:2: error: implicit declaration of=
 function 'RSA_I2OSP' [-Werror=3Dimplicit-function-declaration]
>      ret =3D RSA_I2OSP(m, k, &EM);
>      ^
>    cc1: some warnings being treated as errors
>=20
> vim +15 include/linux/ctype.h
>=20
> ^1da177e Linus Torvalds     2005-04-16   1  #ifndef _LINUX_CTYPE_H
> ^1da177e Linus Torvalds     2005-04-16   2  #define _LINUX_CTYPE_H
> ^1da177e Linus Torvalds     2005-04-16   3 =20
> ^1da177e Linus Torvalds     2005-04-16   4  /*
> ^1da177e Linus Torvalds     2005-04-16   5   * NOTE! This ctype does =
not handle EOF like the standard C
> ^1da177e Linus Torvalds     2005-04-16   6   * library is required to=
=2E
> ^1da177e Linus Torvalds     2005-04-16   7   */
> ^1da177e Linus Torvalds     2005-04-16   8 =20
> ^1da177e Linus Torvalds     2005-04-16   9  #define _U	0x01	/* upper =
*/
> ^1da177e Linus Torvalds     2005-04-16  10  #define _L	0x02	/* lower =
*/
> ^1da177e Linus Torvalds     2005-04-16  11  #define _D	0x04	/* digit =
*/
> ^1da177e Linus Torvalds     2005-04-16  12  #define _C	0x08	/* cntrl =
*/
> ^1da177e Linus Torvalds     2005-04-16  13  #define _P	0x10	/* punct =
*/
> ^1da177e Linus Torvalds     2005-04-16  14  #define _S	0x20	/* white =
space (space/lf/tab) */
> ^1da177e Linus Torvalds     2005-04-16 @15  #define _X	0x40	/* hex di=
git */
> ^1da177e Linus Torvalds     2005-04-16  16  #define _SP	0x80	/* hard =
space (0x20) */
> ^1da177e Linus Torvalds     2005-04-16  17 =20
> 7707e61c Andr=C3=A9 Goddard Rosa 2009-12-14  18  extern const unsigne=
d char _ctype[];
> ^1da177e Linus Torvalds     2005-04-16  19 =20
> ^1da177e Linus Torvalds     2005-04-16  20  #define __ismask(x) (_cty=
pe[(int)(unsigned char)(x)])
> ^1da177e Linus Torvalds     2005-04-16  21 =20
> ^1da177e Linus Torvalds     2005-04-16  22  #define isalnum(c)	((__is=
mask(c)&(_U|_L|_D)) !=3D 0)
> ^1da177e Linus Torvalds     2005-04-16  23  #define isalpha(c)	((__is=
mask(c)&(_U|_L)) !=3D 0)
>=20
> :::::: The code at line 15 was first introduced by commit
> :::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2
>=20
> :::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
> :::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source Technolog=
y Center
> http://lists.01.org/mailman/listinfo/kbuild                 Intel Cor=
poration

Any chance to have a look at this, please?

