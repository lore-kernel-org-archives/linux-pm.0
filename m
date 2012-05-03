From: Colin Cross <ccross@android.com>
Subject: Re: [PATCHv3 0/5] coupled cpuidle state support
Date: Thu, 3 May 2012 13:18:58 -0700
Message-ID: <CAMbhsRS8D=d9aAbikosOis+Q+jMU04Oj9xaRg0jMVxtQ7nijTw@mail.gmail.com>
References: <1335816551-27756-1-git-send-email-ccross@android.com>
	<201204302354.41969.rjw@sisk.pl>
	<CAMbhsRQcDDW5vWbqb1FRtvOmq6UjOjXj9MCfSt2KF9fHrcY59Q@mail.gmail.com>
	<201205032200.01823.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201205032200.01823.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, Len Brown <len.brown@intel.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, May 3, 2012 at 1:00 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
<snip>
> There are two distinct cases to consider here, (1) when the last I/O
> device in the domain becomes idle and the question is whether or not to
> power off the entire domain and (2) when a CPU core in a power domain
> becomes idle while all of the devices in the domain are idle already.
>
> Case (2) is quite straightforward, the .enter() routine for the
> "domain" C-state has to check whether the domain can be turned off and
> do it eventually.
>
> Case (1) is more difficult and (assuming that all CPU cores in the domain
> are already idle at this point) i see two possible ways to handle it:
> (a) Wake up all of the (idle) CPU cores in the domain and let the
> =A0"domain" C-state's .enter() do the job (ie. turn it into case (2)),
> =A0similarly to your patchset.
> (b) If cpuidle has prepared the cores for going into deeper idle,
> =A0turn the domain off directly without waking up the cores.

Multiple clusters is a design that has been considered in this
patchset (all the data structures are in the right place to support
it), and can be supported in the future, but does not exist in any
current systems that would be using this.  In all of today's SoCs,
there is a single cluster, so (1) can't happen - no code can be
executing while all cpus are idle.

(b) is an optimization that would not be possible on any future SoC
that is similar to the current SoCs, where "turn the domain off" is
very tightly integrated with TrustZone secure code running on the
primary cpu of the cluster.

<snip>

> Having considered this for a while I think that it may be more straightfo=
rward
> to avoid waking up the already idled cores.
>
> For instance, say we have 4 CPU cores in a cluster (package) such that ea=
ch
> core has its own idle state (call it C1) and there is a multicore idle st=
ate
> entered by turning off the entire cluster (call this state C-multi). =A0O=
ne of
> the possible ways to handle this seems to be to use an identical table of
> C-states for each core containing the C1 entry and a kind of fake entry c=
alled
> (for example) C4 with the time characteristics of C-multi and a special
> .enter() callback. =A0That callback will prepare the core it is called fo=
r to
> enter C-multi, but instead of simply turning off the whole package it will
> decrement a counter. =A0If the counte happens to be 0 at this point, the
> package will be turned off. =A0Otherwise, the core will be put into the i=
dle
> state corresponding to C1, but it will be ready for entering C-multi at
> any time. The counter will be incremented on exiting the C4 "state".

I implemented something very similar to this on Tegra2 (having each
cpu go to C1, but with enough state saved for C-multi), but it turns
out not to work in hardware.  On every existing ARM SMP system where I
have worked with cpuidle (Tegra2, OMAP4, Exynos5, and some Tegra3),
only cpu 0 can trigger the transition to C-multi.  The cause of this
restriction is different on every platform - sometimes it's by design,
sometimes it's a bug in the SoC ROM code, but the restriction exists.
The primary cpu of the cluster always needs to be awake.

In addition, it may not be possible to transition secondary cpus from
C1 to C-multi without waking them.  That would generally involve
cutting power to a CPU that is in clock gating, which is not a
supported power transition in any SoC that I have a datasheet for.  I
made it work for cpu1 on Tegra2, but I can't guarantee that there are
not unsolvable HW race conditions.

The only generic way to make this work is to wake up all cpus.  Waking
up a subset of cpus is certainly worth investigating as an
optimization, but it would not be used on Tegra2, OMAP4, or Exynos5.
Tegra3 may benefit from it.

> It looks like this should work without modifying the cpuidle core, but
> the drawback here is that the cpuidle core doesn't know how much time
> spend in C4 is really in C1 and how much of it is in C-multi, so the
> statistics reported by it won't reflect the real energy usage.

Idle statistics are extremely important when determining why a
particular use case is drawing too much power, and it is worth
modifying the cpuidle core if only to keep them accurate.  Especially
when justifying the move from the cpufreq hotplug governor based code
that every SoC vendor uses in their BSP to a proper multi-CPU cpuidle
implementation.
