From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 01:50:24 +0200
Message-ID: <201005280150.24873.rjw__22730.2236402922$1275004417$gmane$org@sisk.pl>
References: <20100527140655.GA28048@srcf.ucam.org>
	<201005272355.13222.rjw@sisk.pl>
	<20100527232043.784d5c72@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100527232043.784d5c72@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Friday 28 May 2010, Alan Cox wrote:
> On Thu, 27 May 2010 23:55:13 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Thursday 27 May 2010, Alan Cox wrote:
> > > > > If one works so does the other.
> > > > 
> > > > Not at all. The entire point of opportunistic suspend is that I don't 
> > > > care is currently in TASK_RUNNABLE or has a timer that's due to expire 
> > > > in 100msec - based on policy (through not having any held suspend 
> > > > blockers), I'll go to sleep. That's easily possible on PCs.
> > > 
> > > Yes I appreciate what suspend blockers are trying to do. Now how does
> > > that connect with my first sentence ?
> > 
> > I guess what Matthew wanted to say was that you couldn't use ACPI S3 as
> > a very deep CPU idle state, because of the way wakeup sources are set up
> > for it, while you could use it for aggressive power management with suspend
> > blockers as proposed by Arve.
> 
> Which is a nonsense. Because the entire Gnome desktop and KDE, and
> OpenOffice and Firefox and friends would need fitting out with
> suspend blockers.
> 
> x86 hardware is moving to fix these problems (at least on handheld
> devices initially). Look up the C6 power idle, and S0i1 and S0i3
> standby states. I reckon the laptop folks can probably get the hardware
> fixed well before anyone can convert the entire PC desktop to include
> blockers.

To clarify, I'm not suggesting to spread suspend blockers all over the
universe.

Rafael
