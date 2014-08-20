From: =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
Subject: Handling commit change logs (was: [PATCH v3 13/15] cpufreq: Add cpufreq
 driver for Tegra124)
Date: Wed, 20 Aug 2014 22:02:28 +0200
Message-ID: <53F4FED4.7060408@suse.de>
References: <1408419205-10048-1-git-send-email-tuomas.tynkkynen@iki.fi>	<1408419205-10048-14-git-send-email-tuomas.tynkkynen@iki.fi>	<CAKohpokQOALPH13Ykz4nTBOby8J1X6_F30LNKz=gsC4wN3=3vg@mail.gmail.com>	<53F3A900.8010805@nvidia.com>	<CAKohponcZv9-MFNUQFxC_49-+P6QOhdjxsnYAyL3i4sXdCBYrw@mail.gmail.com> <CABxcv=ncm3Y7Ecfymro6TOuP=d10OV5--8n=dYmHyj6zi8hwEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54986 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734AbaHTUCe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 20 Aug 2014 16:02:34 -0400
In-Reply-To: <CABxcv=ncm3Y7Ecfymro6TOuP=d10OV5--8n=dYmHyj6zi8hwEw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Tuomas Tynkkynen <ttynkkynen@nvidia.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Paul Walmsley <pwalmsley@nvidia.com>, Vince Hsu <vinceh@nvidia.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Javier,

Am 20.08.2014 17:39, schrieb Javier Martinez Canillas:
> As you already know when you apply a patch with git am, everything
> that is between a line with 3 dashes line (---) and the actual diff i=
s
> omitted since that is where the generated diffstat is placed by git
> format-patch.
>=20
> We usually rely on that behavior to put there the history of a patch
> or any information that we think that is useful for reviewers but is
> not suitable to end in the commit message. Now that means that you
> have to generate the patch and then manually edit it to add the
> history there.
>=20
> But since git am omits any text between the first "---" and the diff,
> it means that you can add a "---" on your actual commit message and
> anything that follows will be discarded by git am, that way you can
> maintain your history on your commit message which is way less tediou=
s
> than manually editing patches.
>=20
> So the second "---" from Tuomas patch is actually the one generated b=
y
> git format-patch but that gets discarded by git am just like any othe=
r
> text so it causes no harm when other apply the patches.
>=20
> If this not the correct workflow and you have a better way to manage
> this, I would love to know about it.

One drawback of having --- in the commit message is that you can't
cherry-pick but really need to use git-am for it to be stripped.

I resorted to a scripted way of handling change logs: Per patch series =
I
maintain a shell script that after git-format-patch essentially runs
sed -i "/---/ r /dev/stdin" $OUTDIR/0001-*.patch <<EOCL
=2E..
EOCL
to insert my text after ---. (sed syntax is not POSIX-compliant FWIW.)
Similarly I fill in the blurbs for the cover letter.

Another way I've heard of is git-notes, which lets you associate text
with a given commit id.
But in my tests that data did not survive a git-rebase -i, it stayed
attached to the original commit when editing the commit message or
fixing up a patch. It could still be accessed through the list of
git-notes but not be comfortably extracted from the updated branch via
git-rev-list or the likes.

Cheers,
Andreas

--=20
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6rffer; HRB 16746 AG N=C3=
=BCrnberg
