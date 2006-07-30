From: "Vitaly Wool" <vitalywool@gmail.com>
Subject: Re: PowerOp Design and working patch
Date: Sun, 30 Jul 2006 15:02:47 +0400
Message-ID: <acd2a5930607300402n13890dbg150315f617c86ffd@mail.gmail.com>
References: <242d827d33807b6b46608a26ed29c273@mvista.com>
	<20060728233837.GG2140@kroah.com>
	<c6333353f00bb7fd435ef518dc8cee21@mvista.com>
	<20060729004546.GA3917@kroah.com>
	<1c70fd37e4eb876295e0194e2b8725d6@mvista.com>
	<44CBB1E0.3030908@gmail.com>
	<62e4476a851bbed395b509023edc5c5c@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <62e4476a851bbed395b509023edc5c5c@mvista.com>
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
To: david singleton <dsingleton@mvista.com>
Cc: David Singleton <daviado@gmail.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

David,

On 7/30/06, david singleton <dsingleton@mvista.com> wrote:

> That's one of the simple parts of the concept.  There aren't any
> runtime operating
> point creation.  It's one of the things I like best about cpufreq,  the
> frequency
> and voltages are taken from the hardware vendor data sheet and
> validated.
>
> The user just gets to use the operating points supported by the system,
> not
> choose the frequency or voltage to transition to.
>
> By just presenting the supported operating points to the user it
> removes the
> need for new APIs.  The user just reads the supported operating points
> and decides the best use of the supported operating points.

I see this approach as fundamentally wrong at least because it will
produce very long and hard to manage lists of operating points.
Suppose you have 20 hardware vendor approved core CPU frequency
values, 3 possible voltage values and 10 approved DSP CPU frequency
values (which are derived from the other PLL). Not too impossible is
that almost all combinations are available which makes is almost 600
operating points. I find it absolutely unreal that anyone enters all
that stuff without mistakes; managing those lists/searching thru them
will take significant time which will slow down the state transitions;
and, finally, it's gonna increase the kernel footprint  quite a bit.

It looks to me that the concept that the kernel can implement
rules/restrictions for operating points but shouldn't define them with
possible exception for the most essential ones far better suits both
embedded and non-embedded use cases.

> > 2) interface (kernel as well as userspace(sysfs)) for the rest of power
> >    parameters except cpu voltage and frequency
>
>
> The /sys/power/supported_states file shows the supported operating
> points
> and their parameters.
>
> The platform specific information is hidden through the md_data pointer,
> which in the case of embedded systems with complex clocking schemes,
> contains the clock divisor and multiplier information that the system
> needs
> to perform frequency and voltage scaling and clock manipulation.
>
> The machine dependent portion of a centrino operating point
> is only the perfctl msr bits for each frequency/voltage.  For
> a system with 5 power domains and various clocks the
> machine dependent portion contains the whole array
> of information for the different power domains and their clocks.

Basically I don't see too much sense in your definition of
PM_FREQ_CHANGE and PM_VOLT_CHANGE. The latter one just isn't used
anywhere although the voltage differs between the operating points for
your centrino example. And it's quite a common thing when frequency
and voltage are changed within the same transition; so those either
should be bitfields or something like PM_STATE_CHANGE.

> >
> > 3) per platform nature of an operating point rather than per
> >    a pm control layer (cpufreq for ex.):
> >    - you have cpu freq and voltage defined in common code
> >       while it's still possible that on a certain platform one would
> >       not be interested in control of these parameters
>
> Correct, but on all of the hardware with which I'm familiar cpu
> frequency
> and voltage are common components to power management.

I do agree, but there might be different voltages and different CPU
frequencies within the same SoC, so it will mean that you separate,
say, two CPU frequencies between common code and SoC-specific code.
Maybe it's still the way to go, but it makes things quite complicated
to understand from scratch.
