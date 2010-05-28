From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 23:44:49 +0200
Message-ID: <201005282344.49892.rjw__49773.1746676893$1275083082$gmane$org@sisk.pl>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>
	<1275052817.1645.64.camel@laptop>
	<1275058794.27810.9571.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275058794.27810.9571.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Friday 28 May 2010, Peter Zijlstra wrote:
> On Fri, 2010-05-28 at 15:20 +0200, Peter Zijlstra wrote:
> > On Fri, 2010-05-28 at 14:02 +0100, Alan Cox wrote:
> > > On Fri, 28 May 2010 14:30:36 +0200
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > > 
> > > > On Fri, 2010-05-28 at 13:21 +0100, Alan Cox wrote:
> > > > > [Total kernel changes
> > > > > 
> > > > >         Ability to mark/unmark a scheduler control group as outside of
> > > > >         some parts of idle consideration. Generically useful and
> > > > >         localised. Group latency will do most jobs fine (Zygo is correct
> > > > >         it can't solve his backup case elegantly I think)
> > > > > 
> > > > >         Test in the idling logic to distinguish the case and only needed
> > > > >         for a single Android specific power module. Generically useful
> > > > >         and localised] 
> > > > 
> > > > I really don't like this..
> > > > 
> > > > Why can't we go with the previously suggested: make bad apps block on
> > > > QoS resources or send SIGXCPU, SIGSTOP, SIGTERM and eventually SIGKILL
> > > 
> > > Ok. Are you happy with the QoS being attached to a scheduler control
> > > group and the use of them to figure out what is what ?
> > 
> > Up to a point, but explicitly not running runnable tasks complicates the
> > task model significantly, and interacts with fun stuff like bandwidth
> > inheritance and priority/deadline inheritance like things -- a subject
> > you really don't want to complicate further.
> > 
> > We really want to do our utmost best to make applications block on
> > something without altering our task model.
> > 
> > If applications keep running despite being told repeatedly to cease, I
> > think the SIGKILL option is a sane one (they got SIGXCPU, SIGSTOP and
> > SIGTERM before that) and got ample opportunity to block on something.
> > 
> > Traditional cpu resource management treats the CPU as an ever
> > replenished resource, breaking that assumption (not running runnable
> > tasks) puts us on very shaky ground indeed.
> 
> Also, I'm not quite sure why we would need cgroups to pull this off.
> 
> It seems most of the problems the suspend-blockers are trying to solve
> are due to the fact of not running runnable tasks. Not running runnable
> tasks can be seen as assigning tasks 0 bandwidth. Which is a situation
> extremely prone to all things inversion. Such a situation would require
> bandwidth inheritance to function at all, so possibly we can see
> suspend-blockers as a misguided implementation of that.

I think this is a matter of what is regarded as a "runnable task".  Some
tasks may not even be regarded as runnable in specific power conditions,
although otherwise they would be.

Consider updatedb or another file indexing ... thing on a laptop.  I certainly
don't want anything like this to run and drain my battery, even if it has
already been started when the machine was on AC power.  Now, of course,
I can kill it, but for that I need to notice that it's running and it presumably
might have done some job already and it would be wasteful to lose it.
It would be quite nice if that app was not regarded as runnable when the
system was on battery power.

In my view that's quite analogous to the Android situation, when they simply
don't want some tasks to be regarded as runnable in specific situations.

Rafael
