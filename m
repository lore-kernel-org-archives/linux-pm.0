From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [patch update 2 fix] PM: Introduce core framework
	for run-time PM of I/O devices
Date: Mon, 22 Jun 2009 15:20:43 +0900
Message-ID: <aec7e5c30906212320v3e3e991fyd028d005675f1e25__2116.56324468112$1245651713$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.0906192141380.4003-100000@netrider.rowland.org>
	<Pine.LNX.4.44L0.0906201010590.12994-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906201010590.12994-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sat, Jun 20, 2009 at 11:30 PM, Alan Stern<stern@rowland.harvard.edu> wro=
te:
> Some more thoughts...
>
> Magnus, you might have some insights here. =A0It occurred to me that some
> devices can switch power levels very quickly, and the drivers might
> therefore want the runtime suspend and resume methods to be called as
> soon as possible, even in interrupt context.

I'd like to call pm_request_suspend() from interrupt context. I don't
depend on it, but being able to perform runtime suspend directly from
the ISR would be convenient from a device driver POV. I'm not sure if
that should result in bus/device ->runtime_suspend() calls from
interrupt context though.

In my case the bus specific code for ->runtime_suspend() may just
decrease the usage count of the powerdomain but refrain from calling
the device ->runtime_suspend() callbacks until all devices in the
powerdomain have been suspended. The bus/device runtime suspend
callbacks do not need to be executed from interrupt context. Just
noting that the device is idle is enough at interrupt time. This could
be handled by generic code IMO.

Runtime resume needs to block until the hardware is woken up though.
Just marking the device as resumed and letting the driver access the
hardware before it is woken up does not seem like a good idea. =3D) For
my SuperH devices I do not need to resume from interrupt context, at
least at this point.

>From my perspective it's ok to specificy that the ->runtime_suspend()
and ->runtime_resume() callbacks are executed from process context
only and may sleep. Seems like a simple and good interface that can be
accepted by many bus types. My bus and driver code do not need to
sleep though, so a direct-from-interrupt-context design is fine as
well.

> In terms of the current framework, this probably means holding the
> runtime PM lock (i.e., not releasing it) across the calls to
> ->runtime_suspend and ->runtime_resume. =A0It also means that
> pm_request_suspend and pm_request_resume should carry out their jobs
> immediately instead of queuing a work item. =A0(Unless the current status
> is RPM_SUSPENDING or RPM_RESUMING, which should never happen.)

No problem holding a per struct device lock. I suspect that executing
the callbacks from interrupt context is the most efficient design, but
it may come with interrupt latency side effects.

> Should there be a flag in dev_pm_info to select this behavior?

I'd say that executing the callbacks from process context is enough
for now. This will probably be a good match together with interrupt
threads as well.

Maybe the ARM guys have more advanced requriements?

Cheers,

/ magnus
