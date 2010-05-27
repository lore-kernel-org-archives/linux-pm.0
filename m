From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 22:49:49 +0100
Message-ID: <20100527224949.4d561091__41478.6942223602$1274996599$gmane$org@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.44L0.1005271329460.3239-100000@iolanthe.rowland.org>
	<1274981871.27810.5650.camel@twins>
	<201005272336.26643.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005272336.26643.rjw@sisk.pl>
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
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Thu, 27 May 2010 23:36:26 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Thursday 27 May 2010, Peter Zijlstra wrote:
> > On Thu, 2010-05-27 at 13:32 -0400, Alan Stern wrote:
> > 
> > > On some platforms (like those with ACPI), deeper power-savings are
> > > available by using forced suspend than by using idle. 
> > 
> > Sounds like something that's fixable, doesn't it?
> 
> The fix would probably have to involve rewriting the ACPI spec.

We are on about the fourth version of ACPI already. ACPI evolves and
improves and extends. It's not an impossibility to sort that out if
everyone in the x86 OS world starts thinking 'How come their ARM platform
can do this'

We are also on at least the second suspend/resume model in Linux. The
first was 'isn't this APM stuff neat', the second is heavily oriented
around ACPI ideas. And we already have SoC people moving into the third
model and making it work on non-x6 ('suspend is not special').

I've not poked at the current desktop stuff enough to see if the
gnome-power-manager and friends handle pushing the suspend button with
dbus notifiers to apps. I guess it does.

Alan
