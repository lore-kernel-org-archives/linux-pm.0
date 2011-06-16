From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: ASUS K53E fails to suspend if ehci_hcd is loaded
Date: Fri, 17 Jun 2011 02:12:28 +0600
Message-ID: <20110616201228.GG7253__39717.2321602286$1308261851$gmane$org@belkar.wrar.name>
References: <20110616190600.GD7253@belkar.wrar.name>
	<Pine.LNX.4.44L0.1106161547370.1697-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6736363654072700585=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1106161547370.1697-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, linux-usb@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--===============6736363654072700585==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="reI/iBAAp9kzkmX4"
Content-Disposition: inline


--reI/iBAAp9kzkmX4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 16, 2011 at 03:52:02PM -0400, Alan Stern wrote:
> > When I try to suspend my ASUS K53E laptop, the process hangs after
> > spinning down the disk unless I unload ehci_hcd. This happens on 2.6.38,
> > 2.6.39 and 3.0-rc3+. Some details are at
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D37632
> > What additional info can I provide to help fix this if this is possible?
> Set CONFIG_USB_DEBUG=3Dy and boot with "no_console_suspend" on the=20
> command line.  What appears on the console when the system is hung?

PM: Entering mem sleep
usb usb2: usb auto-resume
sd blah-blah syncing cache
ehci_hcd 0000:00:1d.0: resume root hub
usb 1-1.1: usb suspend
sd blah-blah stopping disk
hub 1-1:1.0: hub_suspend
usb 1-1: unlink qh256-0001/ffff88013b411000 start 1 [1/0 us]
usb 1-1: usb suspend


and that's all.

--=20
WBR, wRAR

--reI/iBAAp9kzkmX4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJN+mOrAAoJEDNi9wMaSZLhHKkP/iJEnzUIGlUye25Ej3WoRLxy
sFCWUQgDNng6pMcKLGp1q/3q/2c4wY8qtWBumoZ7KPBSq6RElOicd5BVLGogy1CA
ha4Qf9Hsg+ygHIY0CjmIDFDvJ3C6cVkYY5i7A3qceDoViWtMJeG+qgOzlkokBgzZ
UBm4a84/RtW8IF8zM2AAlDJp9hm3ozbs/WCVV8tNrXxGmc9Yfjf+frLRbeEXgmNN
rAFto9nYwlHZcZokSdttOqC2mPNHcCS9LyfRA2G19WxtzAgpzqCeTqwLctSFyIjj
B9XthDhLBbcWY1uGXnbPLSd+9NpxHjYGGHZZv/h3ZBhbNDf68RVKDdhLnLHgVAyP
EiCNrszdf6OKTnzwACt8vOgB1PI95Fg2Keom9YC4O+kCxbpk+q677GxD+a2lDquM
AvVR5m73zKu4NsaN8BzTowMGoJYfvJ8dyMg+pV8I866aOlGIFEx83EpiihuaoeK3
sSK4OQbsVXXbW9MtoJpaMPRMZRAXLjz/zUFFJNSJXS/WNGG/CFlmpw1a8Gzp/Swo
WghGDmyjq/oqeH3FJ1iGxRe2OaliUILqJugTZ2zbjmQ6cfPKDZHEKo2e80H6LFOe
HKLBgOqXFx1fz15eW0oB4ixZ2XK1Nre+7PNDnMrPmHjXJqpVuPT2k1lHbTCePNpw
ufTMWGZxTfTFAtQ9ns1x
=Jm1H
-----END PGP SIGNATURE-----

--reI/iBAAp9kzkmX4--

--===============6736363654072700585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6736363654072700585==--
