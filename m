From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: intel_pstate oopses and lockdep report with Linux v4.5-1822-g63e30271b04c
Date: Mon, 21 Mar 2016 15:11:48 +0100
Message-ID: <2299553.MTuVWJXJ99@vostro.rjw.lan>
References: <CA+5PVA5=CJ=yf0EAZqNJX0XMc+ofDDJ-CHBrwuaANQwdhh2XbA@mail.gmail.com> <1458323535.3861.76.camel@linux.intel.com> <94B138B5-2AA0-4756-BF7E-1EA8764860F2@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41885 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755146AbcCUOJj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2016 10:09:39 -0400
In-Reply-To: <94B138B5-2AA0-4756-BF7E-1EA8764860F2@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephane Gasparini <stephane.gasparini@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Josh Boyer <jwboyer@fedoraproject.org>, Philippe Longepe <philippe.longepe@linux.intel.com>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>

On Monday, March 21, 2016 10:28:09 AM Stephane Gasparini wrote:
>=20
> =E2=80=94
> Steph
>=20
>=20
>=20
>=20
> > On Mar 18, 2016, at 6:52 PM, Srinivas Pandruvada <srinivas.pandruva=
da@linux.intel.com> wrote:
> >=20
> > On Fri, 2016-03-18 at 17:13 +0100, Stephane Gasparini wrote:
> >> Rafael,
> >>=20
> >> Why in step 3) both atom_set_pstate() and atom_set_pstate() were n=
ot
> >> both
> >> changed to use wrmsrl ?
> > Initial Atom support was experimental as there were no users, till
> > Chrome started using. So it was just a miss.
> >=20
> > We should never have to use wrmsrl_on_cpu. But looks like
> > cpufreq_driver.init() can't guarantee that.
> >=20
> >> BTW, what is the interest of setting the pstate to LFM during
> >> initialization ?
> >> The BIOS is setting the pstate to either LFM, HFM or BFM, and why
> >> bothering
> >> changing it.
> > This is a different issue. BIOS has different configuration option =
to
> > enable fast boot modes which are not necessarily optimized for Linu=
x.
> > Some aggressive setting will force system to reboot on boot. So I w=
ill
> > leave the way it is.
>=20
> Here is my understanding.
>=20
> 1) until the driver starts, the CPUS will anyway starts at the P-Stat=
e set by the BIOS.
> 2) even if you force it to Lowest P-State in init Intel P-State init,=
 if there is load associated
>    to the execution, 10ms after (or may be quicker with the new sched=
uler based option) the
>    P-State will again set to P0.
>=20
> so because 1) and 2) you=E2=80=99ll have basically the following beha=
vior assuming we have high load
> during boot, as this what can cause a reboot due to high frequencies =
I assume
>=20
> a) BIOS set LFM
> 10 ms after init of intel P-State, CPUs will go to Turbo according to=
 load.
>=20
> b) BIOS set HFM
> CPU will boot to HFM until we reach intel_state init.
> During 10ms, CPU will be at LFM.
> Due to load they will go up to BFM.
>=20
> c) BIOS set to BFM.
> CPU will boot to BFM until we reach intel_state init.
> During 10ms, CPU will be at LFM.
> Due to load they will go up to BFM.
>=20
> So I may have miss something but I do not see what is the real benefi=
t of doing this init to LFM=20
> that will last for 10ms.
>=20
> I still think this initialization is useless and complexity the code.
>=20
> Can you point me to case where having this initialization did solve a=
n issue so that I understand=20
> the interest of doing this initialization ?

What you're saying above makes sense, but that change wouldn't belong t=
o the
patch in question anyway.

Please consider submitting another patch to make that change if you thi=
nk it's
worth the effort.

Thanks,
Rafael

