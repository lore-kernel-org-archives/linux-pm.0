From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: SMP suspend broken due to "swsusp: Change code
	ordering in	disk.c" et al.
Date: Fri, 23 Feb 2007 14:31:59 +0100
Message-ID: <1172237519.3870.34.camel@johannes.berg>
References: <1172201385.15769.32.camel@johannes.berg>
	<200702231254.47009.rjw@sisk.pl>
	<1172233076.3870.26.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0195838688=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1172233076.3870.26.camel@johannes.berg>
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


--===============0195838688==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-VIZiNrgGo01JIhg04xFK"


--=-VIZiNrgGo01JIhg04xFK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-02-23 at 13:19 +0100, Johannes Berg wrote:

> I can give it a go, but it doesn't look as though it'd help. It still
> freezes all threads before disabling CPUs, and my debugging certainly
> pinpointed to kthread_stop() in the workqueue.

As expected, it prints:
CPU#1 offline
CPU 1 dead (my message when it goes into the dead loop)
kthread_stop: stopping migration/1
kthread_stop: stopping ksoftirq/1
kthread_stop: stopping watchdog/1
kthread_stop: kcryptd/1
kthread_stop: stopping xfsdatad/1

and then hangs.

johannes

--=-VIZiNrgGo01JIhg04xFK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF3uzP/ETPhpq3jKURAtTyAJ9ZJbtkEop3ALhukxfMkmPNAhzv1wCfbg8b
RbFYk3sjGCrpfGXCrb8SsZE=
=OFwO
-----END PGP SIGNATURE-----

--=-VIZiNrgGo01JIhg04xFK--


--===============0195838688==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0195838688==--
