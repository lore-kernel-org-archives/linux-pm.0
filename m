From: Mark Gross <mgross@linux.intel.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Wed, 16 Aug 2006 08:25:33 -0700
Message-ID: <20060816152533.GA16133@linux.intel.com>
References: <200608160127.k7G1Rndl027916@olwen.urbana.css.mot.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200608160127.k7G1Rndl027916@olwen.urbana.css.mot.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Scott E. Preece" <preece@motorola.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 15, 2006 at 08:27:49PM -0500, Scott E. Preece wrote:
> =

> =

> | From: Dave Jones<davej@redhat.com>
> | =

> | On Tue, Aug 15, 2006 at 01:35:15PM +0300, Amit Kucheria wrote:
> | =

> |  > d. In the end, all this is leading to an interface for a user-space
> |  > policy manager that will control _system_ power state based on
> |  > constraints imposed by HW peripherals or on policies implemented by
> |  > device manufacturer/distro maintainer.
> | =

> | How does that interface look from a userspace point of view ?
> | Hopefully not anything like the tuple described above.
> | Why would userspace ever care about "interconnect freq" ?
> | =

> | Userspace cares about "save power" or "go fast".
> | Historically, I wish we had never exposed frequencies, but instead
> | a performance percentage, so that the various userspace tools
> | didn't have to care about things like 'what frequencies are available'.
> | Adding the same mistake for voltages doesn't strike me as a fantastic i=
dea.
> ---
> =

> For us, "userspace" means a power policy manager that potentially has a
> lot of awareness about the power needs of specific applications and the
> overall use cases driving the device. There is no interface available or
> visible to a "user".  The policy manager does want to know about
> specific frequencies and voltages and their interaction, because they
> determine the circumstances under which it makes sense to make
> particular transitions.
> =

> As I think I mentioned at the PM Summit in April, it's important to
> recognize that the power and performance implications of operating
> points are not simply based on frequency. Sometimes you want so shift
> "sideways", because changing one parameter may be preferable to changing
> another. =


Yes, over time it will become unrealistic to assume that voltage is a 1
to 1 function of frequency in a power management implementation for most
architectures.  Additionally the control of more than just CPU power
consumption will become only a fraction of the runtime platform PM
story.  =


What is trying to happen with this work is to take some initial steps to
enable more global power load controls by adding infrastructure to
expose the types of platform knobs to the system needed to implement
more power savings.  =


The target is to enable cpufreq styled power load control to multiple
platform components.  Plugging a PowerOP interface in under CPUFREQ is
one way to try to get this while not breaking existing work.

I don't know if its ready for the mm tree yet, it should at least build
for i386 or x86_64 even if today there is not obvious value in non-ACPI
PM platform throttling for these guys.

It is true that the embedded folks will be the early adopters of this
type of thing, but the big iron folks will not be far behind, and
eventually the desktop and laptop crowd will likely follow.

> =

> Note that we also want to be able to run the same code on a range of
> devices that may have significantly different hardware performance, so
> an abstract set of names (fastest to slowest, for instance) is also a
> problem.  =


The problem of what to expose to user space will vary from platform to
platform and use-case to use-case.  I don't think we'll find a one size
fits all solution to this issue.  =


--mgross
