From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Fri, 6 Aug 2010 11:18:32 -0700
Message-ID: <20100806181832.GJ2432__42778.8547742695$1281118874$gmane$org@linux.vnet.ibm.com>
References: <alpine.DEB.2.00.1008051453450.30632@asgard.lang.hm>
	<AANLkTikCCeMG=DAQ04xqkvqH9tngBWyBA5VQTD4_15xU@mail.gmail.com>
	<20100805230304.GQ2447@linux.vnet.ibm.com>
	<AANLkTinatKEBfHhMnKc5wbys13P81PKWSc+nxccgHe-Y@mail.gmail.com>
	<alpine.DEB.2.00.1008051715520.30632@asgard.lang.hm>
	<AANLkTikOuY-q42mDRmxc-9W0uLeJeW-hiFG26WrV7CfU@mail.gmail.com>
	<alpine.DEB.2.00.1008051800360.25170@asgard.lang.hm>
	<20100806123047.GE31326@sirena.org.uk>
	<20100806172226.GH2432@linux.vnet.ibm.com>
	<20100806173325.GA25367@rakim.wolfsonmicro.main>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100806173325.GA25367@rakim.wolfsonmicro.main>
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

On Fri, Aug 06, 2010 at 06:33:25PM +0100, Mark Brown wrote:
> On Fri, Aug 06, 2010 at 10:22:26AM -0700, Paul E. McKenney wrote:
> > On Fri, Aug 06, 2010 at 01:30:48PM +0100, Mark Brown wrote:
> 
> > > this (the one following the rename to suspend blockers).  Essentially
> > > what happens in a mainline context is that some subsystems can with
> > > varying degress of optionality ignore some or all of the instruction to
> > > suspend and keep bits of the system alive during suspend.
> 
> > This underscores a basic difference between servers and these embedded
> > devices.  When you suspend a server, it is doing nothing, because servers
> > rely very heavily on the CPUs.  In contrast, many embedded devices can
> > perform useful work even when the CPUs are completely powered down.
> 
> Well, not really from the Linux point of view.  It's not massively
> different to something like keeping an ethernet controller sufficiently
> alive to allow it to provide wake on LAN functionality while the system
> is suspended in terms of what Linux has to do, and quite a few servers
> have lights out management systems which aren't a million miles away
> from the modem on a phone in terms of their relationship with the host
> computer.

The wake-on-LAN and the lights-out management systems are indeed
interesting examples, and actually pretty good ones.  The reason I
excluded them is that they don't do any application processing -- their
only purpose is the care and feeding of the system itself.  In contrast,
the embedded processors are able to do significant applications processing
(e.g., play back music) while any CPUs are completely shut down and most
of the memory is powered down as well.

							Thanx, Paul
