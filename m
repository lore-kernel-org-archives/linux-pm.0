From: Andrew Savchenko <bircoph@gmail.com>
Subject: Re: [Suspend-devel] [BUG] 3.7-rc regression bisected: s2disk fails
 to resume image: Processes could not be frozen, cannot continue resuming
Date: Sun, 22 May 2016 11:47:22 +0300
Message-ID: <20160522114722.e7bd390bd299486dc6aaf55c@gmail.com>
References: <20130812234415.7db639bb0d664e56b6ab2ab2@gmail.com>
	<20130918191607.GO13318@ZenIV.linux.org.uk>
	<20130924002111.GB31569@amd.pavel.ucw.cz>
	<2906897.X51K0zWBHo@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA512";
 boundary="Signature=_Sun__22_May_2016_11_47_23_+0300_jrrzJv/lBK=1rTfX"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:33786 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbcEVIrq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 22 May 2016 04:47:46 -0400
In-Reply-To: <2906897.X51K0zWBHo@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Al Viro <viro@zeniv.linux.org.uk>
Cc: suspend-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

--Signature=_Sun__22_May_2016_11_47_23_+0300_jrrzJv/lBK=1rTfX
Content-Type: multipart/mixed;
 boundary="Multipart=_Sun__22_May_2016_11_47_22_+0300_/d2yKodA7V0/Z=DU"


--Multipart=_Sun__22_May_2016_11_47_22_+0300_/d2yKodA7V0/Z=DU
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 17 Oct 2013 23:35:12 +0200 Rafael J. Wysocki wrote:
> Sorry for the huge delay.
>=20
> On Tuesday, September 24, 2013 02:21:11 AM Pavel Machek wrote:
> > Hi!
> >=20
> > > > And from suspend_ioctls.h:
> > > > #define SNAPSHOT_IOC_MAGIC      '3'
> > > > #define SNAPSHOT_FREEZE                 _IO(SNAPSHOT_IOC_MAGIC, 1)
> > > >=20
> > > > My mistake, should be '3' instead of 3.
> > >=20
> > > OK...  The thing to test, then, is what does __usermodehelper_disable=
()
> > > return to freeze_processes().  If that's where this -EAGAIN comes fro=
m,
> > > we at least have a plausible theory re what's going on.
> > >=20
> > > freeze_processes() uses __usermodehelper_disable() to stop any new us=
erland
> > > processes spawned by UMH (modprobe, etc.) and waits for ones it might=
 be
> > > waiting for to complete.  Then it does try_to_freeze_tasks(), which
> > > freezes remaining userland, carefully skipping the current thread.
> > > However, it misses the possibility that current thread might have been
> > > spawned by something that had been launched by UMH, with UMH waiting
> > > for it.  Which is the case of everything spawned by linuxrc.
> > >=20
> > > I'd try something like diff below, but I'm *NOT* familiar with swsusp=
 at
> > > all; it's not for mainline until ACKed by swsusp folks.
> > >=20
> > > diff --git a/kernel/kmod.c b/kernel/kmod.c
> > > index fb32636..d968882 100644
> > > --- a/kernel/kmod.c
> > > +++ b/kernel/kmod.c
> > > @@ -571,7 +571,8 @@ int call_usermodehelper_exec(struct subprocess_in=
fo *sub_info, int wait)
> > >  	DECLARE_COMPLETION_ONSTACK(done);
> > >  	int retval =3D 0;
> > > =20
> > > -	helper_lock();
> > > +	if (!(current->flags & PF_FREEZER_SKIP))
> > > +		helper_lock();
> > >  	if (!khelper_wq || usermodehelper_disabled) {
> > >  		retval =3D -EBUSY;
> > >  		goto out;
> > > @@ -611,7 +612,8 @@ wait_done:
> > >  out:
> > >  	call_usermodehelper_freeinfo(sub_info);
> > >  unlock:
> > > -	helper_unlock();
> > > +	if (!(current->flags & PF_FREEZER_SKIP))
> > > +		helper_unlock();
> > >  	return retval;
> > >  }
> > >  EXPORT_SYMBOL(call_usermodehelper_exec);
> >=20
> > PF_FREEZER_SKIP flag is manipulated at about 1000 places, so I'm not
> > sure this will nest correctly.
>=20
> This is not exactly correct unless 1000 is about 50.  And none of them le=
ads to
> call_usermodehelper_exec() as far as I can say.
>=20
> > They seem to be in form of=20
> >=20
> > |=3D FREEZER_SKIP
> > schedule()
> > &=3D ~FREEZER_SKIP
> >=20
> > so this should be safe, but...
>=20
> I think the patch is correct, so
>=20
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Thanks!
=20
The problem is still here with 4.6.0 kernel. Patch is updated to
reflect code base changes while retaining original logics. Works
fine for me here (4.6.0, x86, Atom N270, EeePC 1000H).

Best regards,
Andrew Savchenko

--Multipart=_Sun__22_May_2016_11_47_22_+0300_/d2yKodA7V0/Z=DU
Content-Type: text/x-diff;
 name="linuxrc-usermodhelper_disable-4.6.0.patch"
Content-Disposition: attachment;
 filename="linuxrc-usermodhelper_disable-4.6.0.patch"
Content-Transfer-Encoding: quoted-printable

--- linux-4.6.0/kernel/kmod.c.orig	2016-05-16 01:43:13.000000000 +0300
+++ linux-4.6.0/kernel/kmod.c	2016-05-22 09:49:12.654159691 +0300
@@ -561,7 +561,8 @@
 		call_usermodehelper_freeinfo(sub_info);
 		return -EINVAL;
 	}
-	helper_lock();
+	if (!(current->flags & PF_FREEZER_SKIP))
+		helper_lock();
 	if (usermodehelper_disabled) {
 		retval =3D -EBUSY;
 		goto out;
@@ -595,7 +596,8 @@
 out:
 	call_usermodehelper_freeinfo(sub_info);
 unlock:
-	helper_unlock();
+	if (!(current->flags & PF_FREEZER_SKIP))
+		helper_unlock();
 	return retval;
 }
 EXPORT_SYMBOL(call_usermodehelper_exec);

--Multipart=_Sun__22_May_2016_11_47_22_+0300_/d2yKodA7V0/Z=DU--

--Signature=_Sun__22_May_2016_11_47_23_+0300_jrrzJv/lBK=1rTfX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJXQXIbAAoJEPZTWjO6HuSNGGoP/iuACM9Ytu6HaghFL7/l6M/e
SGnNl+yGorWhrNB3zqcdk6gZ3XH0F7xqklHkPO6WpCwWbljXcgAP3twSSApLhqrM
ZQC3Y5aFykGZuGkwOaKmK59+6hOydntcADmmcogV1HshO4UF6ilGCaPFVRHs2PiV
2nP9jFJjUD46o45vaYnVr1y+ii3gWjNTrVD2q/hG3RfHmbuFSS/YcD1OY7pidF3a
ogboE4fRab3gYH/16njF5GXlZC0sUsHbonPEwQ0SyC2yDM2AM6Q8b/DIJALs0MkO
1EXdWj4jjUXc5D2l1uNSTJM1rnoBQoFPGGNZ/Ti8OEMaELrVfwZyTNxgAVl0kgWG
2+ts9E3QWYf6qSeQCjAvZ/dSCLl7/oamOD+J3ubFHxBACuqs/GtlOJs7j+rMW9vZ
q4ByfAtAQzAyAY2Dxe+BG0qYlAPrDtuL7S3Esrjcr0Wd0WBjNAwUys8Qb0qQuPTC
3PVVJij8ffJ/c2XA1Mqf5CWHJ/50473f5UNvaNjSG4bolF2zaECE0JexDQ+2LtCO
fc7vHS7NiOjmU9PRZojiKXgMxezBPBHhpiQRH4RyZV8C+Z4/hg2rdI0ytkIEEvhr
HPLJ04OphQ6Oqn1SkMt38cT24P8LZq0rwjzxy5PhE2UL3yZKs9QzeCrjnDQ/cpgM
vwGaI6G7PrA2zejp41sa
=mnIK
-----END PGP SIGNATURE-----

--Signature=_Sun__22_May_2016_11_47_23_+0300_jrrzJv/lBK=1rTfX--
