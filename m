From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: intel_pstate oopses and lockdep report with Linux
 v4.5-1822-g63e30271b04c
Date: Mon, 21 Mar 2016 11:58:12 -0700
Message-ID: <1458586692.4729.92.camel@linux.intel.com>
References: <CA+5PVA5=CJ=yf0EAZqNJX0XMc+ofDDJ-CHBrwuaANQwdhh2XbA@mail.gmail.com>
	 <1458323535.3861.76.camel@linux.intel.com>
	 <94B138B5-2AA0-4756-BF7E-1EA8764860F2@linux.intel.com>
	 <2299553.MTuVWJXJ99@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2299553.MTuVWJXJ99@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephane Gasparini <stephane.gasparini@linux.intel.com>
Cc: Josh Boyer <jwboyer@fedoraproject.org>, Philippe Longepe <philippe.longepe@linux.intel.com>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2016-03-21 at 15:11 +0100, Rafael J. Wysocki wrote:
> On Monday, March 21, 2016 10:28:09 AM Stephane Gasparini wrote:
> >=20
> > =E2=80=94
> > Steph
> >=20
> >=20
> >=20
> >=20
> > > On Mar 18, 2016, at 6:52 PM, Srinivas Pandruvada <srinivas.pandru
> > > vada@linux.intel.com> wrote:
> > >=20
> > > On Fri, 2016-03-18 at 17:13 +0100, Stephane Gasparini wrote:
> > > > Rafael,
> > > >=20
> > > > Why in step 3) both atom_set_pstate() and atom_set_pstate()
> > > > were not
> > > > both
> > > > changed to use wrmsrl ?
> > > Initial Atom support was experimental as there were no users,
> > > till
> > > Chrome started using. So it was just a miss.
> > >=20
> > > We should never have to use wrmsrl_on_cpu. But looks like
> > > cpufreq_driver.init() can't guarantee that.
> > >=20
> > > > BTW, what is the interest of setting the pstate to LFM during
> > > > initialization ?
> > > > The BIOS is setting the pstate to either LFM, HFM or BFM, and
> > > > why
> > > > bothering
> > > > changing it.
> > > This is a different issue. BIOS has different configuration
> > > option to
> > > enable fast boot modes which are not necessarily optimized for
> > > Linux.
> > > Some aggressive setting will force system to reboot on boot. So I
> > > will
> > > leave the way it is.
> >=20
> > Here is my understanding.
> >=20
> > 1) until the driver starts, the CPUS will anyway starts at the P-
> > State set by the BIOS.
> > 2) even if you force it to Lowest P-State in init Intel P-State
> > init, if there is load associated
> > =C2=A0=C2=A0=C2=A0to the execution, 10ms after (or may be quicker w=
ith the new
> > scheduler based option) the
> > =C2=A0=C2=A0=C2=A0P-State will again set to P0.
> >=20
> > so because 1) and 2) you=E2=80=99ll have basically the following be=
havior
> > assuming we have high load
> > during boot, as this what can cause a reboot due to high
> > frequencies I assume
> >=20
> > a) BIOS set LFM
> > 10 ms after init of intel P-State, CPUs will go to Turbo according
> > to load.
> >=20
> > b) BIOS set HFM
> > CPU will boot to HFM until we reach intel_state init.
> > During 10ms, CPU will be at LFM.
> > Due to load they will go up to BFM.
> >=20
> > c) BIOS set to BFM.
> > CPU will boot to BFM until we reach intel_state init.
> > During 10ms, CPU will be at LFM.
> > Due to load they will go up to BFM.
> >=20
> > So I may have miss something but I do not see what is the real
> > benefit of doing this init to LFM=C2=A0
> > that will last for 10ms.
> >=20
> > I still think this initialization is useless and complexity the
> > code.
> >=20
> > Can you point me to case where having this initialization did solve
> > an issue so that I understand=C2=A0
> > the interest of doing this initialization ?
>=20
> What you're saying above makes sense, but that change wouldn't belong
> to the
> patch in question anyway.
>=20
> Please consider submitting another patch to make that change if you
> think it's
> worth the effort.

I don't think this is worth an effort because of legacy it is carrying.
The very first version had set this to max then later changed to "min".
I can no longer ask Dirk, why he did that.
Also 10 ms is lot of time for thermal trigger, so it is not worth an
effort to go back and cause regression on some system running on
thermal edges.

Thanks,
Srinivas


>=20
> Thanks,
> Rafael
>=20
