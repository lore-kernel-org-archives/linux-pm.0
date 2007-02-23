From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: SMP suspend broken due to "swsusp: Change code
	ordering in	disk.c" et al.
Date: Fri, 23 Feb 2007 21:23:38 +0100
Message-ID: <1172262219.3870.63.camel@johannes.berg>
References: <1172201385.15769.32.camel@johannes.berg>
	<200702231254.47009.rjw@sisk.pl>
	<1172233076.3870.26.camel@johannes.berg>
	<200702231425.38217.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0931394336=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200702231425.38217.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Dave Vasilevsky <djvasi@gmail.com>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@suspend2.net>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============0931394336==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-7MrpWzujVwUcXQ/hz7vi"


--=-7MrpWzujVwUcXQ/hz7vi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> In that case the fastest fix would be to revert the commit in question (a=
nd
> some others too),

Yeah, the same thing exists for uswsusp and regular suspend-to-ram
afaict.

> but I don't think it will be satisfactory for the people with
> the ACPI issues related to the resume code ordering.  Moreover, it really
> is more reasonable to disable nonboot CPUs after tasks have been frozen
> (I think it's also necessary for the CPU hotplugging with the help of the
> freezer; see below).
>=20
> I'll try to find a better solution later today.

Great.

> [Why, o why people don't test -mm kernels???  The patch that causes the p=
roblem
> has been in -mm since 2.6.20-rc2-mm1 and _nobody_ has reported any proble=
m
> with it until now.  Sigh.]

Sorry. It's hard enough to follow powerpc.git and keep my suspend
patches working on top of that.

> The idea is to freeze tasks every time before CPUs are hot(un)plugged.  T=
his
> way we can avoid nasty locking-related issues that have been haunting us
> for some time.  And yes, we are going to freeze all tasks for this purpos=
e,
> although it seems inefficient at first sight.

It's not like CPU hotplug is very frequent so that's perfectly fine to
me.

> Of course if we do it, the suspend code will have to be changed so that t=
he
> freezing of tasks related to the CPU hotplug doesn't interfere with the
> freezing of tasks related to the suspend in a destructive way.  Then, pro=
bably,
> the problem you have discovered will go away automatically.

Yeah, I agree that would probably fix it, but the freezer guarantee
becomes slightly less, you have some (most) tasks frozen and some then
need to exit the freezer again to cleanly exit. I'm not sure you can do
that w/o getting into possible trouble with locking, i.e. imagine the
cleanup-path needing to wait for completion of some other event from a
thread that's frozen... (not that I'm sure whether that's legal or not
anyway)

> For this reason I'd like to keep the ordering of code in disk.c as it is =
now,
> because something like

[...]

> seems to be more logical than any other ordering.

I used to think of CPU hotplug as a simple mechanism to avoid multi-CPU
problems so I was perfectly fine with disabling them very early during
suspend. I can't really see what problems ACPI might have with that
since the user can anyway do echo 0 > cpu3/online before suspend, no?

johannes

--=-7MrpWzujVwUcXQ/hz7vi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF301K/ETPhpq3jKURAsGLAKCmjya+Fwi7ZeFp64s3fkkOKj5kvQCgmOZ0
kKMH1OLFgzj//Q77CegrJfQ=
=GAho
-----END PGP SIGNATURE-----

--=-7MrpWzujVwUcXQ/hz7vi--


--===============0931394336==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0931394336==--
