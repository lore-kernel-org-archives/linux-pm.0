From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re:
	=?iso-8859-1?q?=5BPATCH_2/2=5D_Fix_console_handling_du?=
	=?iso-8859-1?q?ring=09suspend/resume?=
Date: Sat, 24 Jun 2006 21:58:58 +1000
Message-ID: <200606242159.01731.ncunningham@linuxmail.org>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606232155160.6483@g5.osdl.org>
	<1151131283.10141.79.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0723515587=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1151131283.10141.79.camel@localhost.localdomain>
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
Cc: David Brownell <david-b@pacbell.net>, Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============0723515587==
Content-Type: multipart/signed; boundary="nextPart1325360.xhGecSPMXq";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1325360.xhGecSPMXq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Saturday 24 June 2006 16:41, Benjamin Herrenschmidt wrote:
> Also note that it might be useful to implement something I've been
> carrying around as a patch for debugging suspend on the mac, is what I
> call "fake suspend". I did it as a kernel argument that turns the real
> suspend into a fake suspend, but we should be smarter.
>
> The idea is, as I may have described already, to do the whole driver
> suspend/resume without actually putting the system to sleep in between
> (whatver you do to ACPI to go to S3, whatever I do to the PMU to finish
> the suspend process on macs). In addition, you can have the video device
> "mark" (with flags maybe) the device chain all the way up from the video
> device so that it's skipped by the suspend and resume calls. (that is
> the console is not actually suspended).
>
> That allows you to exercise pretty much 99% of the driver suspend and
> resume code. It's not perfect as the chips will usually never do the D3
> -> D3cold transition, and thus will not be in the same state on resume
> than with a real suspend, but it's already a lot.
>
> Then, you can do a script running fake suspend cycles over and over
> again, while doing things like playing MP3s out of a USB disk while
> copying files to an NFS server etc etc etc... and wait for it to
> crash :)

That would be useful, but it would be even more useful if you could reset=20
hardware to the boot-time configuration between the suspend and resume call=
s,=20
because that difference is what really causes the problems.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart1325360.xhGecSPMXq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEnSkFN0y+n1M3mo0RAt3dAKDm+wSjTZQSk4fgW26bahHUWS6mfwCePguP
mXdDvCzw/Wzro3Fk7OfTK1c=
=XceJ
-----END PGP SIGNATURE-----

--nextPart1325360.xhGecSPMXq--

--===============0723515587==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0723515587==--
