From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Fri, 20 Apr 2007 21:51:53 +0200
Message-ID: <1177098713.5902.24.camel@johannes.berg>
References: <1176980411.6141.83.camel@johannes.berg>
	<20070420065731.GA5831@kroah.com>
	<1177083093.5902.3.camel@johannes.berg>
	<20070420173951.GB14778@kroah.com>
	<1177097838.5902.10.camel@johannes.berg>
	<20070420124448.4eaa159c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1438697620138283335=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070420124448.4eaa159c.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============1438697620138283335==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-SFDhuJC2xDO3HrHYCXcp"


--=-SFDhuJC2xDO3HrHYCXcp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-20 at 12:44 -0700, Andrew Morton wrote:

> > -	local_irq_restore(flags);
> > +	arch_s2ram_enable_irqs(&flags);
> > +	BUG_ON(irqs_disabled());
> >  	return error;
> >  }
>=20
> The second BUG_ON() looks a bit fishy to me.  If someone calls
> suspend_enter() with local interrupts disabled, it will trigger.

Huh, hm, I don't think it's valid to do that. I'm not sure why the code
does irq_save/restore instead of just disable/enable. The only users of
this function are in the power management core code (main.c and user.c)
and they certainly always call it with interrupts enabled, the entry
point for other users is pm_suspend() and that surely cannot be called
with interrupts disabled. Rafael?

johannes

--=-SFDhuJC2xDO3HrHYCXcp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGKRnZ/ETPhpq3jKURAqVjAJ9Lph35aQgnfLjDsfy/rC9nlqSmJQCgjGx2
1C6iRbwPt4wHeZNgSw81JHw=
=Cgtc
-----END PGP SIGNATURE-----

--=-SFDhuJC2xDO3HrHYCXcp--


--===============1438697620138283335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1438697620138283335==--
