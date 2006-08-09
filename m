From: Matthew Locke <matt@nomadgs.com>
Subject: Re: Dynanic On-The-Fly Operating points for PowerOP
Date: Wed, 9 Aug 2006 14:17:38 -0700
Message-ID: <bb52214749a48f317fba09eb522537bb@nomadgs.com>
References: <44D8D40F.50005@mvista.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <44D8D40F.50005@mvista.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Singleton <dsingleton@mvista.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Dave,

I think we need to focus on defining a powerop interface that will work =

for all (or as close to all as possible) architectures and devices =

types including embedded, laptop, server.   As discussed in previous =

emails, some of the goals for powerop are:

- Architecture/board independent interface
- Integrate with clk framework (and a voltage framework in the future) =

for SoC/Board register setting abstraction
- Provide a layer that knows the SoC and board specifics about =

relationship between voltage and frequency and setting operating points =

(we call it PM Core)
- Provide a clean interface to build on top of (for cpu freq governors, =

etc).

I think we can defer the discussion around creation of op points from =

userspace, suspend/resume integration and transition notifiers.  Once =

we get the basics submitted we can add features piece by piece.

Rather than continue submitting different powerop patches I would =

encourage you to join in the discussion about the interface.  I think =

Eugeny's latest patches are pretty close to satisfying the points made =

so far.  However, we are eagerly waiting feedback because there always =

tradeoffs that need to be made when trying to satisfy the goals listed =

above.

Thanks

Matt
On Aug 8, 2006, at 11:12 AM, David Singleton wrote:

> The patches provided in the following three emails continue the =

> unified,
>         simplified PowerOp concept of power management.  The patches
>         can be found at:
>
>                 http://source.mvista.com/~dsingleton
>
>                         powerop-core.patch
>                         powerop-cpufreq.patch
>                         powerop-x86-centrino.patch
>
>
>                 The patches break the working PowerOP feature into
>         three logical parts.  The first patch is the powerop-core.patch
>         that adds support for an operating point in the standard linux
>         power management infrastructure (CONFIG_PM) and adds a new
>         function to perform transitioning to operating points other
>         than suspend to memory or disk.
>
>                 The second patch, powerop-cpufreq.patch, adds the =

> cpufreq
>         portion of the patch that makes cpufreq tables a set of PowerOp
>         operating points.
>
>                 The third patch, powerop-x86-centrino.patch, adds
>         operating points for all the centrino-speedstep processors.
>
>
>         This set of patches has changed in the following ways.
>
>         1) The patch is now broken out of the cpufreq code and =

> implements
>         operating points for whatever speedstep-centrino the system
>         detects upon boot.
>
>         2) The naming scheme for operating points has been unified to
>         provide a better interface to the PowerOp power manager daemon.
>         The names range from:
>
>                         highest
>                         high
>                         medhigh
>                         medium
>                         medlow
>                         low
>                         lowest
>
>         PowerOp maps the supported processor frequencies onto this
>         namespace list.  The set of centrino processors it supports =

> have
>         supported sets of between four and six different operating =

> points.
>
>         The PowerOP daemon, coming soon, can simply read the supported
>         set of operating points and make some simple rules based
>         decisions about when to transition to various operating points.
>
>         The goal of a unified name space is to provide a PowerOp =

> manager
>         that runs out of the box, with very little setup by the user.
>
>
>         3) This patch supports the ability to provide dynamic, =

> on-the-fly
>         operating points to the framework via a loadable module.  The
> operating
>         point parameters of frequency, voltage and transition latency
>         can be passed at insmod time to create any new operating point
>         the centrino hardware will support.
>
>
>         I think I finally understand the 'why' of hardware vendors =

> asking
>         for a requirement of dynamic, on the fly, operating points.
>
>         I have two sets of hardware that support a wide range of
>         processor speeds and voltages depending on:
>
>         a) the rotary and dip switch setting of the board (the =

> mainstone).
>
>         or
>
>         b) the revision or stepping of the hardware on the board.
>
>         Certain revs of hardware support different frequencies and
> voltages.
>         Some steppings won't run all the frequencies.
>
>         The hardware vendors want to provide support for all the
>         frequencies and voltages that the system could support,
>         depending on the switch settings or rev of hardware without
>         having to change kernel code and recompile the kernel.
>
>         The new dynamic, on the fly, operating point module will allow
>         for this feature.
>
>
> David
>
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
>
