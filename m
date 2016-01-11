From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/8] lib/string: introduce match_string() helper
Date: Mon, 11 Jan 2016 17:00:00 +0200
Message-ID: <1452524400.26146.32.camel@linux.intel.com>
References: <1452242596.30729.425.camel@linux.intel.com>
	 <20160109011241.GB560@swordfish>
	 <CAHp75Vf_dESyzvi5EN5KP8OCKtqKoD8YK7w5s0yHpBgt=-q7Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:12711 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757612AbcAKO7g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Jan 2016 09:59:36 -0500
In-Reply-To: <CAHp75Vf_dESyzvi5EN5KP8OCKtqKoD8YK7w5s0yHpBgt=-q7Uw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

On Sat, 2016-01-09 at 13:57 +0200, Andy Shevchenko wrote:
> On Sat, Jan 9, 2016 at 3:12 AM, Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
> > Andy Shevchenko wrote:
> > [..]
> > > >=20
> > > > strncmp() case seems to be quite common.
> > >=20
> > > Like I answered to Rasmus, please, provide real examples.
> >=20
> > [..]
> > > > int nmatch_string(array, array_size, string, string_len)
> > > > {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0do {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0strncmp();
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} while ();
> > > > }
> > > >=20
> > > > int match_string(array, array_size, string)
> > > > {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return nmatch_string(array,=
 array_size, string,
> > > > strlen(string));
> > > > }
> > >=20
> > > See above.
> >=20
> > after some quick and inaccurate grepping, well, probably you're
> > right - not worth it.
>=20
> Good grep anyway, it clearly shows that there is hard to generalize
> which limit to use: a) length of a first argument / item from a list,
> b) length of a second argument or a constant.
>=20
> > arch/mips/bcm63xx/boards/board_bcm963xx.c=C2=A0=C2=A0void __init
> > board_prom_init(void)
> > net/irda/irnet/irnet_irda.c=C2=A0=C2=A0=C2=A0irnet_dname_to_daddr()
> > arch/powerpc/sysdev/ppc4xx_cpm.c static ssize_t cpm_idle_store()
> > arch/x86/ras/mce_amd_inj.c static int __set_inj
> > drivers/hwtracing/intel_th/msu.c mode_store
> > drivers/pci/pcie/aer/ecrc.c void pcie_ecrc_get_policy
> > drivers/pci/pcie/aspm.c pcie_aspm_set_policy
> > drivers/scsi/aic7xxx/aic7xxx_osm.c aic7xxx_setup
> > drivers/scsi/aic7xxx/aic79xx_osm.c aic79xx_setup
> > drivers/scsi/scsi_transport_fc.c static int get_fc_##title##_match
> > drivers/staging/android/ion/hisilicon/hi6220_ion.c get_type_by_name
> > drivers/staging/lustre/lustre/lmv/lproc_lmv.c placement_name2policy
> > drivers/xen/sys-hypervisor.c pmu_mode_store

Thought more about those cases.

If you would like you may introduce something like

int nmatch_string(array, array_size, string, int len)
{
=C2=A0 if (len < 0)
=C2=A0 =C2=A0 return match_string();

=C2=A0 for (=E2=80=A6) {
=C2=A0 =C2=A0 size_t itemlen =3D (len > 0) ? len : strlen(array[index])=
;
=E2=80=A6
=C2=A0 =C2=A0 if (!strncmp(array[index], string, itemlen))
=C2=A0 =C2=A0 =C2=A0 return index;
=C2=A0 }
=C2=A0 return -EINVAL;
}

And convert existing users where it makes sense.

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

