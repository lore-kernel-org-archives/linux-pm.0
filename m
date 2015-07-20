From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V3 02/19] memory: tegra: Add MC flush support
Date: Mon, 20 Jul 2015 11:17:44 +0200
Message-ID: <20150720091743.GO29614@ulmo>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-3-git-send-email-jonathanh@nvidia.com>
 <20150717095754.GG3057@ulmo>
 <20150717102049.GQ6287@tbergstrom-lnx.Nvidia.com>
 <20150717113124.GP3057@ulmo>
 <55ACB54A.4080103@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PtLnLSExlPr13a2X"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37504 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbbGTJR6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2015 05:17:58 -0400
Content-Disposition: inline
In-Reply-To: <55ACB54A.4080103@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Prashant Gaikwad <pgaikwad@nvidia.com>, Terje =?utf-8?Q?Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>, Vince Hsu <vinceh@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


--PtLnLSExlPr13a2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2015 at 09:46:02AM +0100, Jon Hunter wrote:
>=20
> On 17/07/15 12:31, Thierry Reding wrote:
> > * PGP Signed by an unknown key
> >=20
> > On Fri, Jul 17, 2015 at 01:20:49PM +0300, Peter De Schrijver wrote:
> >> On Fri, Jul 17, 2015 at 11:57:55AM +0200, Thierry Reding wrote:
> >>>> Old Signed by an unknown key
> >>>
> >>> On Mon, Jul 13, 2015 at 01:39:40PM +0100, Jon Hunter wrote:
> >>>> The Tegra memory controller implements a flush feature to flush pend=
ing
> >>>> accesses and prevent further accesses from occurring. This feature is
> >>>> used when powering down IP blocks to ensure the IP block is in a good
> >>>> state. The flushes are organised by software groups and IP blocks are
> >>>> assigned in hardware to the different software groups. Add helper
> >>>> functions for requesting a handle to an MC flush for a given
> >>>> software group and enabling/disabling the MC flush itself.
> >>>>
> >>>> This is based upon a change by Vince Hsu <vinceh@nvidia.com>.
> >>>>
> >>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> >>>> ---
> >>>>  drivers/memory/tegra/mc.c | 110 +++++++++++++++++++++++++++++++++++=
+++++++++++
> >>>>  drivers/memory/tegra/mc.h |   2 +
> >>>>  include/soc/tegra/mc.h    |  34 ++++++++++++++
> >>>>  3 files changed, 146 insertions(+)
> >>>
> >>> Do we know if this is actually necessary? I remember having a discuss=
ion
> >>> with Arnd Bergmann a while ago, and the Linux driver model kind of
> >>> assumes that by the time a device is disabled all outstanding accesses
> >>> will have stopped.
> >>>
> >>> Do we have a way to determine that this even makes a difference? Can =
we
> >>> trigger a case where not doing this would cause breakage and see that
> >>> adding this fixes that particular issue?
> >>>
> >>
> >> Most likely it is. The memory controller can still be processing reque=
sts
> >> when the peripheral domain is powergated. This would mean the response=
 cannot
> >> be delivered in that case. So we need to be sure there are no outstand=
ing
> >> requests before shutting down the domain.
> >=20
> > My point is that that's the driver's responsibility anyway, hence making
> > the explicit flush unnecessary.
>=20
> I see your point and it is interesting. The trouble is that we would
> need to test every memory client in every power domain to prove this. So
> I don't think that is a trivial thing to do. Furthermore, looking at
> what we have done in kernel used for android products (which probably
> stress PM the most) this is done and so I don't know of any shipping
> product that stresses PM that does not do this. May be someone else
> might. I personally would not be comfortable removing this without
> testing, but as I mentioned it is not a trivial thing to test correctly.
> However, I will let you and the other maintainers decide what's best here.

Quite frankly, I'm fairly sure most of this is untested anyway. There
isn't a good way to test gr3d for example.

Generally I lean towards not merging any code that we don't know is
needed. Merely because Android kernels do something doesn't mean it is
necessary to do it (or even sane in some cases).

Now I understand that it might be difficult to test this, but that's all
the more reason not to include the code. If we find that we have bugs
that this can fix, then we can come up with tests to trigger it and
validate that the fix actually fixes something.

In other words, I don't think it makes sense to implement mechanisms to
recover from situations that we have no way of triggering in the first
place.

Thierry

--PtLnLSExlPr13a2X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVrLy3AAoJEN0jrNd/PrOh31wQAJpwTPNXAqx7R2U81qsD1bbx
ZliI4G4AzcwyXf4nUStUe4WVzVfkP2LcbPEBhIqGmLxUJc+xsucf8Wa2nOR6qVp1
rMuwfgyif0IUulADDeMGRH511KGo/vHOYC4vtmYpnBIod9kqPIglYaO1tyNBVZV1
GSjuOj14Shu/8y5I4wxOYsGi9cOu5BmM4dfzCk1Yj5AXXFN3Zg96WpJD+Sa9hY9f
aCEfpIS9aFhapQEs4SltkelJgFYk3obLbdphGm2uGiV5sg9gVRjBiCrYLyzKAiQL
6Nrw2IKKz5cDVBzX/689PJTAGqN6N4oWJQWf6YxvglNd5DFEvuE73qw6Idk5hGhK
ztI+V2ydVb7OMwLWM9N6UeAPy+30YCm4vUNlSRjBhPUIYQ9+vx3XGaIP7y/6ersP
mo1jJSgY5NCNkLC0iF3hldrlF1TIr+0Bc2XnttSYH/sJIMLuGf7miaTz/9Q96MQI
8M+okZIxJxkXF0OetWryR2Q5qq8EKPoJoar2fTi/dooum1KFsM9OOLm6VZ6lc4Bl
l+jbMRdqJP5in3HDxWL0f0GAxQ4M6hsz0jfmjdD93EEOCYPOhLoaRziwwb2k5MkI
eU4FLv25TDh1YZ3Z+oQrMM23WBquanLGzFoRiP0rLGt6mepixxVTvCs606M4PecK
7MVmurI74wgthBR9f+X9
=l9OW
-----END PGP SIGNATURE-----

--PtLnLSExlPr13a2X--
