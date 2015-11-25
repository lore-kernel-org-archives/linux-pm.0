From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] x86/platform/iosf_mbi: Remove duplicate
 definitions
Date: Wed, 25 Nov 2015 16:33:04 +0200
Message-ID: <1448461984.15393.53.camel@linux.intel.com>
References: <1447264769-21981-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <alpine.DEB.2.11.1511251514580.12555@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1511251514580.12555@nanos>
Sender: linux-i2c-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>, Wolfram Sang <wsa@the-dreams.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hock Leong Kweh <hock.leong.kweh@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2015-11-25 at 15:20 +0100, Thomas Gleixner wrote:
> On Wed, 11 Nov 2015, Andy Shevchenko wrote:
>=20
> > The read and write opcodes are global for all units on SoC and even
> across
> > Intel SoCs. Remove duplication of corresponding constants. At the
> same time
> > convert all current users.
> >=20
> > No functional change.
> >=20
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Anvin <hpa@zytor.com>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Hock Leong Kweh <hock.leong.kweh@intel.com>

Eduardo, Rui, can you provide your ACKs or comments about the patch?

> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > Since v1:
> > - satisfy kbuild robot
> >=20
> >=C2=A0 arch/x86/include/asm/iosf_mbi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 49 +++++-----------
> ------
> >=C2=A0 arch/x86/platform/atom/punit_atom_debug.c=C2=A0=C2=A0=C2=A0 |=
=C2=A0 7 +---
> >=C2=A0 arch/x86/platform/intel-quark/imr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 28 +++++--------
> >=C2=A0 drivers/i2c/busses/i2c-designware-baytrail.c | 17 +++-----
> >=C2=A0 drivers/powercap/intel_rapl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++---
> >=C2=A0 drivers/thermal/intel_quark_dts_thermal.c=C2=A0=C2=A0=C2=A0 |=
 61 ++++++++++++++
> --------------
> >=C2=A0 drivers/thermal/intel_soc_dts_iosf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 43 ++++++++++----
> ------
>=20
> Hmm. Either we get acks of all maintainers and merge it through
> tip/x86/...=20

I prefer this way because=E2=80=A6

> or we do the following:
>=20
> Add the new constants w/o using them in a seperate patch and ship
> that
> linuswards now. Then the subsystem maintainers can pick the
> individual
> patches up and after the merge window closes we remove the old
> constants in one go.
>=20
> Either way works for me.

=E2=80=A6we are working on another fix which is based also on this patc=
h. Can
you provide your ACK if you are okay with the changes to arch/x86 ?

>=20
> Thanks,
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tglx
>=20
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
