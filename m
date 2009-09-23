From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [regression,
 bisected] adb trackpad disappears after suspend to ram
Date: Thu, 24 Sep 2009 07:28:52 +1000
Message-ID: <1253741332.7103.324.camel__45669.7049471133$1253741480$gmane$org@pasglop>
References: <878wkl6vce.fsf@scholz.fias.uni-frankfurt.de>
	<200906032200.55563.rjw@sisk.pl> <1253676745.7103.268.camel@pasglop>
	<200909231538.51227.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909231538.51227.rjw@sisk.pl>
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
Cc: Adrian Bunk <bunk@kernel.org>, linux-kernel@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, Jan Scholz <scholz@fias.uni-frankfurt.de>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2009-09-23 at 15:38 +0200, Rafael J. Wysocki wrote:
> > This patch fixes it by using IRQF_TIMER for both the PMU and the I2C
> > interrupts. I prefer doing it this way than moving the call sites since
> > I really want those platform functions to still be called after all
> > drivers (and before sysdevs).
> 
> Alternatively, you could introduce a new flag IRQF_NOSUSPEND and use that
> instead of IRQF_TIMER.  That would be cleaner than using IRQF_TIMER for
> non-timer interrupts IMHO.

I totally agree. The current patch is still good for stable though.

I'll send it to Greg after I've upstreamed it, we can introduce IRQF_NOSUSPEND
in a second patch.

Ben.
