From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Wed, 29 Sep 2010 00:05:51 +0200
Message-ID: <201009290005.51644.rjw__37998.68661813$1285711631$gmane$org@sisk.pl>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com>
	<201009282322.16291.rjw@sisk.pl>
	<AANLkTin7yoSArdMTMSxKyamMP-dk7bubPiCEgWGb6RCc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTin7yoSArdMTMSxKyamMP-dk7bubPiCEgWGb6RCc@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Len Brown <len.brown@intel.com>, linux-trace-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, September 28, 2010, Jean Pihet wrote:
> Hi,
> 
> On Tue, Sep 28, 2010 at 11:22 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Tuesday, September 28, 2010, Jean Pihet wrote:
> >> Hi,
> >
> > Hi,
> >
> >> Here is what I am proposing, in reply to all your comments:
> >>
> >> 1) rename the events to match Thomas's proposal:
> >>    power:power_cpu_cstate
> >>    power:power_cpu_pstate
> >>    power:power_cpu_sstate
> >
> > If that sstate thing is going to mean "suspend", then please drop it.
> > "Suspend" is not a state, let alone a CPU state.  It is a procedure by which
> > the (entire) system is put into a sleep state (that is not confined to CPUs).
> 
> Since suspend is tied to the power management of the system, is it ok
> to rename it to e.g. power:system_suspend?

I think so.

Thanks,
Rafael
