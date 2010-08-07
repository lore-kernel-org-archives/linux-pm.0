From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Sat, 7 Aug 2010 07:36:20 -0700
Message-ID: <20100807143620.GB19600__30645.9457766779$1281191861$gmane$org@linux.vnet.ibm.com>
References: <AANLkTikOuY-q42mDRmxc-9W0uLeJeW-hiFG26WrV7CfU@mail.gmail.com>
	<alpine.DEB.2.00.1008051800360.25170@asgard.lang.hm>
	<20100806123047.GE31326@sirena.org.uk>
	<20100806172226.GH2432@linux.vnet.ibm.com>
	<20100806173325.GA25367@rakim.wolfsonmicro.main>
	<20100806181832.GJ2432@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008061517130.30564@asgard.lang.hm>
	<20100807001431.GA3252@opensource.wolfsonmicro.com>
	<20100807003642.GQ2432@linux.vnet.ibm.com>
	<20100807130718.GC11817@opensource.wolfsonmicro.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100807130718.GC11817@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: david@lang.hm, peterz@infradead.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, kevin granade <kevin.granade@gmail.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Aug 07, 2010 at 02:07:18PM +0100, Mark Brown wrote:
> On Fri, Aug 06, 2010 at 05:36:42PM -0700, Paul E. McKenney wrote:
> > On Sat, Aug 07, 2010 at 01:14:32AM +0100, Mark Brown wrote:
> 
> > > services in themselves (like system monitoring).  It's really just
> > > semantics to treat them differently to something like a cellular modem -
> > > at a high level they're both just independant processors ticking away
> > > without the application processor.
> 
> > I agree that a smartphone's cellular modem can be argued to be very
> > similar to wake-on-LAN.  The smartphone applications that seem to me
> > to be very different from wake-on-LAN are things like audio playback,
> > where the system is providing service to the user during the time that
> > it is suspended.
> 
> The cellular modem case includes not just hanging off the network but
> also being on a call - the voice path for a phone call doesn't need the
> CPU to do anything.  It's probably best to view a phone as a bunch of
> interconnected systems that happen to sit in the same box, and there's
> various design decisions that can be taken about which systems own the
> shared components.

OK, apologies, I thought you were talking about the wait-for-a-call case.
If there actually is a call ongoing, then the user perceives the system as
doing something, so this is similar to audio playback and quite different
from wake-on-LAN or system monitoring.

							Thanx, Paul
