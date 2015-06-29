From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3] ARM: tegra: cpuidle: implement
 cpuidle_state.enter_freeze()
Date: Mon, 29 Jun 2015 11:00:51 +0200
Message-ID: <20150629090050.GD5431@ulmo>
References: <1432046953-12945-1-git-send-email-tomeu.vizoso@collabora.com>
 <1773599.T1QStsTFTH@vostro.rjw.lan>
 <CAAObsKCURyo-ujcA7r+UYqSw6ie-aBxKiYEdTKwe-HrL14RkBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3Pql8miugIZX0722"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33359 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbbF2JCB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2015 05:02:01 -0400
Content-Disposition: inline
In-Reply-To: <CAAObsKCURyo-ujcA7r+UYqSw6ie-aBxKiYEdTKwe-HrL14RkBw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Russell King <linux@arm.linux.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Ingo Molnar <mingo@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--3Pql8miugIZX0722
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2015 at 09:09:29AM +0200, Tomeu Vizoso wrote:
> On 21 May 2015 at 03:02, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, May 19, 2015 04:49:12 PM Tomeu Vizoso wrote:
> >> This callback is expected to do the same as enter() but it has to
> >> guarantee that interrupts aren't enabled at any point in its execution,
> >> as the tick is frozen.
> >>
> >> It will be called when the system goes to suspend-to-idle and will
> >> reduce power usage because CPUs won't be awaken for unnecessary IRQs.
> >>
> >> By setting the CPUIDLE_FLAG_TIMER_STOP flag, we can reuse the same code
> >> for both the enter() and enter_freeze() callbacks.
> >>
> >> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> >> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Makes sense to me, but I suppose it should go in via arm-soc.
>=20
> Hi Thierry,
>=20
> what's the plan regarding merging of this patch?
>=20
> It needs df8d9ee ("cpuidle: Run tick_broadcast_exit() with disabled
> interrupts") so it doesn't break boot.

By the looks of it the above patch was merged in 4.1, so I can easily
take this through the Tegra tree. The commit message doesn't say whether
or not this fixes a bug. Is this urgent? Should it go into 4.2? It
sounds more like it's a power-saving feature, so 4.3 is probably more
appropriate.

Thierry

--3Pql8miugIZX0722
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVkQlCAAoJEN0jrNd/PrOhQQoQAJFvfaNF3piS4LsRG3dageuk
6gjX6u4fttI0fxpjU4VWyrAMJab8tkOkK1JDnoBTzY+7VEpWpjU2fprpb9qhOzus
RONdi7FrehtEIM4GOvBsXdvrRY4sgmDlQ5D3yXQmyJQTmDjcwXREhc/YPo75OXcp
3kuk4M8O3yLllCpEYCu0RrlRfGjKTYv5efKggYOXStCQBMGDYh2N0reak6khfWdD
664rQpTUmvc17fCmjivrAKg6zgRvQATl0y3j+sqKuL964qFGOiiN0xkUgdilmb6Z
z95M7fMUwMajAj1OhUyu5KMzIeExSyGJFsIAVlx/7yu6a6f5J0hBFKxaplcOn8T2
GHdDtxBrXpW+va2SHN7JKPFN7p6DWA44NSr0PsqJKeuCcfyUL9B5X0b69N6gxVsO
Ve3snp9gW3YaPq71BbEM8I7axBrMMEmR5vWantvuEER3kueycxN9QU2NjE3GbEmm
mvuG8XveHisUjtRujxtxgSch1z1Vk3rYBWKx627Pv18vpWV7AmV1pW9cQN5CGB6N
r1LYBJaUTd+ZbDYLvNvdDLX95jM/oYS311iFTw7VZHIRzi4zTS4XWjBiwMao9DdQ
A/MYZqSKQqvA4s8OusTbXDgeyXS7bMNDU3LnX2Z5qZkdHf6B5O/sa3BegNGQnSNi
Wd3f8Xw8g9BY1pWmFjJJ
=QxQk
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--
