From: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Wed, 26 Apr 2006 11:16:55 +1000
Message-ID: <200604261116.59070.nigel@suspend2.net>
References: <200604241429.52022.david-b@pacbell.net>
	<200604260818.20484.nigel@suspend2.net>
	<200604251655.01988.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============59393888102805459=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604251655.01988.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============59393888102805459==
Content-Type: multipart/signed; boundary="nextPart1722651.tCveOAWezB";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1722651.tCveOAWezB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 26 April 2006 09:55, David Brownell wrote:
> On Tuesday 25 April 2006 3:18 pm, Nigel Cunningham wrote:
> > I saw the 2 suspends, 1 resume comment in another part of the thread, b=
ut
> > don't believe a driver would be able to detect that 2 suspends and 1
> > resume call had been made - at least not without some non volatile ram.
>
> The extra suspend is just IMO a symptom of sloppiness, like a "here may be
> bugs" sign.  Not necessarily an issue in its own right.
>
> In fact if you count carefully, it's three suspends and one resume:  one
> suspend before calling swsusp_resume, one inside swsusp_resume -- replaced
> by my patch -- and a correctly matched pair in the kernel being resumed.

That doesn't sound right. Let' see - where's this third one?

			Real				Effective
SUSPEND

Pre-copy		suspend(freeze)		suspend(freeze)
			powerdown(freeze)	powerdown(freeze)

Post-copy		powerup
			resume

Powerdown	shutdown_prepare/kernel_power_off/...

RESUME

			bios & kernel init

Pre-restore		suspend(freeze)
			powerdown(freeze)

Post-restore	powerup			powerup
			resume			resume


> Raising two points:  (1) for those who think suspend is right, you can
> think of it as replacing one of the extra ones with
> kernel_restart_prepare(); and (2) not very much code interacts with that
> restart prep, that's a sane audit problem.
>
>
> Also, about non-volatile RAM.  Not necessary ... the device hardware holds
> all the relevant state.  The problem is that swsusp is now trashing it wi=
th
> those suspend calls before resuming the real kernel.  On the plus side, we
> already have code being used to resolve the identical issue for kexec(),
> and all my patch does is to use it.

If devices really do get powered down, then they won't retain the state. If=
=20
they don't actually powerdown, then I see your point.

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1722651.tCveOAWezB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBETsoLN0y+n1M3mo0RAtUfAJsGYM0DYPcbdWmoEZ09srnsHG7K8QCfYNgD
qH/Gcev2PIC4MaL2uVKVHFU=
=m5FF
-----END PGP SIGNATURE-----

--nextPart1722651.tCveOAWezB--

--===============59393888102805459==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============59393888102805459==--
