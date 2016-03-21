From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: intel_pstate oopses and lockdep report with Linux v4.5-1822-g63e30271b04c
Date: Mon, 21 Mar 2016 15:09:19 +0100
Message-ID: <3083355.SxRo8HXI0T@vostro.rjw.lan>
References: <CA+5PVA5=CJ=yf0EAZqNJX0XMc+ofDDJ-CHBrwuaANQwdhh2XbA@mail.gmail.com> <CAJZ5v0ijyXsrK7512oV0cM=jj9P+fXkq36RRc-iTDaAsSq7ugg@mail.gmail.com> <CA730279-06B8-411F-8E7B-B7A2CCF100F0@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62868 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752482AbcCUOHK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2016 10:07:10 -0400
In-Reply-To: <CA730279-06B8-411F-8E7B-B7A2CCF100F0@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephane Gasparini <stephane.gasparini@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Josh Boyer <jwboyer@fedoraproject.org>, Philippe Longepe <philippe.longepe@linux.intel.com>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>

On Monday, March 21, 2016 10:31:37 AM Stephane Gasparini wrote:
>=20
> =E2=80=94
> Steph
>=20
>=20
>=20
>=20
> > On Mar 18, 2016, at 10:44 PM, Rafael J. Wysocki <rafael@kernel.org>=
 wrote:
> >=20
> > On Fri, Mar 18, 2016 at 7:32 PM, Stephane Gasparini
> > <stephane.gasparini@linux.intel.com> wrote:
> >>=20
> >> =E2=80=94
> >> Steph
> >>=20
> >>=20
> >>=20
> >>=20
> >>> On Mar 18, 2016, at 6:52 PM, Srinivas Pandruvada <srinivas.pandru=
vada@linux.intel.com> wrote:
> >>>=20
> >>> On Fri, 2016-03-18 at 17:13 +0100, Stephane Gasparini wrote:
> >>>> Rafael,
> >>>>=20
> >>>> Why in step 3) both atom_set_pstate() and atom_set_pstate() were=
 not
> >>>> both
> >>>> changed to use wrmsrl ?
> >>> Initial Atom support was experimental as there were no users, til=
l
> >>> Chrome started using. So it was just a miss.
> >>>=20
> >>> We should never have to use wrmsrl_on_cpu. But looks like
> >>> cpufreq_driver.init() can't guarantee that.
> >>>=20
> >>>> BTW, what is the interest of setting the pstate to LFM during
> >>>> initialization ?
> >>>> The BIOS is setting the pstate to either LFM, HFM or BFM, and wh=
y
> >>>> bothering
> >>>> changing it.
> >>> This is a different issue. BIOS has different configuration optio=
n to
> >>> enable fast boot modes which are not necessarily optimized for Li=
nux.
> >>> Some aggressive setting will force system to reboot on boot. So I=
 will
> >>> leave the way it is.
> >>>=20
> >>> Thanks,
> >>> Srinivas
> >>>=20
> >>=20
> >> Still it does not answer my question, why when implementing a4675f=
bc4a7a
> >> we did changed core for wrmsrl and not atom ?
> >=20
> > By mistake?
> >=20
> >> My point is that the issue was more due to a miss in the patch a46=
75fbc4a7a
> >> rather than a difference of behavior between atom and core.
> >=20
> > The issue is due to the fact that wrmsrl_on_cpu() is used in atom_s=
et_pstate().
> >=20
> > Moreover, core_set_pstate() doesn't use wrmsrl_on_cpu(), so in fact=
 it
> > is different from atom_set_pstate() in that respect.
> >=20
> > Now, why and when that difference was introduced doesn't really
> > matter.  What matters is whether or not it makes sense and what to =
do
> > about it.
> >=20
> > To me, it doesn't make sense.  wrmsrl() should be used on both Core
> > and Atom to update the MSR in intel_pstate_adjust_busy_pstate().  I=
n
> > turn, wrmsrl_on_cpu() should be used by both of them on init/exit.
> > That's exactly what happens with my patch applied, with a twist tha=
t
> > on init/exit the P-state is always set to the minimum, so it is not
> > even necessary to pass the pstate argument between functions in tha=
t
> > case.
> >=20
> >> The commit message is a bit misleading around this.
> >> The wrmrl_on_cpu() is needed on both core and atom during init.
> >=20
> > Yes, it is, but how is that related to the changelog of this patch?
>=20
> Telling what you are saying in this email in answer to me would make =
the thing=20
> more clear IMO.=20
> 1) the error seen is a side effect of the previous change, so the iss=
ue=20
>    was not existing before

That's moot.

Of course, you can argue that being inconsistent about using wmsrl_on_c=
pu()
vs wmsrl() was a bug by itself, but did it really lead to any user-visi=
ble
problems?

Honestly, I doubt it.

The issue has become visible after commit a4675fbc4a7a and that's the r=
eason
for my patch.

> 2) the explanation would be more clear that during the init/exit wmsr=
l_on_cpu()
>    and other wise wmsrl is the one to be used.

So to me "initialization and cleanup" means exactly "init/exit", so I d=
on't
think it really needs to be more clear than that.

I've added a line about making things consistent between Core and Atom =
to the
changelog, BTW.  Please have a look at it in my tree.

Thanks,
Rafael

