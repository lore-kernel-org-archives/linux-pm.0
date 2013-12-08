From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH V4] cpufreq: suspend governors on system suspend/hibernate
Date: Sun, 8 Dec 2013 13:41:08 +0100
Message-ID: <20131208124108.GA4286@pd.tnic>
References: <28d493f20239a242a7b26dfe1efed40d83bf1e10.1385523340.git.viresh.kumar@linaro.org>
 <87vbz0j55p.fsf@nemi.mork.no>
 <1386429849.9737.7.camel@x41.thuisdomein>
 <3466098.C5M665z3nb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3466098.C5M665z3nb-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, =?utf-8?B?QmrDuHJu?= Mork <bjorn-yOkvZcmFvRU@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lists linaro-kernel <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Patch Tracking <patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Kgene Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jinchoi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sebastian Capella <sebastian.capella-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jonghwan Choi <jhbird.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Dec 08, 2013 at 01:34:36AM +0100, Rafael J. Wysocki wrote:
> On Saturday, December 07, 2013 04:24:09 PM Paul Bolle wrote:
> > On Sat, 2013-12-07 at 12:01 +0100, Bj=C3=B8rn Mork wrote:
> > > Sorry to be making noise here again, but I was eager to verify th=
at the
> > > fixes in v3.13-rc3 were OK on my system.  Unfortunately it seems =
this
> > > patch completely broke suspend for me.  Hibernete ended up with a=
 blank
> > > console and no visible activity, without ever writing any image t=
o disk.
> > >=20
> > > There really weren't that many suspects between v3.13-rc2 and v3.=
13-rc3,
> > > so I went directly to reverting 5a87182aa21d ("cpufreq: suspend
> > > governors on system suspend/hibernate") which fixed the problem. =
I
> > > didn't bother debugging it further from there. I don't think ther=
e is
> > > anything magic about my system which should make this problem spe=
cific
> > > to it.
> > >=20
> > > I am still using the acpi-cpufreq driver on an old x86_64 laptop =
if that
> > > matters.
> >=20
> > On an x86 (32 bits) laptop hibernate also broke in v3.13-rc3. On th=
at
> > machine hibernation itself worked, or at least seemed to work, but =
the
> > machine would basically stop after thawing (directly after loading =
the
> > hibernation image).
> >=20
> > And reverting commit 5a87182aa21d ("cpufreq: suspend governors on s=
ystem
> > suspend/hibernate"), on top of v3.13-rc3, also lead to a successful
> > hibernation/thaw cycle.
>=20
> OK, reverted.

+1.

Grrr, I just wasted a whole morning bisecting the same issue as reporte=
d
above and can confirm the revert is the right thing to do.

Well, almost: the box almost suspends until I hear the clicking sound o=
f
the mainboard trying to turn stuff off but then the fan remains on. Whe=
n
I hit a button on the keyboard, it then turns off completely. This is
probably some nasty BIOS SMI crap which we don't have control over and
I'd guess unrelated to the issue at hand.

Anyway, Rafael, I was wondering: I have a couple of boxes here and it
would probably make a good sense to help out with testing this stuff
more - I just can't have suspend breakages.

Maybe you'd like me to give a run of your tree now and then to check
whether someone has sent you a quickly rushed brownpaper bag of
questionable nature and we can fish it out before it hits Linus. :)

So let me know.

Thanks.

--=20
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
