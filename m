From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sun, 6 Dec 2009 11:58:44 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912061144100.3560__19744.309949647$1260129869$gmane$org@localhost.localdomain>
References: <200912052216.19540.rjw@sisk.pl> <200912060055.36130.rjw@sisk.pl>
	<alpine.LFD.2.00.0912051635330.3560@localhost.localdomain>
	<200912060254.10081.rjw@sisk.pl>
	<alpine.LFD.2.00.0912051758190.3560@localhost.localdomain>
	<20091206113555.5a646713@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091206113555.5a646713@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On Sun, 6 Dec 2009, Arjan van de Ven wrote:
> 
> in suspend, there's a PCI device (:1b) that does take some time, which
> is the audio controller. The bulk of the time is in the serio driver
> though..

That serio thing is disgusting. We had serious problems with the serial 
driver timeouts for boot-time optimizations too, didn't we?

I assume that you don't even _use_ that serial port, do you? Or is it open 
for serial console logging or something? If it isn't even open, we 
shouldn't waste any time on the hardware.

Your graph seems to say that serio1 shutdown is roughly from 29.40 to 
29.85, ie almost half a second. That's just bogus. 

I don't see where it comes from, though. It looks like we have

 - pciserial_suspend_ports/serial_pnp_suspend ->
      serial8250_suspend_port ->
        uart_suspend_port ->
          (wait for tx_empty, but only for ASYNC_INITIALIZED, which 
	  shouldn't be true if it's closed, and should be limited to 30ms)
          uart_change_pm ->
            serial8250_pm

and none of them look like they should take anywhere close to half a 
second. So I'm obviously missing something, and your chart didn't include 
the sleep/wakeup pairs.

			Linus
