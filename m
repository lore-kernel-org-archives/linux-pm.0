From: Johannes Berg <johannes@sipsolutions.net>
Subject: what can we do with frozen processes (or: calling sync
	with	processes frozen)
Date: Sun, 18 Mar 2007 00:21:58 +0100
Message-ID: <1174173718.13027.0.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0795879710=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============0795879710==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ThdU8JXk0tppWQiOvhFN"


--=-ThdU8JXk0tppWQiOvhFN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

When on vacation I was doing a bit more stuff w/o battery and noticed
that I after my patches to implement proper pm_ops for PMU-based
machines the machine would hang during suspend. Now on the way back I'm
sitting in a train and it's working again. Couldn't really be the lower
atmospheric pressure causing it ;) So I looked again and realised that
when writing those patches I thought doing sys_sync() in the ->prepare
callback would be a good idea. It is, as it turns out, not such a great
idea at all, right now anyway.

When laptop mode is enabled [1], xfs will, upon getting a sync, try to
wake up one of it's tasks and then wait for something that task does (as
far as I can tell.) Even though I carry the patch to make xfs's
workqueues non-freezable this event doesn't seem to happen when
processes are frozen and so the system hangs. Not sure why that is but
it isn't really the point right now, read on.

I have now removed the call to sys_sync() to double-verify and that has
indeed cured the problem, but the bigger question really is whether it
should be safe to call it or not [2], especially given that it would
make sense to call it when processes can no longer submit IO.

The real thing we should be doing is think about a whole range of things
you can do in the kernel and then think about whether they should be
allowed to be done in the various stages. A lot of these things are at
least somewhat documented for early boot stages (and you get into
trouble when you do it wrong) but it seems that many developers never
suspend their machines so this needs to be documented in a more explicit
way rather than just breaking when you try (bootup is part of regular
testing routine in an obvious way that suspend isn't)

Yup, this is a lot of hard work, but it could be done gradually as we
run into these problems.

Back to the specific sys_sync() issue, what do people feel is
appropriate? Should XFS get into even more trouble? It seems not to be
able to guarantee full sync when processes are frozen right now, at
least not the way sync is currently implemented.

johannes


[1] which explains why I never really saw this at home because there I
boot with power plugged in and don't enable laptop mode manually while
on vacation I booted w/o power and laptop mode was enabled at boot

[2] actually, another question is why whatever condition xfs waits for
never happens, but something is apparently frozen that it is waiting for
even though I've made the workqueues we had problems with earlier
non-freezable

--=-ThdU8JXk0tppWQiOvhFN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF/HgW/ETPhpq3jKURAs7fAKCSFOk0Ic+o8lksKXaRChvZUPrgtQCcCjO2
tvpMWB3FD7dgLJY/n5aVotY=
=9wyz
-----END PGP SIGNATURE-----

--=-ThdU8JXk0tppWQiOvhFN--


--===============0795879710==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0795879710==--
