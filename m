From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: SMP suspend broken due to "swsusp: Change code
	ordering in	disk.c" et al.
Date: Fri, 23 Feb 2007 13:17:56 +0100
Message-ID: <1172233076.3870.26.camel@johannes.berg>
References: <1172201385.15769.32.camel@johannes.berg>
	<200702231254.47009.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0396900483=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200702231254.47009.rjw@sisk.pl>
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


--===============0396900483==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-hlBUJIF2/ruXnWdi3w9C"


--=-hlBUJIF2/ruXnWdi3w9C
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

[correcting address for Nigel]

Hi Rafael,

> Hm, the only freezable workqueues I was aware of were those in XFS.

Well, I have an XFS root fs. In fact, the one that was mostly causing it
was the xfs one, but I'm not sure it was all the time. The same bug
happens at resume time (if I manually offline all nonboot CPUs before
suspend), at which point I couldn't tell whether it was XFS or something
else.

> Moreover, the patch has got _a_ _lot_ of testing on SMP on x86_64
> and I believe it works for people on i386 too.  So the workqueues in ques=
tion
> seem to be architecture-specific.  Is that correct?

There could be some arch-specific workqueues as well, but at least in
one case I saw xfsdatad causing it.

> > (1) would work, but also only punts the problem until someone wants to
> > do multi-threaded suspend (as if...).
>=20
> It will also break symmetry with the resume code that has to be like this
> because of ACPI-related issues.

Ok. I don't have any ACPI issues due to the lack of ACPI ;)

> > (2a) would sort-of work, but what if someone unplugs a CPU while the
> > system is suspended [will that even work]? the thread would get really
> > stuck there, bound to a CPU that no longer exists.
>=20
> Right now we are working on using the task freezer for CPU hotplugging an=
d if
> that works, this won't be an issue.

Care to elaborate? It doesn't seem to make sense to freeze tasks that
are running on some other CPU if that one is going offline, but I'm
probably misunderstanding you here.
=20
> I'd like to first understand why the workqueues in question here are free=
zable.

I don't think that matters much. We can't have freezable per-CPU
workqueues and then forbid using them.

> Could you please check if the appended patch (on top of the commit you ha=
ve
> reverted) changes anything?

I can give it a go, but it doesn't look as though it'd help. It still
freezes all threads before disabling CPUs, and my debugging certainly
pinpointed to kthread_stop() in the workqueue.

johannes

--=-hlBUJIF2/ruXnWdi3w9C
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF3tt0/ETPhpq3jKURAgaYAJ9SMrARGO6JsRrbMSj95ZJA64+QtgCfQR+U
y2wL933dcYHxaaKghna5LdM=
=Zv0m
-----END PGP SIGNATURE-----

--=-hlBUJIF2/ruXnWdi3w9C--


--===============0396900483==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0396900483==--
