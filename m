From: Jan Scholz <scholz@fias.uni-frankfurt.de>
Subject: Re: [regression,
	bisected] adb trackpad disappears after suspend to ram
Date: Wed, 07 Oct 2009 19:10:13 +0200
Message-ID: <878wfnt9je.fsf@scholz.fias.uni-frankfurt.de>
References: <878wkl6vce.fsf@scholz.fias.uni-frankfurt.de>
	<200906032200.55563.rjw@sisk.pl> <1253676745.7103.268.camel@pasglop>
	<200909231538.51227.rjw@sisk.pl> <1253741332.7103.324.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1253741332.7103.324.camel@pasglop> (Benjamin Herrenschmidt's
	message of "Thu, 24 Sep 2009 07:28:52 +1000")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Adrian Bunk <bunk@kernel.org>, linux-kernel@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, Jan Scholz <scholz@fias.uni-frankfurt.de>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

>> Alternatively, you could introduce a new flag IRQF_NOSUSPEND and use that
>> instead of IRQF_TIMER.  That would be cleaner than using IRQF_TIMER for
>> non-timer interrupts IMHO.
>
> I totally agree. The current patch is still good for stable though.
>
> I'll send it to Greg after I've upstreamed it, we can introduce IRQF_NOSUSPEND
> in a second patch.

How's upstreaming going? I can neither find the patch in Linus branch,
nor in linux-next. Could it be that it got lost?

Cheers,
Jan
