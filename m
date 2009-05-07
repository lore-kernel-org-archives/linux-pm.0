From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH] PM: suspend_device_irqs(): don't disable
	wakeup IRQs
Date: Wed, 6 May 2009 18:18:23 -0700
Message-ID: <d6200be20905061818h58145d5fie5c55ceaf900a196__25710.7571386316$1241659234$gmane$org@mail.gmail.com>
References: <1241483224-7113-1-git-send-email-khilman@deeprootsystems.com>
	<87y6tb3x6r.fsf@deeprootsystems.com>
	<871vr22upr.fsf@deeprootsystems.com> <200905062318.23572.rjw@sisk.pl>
	<87zldpu5rt.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87zldpu5rt.fsf@deeprootsystems.com>
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
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Wed, May 6, 2009 at 5:16 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>
>> On Wednesday 06 May 2009, Kevin Hilman wrote:
>>> Kevin Hilman <khilman@deeprootsystems.com> writes:

> There is at least one problem with that which is why Kyuwon Kim added
> the ->disable hook to OMAP's irq_chip. =A0The problem is with drivers
> that call disable_irq() in their suspend hook, usually done to prevent
> the device from waking the system since on OMAP, any IRQ can be
> configured to wake the system.
>

This does not sound correct. disable_irq_wake should be used for this.
A driver may need to mask its interrupt before suspending but this
should not also disable it as a wakeup source.

> If a driver's suspend hook calls disable_irq() and the system is
> suspended before the lazy disable happens in the next handler, then
> the system will be suspended with that device's IRQ still enabled.
> Without an irq_chip->disable hook, that will result in that device IRQ
> waking up the system if it fires.

The platform suspend code needs to write the wakeup mask into
interrupt controller the before entering suspend.


-- =

Arve Hj=F8nnev=E5g
