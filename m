From: mark gross <640e9920@gmail.com>
Subject: Re: [RFC][PATCH] PM: Avoid losing wakeup events during
	suspend
Date: Mon, 21 Jun 2010 18:25:19 -0700
Message-ID: <20100622012519.GB12795__36234.3877940022$1277169954$gmane$org@gvim.org>
References: <20100621061345.GF9735@gvim.org>
	<Pine.LNX.4.44L0.1006211158200.1687-100000@iolanthe.rowland.org>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1006211158200.1687-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: mark gross <640e9920@gmail.com>, markgross@thegnar.org, Neil Brown <neilb@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 21, 2010 at 12:01:09PM -0400, Alan Stern wrote:
> On Sun, 20 Jun 2010, mark gross wrote:
> 
> > Your confused about what problem this patch attempts to solve.
> 
> I don't think so.  Rafael's description was pretty clear.

Then how is it you don't understand the fact that Rafael's patch is to
solve the wake event notification suspend race and not block opertunistic
suspends or kernel critical sections where suspending should be disabled?

> 
> >  There is
> > a pm_qos patch in the works to address the suspend blocker
> > functionality.
> > http://lists.linux-foundation.org/pipermail/linux-pm/2010-June/026760.html
> 
> No.  That patch addresses something _similar_ to the suspend blocker
> functionality.  The fact remains, though, that pm_qos is not used
> during system suspend (the /sys/power/state interface), hence changes
> to pm_qos won't solve the system-suspend problems that suspend blockers 
> do solve.

You keep saying they solve something, I keep wondering what you are
talking aobut.
Lets see what problems it solves:
* implements oppertunistic suspending (this is a feature not a problem)
* enables kernel critical sections blocking suspending.
* requiers overlapping application specific critcal sections from ISR
into user mode to make implementation correct.
* exposes a user mode interface to set a critical section.
* reduces races between wake events (or suspend blocking events) but I'm
not convinced it solves them. 

suspend blockers provide a way to block oppertunistic suspending, wich
I'll have you know, is a pain to get working right and the enabling from
device to device is not very portable and *that* doesn't say good things
about the scheme.

--mgross
 
