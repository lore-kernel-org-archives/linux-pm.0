From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv3 2/2] arch: Rename CONFIG_DEBUG_RODATA and
 CONFIG_DEBUG_MODULE_RONX
Date: Thu, 16 Feb 2017 23:25:29 +0100
Message-ID: <20170216222529.GA7531@amd>
References: <1486427518-14819-1-git-send-email-labbott@redhat.com>
 <1486427518-14819-3-git-send-email-labbott@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1486427518-14819-3-git-send-email-labbott@redhat.com>
Sender: linux-parisc-owner@vger.kernel.org
To: Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, "H. Peter Anvin" <hpa@zytor.com>, kernel-hardening@lists.openwall.com, Rob Herring <robh@kernel.org>, Jessica Yu <jeyu@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Len Brown <len.brown@intel.com>, linux-s390@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysoc>
List-Id: linux-pm@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> =20
> -config DEBUG_RODATA
> +config STRICT_KERNEL_RWX
>  	bool "Make kernel text and rodata read-only" if ARCH_OPTIONAL_KERNEL_RWX
>  	depends on ARCH_HAS_STRICT_KERNEL_RWX
>  	default !ARCH_OPTIONAL_KERNEL_RWX ||

Debug features are expected to have runtime cost, so kconfig help is
silent about those. But there are runtime costs, right? It would be
nice to mention them in the help text...

								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlimJtkACgkQMOfwapXb+vIejgCgsvrn5eQ2U0NHrSk8jkwMzi0k
mSAAnR5YQy0wi16SGmy3kL+mPGH3sglk
=h8TA
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
