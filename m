From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: intel_pstate oopses and lockdep report with Linux v4.5-1822-g63e30271b04c
Date: Mon, 21 Mar 2016 23:02:46 +0100
Message-ID: <CAJZ5v0i=-4RkOMVUmGLsZN_cbKohKCHdGdWWbiWKDSQuu7VXPA@mail.gmail.com>
References: <CA+5PVA5=CJ=yf0EAZqNJX0XMc+ofDDJ-CHBrwuaANQwdhh2XbA@mail.gmail.com>
	<1458323535.3861.76.camel@linux.intel.com>
	<94B138B5-2AA0-4756-BF7E-1EA8764860F2@linux.intel.com>
	<2299553.MTuVWJXJ99@vostro.rjw.lan>
	<1458586692.4729.92.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458586692.4729.92.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephane Gasparini <stephane.gasparini@linux.intel.com>, Josh Boyer <jwboyer@fedoraproject.org>, Philippe Longepe <philippe.longepe@linux.intel.com>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 21, 2016 at 7:58 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Mon, 2016-03-21 at 15:11 +0100, Rafael J. Wysocki wrote:
>> On Monday, March 21, 2016 10:28:09 AM Stephane Gasparini wrote:
>> >
>> > =E2=80=94
>> > Steph
>> >
>> >
>> >
>> >
>> > > On Mar 18, 2016, at 6:52 PM, Srinivas Pandruvada <srinivas.pandr=
u
>> > > vada@linux.intel.com> wrote:
>> > >
>> > > On Fri, 2016-03-18 at 17:13 +0100, Stephane Gasparini wrote:
>> > > > Rafael,
>> > > >
>> > > > Why in step 3) both atom_set_pstate() and atom_set_pstate()
>> > > > were not
>> > > > both
>> > > > changed to use wrmsrl ?
>> > > Initial Atom support was experimental as there were no users,
>> > > till
>> > > Chrome started using. So it was just a miss.
>> > >
>> > > We should never have to use wrmsrl_on_cpu. But looks like
>> > > cpufreq_driver.init() can't guarantee that.
>> > >
>> > > > BTW, what is the interest of setting the pstate to LFM during
>> > > > initialization ?
>> > > > The BIOS is setting the pstate to either LFM, HFM or BFM, and
>> > > > why
>> > > > bothering
>> > > > changing it.
>> > > This is a different issue. BIOS has different configuration
>> > > option to
>> > > enable fast boot modes which are not necessarily optimized for
>> > > Linux.
>> > > Some aggressive setting will force system to reboot on boot. So =
I
>> > > will
>> > > leave the way it is.
>> >
>> > Here is my understanding.
>> >
>> > 1) until the driver starts, the CPUS will anyway starts at the P-
>> > State set by the BIOS.
>> > 2) even if you force it to Lowest P-State in init Intel P-State
>> > init, if there is load associated
>> >    to the execution, 10ms after (or may be quicker with the new
>> > scheduler based option) the
>> >    P-State will again set to P0.
>> >
>> > so because 1) and 2) you=E2=80=99ll have basically the following b=
ehavior
>> > assuming we have high load
>> > during boot, as this what can cause a reboot due to high
>> > frequencies I assume
>> >
>> > a) BIOS set LFM
>> > 10 ms after init of intel P-State, CPUs will go to Turbo according
>> > to load.
>> >
>> > b) BIOS set HFM
>> > CPU will boot to HFM until we reach intel_state init.
>> > During 10ms, CPU will be at LFM.
>> > Due to load they will go up to BFM.
>> >
>> > c) BIOS set to BFM.
>> > CPU will boot to BFM until we reach intel_state init.
>> > During 10ms, CPU will be at LFM.
>> > Due to load they will go up to BFM.
>> >
>> > So I may have miss something but I do not see what is the real
>> > benefit of doing this init to LFM
>> > that will last for 10ms.
>> >
>> > I still think this initialization is useless and complexity the
>> > code.
>> >
>> > Can you point me to case where having this initialization did solv=
e
>> > an issue so that I understand
>> > the interest of doing this initialization ?
>>
>> What you're saying above makes sense, but that change wouldn't belon=
g
>> to the
>> patch in question anyway.
>>
>> Please consider submitting another patch to make that change if you
>> think it's worth the effort.
>
> I don't think this is worth an effort because of legacy it is carryin=
g.
> The very first version had set this to max then later changed to "min=
".
> I can no longer ask Dirk, why he did that.

The max generally may not be a safe initial setting.

> Also 10 ms is lot of time for thermal trigger, so it is not worth an
> effort to go back and cause regression on some system running on
> thermal edges.

I would be very surprised if staying at the BIOS-provided frequency
caused any regressions to happen, but of course at the same time
pstate.current_pstate has to be initialized to a value reflecting the
one in the register.  In order to do that we can either initialize
them both to known safe values representing the same setting as we do
now (and min definitely is the safest choice here), or read the
register and initialize pstate.current_pstate accordingly.

The latter, however, is less attractive, because now we can do the
same thing on init/exit and with that modification the exit path would
be different.

[BTW, note that init doesn't only happen during boot.  It happens on
CPU online too (although in that case whatever is left by exit should
stick) and during system resume which is quite a bit more sensitive.]

Thanks,
Rafael
