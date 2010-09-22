From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Wed, 22 Sep 2010 10:06:54 -0700
Message-ID: <4C9A37AE.2010509__45033.6100221195$1285175374$gmane$org@linux.intel.com>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com>	
	<201009171736.14170.trenn@suse.de>	<20100917162412.GB3341@elte.hu>	
	<201009180026.59482.trenn@suse.de>	
	<AANLkTimMAr9kEzybFGai3qGyXx36v055iPpXq_C1vW8C@mail.gmail.com>	
	<4C9A21AD.1000800@linux.intel.com>	
	<AANLkTim6B+Je=LykgJb9=0vK5Br1rkft619BRJkBcHdP@mail.gmail.com>	
	<4C9A2FB3.105@linux.intel.com> <1285173835.2275.1026.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1285173835.2275.1026.camel@laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Len Brown <len.brown@intel.com>, Jean Pihet <jean.pihet@newoldbits.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

  On 9/22/2010 9:43 AM, Peter Zijlstra wrote:
> On Wed, 2010-09-22 at 09:32 -0700, Arjan van de Ven wrote:
>>> What are the apps that are using it? I know about builtin-timechart,
>>> pytimechart. Is powertop using this as well?
>> powertop 2.x codebase is as well.
>>
>> and a bunch of tools we have internal here at Intel.
>>
>> the thing with ABIs is that you don't know how many users you have.. at
>> least here you know the lower bound is 3 different tools that are open
>> source.
>> .... and likely many local tools that aren't.
> These tools should be smart enough to look up the tracepoint name, fail
> it its not available, read the tracepoint format, again fail if not
> compatible.
it's not very useful if none of the critical information is available.

you can't at the one hand push people to use perf for critical pieces 
(like machine checks etc etc) and on
the other hand say that it's not ABI stable and should not be used really.

In this case we're talking about basically a suprious rename of 
something that isn't really an improvement
(because it makes it harder to subscribe to only one type of event)... 
that's not a good thing.
