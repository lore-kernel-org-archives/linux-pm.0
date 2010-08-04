From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 04 Aug 2010 09:43:54 +0300
Message-ID: <4C590C2A.9080201@nokia.com>
References: <20100801210548.23f77ff6@infradead.org>	<alpine.DEB.2.00.1008012153300.25170@asgard.lang.hm>	<20100802140933.GB2405@linux.vnet.ibm.com>	<alpine.DEB.2.00.1008021627290.29820@asgard.lang.hm>	<AANLkTi=1kBuyPS_P+eNLcnRu1mJH6BzpzQW_sENZuL1L@mail.gmail.com>	<alpine.DEB.2.00.1008022121430.6545@asgard.lang.hm>	<AANLkTikhcYzNp8CPp8cqrV7Ey5CLMWu1sJTNxUtEi2as@mail.gmail.com>	<alpine.DEB.2.00.1008022203470.6545@asgard.lang.hm>	<AANLkTinFT5jq4nUhUpzS5S4TVDQGj0S7RtRgxNhsz2UF@mail.gmail.com>	<alpine.DEB.2.00.1008031611100.6545@asgard.lang.hm>	<20100804001015.GJ2407@linux.vnet.ibm.com>	<20100803205758.21fcf372@infradead.org>
	<AANLkTikr6CW5AP9=ZVvyMUar39tPX2QcJbY3a4EFDEkN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikr6CW5AP9=ZVvyMUar39tPX2QcJbY3a4EFDEkN@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 08/04/2010 08:22 AM, ext Arve Hj=F8nnev=E5g wrote:

[snip ... discussion about wakeup sources]
> I disagree. On the msm platform the low level timer that brings us out
> of the low power state is the same for idle and suspend. The
> difference is where which kernel api the request comes from. In idle,
> the next event on the clockevents device is usually the first event.
> In suspend the generic kernel timekeeping code cancels this event and
> the rtc wakeup event remains.
>
>    =


wrt wakeup sources: why isn't it possible to just expect the interrupt =

associated to the undesired wakeup src to be masked?
That should be possible on any platform, and I would expect the hw to =

keep track that at least 1 irq has happened for a specific device:
I'm assuming that the system is fast enough to serve the irq before =

another one of same type is generated, should it be considered worth of =

waking up the system.

Timers might be tricky (iirc only 2 out of 12 timers are wakeup sources =

on OMAP3), but many other peripherals should be easier to handle.

cheers, igor
