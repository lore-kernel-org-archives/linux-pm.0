From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Mon, 4 Oct 2010 19:55:36 +0200
Message-ID: <20101004175536.GD1518__13625.1830881976$1286217291$gmane$org@ucw.cz>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com>
	<201009222049.18154.rjw@sisk.pl>
	<AANLkTinJU5+s_1S6i4GpRuiOfsAPiL9UFtrxCCbtoumt@mail.gmail.com>
	<201009282322.16291.rjw@sisk.pl> <4CA261F4.5070803@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4CA261F4.5070803@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, linux-kernel@vger.kernel.org, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

Hi!

> >> Here is what I am proposing, in reply to all your comments:
> >>
> >> 1) rename the events to match Thomas's proposal:
> >>     power:power_cpu_cstate
> >>     power:power_cpu_pstate
> >>     power:power_cpu_sstate
> > If that sstate thing is going to mean "suspend", then please drop it.
> > "Suspend" is not a state, let alone a CPU state.  It is a procedure by which
> > the (entire) system is put into a sleep state (that is not confined to CPUs).
> 
> there are also non-suspend S states, like S0i1 and S0i3 (supported in 
> the current Intel "Moorestown" platform)

Where can one learn more?
								Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
