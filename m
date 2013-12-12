From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V4] cpufreq: suspend governors on system suspend/hibernate
Date: Thu, 12 Dec 2013 02:50:13 +0100
Message-ID: <2173296.zTKqhC7Obn@vostro.rjw.lan>
References: <28d493f20239a242a7b26dfe1efed40d83bf1e10.1385523340.git.viresh.kumar@linaro.org> <3466098.C5M665z3nb@vostro.rjw.lan> <20131208124108.GA4286@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20131208124108.GA4286@pd.tnic>
Sender: cpufreq-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Paul Bolle <pebolle@tiscali.nl>, =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, Viresh Kumar <viresh.kumar@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, Kgene Kim <kgene.kim@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-tegra@vger.kernel.org, jinchoi@broadcom.com, Lan Tianyu <tianyu.lan@intel.com>, Sebastian Capella <sebastian.capella@linaro.org>, Jonghwan Choi <jhbird.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Sunday, December 08, 2013 01:41:08 PM Borislav Petkov wrote:
> On Sun, Dec 08, 2013 at 01:34:36AM +0100, Rafael J. Wysocki wrote:
> > On Saturday, December 07, 2013 04:24:09 PM Paul Bolle wrote:
> > > On Sat, 2013-12-07 at 12:01 +0100, Bj=C3=B8rn Mork wrote:
> > > > Sorry to be making noise here again, but I was eager to verify =
that the
> > > > fixes in v3.13-rc3 were OK on my system.  Unfortunately it seem=
s this
> > > > patch completely broke suspend for me.  Hibernete ended up with=
 a blank
> > > > console and no visible activity, without ever writing any image=
 to disk.
> > > >=20
> > > > There really weren't that many suspects between v3.13-rc2 and v=
3.13-rc3,
> > > > so I went directly to reverting 5a87182aa21d ("cpufreq: suspend
> > > > governors on system suspend/hibernate") which fixed the problem=
=2E I
> > > > didn't bother debugging it further from there. I don't think th=
ere is
> > > > anything magic about my system which should make this problem s=
pecific
> > > > to it.
> > > >=20
> > > > I am still using the acpi-cpufreq driver on an old x86_64 lapto=
p if that
> > > > matters.
> > >=20
> > > On an x86 (32 bits) laptop hibernate also broke in v3.13-rc3. On =
that
> > > machine hibernation itself worked, or at least seemed to work, bu=
t the
> > > machine would basically stop after thawing (directly after loadin=
g the
> > > hibernation image).
> > >=20
> > > And reverting commit 5a87182aa21d ("cpufreq: suspend governors on=
 system
> > > suspend/hibernate"), on top of v3.13-rc3, also lead to a successf=
ul
> > > hibernation/thaw cycle.
> >=20
> > OK, reverted.
>=20
> +1.
>=20
> Grrr, I just wasted a whole morning bisecting the same issue as repor=
ted
> above and can confirm the revert is the right thing to do.
>=20
> Well, almost: the box almost suspends until I hear the clicking sound=
 of
> the mainboard trying to turn stuff off but then the fan remains on. W=
hen
> I hit a button on the keyboard, it then turns off completely. This is
> probably some nasty BIOS SMI crap which we don't have control over an=
d
> I'd guess unrelated to the issue at hand.
>=20
> Anyway, Rafael, I was wondering: I have a couple of boxes here and it
> would probably make a good sense to help out with testing this stuff
> more - I just can't have suspend breakages.
>=20
> Maybe you'd like me to give a run of your tree now and then to check
> whether someone has sent you a quickly rushed brownpaper bag of
> questionable nature and we can fish it out before it hits Linus. :)
>=20
> So let me know.

That would be great, thanks!

My tree is not too interesting at the moment from the cpufreq testing
perspective, but I'll let you know when there's more stuff in there.

Thanks,
Rafael

