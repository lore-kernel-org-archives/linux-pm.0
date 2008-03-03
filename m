From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [RFC][PATCH] cpuidle: avoid singing capacitors
Date: Mon, 03 Mar 2008 13:36:50 +0100
Message-ID: <p73mypg6l25.fsf__13850.3385628157$1204560750$gmane$org@bingen.suse.de>
References: <20080229193812.31f45b0c@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080229193812.31f45b0c@mjolnir.drzeus.cx> (Pierre Ossman's
	message of "Fri\, 29 Feb 2008 19\:38\:12 +0100")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Pierre Ossman <drzeus-list@drzeus.cx> writes:

> Many devices today are of a less than stellar quality, and singing
> transistors are a common problem. A high-pitch noise is created, caused
> by power fluctuations as the processor enters and leaves deep sleep at
> a high frequency.
>
> Instead of just disabling the deep sleep (which wastes power). This
> patch merely reduces the number of times it is entered so that the
> frequency doesn't exceed 500 Hz. That should make sure the problem is
> inaudible.
>
> Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
> --
>
> The basic idea is above, but the implementation doesn't quite work. It seems jiffies is not a good time source in this scenario. The time spent in C3 takes a much bigger hit than I expect. The fact that powertop says that it has an average residency of 200 ms in C2 tells me that those should have been spent in C3.

I like the patch in principle, although I think the threshold should
be configurable, not hard coded.

I haven't checked in detail if that is the case, but you need to make
sure that you only reference jiffies on idle exit after the clock
source has caught up with lost jiffies after idle. That might be 
the cause of your problem.

-Andi
