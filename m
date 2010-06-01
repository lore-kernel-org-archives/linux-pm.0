From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Tue, 1 Jun 2010 03:49:37 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1006010340160.2933__41347.9123534218$1275357038$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.1005271303190.3239-100000@iolanthe.rowland.org>
	<201006010005.19554.rjw@sisk.pl>
	<20100601090023.788cabf4@notabene.brown>
	<201006010232.20263.rjw@sisk.pl>
	<20100601113309.609349fd@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100601113309.609349fd@notabene.brown>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Neil Brown <neilb@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Felipe Balbi <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Tue, 1 Jun 2010, Neil Brown wrote:
> And if you are right that the race window cannot be closed, then the whole
> suspend-blocker infrastructure is pointless as the purpose of it is simply to
> close that window.  If it really does not and cannot work, then it would be
> best to reject it for that reason rather than for less concrete aesthetic
> arguments.
> But presumably it does work in practice on Android hardware so ..... confused.
> 
> Having just seen the email from Thomas, maybe you mean that it cannot be
> closed on devices using ACPI, but can on other devices.  I can sort-of
> imagine how that would be the case (I tried reading an ACPI spec once - my
> hat is of to those of you who understand it).
> That shouldn't prevent us from closing the race window on "sane" hardware
> that allows it.  This would, I think, be sufficient for Android's needs.
> 
> I'm hoping we can get agreement on:
>   - there is a race with suspend

That's a matter of how you define "suspend". 

If "suspend" is another deep idle state and the hardware is sane,
there is no race at all - assumed that the driver/platform developer
got it right. It's not rocket science to transition from "normal" irq
delivery to wakeup based delivery raceless (except for PC style x86
hardware of today)

If "suspend" is the thing we are used to via /sys/power/state then the
race will persist forever except for the suspend blocker workaround,
which we can express in QoS terms as well w/o adding another suspend
related user space API.

Thanks,

	tglx
