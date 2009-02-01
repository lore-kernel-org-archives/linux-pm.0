From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Sat, 31 Jan 2009 17:04:37 -0800
Message-ID: <d6200be20901311704i6542bcd6r1ac2f5dbb50c506@mail.gmail.com>
References: <Pine.LNX.4.44L0.0901311033590.6305-100000@netrider.rowland.org>
	<200901311939.30837.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901311939.30837.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Sat, Jan 31, 2009 at 10:39 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> However, I think that what we are used to call a sleep (or suspend) state=
 is
> really a power off state for cell phone people.

No, our power off state is the same as on the desktop. We do use the
power key to enter and exit sleep, but you can configure a desktop
system to do this as well.

> Sleep states (suspend to RAM, hibernation) are the states of the whole sy=
stem
> in which no instructions are executed by the processor(s).  The difference
> between a sleep state and the power off state is that in a sleep state we=
 have
> some application context saved (in memory or in a storage device) and
> (in principle) after the system goes back to the working state, the
> applications can continue doing do whatever they had been doing before the
> system was put into the sleep state.

On many arm processors there is also a big difference in what events
can take you out of the power-off state versus the sleep-state. On
some systems only the power button or the charger can turn the system
back on after power-off while a number of external and internal
interrupts can take the cpu out of the deep-sleep-state.


> Well, I think that sleep states are not really useful in cell phones.  Us=
eful
> is the ability to put all devices into low power states separately and as
> needed (eg. after a period of inactivity).  IOW, the system as a whole is
> in the working state, but some parts of the hardware may be in low power =
states
> (even all of the I/O devices may be in low power states).  That may very =
well
> look "asleep" from the user point of view, but it is not a sleep state.

That may be true for single-core phones, but for dual core phones we
get significant power savings by doing a full suspend on the core that
runs Linux. On the system we currently have, we can enter the same
hardware state from idle as we can from suspend. But, on an idle
system with the radio is off, there are enough periodic timers to
double the average power draw. On a previous system the power draw
from idle was not even close to the power draw from suspend.

-- =

Arve Hj=F8nnev=E5g
