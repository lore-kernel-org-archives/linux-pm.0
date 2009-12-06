From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sun, 6 Dec 2009 12:18:03 -0800
Message-ID: <20091206121803.70385c33__12272.3937071443$1260130655$gmane$org@infradead.org>
References: <200912052216.19540.rjw@sisk.pl> <200912060055.36130.rjw@sisk.pl>
	<alpine.LFD.2.00.0912051635330.3560@localhost.localdomain>
	<200912060254.10081.rjw@sisk.pl>
	<alpine.LFD.2.00.0912051758190.3560@localhost.localdomain>
	<20091206113555.5a646713@infradead.org>
	<alpine.LFD.2.00.0912061144100.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912061144100.3560@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 6 Dec 2009 11:58:44 -0800 (PST)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Sun, 6 Dec 2009, Arjan van de Ven wrote:
> > 
> > in suspend, there's a PCI device (:1b) that does take some time,
> > which is the audio controller. The bulk of the time is in the serio
> > driver though..
> 
> That serio thing is disgusting. We had serious problems with the
> serial driver timeouts for boot-time optimizations too, didn't we?

isn't serio the PS/2 stuff?


(serio was an issue during boot as well due to some interesting rcu
delays btw)


> and none of them look like they should take anywhere close to half a 
> second. So I'm obviously missing something, and your chart didn't
> include the sleep/wakeup pairs.

what do you mean by this? what would you like to see ?
(I have a separate graph for resume.. but the graphing program does not
show those things that take so short to resume that the font to print
the name would be less than a pixel; can fix that)



[fwiw I care more about resume speed than suspend speed, but obviously
am happy if both get fixed... just resume tends to be much more user
interesting, just like getting out of the idle loop matters more than
getting into it]

-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
