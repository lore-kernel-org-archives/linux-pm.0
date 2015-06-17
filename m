From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.1-rc7: Xorg broken after resume on thinkpad T40p, radeon
 problem?
Date: Wed, 17 Jun 2015 15:21:21 +0200
Message-ID: <20150617132121.GA24634@amd>
References: <20150617124347.GA22879@amd>
 <20150617124949.GA22953@amd>
 <5581711D.6030707@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38570 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754644AbbFQNVX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jun 2015 09:21:23 -0400
Content-Disposition: inline
In-Reply-To: <5581711D.6030707@amd.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, alexander.deucher@amd.com, rjw@rjwysocki.net, lenb@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Wed 2015-06-17 15:07:41, Christian K=F6nig wrote:
> On 17.06.2015 14:49, Pavel Machek wrote:
> >On Wed 2015-06-17 14:43:47, Pavel Machek wrote:
> >>Hi!
> >>
> >>Video is broken on thinkpad T40p after resume from suspend. (In X
> >>only, text console still works.)
> >>
> >>Maybe this is related?
> >>
> >>[ 5430.193071] radeon 0000:01:00.0: putting AGP V2 device into 4x m=
ode
> >>[ 5430.193107] radeon 0000:01:00.0: GTT: 256M 0xD0000000 - 0xDFFFFF=
=46F
> >>[ 5430.214670] radeon 0000:01:00.0: WB disabled
> >>[ 5430.214675] radeon 0000:01:00.0: fence driver on ring 0 use gpu =
addr 0x00000000d0000000 and cpu addr 0xf841a000
> >>[ 5430.214721] [drm] radeon: ring at 0x00000000D0001000
> >>[ 5430.370867] [drm:r100_ring_test] *ERROR* radeon: ring test faile=
d (scratch(0x15E8)=3D0xCAFEDEAD)
> >>[ 5430.370869] [drm:r100_cp_init] *ERROR* radeon: cp isn't working =
(-22).
> >>[ 5430.370872] radeon 0000:01:00.0: failed initializing CP (-22).
> >>
> >>Hibernation works well here, including X. (Which has small glitch w=
ith
> >>mouse cursor being corrupted until it is changed by application).
> >>
> >3.16.0-4-686-pae Debian 3.16.7-cktt11-1 kernel seems to have same
> >problem, with same scratch(0x15E8)=3D0xCAFEDEAD message... so this i=
s
> >not "new" problem...
> >

> Looks like CP init doesn't work. Well is there any kernel where that =
did
> worked?

Unfortunately, not as far as I know.

> If yes it might be a good idea to bisect to narrow down the problem.

No such luck. I may try something like "3.0" if we are really
desperate (2.6.X kernels probably won't won't boot with recent
userland), but I suspect it just never worked.

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
