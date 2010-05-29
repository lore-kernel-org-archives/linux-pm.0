From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Sat, 29 May 2010 09:59:42 +0200
Message-ID: <1275119982.27810.12660.camel__27937.4749785804$1275120031$gmane$org@twins>
References: <Pine.LNX.4.44L0.1005271344040.3239-100000@iolanthe.rowland.org>
	<20100528005045.6ea5feba@lxorguk.ukuu.org.uk>
	<1275031797.32462.18.camel@laptop>  <201005290018.14832.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005290018.14832.rjw@sisk.pl>
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
Cc: Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Sat, 2010-05-29 at 00:18 +0200, Rafael J. Wysocki wrote:
> On Friday 28 May 2010, Peter Zijlstra wrote:
> > On Fri, 2010-05-28 at 00:50 +0100, Alan Cox wrote:
> > > Today "idle" means "no task running"
> > > 
> > > If you are prepared to rephrase that as "no task that matters is running"
> > > what would need to answer ?
> > 
> > I'm not sure we need or want to go there.
> > 
> > Why not simply let upatedb block on its IO because its QoS policy tells
> > us that its IO priority is idle. Therefore it will not avoid the IO
> > device from going idle and indefinitely delaying servicing requests.
> > 
> > When updatedb blocks, the runqueue becomes empty and we gain goodness.
> > 
> > Or are we talking about the same thing?
> 
> There may be apps that don't actually do I/O that we may want to be treated
> that way too.
> 
> Consider the following scenario.  I have a purely computational task that's
> running on my laptop in the background (say it's a folding@home or something
> similar), but I only want it to run when (a) the box is on AC power and (b)
> when user interface is "active" (the latter would have to be defined precisely,
> but for the purpose of this thought experiment let's assume we have such a
> definition).  Then, I'd only like it to be regarded as runnable if (a) and (b)
> both happen at the same time, but it can't block on I/O.

Well, both folding@home and Seti will need to do some IO in order to get
new data and report results, although the computational task might
indeed take quite a while before it does so.

Such tasks should listen to general environment hints, we already have
battery power state exposed, make it use that information. The user
interface is active can be gotten from X.

The thing is, if its a well behaved app and listens to the environment
hints, it will work as you want (could be done by policy knobs
all-round).

The only problem is dealing with apps that don't listen, those are
considered bad/buggy and hence we don't particularly care if they don't
function properly.

For long-running computational tasks we will send a progression of
SIGXCPU, SIGSTOP, SIGTERM and eventually SIGKILL if they keep violating
policy.
