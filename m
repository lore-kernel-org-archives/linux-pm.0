From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: suspend-to-ram fails resume.
Date: Tue, 21 Feb 2006 09:37:12 +1000
Message-ID: <200602210937.16338.ncunningham@cyclades.com>
References: <43EE824B.20609@superbug.co.uk>
	<20060215233300.GB3490@openzaurus.ucw.cz>
	<43F8B1DC.7060204@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============31711728660941674=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <43F8B1DC.7060204@superbug.co.uk>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============31711728660941674==
Content-Type: multipart/signed; boundary="nextPart7777127.JDM8HYtsaV";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart7777127.JDM8HYtsaV
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Monday 20 February 2006 03:58, James Courtier-Dutton wrote:
> Pavel Machek wrote:
> >> "hibernate" and restore to/from disk works fine.
> >> I have been trying to resume after running a "hibernate-ram" script.
> >> Just using a text console, no X.
> >>
> >> I attach a log with comments in it.
> >> I have a Nvidia FX5200 video card.
> >>
> >> After resume the display is blank. ping works from a remote machine, b=
ut
> >> ssh does not work.
> >>
> >> What can I do to help diagnose this problem?
> >
> > get video to work - see Doc*/power/video.txt and see
> > what are last messages on console.
>
> I have sort of solved my problem.
> I can exit from suspend ok now, but I have to disable the detection of
> the power button in the /etc/acpi scripts.
> So, I now need some way of disabling detection of the power button while
> it is exiting from suspend.
> Does anyone have any ideas how to?

Is it doing an init 0 because of the power button press? If so, you might t=
ry=20
one or both of the following:

=2D Remove the acpi button module while suspending.
=2D Assuming this is the result of an acpi event, edit the /etc/acpi* file=
=20
that's telling acpi to shutdown when it sees the power button press.

Hope that helps!

Nigel

--nextPart7777127.JDM8HYtsaV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD+lKsN0y+n1M3mo0RAorXAJ9gmz4cHlT1qMBpz9qqbpApUoFrdwCg9L01
kUBjIl46A5vhYdVFc7m9eKg=
=B7l0
-----END PGP SIGNATURE-----

--nextPart7777127.JDM8HYtsaV--

--===============31711728660941674==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============31711728660941674==--
