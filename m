From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [regression,
	bisected] adb trackpad disappears after suspend to ram
Date: Wed, 7 Oct 2009 22:18:22 +0200
Message-ID: <200910072218.22357.rjw@sisk.pl>
References: <878wkl6vce.fsf@scholz.fias.uni-frankfurt.de>
	<1253741332.7103.324.camel@pasglop>
	<878wfnt9je.fsf@scholz.fias.uni-frankfurt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <878wfnt9je.fsf@scholz.fias.uni-frankfurt.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jan Scholz <scholz@fias.uni-frankfurt.de>
Cc: Adrian Bunk <bunk@kernel.org>, linux-kernel@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 07 October 2009, Jan Scholz wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> >> Alternatively, you could introduce a new flag IRQF_NOSUSPEND and use that
> >> instead of IRQF_TIMER.  That would be cleaner than using IRQF_TIMER for
> >> non-timer interrupts IMHO.
> >
> > I totally agree. The current patch is still good for stable though.
> >
> > I'll send it to Greg after I've upstreamed it, we can introduce IRQF_NOSUSPEND
> > in a second patch.
> 
> How's upstreaming going? I can neither find the patch in Linus branch,
> nor in linux-next. Could it be that it got lost?

More likely Ben didn't have the time to work on it.

Best,
Rafael
