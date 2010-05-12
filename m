From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Tue, 11 May 2010 18:11:09 -0700
Message-ID: <AANLkTikJV-wQX9xh8mRVptebJBctcRrQaUls-IGDhQar__9399.53868878565$1273626732$gmane$org@mail.gmail.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<87632vhbs8.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87632vhbs8.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Geoff Smith <geoffx.smith@intel.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

2010/5/10 Kevin Hilman <khilman@deeprootsystems.com>:
> Hello,
>
> I think many folks are still confused about exactly the problem being
> solved by this series as well as mixed up between opportunistic
> suspend and suspend blockers. =A0Also, how this series impatcs the rest
> of the kernel (especially PM-aware drivers and subsystems) has caused
> a bit of confusion.
>
> To help with the confusion, I think a much clearer description of the
> problem being solved and the proposed solution is needed.
>
> To that end, I created a starting point for that below which
> summarizes how I understand the problem and the proposed solution, but
> of course this should be filled out in more detail and updated as part
> of the documentation that goes with this series.
>
> Hope this helps improve the understanding of this feature,
>
> Kevin
>
>
>
> Table of Contents
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1 Problem Statement
> 2 Solution: Opportunistic suspend
> =A0 =A02.1 When to use a suspend blocker
> =A0 =A02.2 Usage in PM aware drivers
>
>
> 1 Problem Statement
> ~~~~~~~~~~~~~~~~~~~~
>
> Want to to hit deep power state, even when the system is not actually
> idle.
>
> Why?
>
> - some hardware is not capable of deep power states in idle
> - difficulty getting userspace and/or kernel to be idle

There are two parts to this. Suspend freezes tasks that don't idle at
all, and it stops the monotonic clock which in turn stops tasks that
do (frequent) periodic work.

>
> 2 Solution: Opportunistic suspend
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Create an additional "idle path" which has new rules for determining
> idleness. =A0When this new "idle" is reached, trigger full-system
> suspend. =A0Since a suspend is triggered whenever the opportunity
> arises, this is called opportunistic suspend.
>
> The new rules for making the idleness decision are simple:
>
> 1. =A0system may suspend if and only if no suspend blockers are held
>
> 2.1 When to use a suspend blocker
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> [A list of reasons why suspend blockers might be used would be very
> =A0helpful here.]
>
> - ensure wakeup events propagate to userspace (e.g. keypad example in doc)
>
> - screen is on
>
> - someone mentioned "Google use cases"
> =A0(would be nice to hear about more of these)

Most uses of suspend blockers are in some way tied to a potential
wakeup event. We use (a) suspend blocker(s) to make sure the event
propagates to the code that will handle the event, and that code then
uses another suspend blocker while it handles the event.

Some examples:

The battery monitor on Nexus One uses a periodic alarm to wake up the
system. The alarm driver will block suspend so the timer can fire, and
the battery monitor will block suspend while reading the battery
status and changing the charge mode.

Phone rings: We use a few suspend blockers to process the low level
message from the modem which end up returning a message on a tty. The
last step in the kernel currently uses a wakelock with a timeout since
we have not modified the tty layer to block suspend. The user space
ril process then blocks suspend while it handles this message.

USB: We get a (wakeup) message from the modem that there is power on
the usb connector and we block suspend while we detect what is
connected. If we are connected to a USB host, we block suspend and
turn on the usb interface.

>
> 2.2 Usage in PM aware drivers
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> [An example of how a driver already using runtime PM would use
> =A0a suspend blocker would also be helpful.
>

An audio driver can block suspend while audio is playing. We don't
currently use the runtime pm framework since this is new, but we do
runtime pm by turning off clocks and power when the device is
inactive.

-- =

Arve Hj=F8nnev=E5g
