From: Matthew Locke <matt@nomadgs.com>
Subject: Re: cpufreq terminally broken [was Re: community PM
	requirements/issues and PowerOP]
Date: Tue, 27 Feb 2007 14:41:41 -0800
Message-ID: <ADE0CBE2-2BEC-4E5A-A5E6-6313E821D8DB@nomadgs.com>
References: <450516E8.9010403@gmail.com> <20060912033700.GD27397@kroah.com>
	<b324b5ad0609131650q1b7a78cfsa90e3fbe8d7b4093@mail.gmail.com>
	<200702271255.42661.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200702271255.42661.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


On Feb 27, 2007, at 12:55 PM, David Brownell wrote:

> Catching up on some ancient mail from one mbox ..
>
>
> On Wednesday 13 September 2006 4:50 pm, David Singleton wrote:
>> OpPoint constructs operating points for all supported frequency,  =

>> voltage
>> and suspend states for PC and SoC solutions running Linux.
>
> That's one basic issue I have with such approaches to desribing  =

> operating
> points:  "all" such states gets to be an enormous set.  What I've  =

> seen of
> both PowerOP and OpPoint says that they both try to limit that set  =

> by just
> enumerating a handful of specific operating points ... but the more  =

> generic
> solution (generally matching chip specs) would be having a way to  =

> constrain
> the parameters within their natural limits.  (Rather than picking  =

> out a set
> of half a dozen system modes in advance, by hand.)

Agreed, well mostly anyway:)   Eugeny and I went back to the drawing  =

board to see what we could do based on the comments last year and  =

specifically Dominiks "Alternative concept" email.   Basically, we  =

agree that the operating point notion is too limiting and artificial  =

to be the basis for a power management stack.  Something like the  =

knob layer described in Dominik's email is needed.   We have done a  =

bit of thinking on the necessary behavior and features of such a layer.

  It's funny I was in the middle of writing up our thoughts in an  =

email to the pm list when your email came in.  I will finish up that  =

email and then come back to your specific examples below.

>
>  - With CPU clock at AAA MHz, chip voltage K must be between A1 and  =

> A2 volts;
>    but those other clocks only need to follow their usual rules.    =

> This
>    defines a set of many operating points.
>
>  - The MMC driver needs to have power supply P output 3.3 V at 80  =

> mA and
>    have clock D active.  (Presumably, a different set of operating  =

> points.)
>
>  - If clock D is active, the SOC chip can't enter power state X;  =

> but again,
>    other clocks can use their normal rules.  Again, many operating  =

> points.
>
>  - While UART U3 is set to 115200 baud, certain values of clock M  =

> aren't
>    allowed; but there are no other constraints, so that many operating
>    points are compatible with that configuration.
>
>  - Those chips must be in power state X for that module to enter power
>    state Y; other modules can be in any power state.
>
>  - That module must be in power state Y for the system to enter power
>    state Z.
>
>  - Because of chip errata, <these> parameter combinations (or  =

> transitions)
>    are invalid; don't trigger them.
>
> Cataloguing every possible power-related parameter seems like a losing
> game, even on relatively tiny systems which pay attention to power  =

> usage
> from within each driver ... and doomed to failure in larger scenarios,
> like that 256-core case.
>
> It seems that I'm actually criticizing the notion of "operating  =

> point" as
> a model to expose as a power management target ...
>
> It's simple to say that the system is at a particular operating point,
> and that it's an operating point that works well for MP4 playback.   =

> That's
> like saying "it's warm today"; there are many kinds of warm day.  It's
> purely descriptive, and omits lots of relevant details.  (Rainy too?)
>
> But I really can't think it would be common for that to be the  =

> _only_ such
> operating point ... simple counter-examples include the MMC and  =

> UART cases
> above, considering that playback could often work with or without  =

> MMC active,
> with or without UART at 115200 baud.  Ergo, multiple operating  =

> points support
> MP4 playback, ergo "operating point" isn't the key notion that  =

> would need to
> be exposed.  QED.
>
> Now, where does that leave us?  I think it leaves us looking at how  =

> those
> constraints get expressed (by e.g. device drivers for clocks and  =

> voltages,
> ditto cpufreq drivers) and to what they get expressed (clock  =

> framework,
> voltage framework, maybe a CPU horsepower manager the scheduler  =

> talks to).
>
> So for that MP4 example, one could alert the video driver to do its  =

> clock
> setup, a horsepower manager to say "intensive software decode load  =

> coming
> up for this RT task", and one of the relevant operating points  =

> would be
> entered.  And if the video data were coming from the MMC card, a  =

> slightly
> different one would be entered as part of starting that data  =

> stream; etc.
>
> Or in the 256-cpu example, just alert the horsepower manager that a  =

> huge
> simulation job is upcoming ... that is, if the scheduler doesn't  =

> just do
> that automatically when it notices it'd be a nice time to bring up  =

> some
> of those currently-downed cores.  (Automatic up/down of cores may not
> behave well in all cases.  By analogy:  madvise gives VM advice  =

> that can't
> be guessed by the kernel; schedulers may need similar advice.)
>
> Comments?
>
> - Dave
>
>
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
