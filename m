From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] x86/ACPI/cstate: Output AMD on APCI C1 FFH MWAIT AMD
 systems
Date: Wed, 8 Aug 2018 23:06:36 +0200
Message-ID: <20180808210636.GB15831@amd>
References: <20180808174735.3114-1-prarit@redhat.com>
 <20180808195856.GA20912@amd>
 <CAJvTdKnOTi-iQ9BfMW4KQWkqPU=3JRCM-9Kij+3zB5KFMjve9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJvTdKnOTi-iQ9BfMW4KQWkqPU=3JRCM-9Kij+3zB5KFMjve9w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-08-08 16:01:41, Len Brown wrote:
> I think it is sufficient to simply delete the "INTEL" in that string.
>=20
> In the unlikely event that this "change to a kernel API" breaks
> something, we can add it back.

I'd just leave it alone. But yes, just deleting INTEL is better than
patch below.
								Pavel

> > On Wed 2018-08-08 13:47:35, Prarit Bhargava wrote:
> > > commit 5209654a46ee ("x86/ACPI/cstate: Allow ACPI C1 FFH MWAIT use on=
 AMD
> > > systems") allows use of FFH for ACPI C1 but tools like cpupower and t=
urbostat
> > > display INTEL for the cstate description.
> > >
> > > Output "AMD" for AMD systems with FFH for ACPI C1.
> >
> > Um, is it good idea?
> >
> > First, you are changing kernel API.
> >
> > > @@ -107,9 +108,14 @@ static long acpi_processor_ffh_cstate_probe_cpu(=
void *_cx)
> > >                       "Monitor-Mwait will be used to enter C-%d state=
\n",
> > >                       cx->type);
> > >       }
> > > -     snprintf(cx->desc,
> > > -                     ACPI_CX_DESC_LEN, "ACPI FFH INTEL MWAIT 0x%x",
> > > -                     cx->address);
> > > +     if (c->x86_vendor =3D=3D X86_VENDOR_INTEL)
> > > +             snprintf(cx->desc,
> > > +                      ACPI_CX_DESC_LEN, "ACPI FFH INTEL MWAIT 0x%x",
> > > +                      cx->address);
> > > +     else
> > > +             snprintf(cx->desc,
> > > +                      ACPI_CX_DESC_LEN, "ACPI FFH AMD MWAIT 0x%x",
> > > +                      cx->address);
> >
> > Second, I read it as "Intel MWAIT" instruction is used. Yes, AMD cpu can
> > use Intel MWAIT, too...
> >
> > Third, there are more CPU vendors out there.
> >
> >                                                                        =
 Pavel
> > --
> > (english) http://www.livejournal.com/~pavelmachek
> > (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
>=20
>=20
>=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltrW1wACgkQMOfwapXb+vJWLgCfcOXaO54v1nJEGiGUaTQmym1z
odYAoKDTlSJ/bF02Vq+k8g2vwtCHa2aq
=YQfM
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
