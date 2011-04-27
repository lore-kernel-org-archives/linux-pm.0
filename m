From: Colin Cross <ccross@google.com>
Subject: Re: [RFC PATCH] PM: Introduce generic DVFS framework
 with device-specific OPPs
Date: Wed, 27 Apr 2011 13:48:52 -0700
Message-ID: <BANLkTinWD0ktYKzR_jnQSE76AuW+Z1PSLw__5668.06837819076$1303937498$gmane$org@mail.gmail.com>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
	<201104261309.47629.rjw@sisk.pl>
	<BANLkTi=tBYT4NpayaoAA1+f1uaj9QyT+Yw@mail.gmail.com>
	<BANLkTi=GVZnZuXmbK54Swi8Nv9ZZGhZcNw@mail.gmail.com>
	<BANLkTin4rrniJpOheLH=JE0jq7vFpdDbrA@mail.gmail.com>
	<BANLkTi=WWASxk3Fz83324k40Lbq+ccAPeA@mail.gmail.com>
	<BANLkTikEtTDp3Cpj0D5z34wA0_G_DWwKFg@mail.gmail.com>
	<alpine.LFD.2.02.1104272104390.3323@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.02.1104272104390.3323@ionos>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Menon, Nishanth" <nm@ti.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@lists.linux-foundation.org, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 27, 2011 at 12:26 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Forget OMAP implementation details for a while, sit back and look at
> the big picture.

Here's my proposal for DVFS:
- DVFS is implemented in drivers/clk/dvfs.c, and is called by the
common clock implementation to adjust the voltages, if necessary, on
regular clk_* calls.
- Platform code provides mappings in the form (clk, regulator, max
frequency, min voltage) to the dvfs code.
- Everything that is in OPP today gets converted to helper functions
inside the dvfs implementation, and is never called from SoC code
(except to pass tables at init), or from drivers.
- OPP can be recreated in the future as a upper level policy manager
for clocks that need to move together, if that is ever necessary.  It
would not know anything about voltages.
- A few common policy implementations need to be added to the common
clock implementation, like temperature limits.

For Tegra:
- DVFS continues to be accessed by calling clk_* functions

For OMAP:
- DVFS is triggered by hwmod through clk_* functions.  Any cross-arch
driver can continue to call clk_* functions.

OPP currently has opp_enable and opp_disable functions.  I don't
understand why these are needed, they are only used at init time to
determine available voltages, which could be handled by never passing
unavailable voltages to the dvfs implementation.
