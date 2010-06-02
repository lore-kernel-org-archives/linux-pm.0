From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 2 Jun 2010 22:55:51 +0200
Message-ID: <201006022255.51551.rjw__46544.7602015503$1275512200$gmane$org@sisk.pl>
References: <20100601123846.14d0535b@notabene.brown>
	<Pine.LNX.4.44L0.1006011032150.2949-100000@iolanthe.rowland.org>
	<20100602104318.0c41b3cd@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100602104318.0c41b3cd@notabene.brown>
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
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Wednesday 02 June 2010, Neil Brown wrote:
> On Tue, 1 Jun 2010 10:47:49 -0400 (EDT)
> Alan Stern <stern@rowland.harvard.edu> wrote:
...
> So yes, there are different use cases and we should support all of them,
> both "I shut the lid and my laptop really stays asleep" and "I never miss a
> TXT because my phone went to sleep at a bad time".  The process that
> initiates the suspend has a role in choosing what can wake it up.

You'd need to add some all new infrastructure for that, because right now
only hardware wakeup signals are regarded as (system) wakeup events
(they are either interrupts or things like PCI PMEs, possibly translated to
some platform signals like GPIOs or something).

I think I know how to prevent these hardware wakeup events from being lost
(such that the entire suspend will be aborted if one of them happens
during suspend), but for the handling of more generally defined wakeup
events we'd need to provide user space with information on what wakeup events
are available and how to enable and disable them, among other things.

Rafael
