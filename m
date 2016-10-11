From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/4][RFC v2] PM / sleep: Introduce arch-specific hook for
 disable/enable nonboot cpus
Date: Tue, 11 Oct 2016 17:42:51 +0200
Message-ID: <20161011154251.GA22569@amd>
References: <cover.1466844557.git.yu.c.chen@intel.com>
 <fb78859e5c1ea061ce4e35e200821ed170e6658d.1466844557.git.yu.c.chen@intel.com>
 <8f0aeb0a-5e72-8327-2406-a78ad783f6f2@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52317 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752185AbcJKPmz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Oct 2016 11:42:55 -0400
Content-Disposition: inline
In-Reply-To: <8f0aeb0a-5e72-8327-2406-a78ad783f6f2@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Chen Yu <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Brian Gerst <brgerst@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Varun Koyyalagunta <cpudebug@centtech.com>, linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2016-10-07 12:31:41, Andy Lutomirski wrote:
> On 06/25/2016 09:18 AM, Chen Yu wrote:
> >There is requirement that we need to do some arch-specific
> >operations before putting the nonboot CPUs offline/online.
> >One of the requirements comes from the hibernation resume
> >process on x86_64, we need to kick all the offlin-CPUs
> >online and offline again, in order to put them in a safe
> >state, thus to avoid possible unwilling wake up during
> >hibernation resume.
> >
> >Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> >---
> > kernel/cpu.c | 12 ++++++++++++
> > 1 file changed, 12 insertions(+)
> >
> >diff --git a/kernel/cpu.c b/kernel/cpu.c
> >index d25266e..ce6e5e4 100644
> >--- a/kernel/cpu.c
> >+++ b/kernel/cpu.c
> >@@ -1017,6 +1017,16 @@ EXPORT_SYMBOL_GPL(cpu_up);
> > #ifdef CONFIG_PM_SLEEP_SMP
> > static cpumask_var_t frozen_cpus;
> >
> >+void __weak arch_disable_nonboot_cpus_pre(void)
>=20
> I don't like using __weak.  It penalizes code size on architectures that
> don't hook these functions.  My preferred pattern is:
>=20
> include/linux/something.h:
>=20
> #include <asm/something.h>
>=20
> #ifndef arch_do_xyz
> static inline void arch_do_xyz() {}
> #endif
>=20
> arch/whatever/asm/something.h:
>=20
> extern void arch_do_xyz();  /* or static inline... */
> #define arch_do_xyz
>=20
>=20
> This is totally free for architectures that don't have the hooks and it c=
an
> potentially be inlined on architectures that do have the hooks. Everyone
> wins except that it's about five additional lines of code.

Well... 5 additional lines may be worse than few bytes in the object
file...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlf9CHsACgkQMOfwapXb+vKiUQCgr4T5tIoRHTQ1z7ZPOQb6nU5G
XqwAoL13xYYo9fIYc3+nuSTIiCql3ujO
=wk4W
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
