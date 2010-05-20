From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 7)
Date: Fri, 21 May 2010 00:21:15 +0200
Message-ID: <201005210021.15420.rjw__40463.4451763288$1274394256$gmane$org@sisk.pl>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<201005192239.25892.rjw@sisk.pl>
	<AANLkTimoU9BrzbAl7q-LZzGeRolO7gUKBoGjkPWtWn1G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimoU9BrzbAl7q-LZzGeRolO7gUKBoGjkPWtWn1G@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 19 May 2010, Arve Hj=F8nnev=E5g wrote:
...
> PM: Opportunistic suspend support.
> =

> Power management features present in the current mainline kernel are
> insufficient to get maximum possible energy savings on some platforms,
> such as Android.  The problem is that to save maximum amount of energy
> all system hardware components need to be in the lowest-power states
> available for as long as reasonably possible, but at the same time the
> system must always respond to certain events, regardless of the
> current state of the hardware.
> =

> The first goal can be achieved either by using device runtime PM and
> cpuidle to put all hardware into low-power states, transparently from
> the user space point of view, or by suspending the whole system.
> However, system suspend, in its current form, does not guarantee that
> the events of interest will always be responded to, since wakeup
> events (events that wake the CPU from idle and the system from
> suspend) that occur right after initiating suspend will not be
> processed until another possibly unrelated event wakes the system up
> again.
> =

> On hardware where idle can enter the same power state as suspend, idle
> combined with runtime PM can be used, but periodic wakeups increase
> the average power consumption. Suspending the system also reduces the
> harm caused by apps that never go idle. There also are systems where
> some devices cannot be put into low-power states without suspending
> the entire system (or the low-power states available to them without
> suspending the entire system are substantially shallower than the
> low-power states they are put into when the entire system is
> suspended), so the system has to be suspended as a whole to achieve
> the maximum energy savings.
> =

> To allow Android and similar platforms to save more energy than they
> currently can save using the mainline kernel, introduce a mechanism by
> which the system is automatically suspended (i.e. put into a
> system-wide sleep state) whenever it's not doing work that's
> immediately useful to the user, called opportunistic suspend.
> =

> For this purpose introduce the suspend blockers framework allowing the
> kernel's power management subsystem to decide when it is desirable to
> suspend the system (i.e. when the system is not doing anything the
> user really cares about at the moment and therefore it may be
> suspended). Add an API that that drivers can use to block
> opportunistic suspend. This is needed to avoid losing wakeup events
> that occur right after suspend is initiated.
> =

> Add /sys/power/policy that selects the behavior of /sys/power/state.
> After setting the policy to opportunistic, writes to /sys/power/state
> become non-blocking requests that specify which suspend state to enter
> when no suspend blockers are active. A special state, "on", stops the
> process by activating the "main" suspend blocker.

That looks good to me.

Thanks,
Rafael
