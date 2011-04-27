From: Colin Cross <ccross@google.com>
Subject: Re: [RFC PATCH] PM: Introduce generic DVFS framework
 with device-specific OPPs
Date: Wed, 27 Apr 2011 11:45:18 -0700
Message-ID: <BANLkTinufd6SeYWCJ8GsQYHBfWi3beu=Ag@mail.gmail.com>
References: <BANLkTi=GVZnZuXmbK54Swi8Nv9ZZGhZcNw@mail.gmail.com>
	<20110427183430.GC12249@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110427183430.GC12249@sirena.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 27, 2011 at 11:34 AM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Wed, Apr 27, 2011 at 10:49:47AM -0700, Colin Cross wrote:
>
>> Moreover, from a silicon perspective, there is always a simple link
>> from a single frequency to a minimum voltage for a given circuit.
>> There is no need to group them into OPPs, which seem to have a group
>> of clocks and their frequencies that map to a single voltage. =A0That is
>> an artifact of the way TI specifies voltages.
>
> This isn't just a TI thing, other CPU (and general big digital) vendors
> spec things similarly. =A0It's just that TI have more code in mainline
> than most. =A0My understanding is that when people do this the set of
> operating points aren't purely about DVFS, they're also about specifying
> the relationships between the various system clock rates and potentially
> other things which are supported, especially in the blocks that mediate
> between multiple domains. =A0The voltages are just one of the parameters
> here, and with multiple supplies the voltages aren't always orthogonal
> to each other.
Then TI (and other vendors) are providing one table that specifies two
things - the relationship between frequency and voltage for each
clock, and the relationship between multiple clocks for optimal
performance.  Mixing those in the kernel breaks platforms (like Tegra)
that do not have any relationship between multiple clocks.

Can you point me to a platform that implements keeping multiple clocks
changing between OPPs together?  As far as I can tell, OMAP4 always
does dev -> clk, clk -> freq, dev + freq -> voltage, and never looks
at multiple clocks.

>> I proposed in a different thread on LKML that DVFS be handled within
>> the generic clock implementation. =A0Platforms would register a
>> regulator and a table of voltages for each struct clock that required
>> DVFS, and the voltages would be changed on normal clk_* requests.
>> This maintains compatibility with existing clk_* calls.
>
> This comes back to the thing we were discussing in the thread there
> about there being n:m constraints between settings. =A0I've not looked at
> this in any detail but it may be that for the systems which spec things
> as operating points we want to root the core clocking in an operating
> point block which deals with stuff like this.
>

On some platforms there may be a need for some global clock governor,
which can keep multiple clocks in sync, but I haven't seen one for
which that is truly required.
