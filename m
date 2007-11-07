From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC] Add the "icebox"
Date: Wed, 07 Nov 2007 16:54:53 +0100
Message-ID: <1194450893.4470.51.camel@johannes.berg>
References: <Pine.LNX.4.44L0.0711071036540.4444-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8667409887049421007=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0711071036540.4444-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============8667409887049421007==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-5goljiisFof8z06XjtpC"


--=-5goljiisFof8z06XjtpC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> The idea was that kernel threads would have a PM-notifier routine and
> would be sent to the icebox when the routine gets a
> PM_{HIBERNATION|SUSPEND|RESTORE}_PREPARE message.  Presumably the
> notifier routine wouldn't return until the thread was safely on its way
> to the icebox.
>=20
> You are correct that this would require some additional locking, plus=20
> the extra notifier routine, plus ways to handle timeouts, plus maybe=20
> some other stuff.  That's why I said in my earlier message that=20
> keeping the freezer around for these sorts of threads would be a good=20
> idea -- it would avoid all this new overhead.

Ok, makes sense, thanks for the explanation.

> The icebox would still be useful, however, for user tasks that try to
> do I/O after a system-sleep transition has begun.  Right now this can't
> happen, thanks to the freezer (except that it _can_ happen on PPC where
> the freezer isn't used for suspend).  Once the freezer no longer
> affects user tasks, kernel drivers will have to do _something_ when a
> user task submits an I/O request during a system sleep.  That
> "something" will be to go to the icebox.

Right, ok. I wish I could change powerpc, I've been maintaining a patch
for months now, but Paul seems to be dead set against it. Not only does
that fix these things, but also we get to use the /sys/power/state
API...

johannes

--=-5goljiisFof8z06XjtpC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARzHfzKVg1VMiehFYAQLV1w//ST3JvSZ3CNBt1l6O1Sc1XVDQCrWF3r0h
Rt/1F/fMyIF4lHHTUFg2mSP2mVRd7S/8hZwGYxLdHUUuMtZp/P7Wr09w0TlGbWgQ
D1FoDDN2a5lUSNZ2WEZzctMauLa3zxPj0kAEWQpCsDUBHWZtF0UJogIhrUy6lWlS
D360VwIN4EEjFTa3o/LBHbD8C73vvdddan99jpqFrdfjNZQwEWc5GLP6K5LJjHND
9f+SLl3bQxLH+j25vBGZMHSDxoTMGWJXRfXC35tefhp24bG5vGxxOf6l94K5SMpK
EeGqWRJvC2SCLAzRBrZvx23kSFgqi8eiwrirg0sXz8zYM1jF1LAb2IoMucb4Oklz
NvZWsz3iCp0tyOe2FHj4fVUJHq15bBtnF+sF0RD2lfghzDa96xOo4/L4RZkIkwRV
kf/XOm0dhnWMA04NeUp/hiBG/dbwwn0TY2M9AcIdNoCh40XaP+4rcSw9IOysHx7x
/dqLQi4efOC952isrMItCeCLyL1F6q6bGgmnHZzJr0dRYbe5e0LPKPGRL/plwakp
A7V+WyVSXv0nLa0562nIzzhdTsTzkHkT8LMzlb6JCygwskRTSQXdRIi8Ex6DfgSl
jxabMfgeuf+zyK+HZ6lU+yypxJ0/TzVeTpXBis9v76DqQKUVZWy2OQGmTWh9cTCY
7ahdSWGiWOM=
=eRxV
-----END PGP SIGNATURE-----

--=-5goljiisFof8z06XjtpC--


--===============8667409887049421007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8667409887049421007==--
