From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] PM: suspend_device_irqs(): don't disable
	wakeup IRQs
Date: Tue, 05 May 2009 08:56:56 -0700
Message-ID: <87bpq7a6gn.fsf__7071.68111480332$1241539255$gmane$org@deeprootsystems.com>
References: <1241483224-7113-1-git-send-email-khilman@deeprootsystems.com>
	<20090504235405.647772ed.akpm@linux-foundation.org>
	<acd2a5930905050711j57cbf81du2fe4dbb4e408e877@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <acd2a5930905050711j57cbf81du2fe4dbb4e408e877@mail.gmail.com>
	(Vitaly Wool's message of "Tue\, 5 May 2009 18\:11\:31 +0400")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Vitaly Wool <vitalywool@gmail.com> writes:

> On Tue, May 5, 2009 at 10:54 AM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
>> On Mon, =A04 May 2009 17:27:04 -0700 Kevin Hilman <khilman@deeprootsyste=
ms.com> wrote:
>>
>>> Interrupts that are flagged as wakeup sources via set_irq_wake()
>>> should not be disabled for suspend.
>>>
>>
>> Why not?
>
> Sounds like an interesting problem. If a wakeup depends on the
> interrupt line, then no they definitely should not be disabled, as no
> wakeup would happen otherwise. =


Agreed.

> OTOH, this is not necessarily the case; some SoCs configure wakeup
> sources as GPIOs (i.MXs do AFAIR) so it's not clear if we should
> change generic source code in this case.

In the case of GPIO IRQs, then the call to __disable_irq() in
suspend_device_irqs() will trickle down to the irq_chip disable hook
in the GPIO code.  If that code stops the GPIO from triggering
interrupts, which it should, then my guess is your GPIO will no longer
wake the system either.

Kevin
