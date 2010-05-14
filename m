From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 09:06:50 -0700
Message-ID: <878w7mpiw5.fsf__17268.0043070161$1273853299$gmane$org@deeprootsystems.com>
References: <alpine.DEB.2.00.1005122118530.7624@utopia.booyaka.com>
	<Pine.LNX.4.44L0.1005131002380.1695-100000@iolanthe.rowland.org>
	<20100513191717.GA3428@atomide.com>
	<20100513192522.GA19256@srcf.ucam.org>
	<20100513194205.GC3428@atomide.com>
	<20100513195349.GB19722@srcf.ucam.org>
	<20100513200003.GE3428@atomide.com>
	<20100513200814.GA20254@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100513200814.GA20254@srcf.ucam.org> (Matthew Garrett's message
	of "Thu\, 13 May 2010 21\:08\:14 +0100")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Matthew Garrett <mjg@redhat.com> writes:

> On Thu, May 13, 2010 at 01:00:04PM -0700, Tony Lindgren wrote:
>
>> The system stays running because there's something to do. The system
>> won't suspend until all the processors hit the kernel idle loop and
>> the next_timer_interrupt_critical() returns nothing.
>
> At which point an application in a busy loop cripples you. I think we 
> could implement your suggestion more easily by just giving untrusted 
> applications an effectively infinite amount of timer slack, 
>
> but it still doesn't handle the case where an app behaves
> excrutiatingly badly.

Is design for exruciatingly bad apps a design requirement?

If so, opportunistic suspend + suspend blockers fails as well.  An app
could easily hold a suspend blocker during its entire execution
crippling PM.

Using opportunistic suspend may possibly allow you contain bad
apps/drivers, but at the cost of having to patch already working and
trusted apps and known-working kernel code with suspend blockers.

IMO, rather than accepting a solution that allows bad apps to run
wild, it would be much better to _continue_ focus on tools for finding
and containing bad apps.  This approach has the added bonus of solving
problems on *every* linux-based system, not just Android.

Kevin
