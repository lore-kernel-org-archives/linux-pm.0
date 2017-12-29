From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.15-rc5: resume took way too long, warning in syslog
Date: Fri, 29 Dec 2017 23:04:26 +0100
Message-ID: <20171229220426.GA3485@amd>
References: <20171229155714.GA30656@amd>
 <Pine.LNX.4.44L0.1712291119210.24019-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1712291119210.24019-100000@netrider.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-pm mailing list <linux-pm@vger.kernel.org>, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-12-29 11:23:36, Alan Stern wrote:
> On Fri, 29 Dec 2017, Pavel Machek wrote:
>=20
> > Hi!
> >=20
> > v4.15-rc5.. resume took _way_ too long, and I have warn_on in dmesg as
> > a bonus. It looks like USB problem...? I never seen this before.
>=20
> Is this problem very repeatable?  Is there any possibility of bisecting=
=20
> to find the cause?

It is first time this happened.. Let me see if it reappears.

But I start to get feeling, that something like this is simply going
to happen from time to time... USB hubs are not exactly high-quality
parts, EMI, ...

									Pavel



> > [42269.489765] usb 1-1.3: reset full-speed USB device number 3 using eh=
ci-pci
> > [42269.577806] ata2: SATA link down (SStatus 0 SControl 300)
> > [42269.577851] ata5: SATA link down (SStatus 0 SControl 300)
> > [42269.677809] usb 1-1.6: reset high-speed USB device number 4 using eh=
ci-pci
> > [42270.167923] psmouse serio1: synaptics: queried max coordinates: x [.=
=2E5472], y [..4448]
> > [42270.361825] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > [42270.363396] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) su=
cceeded
> > [42270.363404] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE =
LOCK) filtered out
> > [42270.363409] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) fi=
ltered out
> > [42270.366202] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) su=
cceeded
> > [42270.366209] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE =
LOCK) filtered out
> > [42270.366215] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) fi=
ltered out
> > [42270.367116] ata1.00: configured for UDMA/133
> > [42273.571626] e1000e: eth2 NIC Link is Up 100 Mbps Full Duplex, Flow C=
ontrol: Rx/Tx
> > [42273.571638] e1000e 0000:00:19.0 eth2: 10/100 speed: disabling TSO
> > [42274.421868] usb 2-1.1.4: reset high-speed USB device number 55 using=
 ehci-pci
> > [42279.541849] usb 2-1.1.4: device descriptor read/64, error -110
> > [42295.157864] usb 2-1.1.4: device descriptor read/64, error -110
> > [42295.345865] usb 2-1.1.4: reset high-speed USB device number 55 using=
 ehci-pci
> > [42300.533867] usb 2-1.1.4: device descriptor read/64, error -110
> > [42316.149843] usb 2-1.1.4: device descriptor read/64, error -110
> > [42316.337864] usb 2-1.1.4: reset high-speed USB device number 55 using=
 ehci-pci
> > [42327.029859] usb 2-1.1.4: device not accepting address 55, error -110
> > [42327.113863] usb 2-1.1.4: reset high-speed USB device number 55 using=
 ehci-pci
> > [42337.781888] usb 2-1.1.4: device not accepting address 55, error -110
>=20
> > [42337.913753] usb 2-1.1.4: new high-speed USB device number 56 using e=
hci-pci
> > [42338.395078] e1000e: eth2 NIC Link is Down
> > [42338.732172] systemd-journald[2470]: Received SIGTERM from PID 1 (sys=
temd).
> > [42339.679602] systemd[1]: Unit systemd-journald.service entered failed=
 state.
> > [42340.426957] systemd-journald[30462]: Received request to flush runti=
me journal from PID 1
> > [42343.029871] usb 2-1.1.4: device descriptor read/64, error -110
> > [42344.483918] e1000e: eth2 NIC Link is Up 100 Mbps Full Duplex, Flow C=
ontrol: Rx/Tx
> > [42344.483927] e1000e 0000:00:19.0 eth2: 10/100 speed: disabling TSO
> > [42358.645164] usb 2-1.1.4: device descriptor read/64, error -110
> > [42358.833023] usb 2-1.1.4: new high-speed USB device number 57 using e=
hci-pci
> > [42364.018463] usb 2-1.1.4: device descriptor read/64, error -110
> > [42379.626669] usb 2-1.1.4: device descriptor read/64, error -110
> > [42379.735177] usb 2-1.1-port4: attempt power cycle
> > [42380.338299] usb 2-1.1.4: new high-speed USB device number 58 using e=
hci-pci
>=20
> It sure looks like that USB device (or maybe the hub it was connected=20
> to) decided to stop working during the suspend.
>=20
> Alan Stern

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpGu+oACgkQMOfwapXb+vIV1QCguDYQAG16hZVLx/8LC8lfQzQl
fHsAoKWwzW1fQT05VGgjXC8G5dqJGn0O
=TY1G
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
