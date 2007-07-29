From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH 2/2] Introduce CONFIG_SUSPEND
Date: Sun, 29 Jul 2007 23:18:24 +0200
Message-ID: <20070729211824.GL16817__37625.4953364425$1185743983$gmane$org@stusta.de>
References: <200707251238.50218.lenb@kernel.org>
	<200707291438.06849.rjw@sisk.pl> <20070729204001.GJ16817@stusta.de>
	<200707292317.21419.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707292317.21419.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: david@lang.hm, Nigel Cunningham <nigel@nigel.suspend2.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Jul 29, 2007 at 11:17:20PM +0200, Rafael J. Wysocki wrote:
> On Sunday, 29 July 2007 22:40, Adrian Bunk wrote:
> > On Sun, Jul 29, 2007 at 02:38:05PM +0200, Rafael J. Wysocki wrote:
> > >...
> > > +config SUSPEND
> > > +	bool "Suspend"
> > =C2=A0            "Suspend to RAM"
>=20
> Not only.  This also includes "standby".

Whatever it includes - please tell it to the user in the prompt.

Technical issues are important, but it's often forgotten how many=20
problems people run into because the description of a kconfig option=20
could have been better.

> > >...
> > >  config HIBERNATION
> > >  	bool "Hibernation"
> > >...         "Hibernation (Suspend to disk)"
> >=20
> > cu
> > Adrian
>=20
> Greetings,
> Rafael
>=20
>=20
> --=20
> "Premature optimization is the root of all evil." - Donald Knuth

cu
Adrian

--=20

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
