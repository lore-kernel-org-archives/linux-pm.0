From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: 4.1-rc7: Xorg broken after resume on thinkpad T40p, radeon
 problem?
Date: Wed, 17 Jun 2015 15:50:17 +0200
Message-ID: <1434549017.2400.3.camel@x220>
References: <20150617124347.GA22879@amd> <20150617124949.GA22953@amd>
	 <5581711D.6030707@amd.com> <20150617132121.GA24634@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150617132121.GA24634@amd>
Sender: linux-acpi-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org, alexander.deucher@amd.com, rjw@rjwysocki.net, lenb@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2015-06-17 at 15:21 +0200, Pavel Machek wrote:
> On Wed 2015-06-17 15:07:41, Christian K=C3=B6nig wrote:
> > On 17.06.2015 14:49, Pavel Machek wrote:
> > >On Wed 2015-06-17 14:43:47, Pavel Machek wrote:
> > >>Hi!
> > >>
> > >>Video is broken on thinkpad T40p after resume from suspend. (In X
> > >>only, text console still works.)
> > >>
> > >>Maybe this is related?
> > >>
> > >>[ 5430.193071] radeon 0000:01:00.0: putting AGP V2 device into 4x=
 mode
> > >>[ 5430.193107] radeon 0000:01:00.0: GTT: 256M 0xD0000000 - 0xDFFF=
=46FFF
> > >>[ 5430.214670] radeon 0000:01:00.0: WB disabled
> > >>[ 5430.214675] radeon 0000:01:00.0: fence driver on ring 0 use gp=
u addr 0x00000000d0000000 and cpu addr 0xf841a000
> > >>[ 5430.214721] [drm] radeon: ring at 0x00000000D0001000
> > >>[ 5430.370867] [drm:r100_ring_test] *ERROR* radeon: ring test fai=
led (scratch(0x15E8)=3D0xCAFEDEAD)
> > >>[ 5430.370869] [drm:r100_cp_init] *ERROR* radeon: cp isn't workin=
g (-22).
> > >>[ 5430.370872] radeon 0000:01:00.0: failed initializing CP (-22).
> > >>
> > >>Hibernation works well here, including X. (Which has small glitch=
 with
> > >>mouse cursor being corrupted until it is changed by application).
> > >>
> > >3.16.0-4-686-pae Debian 3.16.7-cktt11-1 kernel seems to have same
> > >problem, with same scratch(0x15E8)=3D0xCAFEDEAD message... so this=
 is
> > >not "new" problem...
> > >
>=20
> > Looks like CP init doesn't work. Well is there any kernel where tha=
t did
> > worked?
>=20
> Unfortunately, not as far as I know.
>=20
> > If yes it might be a good idea to bisect to narrow down the problem=
=2E
>=20
> No such luck. I may try something like "3.0" if we are really
> desperate (2.6.X kernels probably won't won't boot with recent
> userland), but I suspect it just never worked.

The above looks very much like the issue that made me write commit
45171002b01b ("radeon: add AGPMode 1 quirk for RV250"). See
https://bugzilla.redhat.com/show_bug.cgi?id=3D531825 for a lot of
background.

Does booting with radeon.agpmode=3D1 survive a suspend and resume cycle=
?

Hope this helps,


Paul Bolle

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
