From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH] intel_idle: Don't use on Lenovo Ideapad S10-3t
Date: Wed, 4 Nov 2015 18:21:00 +0200
Message-ID: <20151104162100.GT4437@intel.com>
References: <1446499360-31984-1-git-send-email-ville.syrjala@linux.intel.com>
 <1A7043D5F58CCB44A599DFD55ED4C9484693D228@fmsmsx115.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1A7043D5F58CCB44A599DFD55ED4C9484693D228@fmsmsx115.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 03, 2015 at 03:04:21AM +0000, Brown, Len wrote:
> > Lenovo Ideapad S10-3t hangs coming out of S3 with intel_idle.
> > The two workaround that seem to help are "intel_idle.max_cstate=3D0=
"
> > or "nohz=3Doff highres=3Doff".
> >=20
> > At a first glance quirk_tigerpoint_bm_sts() seemed promising, but
> > even when moved to early_resume it didn't do anything.
> >=20
> > I have no idea what's wrong here, so let's just disable intel_idle
> > for these machines using a DMI match.
>=20
> Ville,=20
>=20
> It is great that several workarounds have been discovered.
>=20
> But it would be better to get a good idea of the root-cause
> before permanently ignoring the problem via a new
> black-list in the upstream kernel.
>=20
> Is it possible for you to file a bug at bugzilla.kernel.org
> against Product: power-management; component: intel_idle?

https://bugzilla.kernel.org/show_bug.cgi?id=3D107151

>=20
> In it, please put the following information.
>=20
> If this is a regression, the oldest kernel that broke.

I'll repeat the details here just in case people are too lazy to look a=
t
the bug:

It seems intel_idle has always been flaky with this hardware. It used t=
o
work a little better in the past, but not perfectly.

I tried to bisect the total breakage starting from v3.11, and found the
following commit to be at fault:
commit a8d46b9e4e487301affe84fa53de40b890898604
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Tue Sep 30 02:29:01 2014 +0200

    ACPI / sleep: Rework the handling of ACPI GPE wakeup from
    suspend-to-idle

Before that I observed three different behaviours for S3 resume:
a) sometimes it resumed OK
b) sometimes it resumed part way, but kbd/network etc. were still
   dead, but then pressing the power button made it finish the resume
   somehow
c) same as the previous, except the power button press also made it
   all the way to userspace and initiated a normal shutdown
The same kernel could exhibit both a) and b), or both a) and c).

After a8d46b9e4e48 it never resumes, no matter if I press the power
button or not.

> When booted with intel_idle, and then without:
>=20
> dmesg | grep idle
> grep . /sys/devices/system/cpu/cpu0/cpuidle/*/*
> # turbostat --debug sleep 10 2> turbostat.out
>=20
> # cd /sys/devices/system/clocksource/clocksource0
> grep . available_clocksource current_clocksource
>=20
>=20
> Other boot options to test:
>=20
> maxcpus=3D1
> nohpet
>=20
> intel_idle.max_cstate=3D3
> and if that fails
> intel_idle.max_cstate=3D2
> and if that fails
> intel_idle.max_cstate=3D1

None of these help.

--=20
Ville Syrj=E4l=E4
Intel OTC
