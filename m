From: Amit Kucheria <amit.kucheria@nokia.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Tue, 15 Aug 2006 13:35:15 +0300
Message-ID: <1155638115.6736.135.camel@localhost>
References: <20060814200735.GC14099@kroah.com>
	<c948ef9077556626e85291ad716b7ddb@nomadgs.com>
	<20060814224623.GH30814@redhat.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com> <20060815010020.GA14251@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060815010020.GA14251@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ext Greg KH <greg@kroah.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2006-08-14 at 18:00 -0700, ext Greg KH wrote:
> On Mon, Aug 14, 2006 at 07:48:01PM -0400, Dave Jones wrote:
> > =

> > This adds a whole bunch of new code, and doesn't seem to make any
> > existing code any simpler (to me at least).  From a cpufreq point of vi=
ew,
> > what does adding this buy us? What problem do we have today that is
> > being solved by all this?
> > =

> > Every explanation of powerop I've seen so far dives into microdetails,
> > whilst the 10,000ft view has always passed me by other than "this is
> > what we've had in the embedded world".
> > =

> > The diagram at http://lists.osdl.org/pipermail/linux-pm/2006-August/003=
196.html
> > also confuses me.  I was under the impression that powerop was adding a=
dditional
> > userspace interfaces.  If we're not changing how things from a userspace
> > point of view, we're churning a lot of kernel code,.. why?
> > =

> > Clue me in here, I'm feeling thick.
> =

> You're not alone, I really don't get it either.
> =

> But I guess we'll just wait for the next round of unified patches and
> then go from there.

Here is my shot at providing a 10,000ft view:

a. For embedded platforms, cpufreq just does not cut it when specifying
an operating point for the device. These platforms use tuples such as

  <voltage, pll_freq, core1_freq, core2_freq, interconnect_freq> =


to signify an 'operating point'. Note that core1 and core2 can be
totally different processors e.g. ARM and DSP. x86 platforms hide this
complexity behind ACPI.

b. The clocking and voltage dependency tree in embedded devices can be
summarised in the clock framework ( find ./arch -name clock* ) and
soon-to-be-available voltage framework. These is again done to large
extent by ACPI on x86.

c. PowerOP provides an interface, that most embedded developers agree,
is a good starting point to encapsulate platform information in a
consistent way without having to resort to subarch-specific kludges.

d. In the end, all this is leading to an interface for a user-space
policy manager that will control _system_ power state based on
constraints imposed by HW peripherals or on policies implemented by
device manufacturer/distro maintainer.

In conclusion, PowerOP only allows embedded platforms to join the PM fun
without affecting cpufreq-supported platforms adversely. Or that is the
original idea. If that rule is being violated, please feel free to point
that out.

The way forward as I see is:

1. PowerOP integration into mainline [patch 1/3]
    - PM Core drivers (OMAP, x86) [patch 2/3]
    - cpufreq drivers modified to use PowerOP (OMAP, x86) [patch 3/3]

At this point, PowerOP is an optional component in mainline tree.
Cpufreq drivers can _choose_ to use it or not. But now embedded
platforms can do the PM dance in a consistent way.

2. Support for more architectures - PPC, x86_64, XScale, MIPS? Platform
expertise needed here.

3. Move clock/voltage framework from arch/arm to kernel/clock and
kernel/voltage. This would allow more embedded platforms and potentially
future PC platforms to utilise the framework for 'automated'
clock/voltage dependency management.

4. Userspace policy managers are created to provide basic control of
system operating points. Embedded system integrators might want to
extend these policy managers to fully utilise the 'knobs' available on
their platforms.

5. <Crystal Ball Gazing/Wishful Thinking>
- Clock/Voltage FW <--> ACPI logical mappings allows us to use global
state names in /sys/power/state for system power state transitions.
- Drivers on PC platforms are fixed to use/unuse resources dynamically
to allow asynchronous peripheral power state transitions. Embedded
platforms use clock framework for this.
- PowerOP can address needs of all platforms, allowing removal of
cpufreq.
   </CBG/WT>

Regards,
Amit
-- =

Amit Kucheria <amit.kucheria@nokia.com>
Nokia
