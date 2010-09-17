From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Fri, 17 Sep 2010 17:36:13 +0200
Message-ID: <201009171736.14170.trenn__3280.07520079172$1284737910$gmane$org@suse.de>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com>
	<AANLkTi=W_Lo2m=hkA2F48oUziqGzt4Tr8y6KhfgqRnbz@mail.gmail.com>
	<20100917142459.GA28124@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100917142459.GA28124@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Len Brown <len.brown@intel.com>, linux-trace-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jean Pihet <jean.pihet@newoldbits.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Friday 17 September 2010 16:24:59 Ingo Molnar wrote:
> 
> * Jean Pihet <jean.pihet@newoldbits.com> wrote:
> 
> > > Apropos documentation..., are the power trace events documented
> > > somewhere?
> >
> > No. We need something like Documentation/trace/events-kmem.txt. I
> > can write that with for the new power API.
> Such a patch introducing events-power.txt would be most welcome!
Better wait a bit...
As soon as it exists, things are harder to change.
As long as there isn't an API documented, there doesn't exist one
(yes we want to have perf timechart, etc. still functional/compatible,
but still, better let's do not the same mistake with some quick shots).

Whatabout adding perf/trace interfaces to:
Documentation/ABI/*/perf-xy

    Thomas
