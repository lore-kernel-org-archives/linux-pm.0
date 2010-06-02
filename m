From: Neil Brown <neilb@suse.de>
Subject: Re: [PATCH] - race-free suspend. Was: Re: [PATCH 0/8]
 Suspend block api (version 8)
Date: Thu, 3 Jun 2010 08:05:56 +1000
Message-ID: <20100603080556.46d2d671__20054.5259555385$1275516422$gmane$org@notabene.brown>
References: <Pine.LNX.4.44L0.1005271303190.3239-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.1006011243350.2933@localhost.localdomain>
	<20100602153235.340a7852@notabene.brown>
	<201006022241.14152.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006022241.14152.rjw@sisk.pl>
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
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Wed, 2 Jun 2010 22:41:14 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Wednesday 02 June 2010, Neil Brown wrote:
> > - Would this fix the "bug"??
> > - and address the issues that suspend-blockers was created to address?
> > - or are the requirements on user-space too onerous?
> 
> In theory wakeup events can also happen after  wait_for_blockers() has returned
> 0 and I guess we should rollback the suspend in such cases.
> 

I naively assumed this was already the case, but on a slightly closer look at
the code it seems not.

Presumably there is some point deep in the suspend code, probably after the
call to sysdev_suspend, where interrupts are disabled and we are about to
actually suspend.  At that point a simple "is a roll-back required" test
could abort the suspend.
Then any driver that handles wake-up events, if it gets and event that (would
normally cause a wakeup) PM_SUSPEND_PREPARE and PM_POST_SUSPEND, could set
the "roll-back is required" flag.

??

NeilBrown
