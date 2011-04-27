From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC PATCH] PM: Introduce generic DVFS
	framework	with device-specific OPPs
Date: Wed, 27 Apr 2011 19:34:30 +0100
Message-ID: <20110427183430.GC12249@sirena.org.uk>
References: <BANLkTi=GVZnZuXmbK54Swi8Nv9ZZGhZcNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <BANLkTi=GVZnZuXmbK54Swi8Nv9ZZGhZcNw@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Colin Cross <ccross@google.com>
Cc: Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 27, 2011 at 10:49:47AM -0700, Colin Cross wrote:

> Moreover, from a silicon perspective, there is always a simple link
> from a single frequency to a minimum voltage for a given circuit.
> There is no need to group them into OPPs, which seem to have a group
> of clocks and their frequencies that map to a single voltage.  That is
> an artifact of the way TI specifies voltages.

This isn't just a TI thing, other CPU (and general big digital) vendors
spec things similarly.  It's just that TI have more code in mainline
than most.  My understanding is that when people do this the set of
operating points aren't purely about DVFS, they're also about specifying
the relationships between the various system clock rates and potentially
other things which are supported, especially in the blocks that mediate
between multiple domains.  The voltages are just one of the parameters
here, and with multiple supplies the voltages aren't always orthogonal
to each other.

> I proposed in a different thread on LKML that DVFS be handled within
> the generic clock implementation.  Platforms would register a
> regulator and a table of voltages for each struct clock that required
> DVFS, and the voltages would be changed on normal clk_* requests.
> This maintains compatibility with existing clk_* calls.

This comes back to the thing we were discussing in the thread there
about there being n:m constraints between settings.  I've not looked at
this in any detail but it may be that for the systems which spec things
as operating points we want to root the core clocking in an operating
point block which deals with stuff like this.
