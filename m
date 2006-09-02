From: "David Singleton" <daviado@gmail.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Sat, 2 Sep 2006 11:05:03 -0700
Message-ID: <b324b5ad0609021105u7fcab8c3w6d21bfca9caa93d1@mail.gmail.com>
References: <ADE4D9DBCFC3A345AAA95C195F62B6DD01A94E18@de01exm64.ds.mot.com>
	<1ac6c8e2a817eb0e11257b47199872f8@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1ac6c8e2a817eb0e11257b47199872f8@comcast.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Locke <matthew.a.locke@comcast.net>
Cc: linux-pm@lists.osdl.org, Preece Scott-PREECE <scott.preece@motorola.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 8/29/06, Matthew Locke <matthew.a.locke@comcast.net> wrote:
>
> On Aug 29, 2006, at 10:49 AM, Preece Scott-PREECE wrote:
>
> >
> >> From: linux-pm-bounces@lists.osdl.org
> >> [mailto:linux-pm-bounces@lists.osdl.org] On Behalf Of Pavel Machek
> >> Sent: Tuesday, August 29, 2006 11:35 AM
> >> To: David Singleton
> >> Cc: linux-pm@lists.osdl.org
> >> Subject: Re: [linux-pm] So, what's the status on the recent
> >> patches here?
> >>
> >> Hi!
> >>>>>         point, by name. There is a new
> >>>> /sys/power/operating_points directory
> >>>>>         that shows all the operating points the
> >>>> system supports. An
> >>>>>         exampled from my centrino laptop shows:
> >>>>>
> >>>>>         /sys/power/operating_points/high
> >>>>>         /sys/power/operating_points/highest
> >>>>>         /sys/power/operating_points/low
> >>>>>         /sys/power/operating_points/lowest
> >>>>>         /sys/power/operating_points/medium
> >>>>>         /sys/power/operating_points/mem
> >>>>>         /sys/power/operating_points/standby
> >>>>
> >>>> What makes you think that mixing operating and sleep
> >> states is good
> >>>> idea?
> >>>
> >>> They are all power states managed by the kernel and in the
> >> operating
> >>> point concept they are all operating points the system supports.
> >>
> >> That does not make mixing them right.
> > ---
> >
> > Could you say why you think they shouldn't be mixed? Absent argument to
> > the contrary,
> > making it a single continuum seems appealing. Why have separate
> > policies?
>
> I know this questions is directed at Pavel but I have similar concerns.
>    I agree that making sleep states into operating points is appealing.
> However,  if the implementation is just going to special case the sleep
> state operating points then they should be handled separately.  As
> Pavel points out, you can see from Dave's implementation that the
> operating point definition doesn't quite work for both.   Voltage and
> frequency don't have meaning for the sleep points.

Actually what I was trying, unsuccessfully, to explain was that
suspend states are valid, supported operating states the
system can be in for power management.    And that they are the
same as an operating point for a processor frequency.

Nothing is being 'mixed' because they are all the same thing;
an operating point the system can be in from a power management
perspective.

And since they are are valid operating points they should be in
the same power management framework and operate
through the same interfaces.

And voltage and frequency (and latency) do matter to suspend states.
Systems that support multiple suspend states have different
power consumption levels (hence the voltage requirement) associated
with the different suspend states.

And different suspend states have latencies to get into
and the power manager needs to know all of this information.

The power manager must know about the voltage values
to determine which state consumes the most or least power.

And the power manager must know about the latencies for different
states so it can decide when best to use them.  If a suspend state
takes too long to enter for the current operation of they system then
the power manager may choose to just move to a lower power consumption
operating point.


>The per point
> transition callbacks are needed just to handle the sleep points.

Not true.  The call backs are also needed when transitioning
to a new processor frequency operating point that will affect device state.

 The prepare to transition and finish transition callbacks
are needed for transitions between all operating points, whether
a suspend or processor frequency point.  Which is why I'm using
the existing cpufreq scaling callbacks and transitioning between
both supported processor frequencies and suspend states
is working on different architectures for OpPoint now.

> Latency has a very different meaning between the two types.


No, latency means the same thing for all operating points.  It's the time
it takes to transition into the state (and out of as well).

The power manager needs to know that time it takes to transition into
both a new cpu frequency and a suspend state.  If the suspend state
latency is too long the power manager may choose to just go to
a lower frequency operating point.

And when devices can export their latencies to transition into an idle
or suspended state the design and model still works.

And in fact the power manager can then better create policies which contain
an operating point for the entire system and a set of device states,
which is the definition of a policy.  And where the huge combination of
possible policies comes from.

When the power manager understands the frequency, voltage and
latency for each supported operating point and the latencies for
idling devices it can then operate in the most efficient manner
and create the best power management polices and classes of
policies for the system.




>  Also,  the
> type field is required to identify which points are sleep points and
> which ones are operating points.

They are all operating points.  They are all valid, supported states the sy=
stem
can be in.  And of course they should be in the same power management
framework and work through the same interfaces.

>  I think the concept of using
> operating points to define sleep states could be a valid one but the
> implementation provided isn't quite right (yet).
>
> However, this should not detract from mainlining PowerOP.  Integrating
> sleep and operating points is not required to use PowerOP.


>
> >
> > ---
> >>
> >>> The system can be set to any of the supported states by
> >> setting their
> >>> name in the /sys/power/state file.  I find simplicity is usually a
> >>> good thing.
> >>
> >> I believe the quote is 'make it as simple as possible but not
> >> simpler'.
> > ---
> >
> > So, why don't you think this simplification is possible?
> >
> > ---
> >>
> >>>> And '600MHz' makes lot more sense than 'lowest' on centrino.
> >>>
> >>> Perhaps, but the common name space makes it easy for the
> >> power manager
> >>> daemon to perform the same functions without having to know
> >> that the
> >>> lowest speed on my laptop is 600Mhz.
> >>
> >> And enumerate english strings in power daemon? Limiting the
> >> numver of states?
> > ---
> >
> > Are you saying that on your laptop, all possible CPU and bus
> > frequencies
> >
> > can be used independently? So, it would be unnecessarily limiting to
> > have
> > the system designer provide a list of combinations that work? Remember
> > that
> > the scope of this is a limited set of parameters, not all the devices
> > in
> > the system.
> >
> > ---
> >>
> >>>>
> >>>>>         /sys/power/operating_points/high/frequency
> >>>>>         /sys/power/operating_points/high/voltage
> >>>>>         /sys/power/operating_points/high/latency
> >>>>
> >>>> What is voltage for 'mem'?
> >>>
> >>> I don't know what the voltage or latency is for mem.
> >>> Perhaps Intel could better
> >>> say what the voltage is in the suspend state and what the
> >> latency was
> >>> for transistion to that state.  I didn't have the data
> >> available when
> >>> I wrote the code.
> >>
> >> And you will not have data available even if intel helps you.
> >> What is _frequency_ for mem? These fields are meaningless for
> >> sleep states; that should tell you that mixing sleep and
> >> operating states is bad idea.
> > ---
> >
> > Why isn't 0 a meaningful value for frequency? And I can imagine
> > that some hardware might have different voltage options for sleep
> > States.  Additionally, these sys entries could represent the frequency,
> > voltage, etc., that the system would go to upon resuming from sleep...
>
> I think its more an issue with the implementation rather than the
> concept.  We can't just have frequency and voltage as shown in oppoint
> patches because we don't know which frequency and voltage they refer
> to.  The number of frequency and voltage parameters are completely
> dependent on the hardware platform.
>
> You bring up a more interesting area to look at integrating sleep
> states and operating points.  Can we add some hooks that allow us to
> define which operating point is selected at resume?  Need to think
> about that a bit:)
>
> >
> > scott
> >
> > _______________________________________________
> > linux-pm mailing list
> > linux-pm@lists.osdl.org
> > https://lists.osdl.org/mailman/listinfo/linux-pm
> >
>
>
