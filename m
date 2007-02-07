From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [linux-pm] [RFC 07/10] powermac: support G5 CPU hotplug
Date: Wed, 07 Feb 2007 12:40:20 +0100
Message-ID: <1170848420.6798.8.camel@johannes.berg>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185837.640324000@sipsolutions.net>
	<20070206124212.GD8662@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0424156034=="
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20070206124212.GD8662@elf.ucw.cz>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Mime-version: 1.0
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org


--===============0424156034==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BLAwoKzWWNcGrT6bQg4H"


--=-BLAwoKzWWNcGrT6bQg4H
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> > +	/* it seems to be possible that we died from within
> > +	 * an interrupt ... reset the in-irq counts */
> > +	task_thread_info(paca[cpu].__current)->preempt_count &=3D
> > +		~(SOFTIRQ_MASK|HARDIRQ_MASK);
> > +
> >  	cpu_idle();
> >  	return 0;
>=20
> This is quite a nasty hack. Are you sure?
>=20
> I've seen similar weirdness on pc, and it was caused by
> swsusp-copying-code using FPU and incrementing preempt_count...

I know. I'm not really happy with it. But I can't figure out where the
hardirq count can be incremented. The preempt count is fine (well, in my
latest patchset, this one forgot one spot), but the hard irq count is
not. Which is really strange because we only use that for actual in-irq
stuff...

johannes

--=-BLAwoKzWWNcGrT6bQg4H
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFybqk/ETPhpq3jKURAoFIAJ0QTsyDYZVgekoVv/KMfhRK+jtucgCeP4o8
3clkydQcW+EXvzM44cYL3Io=
=4jVh
-----END PGP SIGNATURE-----

--=-BLAwoKzWWNcGrT6bQg4H--


--===============0424156034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
--===============0424156034==--
