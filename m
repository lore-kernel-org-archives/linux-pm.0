From: Johannes Berg <johannes@sipsolutions.net>
Subject: SMP suspend broken due to "swsusp: Change code ordering
	in disk.c"	et al.
Date: Fri, 23 Feb 2007 04:29:45 +0100
Message-ID: <1172201385.15769.32.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1904933196=="
Return-path: <linux-pm-bounces@lists.osdl.org>
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
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Dave Vasilevsky <djvasi@gmail.com>, Pavel Machek <pavel@ucw.cz>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Nigel Cunningham <ncunningham@cyclades.com>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============1904933196==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-k/ZhSqc6Os+UlIDb3FFL"


--=-k/ZhSqc6Os+UlIDb3FFL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

After first debugging a while and then bisecting I found out why my quad
G5 won't suspend any longer.

Let me explain. The patch in question (committed as
ed746e3b18f4df18afa3763155972c5835f284c5, but the other ones around that
for other suspend methods will have the same problems) modifies the
suspend sequence to be like this:

freeze_processes
swsusp_shrink_memory
platform_prepare
device_suspend
disable_nonboot_cpus
[...]

while previously it was

disable_nonboot_cpus
freeze_processes
platform_prepare
swsusp_shrink_memory
[...]


The only thing I'm worried about here is the ordering of
freeze_processes vs. disable_nonboot_cpus. The problem with this new
ordering is with workqueues, specifically freezable per-CPU workqueues
which consist of one kthread per CPU, bound to a single CPU. Now, when
CPUs are hot-unplugged, the workqueue code (by having a cpu notifier
called) will kill the thread for the CPU that is being unplugged. If you
look into kernel/workqueue.c, you'll notice that this is done by a
regular kthread_stop() as one might expect.

However, and this is the problem, for any freezable workqueue, the
workqueue kthread will be frozen at this point! Hence, kthread_stop()
will wait forever for the thread to finish, blocking the suspend
process.

Now, as for a solution, I don't really have a great idea yet. We have a
bunch of things we could do:
 (1) simply change the ordering to disable nonboot CPUs much earlier
 (2a) teach kthread_stop() about frozen processes and that it doesn't
      need to wait for them because they'll die once they wake up again
 (2b) teach kthread_stop() about frozen processes modify the freezer to
      allow waking up a process that is destined to die
 (3) teach the workqueue code about suspend

Of these options,

(1) would work, but also only punts the problem until someone wants to
do multi-threaded suspend (as if...).

(2a) would sort-of work, but what if someone unplugs a CPU while the
system is suspended [will that even work]? the thread would get really
stuck there, bound to a CPU that no longer exists.

(2b) should be possible, but would require some sort of per-thread
exit-the-freezer API

(3) is icky

I think I prefer (2b) or alternatively (1). In any case, with the commit
mentioned above reverted, my quad G5 can suspend to disk again and I'm
happy that it isn't my fault ;)

johannes

--=-k/ZhSqc6Os+UlIDb3FFL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF3l+o/ETPhpq3jKURAq1QAKCBJ1m89nC5qeZx69TBBWE7WTtoZACdHXiI
YHWnU/QmeNZfcFTLy9N/vSM=
=V8iG
-----END PGP SIGNATURE-----

--=-k/ZhSqc6Os+UlIDb3FFL--


--===============1904933196==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1904933196==--
