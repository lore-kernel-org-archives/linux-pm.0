From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Tue, 28 Sep 2010 14:45:24 -0700
Message-ID: <4CA261F4.5070803__28197.6325590678$1285710393$gmane$org@linux.intel.com>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com>
	<201009222049.18154.rjw@sisk.pl>
	<AANLkTinJU5+s_1S6i4GpRuiOfsAPiL9UFtrxCCbtoumt@mail.gmail.com>
	<201009282322.16291.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009282322.16291.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, linux-trace-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jean Pihet <jean.pihet@newoldbits.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

  On 9/28/2010 2:22 PM, Rafael J. Wysocki wrote:
> On Tuesday, September 28, 2010, Jean Pihet wrote:
>> Hi,
> Hi,
>
>> Here is what I am proposing, in reply to all your comments:
>>
>> 1) rename the events to match Thomas's proposal:
>>     power:power_cpu_cstate
>>     power:power_cpu_pstate
>>     power:power_cpu_sstate
> If that sstate thing is going to mean "suspend", then please drop it.
> "Suspend" is not a state, let alone a CPU state.  It is a procedure by which
> the (entire) system is put into a sleep state (that is not confined to CPUs).

there are also non-suspend S states, like S0i1 and S0i3 (supported in 
the current Intel "Moorestown" platform)

so it's slightly more complex than "just" suspend :)
