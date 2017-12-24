From: Pavel Machek <pavel@ucw.cz>
Subject: [regression] Re: Thinkpad T40p: suspend to ram stopped working
 sometime before 4.14
Date: Sun, 24 Dec 2017 19:17:40 +0100
Message-ID: <20171224181740.GA26326@amd>
References: <20171224114921.GA9891@amd>
 <58258946.1WsWlzHmoT@aspire.rjw.lan>
 <20171224152232.GA30077@amd>
 <20171224153624.GA22377@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50367 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751089AbdLXSRm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Dec 2017 13:17:42 -0500
Content-Disposition: inline
In-Reply-To: <20171224153624.GA22377@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, gregkh@linuxfoundation.org, kyle@kernel.org, akpm@linux-foundation.org, mmarek@suse.com, yamada.masahiro@socionext.com, dwmw2@infradead.org
Cc: kernel list <linux-kernel@vger.kernel.org>, len.brown@intel.com, linux-pm@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > 4.15-rcX is broken, but that had other problems so lets not go ther=
e.
> > > >=20
> > > > 4.14 is broken.
> > >=20
> > > And what exactly does happen?
> >=20
> > Suspend looks ok. I believe there's some reaction to power button, but
> > screen stays blank. I'll re-check that.. I'm in the middle of bisect
> > now.
>=20
> Ok, so suspend looks ok. On resume, "moon" LED goes off and power /
> bluetooth LEDs go on, but screen is black and no response to
> > > > anything.

And it seems bad commit is

commit 5620a0d1aacd554ebebcff373e31107bb1ef7769
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Thu Sep 14 14:23:01 2017 -0700

    firmware: delete in-kernel firmware

Unfortuantely, it does not revert cleanly.

lspavel@hobit:~$ lspci
00:00.0 Host bridge: Intel Corporation 82855PM Processor to I/O
Controller (rev 03)
00:01.0 PCI bridge: Intel Corporation 82855PM Processor to AGP
Controller (rev 03)
00:1d.0 USB controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01)
00:1d.1 USB controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01)
00:1d.2 USB controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01)
00:1d.7 USB controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M)
USB2 EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface
Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE
Controller (rev 01)
00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
SMBus Controller (rev 01)
00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
AC'97 Modem Controller (rev 01)
01:00.0 VGA compatible controller: Advanced Micro Devices,
Inc. [AMD/ATI] RV250/M9 GL [Mobility FireGL 9000/Radeon 9000] (rev 02)
02:00.0 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus
Controller (rev 01)
02:00.1 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus
Controller (rev 01)
02:01.0 Ethernet controller: Intel Corporation 82540EP Gigabit
Ethernet Controller (Mobile) (rev 03)
02:02.0 Ethernet controller: Qualcomm Atheros AR5211 Wireless Network
Adapter [AR5001X 802.11ab] (rev 01)
pavel@hobit:~$

5620a0d1aacd554ebebcff373e31107bb1ef7769 contains:

 firmware/radeon/R200_cp.bin.ihex            |  130

=2E.maybe that's the reason?

								Pavel

# bad: [eb3b451f8b5a6eb0ebe09ff0f79937977f985a36] Configuration for final v=
4.14
# good: [9fd3408ca15f4018466e87255ab2644f54de1c1c] "Definitely say Y... so =
it should be default."
git bisect start 'my-v4.14' 'my-v4.13'
# good: [088eb54dfadd2cdaeb50969fadda4ecfd8d490c2] Date: Wed, 6 Sep 2017 09=
:03:47 +0300 From: Adrian Hunter <adrian.hunter@intel.com> To: Shawn Lin <s=
hawn.lin@rock-chips.com>, Pavel Machek <pavel@ucw.cz>,         linux-mmc@vg=
er.kernel.org 	Cc: kernel list <linux-kernel@vger.kernel.org>, Seraphime 	K=
irkovski <kirkseraph@gmail.com> 	Subject: Re: 4.13 on thinkpad x220: oops w=
hen writing to SD 	card
git bisect good 088eb54dfadd2cdaeb50969fadda4ecfd8d490c2
# good: [15d8ffc96464f6571ecf22043c45fad659f11bdd] Merge tag 'mmc-v4.14' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
git bisect good 15d8ffc96464f6571ecf22043c45fad659f11bdd
# good: [e90937e756938f03d37d4cae7c82316a3a425944] Merge tag 'armsoc-device=
tree' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect good e90937e756938f03d37d4cae7c82316a3a425944
# bad: [93b5533ab58d635968ebb0939fe90f3b022601af] Merge tag 'pci-v4.14-fixe=
s-3' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci
git bisect bad 93b5533ab58d635968ebb0939fe90f3b022601af
# bad: [9db59599ae502b38b27cff6462273f84acd59927] Merge tag 'for-linus' of =
git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect bad 9db59599ae502b38b27cff6462273f84acd59927
# good: [561a8eb3e1d219f415597c76dae44b530b7f961a] Merge tag 'rtc-4.14' of =
git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux
git bisect good 561a8eb3e1d219f415597c76dae44b530b7f961a
# good: [939ae58960bb5ce0c51776aec38877a401c03bcf] Merge git://www.linux-wa=
tchdog.org/linux-watchdog
git bisect good 939ae58960bb5ce0c51776aec38877a401c03bcf
# good: [e7cdb60fd28b252f1c15a0e50f79a01906124915] Merge branch 'zstd-minim=
al' of git://git.kernel.org/pub/scm/linux/kernel/git/mason/linux-btrfs
git bisect good e7cdb60fd28b252f1c15a0e50f79a01906124915
# good: [9e0ce554b039e3df288d83189ecf226c16da04af] Merge branch 'work.misc'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect good 9e0ce554b039e3df288d83189ecf226c16da04af
# good: [4c0b4bc60f95de4741c89b41174760258343f091] kvm,mips: Fix potential =
swait_active() races
git bisect good 4c0b4bc60f95de4741c89b41174760258343f091
# good: [30db202e54d251e4887935f7b4538b44911bb091] Merge tag 'for-linus-4.1=
4-ofs2' of git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux
git bisect good 30db202e54d251e4887935f7b4538b44911bb091
# good: [866a30efdcb63a330b480600d0b501547f9a5a58] Merge tag 'nios2-v4.14-r=
c1' of git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2
git bisect good 866a30efdcb63a330b480600d0b501547f9a5a58
# good: [4f350c6dbcb9000e18907515ec8a7b205ac33c69] kvm: nVMX: Handle deferr=
ed early VMLAUNCH/VMRESUME failure properly
git bisect good 4f350c6dbcb9000e18907515ec8a7b205ac33c69
# bad: [b38923a068c10fc36ca8f596d650d095ce390b85] Merge tag 'firmware_remov=
al-4.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver=
-core
git bisect bad b38923a068c10fc36ca8f596d650d095ce390b85


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlo/70QACgkQMOfwapXb+vIwiACgsrhq2LjvxFoZJB2YwpnnXIth
R60AnR0x2xw9wcFElHLaVW7vX7RrDURy
=/Mo9
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
